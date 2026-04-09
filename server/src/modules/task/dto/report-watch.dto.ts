import { IsNotEmpty, IsInt, Min } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

export class ReportWatchDto {
  @ApiProperty({ description: '剧集ID' })
  @IsNotEmpty()
  @Type(() => Number)
  @IsInt()
  dramaId: number;

  @ApiProperty({ description: '集数ID' })
  @IsNotEmpty()
  @Type(() => Number)
  @IsInt()
  episodeId: number;

  @ApiProperty({ description: '观看时长(秒)' })
  @IsNotEmpty()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  watchDuration: number;
}
