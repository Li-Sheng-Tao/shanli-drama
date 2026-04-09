import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../../prisma/prisma.service';
import { WechatLoginDto } from './dto/wechat-login.dto';
import { PhoneLoginDto } from './dto/phone-login.dto';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async wechatLogin(dto: WechatLoginDto) {
    // TODO: 调用微信接口获取 openid
    const openid = `mock_openid_${dto.code}`;
    let user = await this.prisma.user.findUnique({ where: { openid } });

    if (!user) {
      user = await this.prisma.user.create({
        data: {
          openid,
          nickname: '微信用户',
          avatar: '',
        },
      });
    }

    const token = this.generateToken(user.id);
    return { token, user };
  }

  async phoneLogin(dto: PhoneLoginDto) {
    // TODO: 验证短信验证码
    let user = await this.prisma.user.findUnique({ where: { phone: dto.phone } });

    if (!user) {
      user = await this.prisma.user.create({
        data: {
          phone: dto.phone,
          nickname: `用户${dto.phone.slice(-4)}`,
          avatar: '',
        },
      });
    }

    const token = this.generateToken(user.id);
    return { token, user };
  }

  private generateToken(userId: number): string {
    const payload = { sub: userId };
    return this.jwtService.sign(payload);
  }
}
