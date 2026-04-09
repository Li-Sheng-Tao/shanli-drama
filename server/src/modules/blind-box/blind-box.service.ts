import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class BlindBoxService {
  constructor(private prisma: PrismaService) {}

  async getList() {
    return this.prisma.blindBox.findMany({
      where: { isActive: true },
      orderBy: { createdAt: 'desc' },
    });
  }

  async openBox(userId: number, boxId: number) {
    const box = await this.prisma.blindBox.findUnique({
      where: { id: boxId },
    });

    if (!box || !box.isActive) {
      throw new BadRequestException('宝箱不存在或已下架');
    }

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { coinBalance: true },
    });

    const currentBalance = user?.coinBalance ?? 0;
    if (currentBalance < box.coinCost) {
      throw new BadRequestException('金币不足');
    }

    // 简单的随机奖励逻辑
    const rewards = [10, 20, 30, 50, 100];
    const weights = [40, 30, 20, 8, 2]; // 权重
    const totalWeight = weights.reduce((a, b) => a + b, 0);

    let random = Math.random() * totalWeight;
    let reward = rewards[0];
    for (let i = 0; i < weights.length; i++) {
      random -= weights[i];
      if (random <= 0) {
        reward = rewards[i];
        break;
      }
    }

    const newBalance = currentBalance - box.coinCost + reward;

    await this.prisma.$transaction([
      this.prisma.user.update({
        where: { id: userId },
        data: { coinBalance: newBalance },
      }),
      this.prisma.coinTransaction.create({
        data: {
          userId,
          type: 'exchange',
          amount: reward - box.coinCost,
          balanceAfter: newBalance,
          description: `开启${box.boxName}获得${reward}金币`,
          relatedId: boxId,
        },
      }),
    ]);

    return { reward, balance: newBalance };
  }
}
