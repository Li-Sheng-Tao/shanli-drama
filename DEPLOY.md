# 山狸看剧 APP 部署指南

## 环境要求

- Node.js >= 18.x
- Flutter >= 3.x
- MySQL >= 8.0
- Redis >= 6.x
- Docker & Docker Compose（可选，推荐）

## 快速开始（Docker 一键部署）

### 1. 克隆项目

```bash
git clone https://github.com/Li-Sheng-Tao/shanli-drama.git
cd shanli-drama
```

### 2. 配置环境变量

```bash
cd server
cp .env.example .env
# 编辑 .env 文件，修改数据库密码等配置
```

### 3. 启动服务

```bash
# 启动 MySQL + Redis + 后端
docker-compose up -d

# 查看日志
docker-compose logs -f
```

### 4. 初始化数据库

```bash
# 进入后端容器
docker-compose exec server bash

# 生成 Prisma Client
npx prisma generate

# 同步数据库结构
npx prisma db push

# 导入种子数据
npx prisma db seed
```

### 5. 验证部署

访问以下地址验证：

- 后端 API: http://localhost:3000
- Swagger 文档: http://localhost:3000/api-docs
- 健康检查: http://localhost:3000/health

---

## 手动部署

### 前端部署（Flutter）

#### 开发环境运行

```bash
cd app
flutter pub get
flutter run
```

#### 构建 H5 版本

```bash
cd app
flutter build web --release
# 输出目录: app/build/web
```

#### 构建 Android APK

```bash
cd app
flutter build apk --release
# 输出目录: app/build/app/outputs/flutter-apk/
```

#### 构建 iOS

```bash
cd app
flutter build ios --release
# 使用 Xcode 打开 app/ios/Runner.xcworkspace 进行签名打包
```

### 后端部署（NestJS）

#### 1. 安装依赖

```bash
cd server
npm install
```

#### 2. 配置 MySQL

创建数据库：

```sql
CREATE DATABASE shanli_drama CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 3. 配置环境变量

复制并编辑 `.env` 文件：

```bash
cp .env.example .env
```

修改以下配置：

```env
DATABASE_URL="mysql://root:your_password@localhost:3306/shanli_drama"
JWT_SECRET="your_jwt_secret_key"
JWT_EXPIRES_IN="7d"
PORT=3000
```

#### 4. 初始化数据库

```bash
# 生成 Prisma Client
npx prisma generate

# 同步数据库结构
npx prisma db push

# 导入种子数据
npx prisma db seed
```

#### 5. 启动服务

```bash
# 开发环境
npm run start:dev

# 生产环境
npm run build
npm run start:prod
```

---

## 数据库结构

### 16张数据表

| 表名 | 说明 |
|------|------|
| User | 用户表 |
| Drama | 剧集表 |
| Episode | 单集表 |
| WatchRecord | 观看记录表 |
| Favorite | 收藏表 |
| UserFollow | 关注表 |
| CoinTransaction | 金币流水表 |
| DailyTask | 每日任务表 |
| UserDailyTask | 用户每日任务记录 |
| UserCheckin | 签到记录表 |
| VipOrder | VIP订单表 |
| Comment | 评论表 |
| UserLike | 点赞表 |
| Advertisement | 广告配置表 |
| BlindBox | 宝箱配置表 |
| SystemConfig | 系统配置表 |

### Prisma Schema

数据库结构定义在 `server/prisma/schema.prisma` 文件中。

---

## API 接口

### 基础地址

```
http://localhost:3000/api/v1
```

### 主要接口

| 模块 | 接口 | 方法 |
|------|------|------|
| 认证 | /auth/wechat-login | POST |
| 认证 | /auth/phone-login | POST |
| 剧集 | /dramas/feed | GET |
| 剧集 | /dramas/:id | GET |
| 金币 | /coins/balance | GET |
| 金币 | /coins/checkin | POST |
| 任务 | /tasks/daily | GET |
| VIP | /vip/plans | GET |

完整 API 文档请访问：http://localhost:3000/api-docs

---

## 生产环境部署

### 使用 PM2 守护进程

```bash
# 安装 PM2
npm install -g pm2

# 启动服务
cd server
pm2 start dist/main.js --name shanli-drama-server

# 查看状态
pm2 status

# 查看日志
pm2 logs shanli-drama-server

# 重启服务
pm2 restart shanli-drama-server

# 开机自启
pm2 startup
pm2 save
```

### Nginx 反向代理

```nginx
server {
    listen 80;
    server_name your-domain.com;

    # 后端 API
    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # 前端 H5
    location / {
        root /path/to/app/build/web;
        try_files $uri $uri/ /index.html;
    }
}
```

---

## 常见问题

### 1. 数据库连接失败

检查 `.env` 文件中的 `DATABASE_URL` 配置是否正确。

### 2. Prisma Client 未生成

运行 `npx prisma generate` 重新生成。

### 3. 端口被占用

修改 `.env` 文件中的 `PORT` 配置。

### 4. Flutter 依赖安装失败

使用国内镜像：

```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
```

---

## 技术支持

- GitHub Issues: https://github.com/Li-Sheng-Tao/shanli-drama/issues
