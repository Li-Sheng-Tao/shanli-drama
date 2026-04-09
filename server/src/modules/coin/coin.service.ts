import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { ExchangeDto } from './dto/exchange.dto';
import { PaginationDto } from '../../common/dto/pagination.dto';

@Injectable()
export class CoinService {
  constructor(private prisma: PrismaService) {}

  async getBalance(userId: number) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { coinBalance: true },
    });
    return { balance: user?.coinBalance ?? 0 };
  }

  async getTransactions(userId: number, query: PaginationDto) {
    const [list, total] = await Promise.all([
      this.prisma.coinTransaction.findMany({
        where: { userId },
        orderBy: { createdAt: 'desc' },
        skip: query.skip,
        take: query.take,
      }),
      this.prisma.coinTransaction.count({ where: { userId } }),
    ]);

    return { list, total, page: query.page, limit: query.limit };
  }

  async checkin(userId: number) {
    const today = new Date().toISOString().slice(0, 10);

    const existing = await this.prisma.userCheckin.findUnique({
      where: { checkinDate: today },
    });
    if (existing) {
      throw new BadRequestException('今日已签到');
    }

    // 计算连续签到天数
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayStr = yesterday.toISOString().slice(0, 10);

    const yesterdayCheckin = await this.prisma.userCheckin.findFirst({
      where: { userId, checkinDate: yesterdayStr },
    });

    let dayNumber = 1;
    if (yesterdayCheckin) {
      dayNumber = yesterdayCheckin.dayNumber + 1;
    }

    const coinReward = Math.min(dayNumber * 10, 100);

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { coinBalance: true },
    });

    const newBalance = (user?.coinBalance ?? 0) + coinReward;

    await this.prisma.$transaction([
      this.prisma.user.update({
        where: { id: userId },
        data: { coinBalance: newBalance },
      }),
      this.prisma.userCheckin.create({
        data: {
          userId,
          checkinDate: today,
          dayNumber,
          coinReward,
        },
      }),
      this.prisma.coinTransaction.create({
        data: {
          userId,
          type: 'checkin',
          amount: coinReward,
          balanceAfter: newBalance,
          description: `连续签到第${dayNumber}天`,
        },
      }),
    ]);

    return { dayNumber, coinReward, balance: newBalance };
  }

  async exchange(userId: number, dto: ExchangeDto) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { coinBalance: true },
    });

    const currentBalance = user?.coinBalance ?? 0;
    if (currentBalance < dto.amount) {
      throw new BadRequestException('金币不足');
    }

    const newBalance = currentBalance - dto.amount;

    await this.prisma.$transaction([
      this.prisma.user.update({
        where: { id: userId },
        data: { coinBalance: newBalance },
      }),
      this.prisma.coinTransaction.create({
        data: {
          userId,
          type: 'exchange',
          amount: -dto.amount,
          balanceAfter: newBalance,
          description: `兑换类型${dto.type}`,
          relatedId: dto.type,
        },
      }),
    ]);

    return { balance: newBalance };
  }
}
