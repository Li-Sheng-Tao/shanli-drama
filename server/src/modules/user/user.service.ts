import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async findById(id: number) {
    return this.prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        openid: false,
        unionid: false,
        phone: true,
        nickname: true,
        avatar: true,
        gender: true,
        vipLevel: true,
        vipExpireAt: true,
        coinBalance: true,
        totalWatchSeconds: true,
        status: true,
        createdAt: true,
        updatedAt: true,
      },
    });
  }

  async updateProfile(id: number, data: { nickname?: string; avatar?: string }) {
    return this.prisma.user.update({
      where: { id },
      data,
    });
  }
}
