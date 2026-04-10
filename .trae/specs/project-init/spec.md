# 山狸漫剧APP - 项目初始化产品需求文档

## Overview
- **Summary**: 初始化 uni-app 项目（Vue3 + Composition API），配置基础架构、样式系统和底部导航栏，为后续功能开发做准备。
- **Purpose**: 建立统一的前端项目结构和开发规范，确保跨端兼容性和开发效率。
- **Target Users**: 开发团队、前端工程师

## Goals
- 完成 uni-app 项目初始化，配置 Vue3 + Pinia + SCSS
- 建立符合设计规范的全局样式系统（颜色、字体、间距、圆角等）
- 配置底部导航栏（刷刷、找片、福利、我的）
- 建立标准的项目目录结构
- 确保 H5 端优先开发的基础架构

## Non-Goals (Out of Scope)
- 不包含具体业务功能实现
- 不包含后端 API 集成
- 不包含小程序和 APP 端的具体适配
- 不包含第三方服务集成

## Background & Context
- 项目采用 uni-app 跨端框架，支持 H5、小程序、APP 三端
- 技术栈：Vue 3 + Composition API + Pinia + SCSS
- 开发优先级：H5 优先验证效果，然后是小程序和 APP
- 设计规范已在 07-UI设计规范.md 中定义

## Functional Requirements
- **FR-1**: 初始化 uni-app 项目，配置 Vue3、Pinia、SCSS 依赖
- **FR-2**: 建立标准项目目录结构，包含 api、assets、components、composables、layouts、pages、stores、utils 等目录
- **FR-3**: 配置 pages.json，定义底部导航栏和页面路由
- **FR-4**: 创建全局样式系统，包含颜色变量、字体、间距、圆角、阴影等设计令牌
- **FR-5**: 实现底部导航栏组件，支持 4 个 Tab（刷刷、找片、福利、我的）
- **FR-6**: 配置环境变量和构建脚本

## Non-Functional Requirements
- **NFR-1**: 代码风格符合 dev-protocol 规范
- **NFR-2**: 跨端兼容性，优先保证 H5 端体验
- **NFR-3**: 项目结构清晰，易于维护和扩展
- **NFR-4**: 构建流程顺畅，支持开发和生产环境

## Constraints
- **Technical**: 使用 uni-app 框架，Vue 3 + Composition API，Pinia 状态管理
- **Dependencies**: 需要安装必要的依赖包（Pinia、SCSS 等）

## Assumptions
- 开发环境已配置 Node.js 和 npm/yarn
- 已安装 uni-app 官方脚手架工具
- 设计规范文档（07-UI设计规范.md）已就绪

## Acceptance Criteria

### AC-1: 项目初始化完成
- **Given**: 开发环境已配置
- **When**: 执行项目初始化命令
- **Then**: 生成 uni-app 项目结构，包含必要的配置文件
- **Verification**: `programmatic`

### AC-2: 依赖配置正确
- **Given**: 项目已初始化
- **When**: 安装依赖包
- **Then**: 成功安装 Vue 3、Pinia、SCSS 等依赖
- **Verification**: `programmatic`

### AC-3: 目录结构规范
- **Given**: 项目已初始化
- **When**: 检查项目目录
- **Then**: 包含标准目录结构（api、assets、components、composables、layouts、pages、stores、utils）
- **Verification**: `human-judgment`

### AC-4: 样式系统建立
- **Given**: 项目已初始化
- **When**: 查看样式文件
- **Then**: 包含全局样式变量，符合设计规范
- **Verification**: `human-judgment`

### AC-5: 底部导航栏配置
- **Given**: 项目已初始化
- **When**: 查看 pages.json
- **Then**: 正确配置 4 个 Tab 的底部导航栏
- **Verification**: `programmatic`

### AC-6: H5 端构建成功
- **Given**: 项目已初始化和配置
- **When**: 执行 H5 构建命令
- **Then**: 构建成功，无错误
- **Verification**: `programmatic`

## Open Questions
- [ ] 是否需要配置 ESLint 和 Prettier 等代码质量工具？
- [ ] 是否需要集成 TypeScript？
- [ ] 项目名称和应用标识如何设置？