import { Module } from '@nestjs/common';
import { AdService } from './ad.service';
import { AdController } from './ad.controller';

@Module({
  controllers: [AdController],
  providers: [AdService],
  exports: [AdService],
})
export class AdModule {}
