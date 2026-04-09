import { IsNotEmpty, IsInt, Min } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

export class ExchangeDto {
  @ApiProperty({ description: '兑换类型' })
  @IsNotEmpty()
  @IsInt()
  @Type(() => Number)
  type: number;

  @ApiProperty({ description: '兑换数量' })
  @IsNotEmpty()
  @IsInt()
  @Min(1)
  @Type(() => Number)
  amount: number;
}
