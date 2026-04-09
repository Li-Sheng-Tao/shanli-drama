import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { ReportWatchDto } from './dto/report-watch.dto';

@Injectable()
export class TaskService {
  constructor(private prisma: PrismaService) {}

  async getDailyTasks(userId: number) {
    const today = new Date().toISOString().slice(0, 10);

    const tasks = await this.prisma.dailyTask.findMany({
      where: { isActive: true },
      orderBy: { sortOrder: 'asc' },
    });

    const userTasks = await this.prisma.userDailyTask.findMany({
      where: { userId, taskDate: today },
    });

    const userTaskMap = new Map(userTasks.map((ut) => [ut.taskId, ut]));

    const list = tasks.map((task) => {
      const userTask = userTaskMap.get(task.id);
      return {
        ...task,
        progress: userTask?.progress ?? 0,
        completed: userTask?.completed ?? false,
        rewardClaimed: userTask?.rewardClaimed ?? false,
      };
    });

    return { date: today, list };
  }

  async claimReward(userId: number, taskId: number) {
    const today = new Date().toISOString().slice(0, 10);

    const task = await this.prisma.dailyTask.findUnique({
      where: { id: taskId },
    });

    if (!task) {
      throw new BadRequestException('任务不存在');
    }

    const userTask = await this.prisma.userDailyTask.findUnique({
      where: { userId_taskId_taskDate: { userId, taskId, taskDate: today } },
    });

    if (!userTask || !userTask.completed) {
      throw new BadRequestException('任务未完成');
    }

    if (userTask.rewardClaimed) {
      throw new BadRequestException('奖励已领取');
    }

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { coinBalance: true },
    });

    const newBalance = (user?.coinBalance ?? 0) + task.coinReward;

    await this.prisma.$transaction([
      this.prisma.user.update({
        where: { id: userId },
        data: { coinBalance: newBalance },
      }),
      this.prisma.userDailyTask.update({
        where: { id: userTask.id },
        data: { rewardClaimed: true },
      }),
      this.prisma.coinTransaction.create({
        data: {
          userId,
          type: 'task',
          amount: task.coinReward,
          balanceAfter: newBalance,
          description: `完成任务: ${task.taskName}`,
          relatedId: taskId,
        },
      }),
    ]);

    return { coinReward: task.coinReward, balance: newBalance };
  }

  async reportWatch(userId: number, dto: ReportWatchDto) {
    const today = new Date().toISOString().slice(0, 10);

    // 更新观看记录
    const existingRecord = await this.prisma.watchRecord.findFirst({
      where: { userId, episodeId: dto.episodeId },
    });

    if (existingRecord) {
      await this.prisma.watchRecord.update({
        where: { id: existingRecord.id },
        data: {
          watchDurationSeconds: existingRecord.watchDurationSeconds + dto.watchDuration,
          watchProgressSeconds: dto.watchDuration,
        },
      });
    } else {
      await this.prisma.watchRecord.create({
        data: {
          userId,
          dramaId: dto.dramaId,
          episodeId: dto.episodeId,
          watchDurationSeconds: dto.watchDuration,
          watchProgressSeconds: dto.watchDuration,
        },
      });
    }

    // 更新用户总观看时长
    await this.prisma.user.update({
      where: { id: userId },
      data: { totalWatchSeconds: { increment: dto.watchDuration } },
    });

    // 更新观看时长任务进度
    const watchTask = await this.prisma.dailyTask.findFirst({
      where: { taskType: 'watch_duration', isActive: true },
    });

    if (watchTask) {
      await this.prisma.userDailyTask.upsert({
        where: {
          userId_taskId_taskDate: {
            userId,
            taskId: watchTask.id,
            taskDate: today,
          },
        },
        create: {
          userId,
          taskId: watchTask.id,
          taskDate: today,
          progress: dto.watchDuration,
        },
        update: {
          progress: { increment: dto.watchDuration },
        },
      });
    }

    return { success: true };
  }
}
