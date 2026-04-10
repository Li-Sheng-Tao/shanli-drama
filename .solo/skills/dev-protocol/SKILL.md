---
name: dev-protocol
description: 'AI 开发协议执行器，用于指导 uni-app (Vue 3 + Composition API) 跨端开发和 Python (FastAPI) 后端开发，确保代码风格一致、开发流程规范、变更记录完整。'
license: MIT
allowed-tools: Bash, FileSystem
---

# AI 开发协议 (Dev Protocol)

> **触发方式**：自动加载，每次开发任务开始时 AI 必须遵循本协议
> **适用技术栈**：前端 uni-app (Vue 3 + Composition API) 跨端开发（H5 → 小程序 → APP） + 后端 Python (FastAPI)
> **开发优先级**：H5 优先验证效果 → 小程序同步适配 → APP 后续开发
> **核心目标**：保持代码风格一致、开发流程规范、变更记录完整
> **关联文档**：
> - 任务看板：`山狸漫剧APP产品需求文档/TASKBOARD.md`
> - UI 设计规范：`山狸漫剧APP产品需求文档/07-UI设计规范.md`
> - UI 参考截图：`山狸漫剧APP产品需求文档/ui-reference/`

## 零、任务认领流程（每次开发前必做）

AI 每次接到开发指令时，**必须**先执行任务认领：

### Step 0: 认领任务

```
1. 读取 TASKBOARD.md → 查看 TODO 列表和 DOING 列表
2. 如果用户指定了具体任务 → 在看板中找到对应任务
3. 如果用户未指定任务 → 按优先级(P0→P1)和依赖关系推荐可开发任务
4. 将任务从 TODO 移至 DOING（填写开始日期）
5. 向用户确认任务范围后开始开发
```

### Step 0.1: 任务完成后

```
1. 更新 CHANGELOG.md（按协议格式记录变更）
2. 将任务从 DOING 移至 DONE（填写完成日期和版本号）
3. 检查是否有因本任务完成而解锁的新可开发任务
4. 向用户报告完成情况
```

---

## 一、开发任务启动流程

每次确认开发任务后，AI **必须**按以下顺序执行：

### Step 1: 读取项目上下文

```
1. 读取 CHANGELOG.md → 了解最近开发历史和当前进度
2. 读取 TASKBOARD.md → 了解当前任务状态和整体进度
3. 读取 07-UI设计规范.md → 了解目标页面的设计规格
4. 读取 ui-reference/ 目录中的参考截图 → 了解视觉目标
5. 读取项目根目录的 package.json / composer.json → 了解依赖和项目配置
6. 读取已有的代码文件 → 了解当前代码风格和结构
```

### Step 2: 任务分析

在动手写代码之前，先明确：

```
- 任务目标：要实现什么功能/修复什么问题
- UI 参考：对照 07-UI设计规范.md 和 ui-reference/ 截图
- 影响范围：涉及哪些文件/模块
- 依赖关系：是否需要新增依赖，TASKBOARD 中标注的前置任务是否完成
- 风险评估：是否影响已有功能
```

### Step 3: 制定开发计划

向用户输出开发计划，包含：

```
- 任务概述（一句话说明）
- 涉及文件列表
- 开发步骤（1, 2, 3...）
- 预计影响
```

### Step 4: 执行开发

按计划逐步执行，每完成一个步骤确认无误后再进行下一步。

### Step 5: 收尾

开发完成后**必须**执行收尾流程（见下方"开发收尾规范"）。

---

## 二、前端代码规范 (uni-app)

### 2.1 项目结构

```
src/
├── api/                  # API 接口定义
│   ├── modules/          # 按模块划分
│   │   ├── user.js
│   │   ├── drama.js
│   │   └── ...
│   └── index.js          # 统一导出 + 请求实例
├── assets/               # 静态资源（图片、字体、全局样式）
│   ├── images/
│   ├── fonts/
│   └── styles/
│       ├── variables.scss    # SCSS 变量
│       ├── mixins.scss       # SCSS 混入
│       └── global.scss       # 全局样式
├── components/           # 公共组件
│   ├── common/           # 通用基础组件
│   └── business/         # 业务通用组件
├── composables/          # 组合式函数（hooks）
├── layouts/              # 布局组件
├── pages/                # 页面（uni-app 页面目录）
│   ├── index/            # 首页（刷刷）
│   │   └── index.vue
│   ├── find/             # 找片
│   │   └── index.vue
│   ├── welfare/          # 福利
│   │   └── index.vue
│   ├── mine/             # 我的
│   │   └── index.vue
│   ├── drama/            # 剧集相关
│   │   ├── detail.vue    # 剧集详情
│   │   └── play.vue      # 播放页
│   └── ...
├── stores/               # Pinia 状态管理
│   ├── index.js
│   └── modules/
├── utils/                # 工具函数
├── App.vue
├── main.js
├── manifest.json         # uni-app 配置
├── pages.json            # 页面路由配置
└── uni.scss              # uni-app 内置 SCSS 变量
```

