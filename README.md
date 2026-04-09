# 山狸看剧 (ShanLi Drama)

一款基于 Flutter + NestJS 的短剧聚合平台，支持 iOS、Android、微信小程序和 H5。

## 项目结构

```
├── app/                        # Flutter 前端（原 shanli_drama）
│   ├── lib/
│   │   ├── core/              # 核心基础层（主题、网络、存储、路由）
│   │   ├── models/            # 数据模型
│   │   ├── providers/         # Riverpod 状态管理
│   │   ├── repositories/      # 数据仓库层
│   │   ├── services/          # 业务服务层
│   │   └── features/          # 功能模块
│   │       ├── splash/        # 启动页
│   │       ├── auth/          # 登录
│   │       ├── main_shell/    # 主框架（底部导航）
│   │       ├── feed/          # 主屏A-刷刷（短视频式看剧）
│   │       ├── explore/       # 主屏B-找片（搜索/排行/上新）
│   │       ├── welfare/       # 主屏C-福利（金币/签到/任务/宝箱）
│   │       ├── profile/       # 主屏D-我的（会员/设置）
│   │       └── common/        # 通用组件
│   └── pubspec.yaml
│
├── server/                     # NestJS 后端（原 shanli_drama_server）
│   ├── src/
│   │   ├── modules/           # API 模块
│   │   │   ├── auth/          # 认证（微信/手机号登录）
│   │   │   ├── drama/         # 剧集（推荐/搜索/播放/评论）
│   │   │   ├── coin/          # 金币（余额/签到/兑换）
│   │   │   ├── task/          # 任务（每日任务/领取奖励）
│   │   │   ├── vip/           # 会员（套餐/订单/支付）
│   │   │   ├── ad/            # 广告
│   │   │   ├── blind-box/     # 宝箱盲盒
│   │   │   └── notification/  # 消息通知
│   │   ├── common/            # 公共模块（守卫/拦截器/过滤器）
│   │   └── prisma/            # Prisma 数据库服务
│   ├── prisma/
│   │   └── schema.prisma      # 数据库模型（16张表）
│   └── package.json
│
└── docs/                       # 文档
    └── 山狸看剧APP技术方案.docx
```

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 | Flutter 3.x + Riverpod + GoRouter + Dio |
| 后端 | NestJS + Prisma + MySQL + Redis |
| 存储 | 阿里云 OSS + CDN |
| 广告 | 穿山甲 GroMore |
| 支付 | 微信支付 + 支付宝 |

## 快速开始

### 前端

```bash
cd app
flutter pub get
flutter run                  # 运行
flutter build web --release  # 构建 H5
flutter build apk            # 构建 Android
flutter build ios            # 构建 iOS
```

### 后端

```bash
cd server
npm install
cp .env.example .env         # 配置环境变量
npx prisma db push           # 同步数据库
npm run start:dev            # 启动开发服务
```

访问 Swagger 文档：`http://localhost:3000/api-docs`

## 功能模块

- **主屏A-刷刷**：短视频式上下滑动看剧，点赞/评论/分享/收藏
- **主屏B-找片**：搜索、推荐、排行榜、上新日历、剧集详情
- **主屏C-福利**：金币余额、7天签到、每日任务、宝箱盲盒
- **主屏D-我的**：个人中心、VIP会员购买、设置
- **金币体系**：签到/看剧/任务获取金币，兑换解锁时长或宝箱
- **会员体系**：周/月/季/年套餐，去广告+畅看全部
- **广告系统**：开屏广告、解锁广告、信息流广告

## License

MIT
