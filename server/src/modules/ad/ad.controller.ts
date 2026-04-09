import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AdService } from './ad.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

class AdRewardDto {
  @ApiProperty({ description: '广告位置: splash/unlock/feed' })
  @IsNotEmpty()
  @IsString()
  adPosition: string;
}

@ApiTags('广告')
@Controller('api/v1/ads')
export class AdController {
  constructor(private readonly adService: AdService) {}

  @Get('config')
  @ApiOperation({ summary: '广告配置' })
  async getConfig() {
    return this.adService.getConfig();
  }

  @Post('reward')
  @ApiOperation({ summary: '广告奖励' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async reward(
    @CurrentUser('id') userId: number,
    @Body() dto: AdRewardDto,
  ) {
    return this.adService.reward(userId, dto.adPosition);
  }
}