### 2.2 跨端开发注意事项

| 注意事项 | 说明 |
|---------|------|
| 条件编译 | 使用 `#ifdef H5` / `#ifdef MP-WEIXIN` / `#ifdef APP-PLUS` 做平台差异处理 |
| 请求封装 | H5 用 axios，小程序/APP 用 uni.request，统一封装在 `utils/request.js` |
| 路由跳转 | 使用 `uni.navigateTo` / `uni.switchTab`，不用 vue-router |
| 状态栏适配 | 使用 `uni.getSystemInfoSync()` 获取状态栏高度动态适配 |
| 安全区域 | 使用 `uni.getSystemInfoSync().safeAreaInsets` 处理底部安全区 |
| 视频播放 | H5 使用 `<video>` 标签，小程序使用 `<video>` 组件，注意属性差异 |
| 支付 | H5 对接微信 H5 支付，小程序对接微信小程序支付 |
| 登录 | H5 使用手机号+验证码，小程序使用 `uni.login` + 手机号授权 |
| 分享 | 小程序使用 `onShareAppMessage`，H5 可自定义分享链接 |
| 桌面组件 | 仅 APP 端支持 `uni.createDesktopShortcut`，需条件编译 |

### 2.3 条件编译示例

```javascript
// #ifdef H5
import axios from 'axios'
// #endif

// #ifdef MP-WEIXIN
// 小程序端使用 uni.request
// #endif

// #ifdef APP-PLUS
// APP 端专属逻辑
// #endif
```

### 2.4 命名规范

| 类型 | 规则 | 示例 |
|------|------|------|
| 组件文件 | PascalCase | `UserProfile.vue`, `DramaList.vue` |
| 组件 name | PascalCase，与文件名一致 | `name: 'UserProfile'` |
| 组合式函数 | camelCase，use 前缀 | `useUserAuth.js`, `useDramaList.js` |
| API 文件 | camelCase | `userService.js`, `dramaApi.js` |
| 路由路径 | kebab-case | `/user-profile`, `/drama-list` |
| CSS 类名 | BEM 命名 | `.block__element--modifier` |
| 常量 | UPPER_SNAKE_CASE | `MAX_PAGE_SIZE`, `API_BASE_URL` |
| 变量/函数 | camelCase | `userName`, `fetchDramaList` |
| props | camelCase | `:dramaId`, `:isVisible` |
| emit 事件 | kebab-case | `@update-drama`, `@close-modal` |
| Store | camelCase | `useUserStore`, `useDramaStore` |

### 2.5 Vue 组件规范

```vue
<!-- 组件模板顺序 -->
<template>
  <!-- 1. 根元素，单一根节点 -->
  <!-- 2. 按逻辑分区，用注释分隔 -->
</template>

<script setup>
// 1. 导入顺序：
//    ① Vue 内置
//    ② 第三方库
//    ③ 项目内部（@/ 开头）
//    ④ 相对路径

// 2. Props 定义
const props = defineProps({
  dramaId: {
    type: Number,
    required: true,
  },
  title: {
    type: String,
    default: '',
  },
})

// 3. Emits 定义
const emit = defineEmits(['update', 'close'])

// 4. 响应式状态
const loading = ref(false)
const dataList = ref([])

// 5. 计算属性
const filteredList = computed(() => {
  return dataList.value.filter(item => item.active)
})

// 6. 方法
function handleClick() {
  // ...
}

// 7. 生命周期
onMounted(() => {
  // ...
})

// 8. 暴露给父组件
defineExpose({
  refresh: handleClick,
})
</script>

<style lang="scss" scoped>
/* 使用 BEM 命名 */
.drama-card {
  &__title {
    font-size: 16px;
  }

  &--active {
    color: #1890ff;
  }
}
</style>
```

