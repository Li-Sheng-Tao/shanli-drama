import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('开始插入种子数据...');

  // 插入每日任务
  await prisma.dailyTask.createMany({
    data: [
      {
        taskKey: 'watch_1min',
        taskName: '看剧1分钟',
        description: '观看视频1分钟',
        coinReward: 5,
        targetValue: 60,
        taskType: 'watch_duration',
        sortOrder: 1,
      },
      {
        taskKey: 'watch_5min',
        taskName: '看剧5分钟',
        description: '观看视频5分钟',
        coinReward: 20,
        targetValue: 300,
        taskType: 'watch_duration',
        sortOrder: 2,
      },
      {
        taskKey: 'watch_10min',
        taskName: '看剧10分钟',
        description: '观看视频10分钟',
        coinReward: 50,
        targetValue: 600,
        taskType: 'watch_duration',
        sortOrder: 3,
      },
      {
        taskKey: 'checkin',
        taskName: '每日签到',
        description: '每天签到领取金币',
        coinReward: 10,
        targetValue: 1,
        taskType: 'checkin',
        sortOrder: 4,
      },
      {
        taskKey: 'share_drama',
        taskName: '分享剧集',
        description: '分享剧集到微信',
        coinReward: 20,
        targetValue: 1,
        taskType: 'share',
        sortOrder: 5,
      },
      {
        taskKey: 'reserve_drama',
        taskName: '预约剧集',
        description: '预约即将上新的剧集',
        coinReward: 10,
        targetValue: 1,
        taskType: 'reserve',
        sortOrder: 6,
      },
    ],
    skipDuplicates: true,
  });

  // 插入系统配置
  await prisma.systemConfig.createMany({
    data: [
      { configKey: 'coin_per_minute', configValue: '5', description: '每分钟观看获得金币数' },
      { configKey: 'max_daily_coin', configValue: '60', description: '每日观看金币上限' },
      { configKey: 'vip_week_price', configValue: '9.90', description: '周会员价格' },
      { configKey: 'vip_month_price', configValue: '29.90', description: '月会员价格' },
      { configKey: 'vip_quarter_price', configValue: '79.90', description: '季会员价格' },
      { configKey: 'vip_year_price', configValue: '199.90', description: '年会员价格' },
    ],
    skipDuplicates: true,
  });

  // 插入广告配置
  await prisma.advertisement.createMany({
    data: [
      {
        adPosition: 'splash',
        adProvider: 'pangolin',
        adUnitId: 'splash_ad_unit_id',
        priority: 1,
      },
      {
        adPosition: 'unlock',
        adProvider: 'pangolin',
        adUnitId: 'unlock_ad_unit_id',
        priority: 1,
      },
      {
        adPosition: 'feed',
        adProvider: 'pangolin',
        adUnitId: 'feed_ad_unit_id',
        priority: 1,
      },
    ],
    skipDuplicates: true,
  });

  // 插入宝箱配置
  await prisma.blindBox.createMany({
    data: [
      {
        boxName: '小宝箱',
        boxType: 'small',
        coinCost: 100,
        probabilityConfig: JSON.stringify({ min: 50, max: 200 }),
      },
      {
        boxName: '中宝箱',
        boxType: 'medium',
        coinCost: 500,
        probabilityConfig: JSON.stringify({ min: 300, max: 800 }),
      },
      {
        boxName: '大宝箱',
        boxType: 'large',
        coinCost: 1000,
        probabilityConfig: JSON.stringify({ min: 800, max: 2000 }),
      },
    ],
    skipDuplicates: true,
  });

  // 插入测试剧集
  const dramas = await prisma.drama.createMany({
    data: [
      {
        title: '总裁的替身新娘',
        coverUrl: 'https://example.com/covers/drama1.jpg',
        verticalCoverUrl: 'https://example.com/covers/drama1_v.jpg',
        description: '豪门总裁与替身新娘的虐恋情深',
        genre: '甜宠',
        tags: '总裁,替身,甜宠',
        episodeCount: 100,
        status: 'serial',
        isExclusive: true,
        isNew: true,
        playCount: 10000,
        collectCount: 500,
        sortWeight: 100,
      },
      {
        title: '重生之复仇女王',
        coverUrl: 'https://example.com/covers/drama2.jpg',
        verticalCoverUrl: 'https://example.com/covers/drama2_v.jpg',
        description: '重生后复仇虐渣，成为女王',
        genre: '逆袭',
        tags: '重生,复仇,逆袭',
        episodeCount: 80,
        status: 'serial',
        isExclusive: false,
        isNew: true,
        playCount: 8000,
        collectCount: 400,
        sortWeight: 90,
      },
      {
        title: '穿越时空爱上你',
        coverUrl: 'https://example.com/covers/drama3.jpg',
        verticalCoverUrl: 'https://example.com/covers/drama3_v.jpg',
        description: '穿越时空与古代王爷的浪漫爱情',
        genre: '穿越',
        tags: '穿越,爱情,王爷',
        episodeCount: 120,
        status: 'serial',
        isExclusive: true,
        isNew: false,
        playCount: 15000,
        collectCount: 800,
        sortWeight: 95,
      },
      {
        title: '神秘庄园的秘密',
        coverUrl: 'https://example.com/covers/drama4.jpg',
        verticalCoverUrl: 'https://example.com/covers/drama4_v.jpg',
        description: '庄园里的悬疑案件，揭开真相',
        genre: '悬疑',
        tags: '悬疑,推理,庄园',
        episodeCount: 60,
        status: 'finished',
        isExclusive: false,
        isNew: false,
        playCount: 5000,
        collectCount: 300,
        sortWeight: 80,
      },
      {
        title: '霸道王爷俏王妃',
        coverUrl: 'https://example.com/covers/drama5.jpg',
        verticalCoverUrl: 'https://example.com/covers/drama5_v.jpg',
        description: '霸道王爷与俏皮王妃的欢喜冤家',
        genre: '甜宠',
        tags: '王爷,王妃,甜宠',
        episodeCount: 90,
        status: 'serial',
        isExclusive: true,
        isNew: true,
        playCount: 12000,
        collectCount: 600,
        sortWeight: 85,
      },
    ],
    skipDuplicates: true,
  });

  console.log('种子数据插入完成！');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
