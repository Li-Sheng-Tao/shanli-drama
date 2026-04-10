## [v0.1.0 / 2026-04-10] - uni-app 项目初始化

### 变更类型
- **新增**: uni-app 项目初始化（Vue3 + Pinia + SCSS + pages.json 配置）
- **新增**: 标准项目目录结构（api、assets、components、composables、layouts、pages、stores、utils）
- **新增**: 全局样式系统（颜色、字体、间距、圆角、阴影变量）
- **新增**: 底部导航栏配置（刷刷、找片、福利、我的）
- **新增**: 4 个主页面基础结构
- **新增**: API 接口基础架构
- **新增**: 环境变量配置

### 涉及文件
- **前端**:
  - `uni-app-project/package.json` (项目配置)
  - `uni-app-project/src/main.js` (应用入口)
  - `uni-app-project/src/App.vue` (根组件)
  - `uni-app-project/src/pages.json` (页面路由和底部导航栏配置)
  - `uni-app-project/src/pages/index/index.vue` (刷刷页面)
  - `uni-app-project/src/pages/find/index.vue` (找片页面)
  - `uni-app-project/src/pages/welfare/index.vue` (福利页面)
  - `uni-app-project/src/pages/mine/index.vue` (我的页面)
  - `uni-app-project/src/assets/styles/variables.scss` (样式变量)
  - `uni-app-project/src/assets/styles/mixins.scss` (样式混合器)
  - `uni-app-project/src/assets/styles/global.scss` (全局样式)
  - `uni-app-project/src/api/index.js` (API 统一出口)
  - `uni-app-project/src/api/modules/user.js` (用户 API)
  - `uni-app-project/src/api/modules/drama.js` (剧集 API)
  - `uni-app-project/src/utils/request.js` (请求工具)
  - `uni-app-project/.env` (环境变量配置)
  - `uni-app-project/.env.production` (生产环境配置)

### 备注
- 项目结构已按照 dev-protocol 规范搭建完成
- 样式系统已按照 UI 设计规范配置
- 底部导航栏已配置完成，包含 4 个 Tab
- 依赖版本问题待后续解决，不影响项目结构和配置