### 2.6 API 接口规范

```javascript
// src/api/modules/drama.js
import { request } from '@/api/index'

/** 获取剧集列表 */
export function getDramaList(params) {
  return request({
    url: '/api/v1/dramas',
    method: 'GET',
    data: params,
  })
}

/** 获取剧集详情 */
export function getDramaDetail(id) {
  return request({
    url: `/api/v1/dramas/${id}`,
    method: 'GET',
  })
}
```

### 2.7 请求封装规范

```javascript
// src/api/index.js
// #ifdef H5
import axios from 'axios'
// #endif

const BASE_URL = import.meta.env.VITE_API_BASE_URL

// #ifdef H5
const service = axios.create({
  baseURL: BASE_URL,
  timeout: 15000,
})
// #endif

// #ifndef H5
// 小程序/APP 使用 uni.request 封装
const service = {
  request(options) {
    return new Promise((resolve, reject) => {
      uni.request({
        url: BASE_URL + options.url,
        method: options.method || 'GET',
        data: options.data || {},
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${uni.getStorageSync('token')}`,
        },
        success: (res) => {
          if (res.statusCode === 200) {
            resolve(res.data)
          } else {
            reject(res.data)
          }
        },
        fail: reject,
      })
    })
  }
}
// #endif

export function request(options) {
  return service.request ? service.request(options) : service(options)
}
```

### 2.8 状态管理规范 (Pinia)

```javascript
// src/stores/modules/drama.js
import { defineStore } from 'pinia'
import { getDramaList } from '@/api/modules/drama'

export const useDramaStore = defineStore('drama', {
  state: () => ({
    dramaList: [],
    currentDrama: null,
    loading: false,
  }),

  getters: {
    activeDramas: (state) => state.dramaList.filter(d => d.status === 1),
  },

  actions: {
    async fetchDramaList(params) {
      this.loading = true
      try {
        const { data } = await getDramaList(params)
        this.dramaList = data.list
      } finally {
        this.loading = false
      }
    },
  },
})
```

### 2.9 样式规范

```scss
// 1. 优先使用 SCSS 变量
$color-primary: #1890ff;
$color-success: #52c41a;
$color-warning: #faad14;
$color-danger: #ff4d4f;
$color-text: #333333;
$color-text-secondary: #666666;
$color-border: #e8e8e8;
$font-size-base: 14px;
$border-radius-base: 4px;

// 2. 间距使用 4px 基数
// margin/padding: 4, 8, 12, 16, 20, 24, 32

// 3. z-index 层级管理
$z-dropdown: 100;
$z-sticky: 200;
$z-fixed: 300;
$z-modal-backdrop: 400;
$z-modal: 500;
$z-popover: 600;
$z-tooltip: 700;
$z-toast: 800;
```

---

## 三、Python 后端代码规范 (FastAPI)

### 3.1 项目结构

```
app/
├── main.py               # FastAPI 应用入口
├── config.py             # 配置文件（数据库、Redis、JWT 等）
├── api/                  # API 路由（按模块划分）
│   ├── __init__.py
│   ├── deps.py           # 公共依赖（鉴权、分页等）
│   └── v1/
│       ├── __init__.py
│       ├── user.py       # 用户相关路由
│       ├── drama.py      # 剧集相关路由
│       ├── coin.py       # 金币相关路由
│       └── member.py     # 会员相关路由
├── models/               # SQLAlchemy 数据模型
│   ├── __init__.py
│   ├── user.py
│   ├── drama.py
│   ├── coin.py
│   └── member.py
├── schemas/              # Pydantic 请求/响应模型
│   ├── __init__.py
│   ├── user.py
│   ├── drama.py
│   ├── common.py         # 通用响应模型
│   └── ...
├── services/             # 业务逻辑层
│   ├── __init__.py
│   ├── user_service.py
│   ├── drama_service.py
│   ├── coin_service.py
│   └── ...
├── core/                 # 核心模块
│   ├── __init__.py
│   ├── security.py       # JWT、密码加密
│   ├── database.py       # 数据库连接
│   ├── redis.py          # Redis 连接
│   ├── exceptions.py     # 自定义异常
│   └── middleware.py      # 中间件
├── utils/                # 工具函数
│   ├── __init__.py
│   └── helpers.py
└── requirements.txt      # 依赖清单
```

### 3.2 命名规范

| 类型 | 规则 | 示例 |
|------|------|------|
| 文件名 | snake_case | `drama_service.py`, `user.py` |
| 类名 | PascalCase | `DramaService`, `UserCreate` |
| 函数/方法名 | snake_case | `get_drama_list()`, `create_user()` |
| 变量 | snake_case | `drama_list`, `current_user` |
| 常量 | UPPER_SNAKE_CASE | `MAX_PAGE_SIZE`, `CACHE_PREFIX` |
| 数据库表名 | snake_case，复数 | `users`, `drama_episodes` |
| 数据库字段 | snake_case | `created_at`, `user_id` |
| API 路由 | kebab-case | `/api/v1/drama-list` |
| Pydantic 模型 | PascalCase | `DramaListResponse`, `CoinBalance` |

### 3.3 路由规范

```python
# app/api/v1/drama.py
from fastapi import APIRouter, Depends, Query
from app.schemas.drama import DramaListResponse, DramaDetailResponse
from app.schemas.common import SuccessResponse, PagedResponse
from app.services import drama_service
from app.api.deps import get_current_user

