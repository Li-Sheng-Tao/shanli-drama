import { Controller, Get, Post, Param, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { BlindBoxService } from './blind-box.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { ParseIntPipe } from '@nestjs/common';

@ApiTags('宝箱')
@Controller('api/v1/blind-boxes')
export class BlindBoxController {
  constructor(private readonly blindBoxService: BlindBoxService) {}

  @Get('list')
  @ApiOperation({ summary: '宝箱列表' })
  async getList() {
    return this.blindBoxService.getList();
  }

  @Post('open/:id')
  @ApiOperation({ summary: '开宝箱' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async openBox(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) boxId: number,
  ) {
    return this.blindBoxService.openBox(userId, boxId);
  }
}
