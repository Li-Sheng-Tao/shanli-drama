# 阶段1：构建
FROM node:18-alpine AS builder

WORKDIR /app

# 复制 package 文件
COPY package*.json ./

# 安装依赖
RUN npm ci

# 复制源代码
COPY . .

# 构建
RUN npm run build

# 阶段2：运行
FROM node:18-alpine

WORKDIR /app

# 复制 package 文件
COPY package*.json ./

# 安装生产依赖
RUN npm ci --only=production

# 从构建阶段复制构建产物
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

# 生成 Prisma Client
RUN npx prisma generate

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["node", "dist/main"]
