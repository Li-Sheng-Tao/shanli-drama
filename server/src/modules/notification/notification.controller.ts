import { Controller, Get, Put, Param, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { NotificationService } from './notification.service';
import { PaginationDto } from '../../common/dto/pagination.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { ParseIntPipe } from '@nestjs/common';

@ApiTags('消息通知')
@ApiBearerAuth()
@Controller('api/v1/notifications')
@UseGuards(JwtAuthGuard)
export class NotificationController {
  constructor(private readonly notificationService: NotificationService) {}

  @Get()
  @ApiOperation({ summary: '消息列表' })
  async getList(
    @CurrentUser('id') userId: number,
    @Query() query: PaginationDto,
  ) {
    return this.notificationService.getList(userId, query);
  }

  @Put(':id/read')
  @ApiOperation({ summary: '标记已读' })
  async markAsRead(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) notificationId: number,
  ) {
    return this.notificationService.markAsRead(userId, notificationId);
  }
}
