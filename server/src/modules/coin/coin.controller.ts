import { Controller, Get, Post, Body, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { CoinService } from './coin.service';
import { ExchangeDto } from './dto/exchange.dto';
import { PaginationDto } from '../../common/dto/pagination.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';

@ApiTags('金币')
@ApiBearerAuth()
@Controller('api/v1/coins')
@UseGuards(JwtAuthGuard)
export class CoinController {
  constructor(private readonly coinService: CoinService) {}

  @Get('balance')
  @ApiOperation({ summary: '获取金币余额' })
  async getBalance(@CurrentUser('id') userId: number) {
    return this.coinService.getBalance(userId);
  }

  @Get('transactions')
  @ApiOperation({ summary: '金币流水' })
  async getTransactions(
    @CurrentUser('id') userId: number,
    @Query() query: PaginationDto,
  ) {
    return this.coinService.getTransactions(userId, query);
  }

  @Post('checkin')
  @ApiOperation({ summary: '签到' })
  async checkin(@CurrentUser('id') userId: number) {
    return this.coinService.checkin(userId);
  }

  @Post('exchange')
  @ApiOperation({ summary: '兑换' })
  async exchange(
    @CurrentUser('id') userId: number,
    @Body() dto: ExchangeDto,
  ) {
    return this.coinService.exchange(userId, dto);
  }
}