router = APIRouter(prefix="/dramas", tags=["剧集"])


@router.get("", response_model=SuccessResponse[PagedResponse[DramaListResponse]])
async def get_drama_list(
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=50),
    category: str = Query(None),
    keyword: str = Query(None),
):
    """获取剧集列表"""
    result = await drama_service.get_list(
        page=page,
        page_size=page_size,
        category=category,
        keyword=keyword,
    )
    return SuccessResponse(data=result)


@router.get("/{drama_id}", response_model=SuccessResponse[DramaDetailResponse])
async def get_drama_detail(drama_id: int):
    """获取剧集详情"""
    drama = await drama_service.get_detail(drama_id)
    return SuccessResponse(data=drama)
```

### 3.4 服务层规范

```python
# app/services/drama_service.py
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from app.models.drama import Drama
from app.core.exceptions import BusinessException


class DramaService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_list(
        self,
        page: int = 1,
        page_size: int = 20,
        category: str = None,
        keyword: str = None,
    ) -> dict:
        """获取剧集列表"""
        query = select(Drama).where(Drama.status == 1)

        if category:
            query = query.where(Drama.category == category)
        if keyword:
            query = query.where(Drama.title.contains(keyword))

        # 总数
        count_query = select(func.count()).select_from(query.subquery())
        total = (await self.db.execute(count_query)).scalar()

        # 分页
        query = query.order_by(Drama.created_at.desc())
        query = query.offset((page - 1) * page_size).limit(page_size)
        result = (await self.db.execute(query)).scalars().all()

        return {
            "list": result,
            "total": total,
            "page": page,
            "page_size": page_size,
            "total_pages": (total + page_size - 1) // page_size,
        }

    async def get_detail(self, drama_id: int) -> Drama:
        """获取剧集详情"""
        drama = await self.db.get(Drama, drama_id)
        if not drama:
            raise BusinessException("剧集不存在")
        return drama
```

### 3.5 Pydantic 模型规范

```python
# app/schemas/common.py
from pydantic import BaseModel
from typing import Generic, TypeVar, Optional, List

T = TypeVar("T")


class SuccessResponse(BaseModel, Generic[T]):
    """统一成功响应"""
    code: int = 0
    message: str = "success"
    data: Optional[T] = None


class PagedResponse(BaseModel, Generic[T]):
    """分页响应"""
    list: List[T]
    total: int
    page: int
    page_size: int
    total_pages: int


class ErrorResponse(BaseModel):
    """统一错误响应"""
    code: int
    message: str
    data: Optional[None] = None
```

### 3.6 数据模型规范

```python
# app/models/drama.py
from sqlalchemy import Column, Integer, String, Text, BigInteger, SmallInteger, DateTime
from sqlalchemy.sql import func
from app.core.database import Base


