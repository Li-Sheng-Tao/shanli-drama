import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './modules/auth/auth.module';
import { UserModule } from './modules/user/user.module';
import { DramaModule } from './modules/drama/drama.module';
import { CoinModule } from './modules/coin/coin.module';
import { TaskModule } from './modules/task/task.module';
import { VipModule } from './modules/vip/vip.module';
import { AdModule } from './modules/ad/ad.module';
import { BlindBoxModule } from './modules/blind-box/blind-box.module';
import { NotificationModule } from './modules/notification/notification.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    AuthModule,
    UserModule,
    DramaModule,
    CoinModule,
    TaskModule,
    VipModule,
    AdModule,
    BlindBoxModule,
    NotificationModule,
  ],
})
export class AppModule {}
