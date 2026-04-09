import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class AdService {
  constructor(private prisma: PrismaService) {}

  async getConfig() {
    const ads = await this.prisma.advertisement.findMany({
      where: { isActive: true },
      orderBy: { priority: 'desc' },
    });

    const grouped = ads.reduce((acc, ad) => {
      if (!acc[ad.adPosition]) {
        acc[ad.adPosition] = [];
      }
      acc[ad.adPosition].push({
        adProvider: ad.adProvider,
        adUnitId: ad.adUnitId,
      });
      return acc;
    }, {} as Record<string, any[]>);

    return grouped;
  }

  async reward(userId: number, adPosition: string) {
    const reward = 10; // 每次观看广告奖励10金币

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { coinBalance: true },
    });

    const newBalance = (user?.coinBalance ?? 0) + reward;

    await this.prisma.$transaction([
      this.prisma.user.update({
        where: { id: userId },
        data: { coinBalance: newBalance },
      }),
      this.prisma.coinTransaction.create({
        data: {
          userId,
          type: 'watch',
          amount: reward,
          balanceAfter: newBalance,
          description: `观看${adPosition}广告奖励`,
        },
      }),
    ]);

    return { reward, balance: newBalance };
  }
}
