import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateOrderDto {
  @ApiProperty({ description: '套餐类型: week/month/quarter/year' })
  @IsNotEmpty()
  @IsString()
  planType: string;

  @ApiProperty({ description: '支付方式: wechat/alipay' })
  @IsNotEmpty()
  @IsString()
  payMethod: string;
}
