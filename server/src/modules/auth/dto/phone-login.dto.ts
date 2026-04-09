import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class PhoneLoginDto {
  @ApiProperty({ description: '手机号' })
  @IsNotEmpty()
  @IsString()
  phone: string;

  @ApiProperty({ description: '验证码' })
  @IsNotEmpty()
  @IsString()
  code: string;
}
