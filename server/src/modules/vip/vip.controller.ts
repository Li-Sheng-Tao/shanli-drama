import { Controller, Get, Post, Body, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { VipService } from './vip.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';

@ApiTags('VIP')
@Controller('api/v1/vip')
export class VipController {
  constructor(private readonly vipService: VipService) {}

  @Get('plans')
  @ApiOperation({ summary: 'VIP套餐列表' })
  async getPlans() {
    return this.vipService.getPlans();
  }

  @Post('order/create')
  @ApiOperation({ summary: '创建VIP订单' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async createOrder(
    @CurrentUser('id') userId: number,
    @Body() dto: CreateOrderDto,
  ) {
    return this.vipService.createOrder(userId, dto);
  }

  @Post('order/callback')
  @ApiOperation({ summary: '支付回调' })
  async handleCallback(@Body() body: { orderNo: string; payStatus: string }) {
    return this.vipService.handleCallback(body.orderNo, body.payStatus);
  }

  @Get('order/verify')
  @ApiOperation({ summary: '验证会员状态' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async verifyVip(@CurrentUser('id') userId: number) {
    return this.vipService.verifyVip(userId);
  }
}
