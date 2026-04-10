# 山狸漫剧APP - 产品需求文档

## Overview
- **Summary**: 山狸漫剧APP是一款集短视频剧集观看、金币任务系统、会员服务于一体的移动应用，为用户提供丰富的剧集内容和互动体验。
- **Purpose**: 解决用户碎片化娱乐需求，提供高质量的剧集内容和便捷的观看体验，同时通过金币和会员系统实现商业变现。
- **Target Users**: 喜欢观看短视频剧集的移动用户，年龄跨度广，注重娱乐体验和互动性。

## Goals
- 提供流畅的剧集观看体验
- 实现金币任务系统，增强用户粘性
- 构建会员服务体系，提升用户价值
- 开发后台管理系统，方便运营管理
- 确保应用性能稳定，用户体验良好

## Non-Goals (Out of Scope)
- 不支持PC端桌面应用
- 不包含直播功能（二期规划）
- 不提供内容创作平台（二期规划）
- 不支持离线下载功能

## Background & Context
- 参考竞品：火龙漫剧APP（UI设计和播放体验）、东梨短剧APP（金币系统）
- 产品定位：短视频剧集平台，注重用户体验和互动性
- 商业模式：会员订阅 + 广告变现

## Functional Requirements
- **FR-1**: 剧集观看功能（刷刷屏）
- **FR-2**: 剧集搜索和分类功能（找片屏）
- **FR-3**: 金币任务系统（福利屏）
- **FR-4**: 用户个人中心（我的屏）
- **FR-5**: 会员服务系统
- **FR-6**: 广告系统（开屏、解锁、弹窗）
- **FR-7**: 后台管理系统

## Non-Functional Requirements
- **NFR-1**: 性能要求 - 应用启动时间<3秒，视频加载时间<2秒
- **NFR-2**: 安全性 - 全站HTTPS加密，JWT Token认证，视频DRM加密
- **NFR-3**: 兼容性 - 支持Android 6.0+和iOS 12.0+设备
- **NFR-4**: 可扩展性 - 支持后续功能迭代和内容扩展

## Constraints
- **Technical**: 前端使用React Native，后端使用Node.js，数据库使用PostgreSQL
- **Business**: 一期开发周期3个月，预算有限
- **Dependencies**: 视频CDN服务，广告联盟API，支付网关

## Assumptions
- 用户拥有智能手机并能连接互联网
- 内容提供商能够持续提供高质量剧集
- 广告主能够提供合适的广告内容

## Acceptance Criteria

### AC-1: 剧集观看功能
- **Given**: 用户打开APP进入刷刷屏
- **When**: 用户向上滑动屏幕
- **Then**: 系统自动播放下一个剧集，加载时间<2秒
- **Verification**: `programmatic`

### AC-2: 金币任务系统
- **Given**: 用户进入福利屏
- **When**: 用户完成指定任务
- **Then**: 系统立即发放相应金币到用户账户
- **Verification**: `programmatic`

### AC-3: 会员服务
- **Given**: 用户购买会员
- **When**: 用户观看剧集
- **Then**: 系统跳过广告，直接播放剧集
- **Verification**: `programmatic`

### AC-4: 后台管理
- **Given**: 管理员登录后台
- **When**: 管理员上传新剧集
- **Then**: 系统成功处理并在前端展示
- **Verification**: `programmatic`

### AC-5: 广告系统
- **Given**: 用户打开APP
- **When**: 应用启动
- **Then**: 系统显示开屏广告，时长3秒
- **Verification**: `programmatic`

## Open Questions
- [ ] 具体的视频CDN服务选择
- [ ] 广告联盟的具体合作方式
- [ ] 会员定价策略
- [ ] 内容审核机制的具体实现
- [ ] 数据埋点的具体方案