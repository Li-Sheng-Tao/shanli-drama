---
name: dev-protocol
description: "AI 开发协议执行器，用于指导 uni-app (Vue 3 + Composition API) 跨端开发和 PHP 后端开发，确保代码风格一致、开发流程规范、变更记录完整。"
license: MIT
allowed-tools: Bash, FileSystem
---

# AI 开发协议 (Dev Protocol)

> **触发方式**：自动加载，每次开发任务开始时 AI 必须遵循本协议
> **适用技术栈**：前端 uni-app (Vue 3 + Composition API) 跨端开发（H5 → 小程序 → APP） + 后端 PHP
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
