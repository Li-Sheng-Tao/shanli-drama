import { Module } from '@nestjs/common';
import { BlindBoxService } from './blind-box.service';
import { BlindBoxController } from './blind-box.controller';

@Module({
  controllers: [BlindBoxController],
  providers: [BlindBoxService],
  exports: [BlindBoxService],
})
export class BlindBoxModule {}
