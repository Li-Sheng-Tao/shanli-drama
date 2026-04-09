import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { PaginationDto } from '../../common/dto/pagination.dto';

@Injectable()
export class NotificationService {
  constructor(private prisma: PrismaService) {}

  async getList(userId: number, query: PaginationDto) {
    // TODO: 实现消息通知表，暂时返回空列表
    return {
      list: [],
      total: 0,
      page: query.page,
      limit: query.limit,
    };
  }

  async markAsRead(userId: number, notificationId: number) {
    // TODO: 实现标记已读逻辑
    return { success: true };
  }
}