class Drama(Base):
    __tablename__ = "dramas"

    id = Column(BigInteger, primary_key=True, autoincrement=True)
    title = Column(String(100), nullable=False, comment="剧名")
    cover = Column(String(255), comment="封面URL")
    description = Column(Text, comment="简介")
    category = Column(String(50), comment="分类")
    tags = Column(String(500), comment="标签JSON")
    total_episodes = Column(Integer, default=0, comment="总集数")
    status = Column(SmallInteger, default=1, comment="状态 0下架 1上架")
    is_exclusive = Column(SmallInteger, default=0, comment="是否独家")
    is_new = Column(SmallInteger, default=0, comment="是否新剧")
    unlock_coins = Column(Integer, default=0, comment="解锁金币数")
    view_count = Column(BigInteger, default=0, comment="播放量")
    collect_count = Column(BigInteger, default=0, comment="收藏量")
    created_at = Column(DateTime, server_default=func.now())
    updated_at = Column(DateTime, server_default=func.now(), onupdate=func.now())
```

### 3.7 API 响应格式

```json
// 成功响应
{
    "code": 0,
    "message": "success",
    "data": {
        "list": [...],
        "total": 100
    }
}

// 错误响应
{
    "code": 40001,
    "message": "参数错误：缺少 drama_id",
    "data": null
}

// 分页响应
{
    "code": 0,
    "message": "success",
    "data": {
        "list": [...],
        "total": 100,
        "page": 1,
        "page_size": 20,
        "total_pages": 5
    }
}
```

### 3.8 错误码规范

| 范围 | 模块 |
|------|------|
| 0 | 成功 |
| 40001 - 40099 | 参数/请求错误 |
| 40101 - 40199 | 认证/授权错误 |
| 40301 - 40399 | 权限错误 |
| 40401 - 40499 | 资源不存在 |
| 41001 - 41099 | 业务逻辑错误 |
| 50001 - 50099 | 服务器内部错误 |

### 3.9 自定义异常

```python
# app/core/exceptions.py
from fastapi import HTTPException, status


class BusinessException(HTTPException):
    """业务逻辑异常"""
    def __init__(self, message: str, code: int = 41001):
        super().__init__(
            status_code=status.HTTP_OK,
            detail={"code": code, "message": message, "data": None},
        )
```

---

## 四、Git 提交规范

### 4.1 Commit Message 格式

```
<type>(<scope>): <subject>

<body>
```

### 4.2 Type 类型

| 类型 | 说明 |
|------|------|
| `feat` | 新功能 |
| `fix` | 修复 Bug |
| `docs` | 文档变更 |
| `style` | 代码格式（不影响逻辑） |
| `refactor` | 重构（不是新功能也不是修 Bug） |
| `perf` | 性能优化 |
| `test` | 测试相关 |
| `chore` | 构建过程或辅助工具变动 |

### 4.3 Scope 范围

| Scope | 说明 |
|-------|------|
| `auth` | 认证模块 |
| `user` | 用户模块 |
| `drama` | 剧集模块 |
| `coin` | 金币/积分模块 |
| `member` | 会员模块 |
| `pay` | 支付模块 |
| `admin` | 后台管理 |
| `ui` | UI/样式 |
| `api` | API 接口 |

### 4.4 示例

```
feat(drama): 新增剧集收藏功能
fix(coin): 修复金币扣除后余额未更新的问题
refactor(user): 重构用户信息页面组件
docs: 更新 API 接口文档
```

---

## 五、CHANGELOG 维护规范

### 5.1 文件位置

```
项目根目录/CHANGELOG.md
```

### 5.2 格式模板

每次开发完成后，AI **必须** 在 CHANGELOG.md 顶部追加记录：

```markdown
## [版本号/日期] - 任务标题

### 变更类型
- **新增**: 新功能描述
- **修改**: 修改内容描述
- **修复**: 修复的问题描述
- **重构**: 重构内容描述

### 涉及文件
- `前端`: 修改的前端文件列表
- `后端`: 修改的后端文件列表

### 备注
- 其他需要说明的事项（如：需要后续跟进、依赖变更等）
```

### 5.3 记录示例

```markdown
## [v0.2.0 / 2026-04-10] - 剧集收藏与预约功能

### 变更类型
- **新增**: 剧集收藏功能（收藏/取消收藏）
- **新增**: 剧集预约功能（新剧上架提醒、更新提醒）
- **新增**: 收藏列表页面、预约列表页面
- **修改**: 用户中心增加收藏和预约入口

### 涉及文件
- **前端**:
  - `src/views/drama/components/DramaCard.vue` (新增收藏/预约按钮)
  - `src/views/user/CollectionList.vue` (新增)
  - `src/views/user/ReservationList.vue` (新增)
  - `src/api/modules/drama.js` (新增收藏/预约接口)
  - `src/stores/modules/drama.js` (新增收藏/预约状态)
