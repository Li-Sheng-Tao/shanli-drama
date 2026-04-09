import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { SearchDramaDto, FeedQueryDto } from './dto/search-drama.dto';
import { CreateCommentDto } from './dto/create-comment.dto';
import { PaginationDto } from '../../common/dto/pagination.dto';

@Injectable()
export class DramaService {
  constructor(private prisma: PrismaService) {}

  async getFeed(query: FeedQueryDto) {
    const where: any = { status: 'serial' };
    if (query.genre) {
      where.genre = { contains: query.genre };
    }

    const orderBy: any = {};
    if (query.sort === 'hot') {
      orderBy.playCount = 'desc';
    } else if (query.sort === 'new') {
      orderBy.isNew = 'desc';
    } else {
      orderBy.sortWeight = 'desc';
    }

    const [list, total] = await Promise.all([
      this.prisma.drama.findMany({
        where,
        orderBy,
        skip: query.skip,
        take: query.take,
      }),
      this.prisma.drama.count({ where }),
    ]);

    return { list, total, page: query.page, limit: query.limit };
  }

  async search(query: SearchDramaDto) {
    const where: any = {};
    if (query.keyword) {
      where.OR = [
        { title: { contains: query.keyword } },
        { description: { contains: query.keyword } },
        { tags: { contains: query.keyword } },
      ];
    }
    if (query.genre) {
      where.genre = { contains: query.genre };
    }
    if (query.tag) {
      where.tags = { contains: query.tag };
    }
    if (query.status) {
      where.status = query.status;
    }

    const [list, total] = await Promise.all([
      this.prisma.drama.findMany({
        where,
        orderBy: { sortWeight: 'desc' },
        skip: query.skip,
        take: query.take,
      }),
      this.prisma.drama.count({ where }),
    ]);

    return { list, total, page: query.page, limit: query.limit };
  }

  async findById(id: number) {
    return this.prisma.drama.findUnique({
      where: { id },
      include: {
        episodes: {
          orderBy: { sortOrder: 'asc' },
          select: {
            id: true,
            episodeNumber: true,
            title: true,
            durationSeconds: true,
            isFree: true,
            coinCost: true,
          },
        },
      },
    });
  }

  async getEpisodes(dramaId: number) {
    return this.prisma.episode.findMany({
      where: { dramaId },
      orderBy: { sortOrder: 'asc' },
    });
  }

  async getPlayInfo(dramaId: number, episodeId: number) {
    return this.prisma.episode.findFirst({
      where: { id: episodeId, dramaId },
    });
  }

  async getRankings() {
    const hot = await this.prisma.drama.findMany({
      orderBy: { playCount: 'desc' },
      take: 10,
    });
    const newDramas = await this.prisma.drama.findMany({
      where: { isNew: true },
      orderBy: { createdAt: 'desc' },
      take: 10,
    });
    return { hot, new: newDramas };
  }

  async getCalendar() {
    const dramas = await this.prisma.drama.findMany({
      where: { isNew: true },
      orderBy: { createdAt: 'desc' },
      select: {
        id: true,
        title: true,
        coverUrl: true,
        createdAt: true,
      },
    });
    return dramas;
  }

  async favorite(userId: number, dramaId: number) {
    return this.prisma.favorite.upsert({
      where: { userId_dramaId: { userId, dramaId } },
      create: { userId, dramaId },
      update: {},
    });
  }

  async reserve(userId: number, dramaId: number) {
    // TODO: 实现预约逻辑
    return { success: true };
  }

  async getComments(dramaId: number, query: PaginationDto) {
    const where: any = { dramaId, parentId: null };
    const [list, total] = await Promise.all([
      this.prisma.comment.findMany({
        where,
        orderBy: { createdAt: 'desc' },
        skip: query.skip,
        take: query.take,
        include: {
          user: {
            select: { id: true, nickname: true, avatar: true },
          },
          replies: {
            include: {
              user: {
                select: { id: true, nickname: true, avatar: true },
              },
            },
          },
        },
      }),
      this.prisma.comment.count({ where }),
    ]);

    return { list, total, page: query.page, limit: query.limit };
  }

  async createComment(userId: number, dramaId: number, dto: CreateCommentDto) {
    return this.prisma.comment.create({
      data: {
        userId,
        dramaId,
        content: dto.content,
        episodeId: dto.episodeId,
        parentId: dto.parentId,
      },
    });
  }

  async like(userId: number, dramaId: number) {
    return this.prisma.userLike.upsert({
      where: {
        userId_targetType_targetId: {
          userId,
          targetType: 'drama',
          targetId: dramaId,
        },
      },
      create: { userId, targetType: 'drama', targetId: dramaId },
      update: {},
    });
  }
}
