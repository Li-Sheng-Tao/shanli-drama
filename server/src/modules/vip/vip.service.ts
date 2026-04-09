import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateOrderDto } from './dto/create-order.dto';

const VIP_PLANS: Record<string, { name: string; price: number; days: number }> = {
  week: { name: '周卡', price: 9.9, days: 7 },
  month: { name: '月卡', price: 29.9, days: 30 },
  quarter: { name: '季卡', price: 79.9, days: 90 },
  year: { name: '年卡', price: 259.9, days: 365 },
};

@Injectable()
export class VipService {
  constructor(private prisma: PrismaService) {}

  async getPlans() {
    return Object.entries(VIP_PLANS).map(([key, value]) => ({
      planType: key,
      ...value,
    }));
  }

  async createOrder(userId: number, dto: CreateOrderDto) {
    const plan = VIP_PLANS[dto.planType];
    if (!plan) {
      throw new Error('无效的套餐类型');
    }

    const orderNo = `VIP${Date.now()}${userId}`;
    return this.prisma.vipOrder.create({
      data: {
        userId,
        orderNo,
        planType: dto.planType,
        amount: plan.price,
        payMethod: dto.payMethod,
        payStatus: 'pending',
      },
    });
  }

  async handleCallback(orderNo: string, payStatus: string) {
    const order = await this.prisma.vipOrder.findUnique({
      where: { orderNo },
    });

    if (!order) {
      throw new Error('订单不存在');
    }

    if (payStatus === 'paid') {
      const plan = VIP_PLANS[order.planType];
      const vipStartAt = new Date();
      const vipExpireAt = new Date();
      vipExpireAt.setDate(vipExpireAt.getDate() + plan.days);

      await this.prisma.vipOrder.update({
        where: { orderNo },
        data: {
          payStatus: 'paid',
          payTime: new Date(),
          vipStartAt,
          vipExpireAt,
        },
      });
    }

    return { success: true };
  }

  async verifyVip(userId: number) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        vipLevel: true,
        vipExpireAt: true,
      },
    });

    const isVip =
      (user?.vipLevel ?? 0) > 0 &&
      user?.vipExpireAt &&
      new Date(user.vipExpireAt) > new Date();

    return {
      isVip,
      vipLevel: user?.vipLevel ?? 0,
      vipExpireAt: user?.vipExpireAt ?? null,
    };
  }
}
