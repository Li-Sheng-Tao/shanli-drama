import { IsOptional, IsString, IsInt, Min } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiPropertyOptional } from '@nestjs/swagger';
import { PaginationDto } from '../../../common/dto/pagination.dto';

export class SearchDramaDto extends PaginationDto {
  @ApiPropertyOptional({ description: '搜索关键词' })
  @IsOptional()
  @IsString()
  keyword?: string;

  @ApiPropertyOptional({ description: '分类' })
  @IsOptional()
  @IsString()
  genre?: string;

  @ApiPropertyOptional({ description: '标签' })
  @IsOptional()
  @IsString()
  tag?: string;

  @ApiPropertyOptional({ description: '状态: serial/finished' })
  @IsOptional()
  @IsString()
  status?: string;
}

export class FeedQueryDto extends PaginationDto {
  @ApiPropertyOptional({ description: '分类筛选' })
  @IsOptional()
  @IsString()
  genre?: string;

  @ApiPropertyOptional({ description: '排序方式: latest/hot/new' })
  @IsOptional()
  @IsString()
  sort?: string;
}
