import {
  Controller,
  Get,
  Post,
  Param,
  Query,
  Body,
  ParseIntPipe,
  UseGuards,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { DramaService } from './drama.service';
import { FeedQueryDto, SearchDramaDto } from './dto/search-drama.dto';
import { CreateCommentDto } from './dto/create-comment.dto';
import { PaginationDto } from '../../common/dto/pagination.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';

@ApiTags('剧集')
@Controller('api/v1/dramas')
export class DramaController {
  constructor(private readonly dramaService: DramaService) {}

  @Get('feed')
  @ApiOperation({ summary: '推荐流' })
  async getFeed(@Query() query: FeedQueryDto) {
    return this.dramaService.getFeed(query);
  }

  @Get('search')
  @ApiOperation({ summary: '搜索剧集' })
  async search(@Query() query: SearchDramaDto) {
    return this.dramaService.search(query);
  }

  @Get('rankings')
  @ApiOperation({ summary: '排行榜' })
  async getRankings() {
    return this.dramaService.getRankings();
  }

  @Get('calendar')
  @ApiOperation({ summary: '上新日历' })
  async getCalendar() {
    return this.dramaService.getCalendar();
  }

  @Get(':id')
  @ApiOperation({ summary: '剧集详情' })
  async findById(@Param('id', ParseIntPipe) id: number) {
    return this.dramaService.findById(id);
  }

  @Get(':id/episodes')
  @ApiOperation({ summary: '集数列表' })
  async getEpisodes(@Param('id', ParseIntPipe) id: number) {
    return this.dramaService.getEpisodes(id);
  }

  @Get(':id/play/:episodeId')
  @ApiOperation({ summary: '播放地址' })
  async getPlayInfo(
    @Param('id', ParseIntPipe) id: number,
    @Param('episodeId', ParseIntPipe) episodeId: number,
  ) {
    return this.dramaService.getPlayInfo(id, episodeId);
  }

  @Post(':id/favorite')
  @ApiOperation({ summary: '收藏' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async favorite(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) dramaId: number,
  ) {
    return this.dramaService.favorite(userId, dramaId);
  }

  @Post(':id/reserve')
  @ApiOperation({ summary: '预约' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async reserve(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) dramaId: number,
  ) {
    return this.dramaService.reserve(userId, dramaId);
  }

  @Get(':id/comments')
  @ApiOperation({ summary: '评论列表' })
  async getComments(
    @Param('id', ParseIntPipe) id: number,
    @Query() query: PaginationDto,
  ) {
    return this.dramaService.getComments(id, query);
  }

  @Post(':id/comments')
  @ApiOperation({ summary: '发表评论' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async createComment(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) dramaId: number,
    @Body() dto: CreateCommentDto,
  ) {
    return this.dramaService.createComment(userId, dramaId, dto);
  }

  @Post(':id/like')
  @ApiOperation({ summary: '点赞' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  async like(
    @CurrentUser('id') userId: number,
    @Param('id', ParseIntPipe) dramaId: number,
  ) {
    return this.dramaService.like(userId, dramaId);
  }
}