- **后端**:
  - `app/Controllers/Drama/DramaController.php` (新增收藏/预约方法)
  - `app/Services/Drama/DramaService.php` (新增收藏/预约逻辑)
  - `app/Models/UserCollection.php` (新增模型)
  - `app/Models/UserReservation.php` (新增模型)

### 备注
- 预约提醒推送需要后续对接消息推送服务
- 收藏列表分页加载待优化
```

### 5.4 版本号规则

采用 **语义化版本** (Semantic Versioning)：

```
MAJOR.MINOR.PATCH

MAJOR: 不兼容的 API 变更
MINOR: 向下兼容的功能新增
PATCH: 向下兼容的问题修复
```

---

## 六、开发收尾检查清单

每次开发任务完成前，AI **必须**逐项检查：

### 6.1 代码质量

- [ ] 代码符合本协议的命名规范
- [ ] 新文件放置在正确的目录结构中
- [ ] 无硬编码的魔法数字/字符串（使用常量或配置）
- [ ] 无 `console.log` / `var_dump` / `dd()` 等调试代码
- [ ] 无注释掉的废弃代码

### 6.2 功能完整性

- [ ] 所有需求点都已实现
- [ ] 边界情况已处理（空数据、网络错误、权限不足）
- [ ] 加载状态和错误状态有 UI 反馈

### 6.3 安全性

- [ ] 用户输入已做验证和过滤
- [ ] API 接口有权限校验
- [ ] 敏感数据未暴露在前端

### 6.4 记录更新

- [ ] CHANGELOG.md 已更新
- [ ] 新增文件已在 CHANGELOG 中列出
- [ ] 版本号已按规则更新

---

## 七、新任务快速接手指南

AI 接到新任务时，按以下步骤快速了解项目：

```
1. 读 CHANGELOG.md     → 了解开发历史和当前进度
2. 读 package.json     → 了解前端依赖和脚本
3. 读 composer.json    → 了解后端依赖
4. 读路由文件           → 了解现有 API 和页面
5. 读相关模块代码       → 了解已有实现方式
6. 按本协议规范开发     → 保持一致性
```

---

## 八、文件注释规范

### 8.1 Python 文件头注释

```python
"""
剧集服务模块

负责剧集的增删改查、收藏、预约等业务逻辑

@author AI Developer
@since v0.1.0
@updated v0.2.0 新增预约功能
"""
```

### 8.2 Vue 组件头注释

```vue
<!--
  剧集卡片组件

  用于剧集列表中展示单个剧集信息
  包含封面、剧名、标签、收藏/预约操作

  @author AI Developer
  @since v0.1.0
  @updated v0.2.0 新增预约按钮
-->
```

### 8.3 函数/方法注释

```python
async def get_drama_list(
    self,
    page: int = 1,
    page_size: int = 20,
    category: str = None,
    keyword: str = None,
) -> dict:
    """获取剧集列表

    Args:
        page: 页码
        page_size: 每页数量
        category: 分类筛选
        keyword: 关键词搜索

    Returns:
        dict: 包含 list, total, page, page_size, total_pages

    Raises:
        BusinessException: 参数错误时抛出
    """
```

```javascript
/**
 * 获取剧集列表
 * @param {Object} params - 筛选参数
 * @param {number} params.page - 页码
 * @param {number} params.pageSize - 每页数量
 * @param {string} params.category - 分类筛选
 * @returns {Promise<{list: Drama[], total: number}>}
 */
export function getDramaList(params) {
  // ...
}
```

---

## 九、禁止事项

以下行为在开发中**严格禁止**：

1. ❌ 不读 CHANGELOG 直接开发（会导致风格不一致、重复开发）
2. ❌ 不做任务分析直接写代码（会导致遗漏需求）
3. ❌ 开发完不更新 CHANGELOG（会导致记录断裂）
4. ❌ 使用 `any` 类型（TypeScript 项目）
5. ❌ 在组件中直接写 API 请求（必须通过 api 层）
6. ❌ 在控制器中写复杂业务逻辑（必须下沉到 Service 层）
7. ❌ 提交包含调试代码
8. ❌ 修改已有代码风格（保持与现有代码一致）
9. ❌ 硬编码配置值（使用配置文件或环境变量）
10. ❌ 跳过收尾检查清单