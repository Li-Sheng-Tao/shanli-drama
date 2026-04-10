# 前端请求封装 - 产品需求文档

## Overview
- **Summary**: 实现前端请求封装，支持 H5 端使用 axios，小程序/APP 端使用 uni.request，通过条件编译实现跨平台兼容
- **Purpose**: 为前端与后端 API 交互提供统一的请求接口，处理请求配置、错误处理、身份验证等通用逻辑
- **Target Users**: 前端开发人员，使用统一的请求方法进行 API 调用

## Goals
- 实现跨平台请求封装（H5、小程序、APP）
- 提供统一的请求方法和错误处理机制
- 支持请求头配置、身份验证、超时处理
- 实现请求和响应拦截器

## Non-Goals (Out of Scope)
- 后端 API 实现
- 业务逻辑处理
- 数据缓存机制

## Background & Context
- 前端使用 uni-app 框架进行跨端开发
- H5 端可以使用 axios 库
- 小程序和 APP 端只能使用 uni.request
- 需要通过条件编译实现不同平台的适配

## Functional Requirements
- **FR-1**: 实现统一的请求方法，支持 GET、POST、PUT、DELETE 等 HTTP 方法
- **FR-2**: H5 端使用 axios，小程序/APP 端使用 uni.request
- **FR-3**: 支持请求头配置，包括 Content-Type、Authorization 等
- **FR-4**: 实现请求和响应拦截器
- **FR-5**: 统一的错误处理机制

## Non-Functional Requirements
- **NFR-1**: 代码风格符合项目规范
- **NFR-2**: 跨平台兼容性良好
- **NFR-3**: 性能优化，避免重复请求
- **NFR-4**: 可维护性高，易于扩展

## Constraints
- **Technical**: uni-app 框架限制，小程序/APP 端不能使用 axios
- **Dependencies**: 前端依赖 axios（H5 端）

## Assumptions
- 后端 API 接口格式统一
- 身份验证使用 JWT token
- 请求超时时间为 15 秒

## Acceptance Criteria

### AC-1: 跨平台请求封装
- **Given**: 前端代码在不同平台运行
- **When**: 调用请求方法
- **Then**: H5 端使用 axios，小程序/APP 端使用 uni.request
- **Verification**: `programmatic`

### AC-2: 统一请求方法
- **Given**: 前端代码需要调用 API
- **When**: 使用封装的 request 方法
- **Then**: 支持不同 HTTP 方法，参数格式统一
- **Verification**: `programmatic`

### AC-3: 请求头配置
- **Given**: 需要设置请求头信息
- **When**: 配置请求选项
- **Then**: 请求头正确设置并发送
- **Verification**: `programmatic`

### AC-4: 错误处理
- **Given**: API 请求失败
- **When**: 服务器返回错误或网络异常
- **Then**: 统一的错误处理机制捕获并处理错误
- **Verification**: `programmatic`

### AC-5: 拦截器功能
- **Given**: 需要在请求前或响应后执行逻辑
- **When**: 配置拦截器
- **Then**: 拦截器正确执行
- **Verification**: `programmatic`

## Open Questions
- [ ] 后端 API 基础 URL 的配置方式
- [ ] 错误处理的具体策略