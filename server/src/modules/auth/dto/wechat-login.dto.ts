import { IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class WechatLoginDto {
  @ApiProperty({ description: '微信 code' })
  @IsNotEmpty()
  @IsString()
  code: string;

  @ApiProperty({ description: '微信 encryptedData', required: false })
  @IsOptional()
  @IsString()
  encryptedData?: string;

  @ApiProperty({ description: '微信 iv', required: false })
  @IsOptional()
  @IsString()
  iv?: string;
}
