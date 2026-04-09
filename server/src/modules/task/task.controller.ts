import { Controller, Get, Post, Param, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { TaskService } from './task.service';
import { ReportWatchDto } from './dto/report-watch.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { ParseIntPipe } from '@nestjs/common';

@ApiTags('任务')
@ApiBearerAuth()
@Controller('api/v1/tasks')
@UseGuards(JwtAuthGuard)
export class TaskController {
  constructor(private readonly taskService: TaskService) {}

  @Get('daily')
  @ApiOperation({ summary: '每日任务列表' })
  async getDailyTasks(@CurrentUser('id') userId: number) {
    return this.taskService.getDailyTasks(userId);
  }

  @Post('daily/:id/claim')
  @ApiOperation({ summary: '领取任务奖励' })
  async claimReward(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) taskId: number,
  ) {
    return this.taskService.claimReward(userId, taskId);
  }

  @Post('report-watch')
  @ApiOperation({ summary: '上报观看时长' })
  async reportWatch(
    @CurrentUser('id') userId: number,
    @Body() dto: ReportWatchDto,
  ) {
    return this.taskService.reportWatch(userId, dto);
  }
}
