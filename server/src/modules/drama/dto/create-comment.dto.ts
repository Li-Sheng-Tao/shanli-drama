import { IsNotEmpty, IsString, IsOptional, IsInt } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class CreateCommentDto {
  @ApiProperty({ description: '评论内容' })
  @IsNotEmpty()
  @IsString()
  content: string;

  @ApiPropertyOptional({ description: '集数ID' })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  episodeId?: number;

  @ApiPropertyOptional({ description: '父评论ID' })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  parentId?: number;
}
