# Angular 交互演示

基于 [Angular 中文文档](https://angular.cn/overview) 结构的可运行示例项目，通过实际操作演示核心概念（非文档搬运）。

## 快速开始

```bash
npm install
ng serve
```

访问 `http://localhost:4200`，左侧导航切换各演示页面。

## 模块说明

### 简介
- **Angular 概览** — 功能入口卡片，跳转各交互 Demo

### 深度指南（可动手操作）

| 页面 | 演示内容 |
|------|----------|
| 信号 | signal / computed 计数器 |
| 组件 | input / output 父子通信、UserCard |
| 模板 | 属性/事件绑定、@if / @for / @switch |
| 指令 | 自定义 HighlightDirective、NgClass |
| 依赖注入 | inject() + UserService 共享状态 |
| 路由 | 嵌套路由、参数读取、router-outlet |
| 表单 | 响应式表单 + Validators 校验 |
| HTTP 客户端 | loading / success / error 异步状态（本地 Mock，无外部请求） |
| 延迟加载 | @defer + placeholder / loading 块 |
| 测试 | 浏览器内模拟单元测试断言 |
| 国际化 | 运行时中英文切换 |
| 动画 | CSS 过渡与列表动画 |
| 拖放 | HTML5 原生拖放排序 |

### 开发者工具（本地模拟，无外部依赖）

| 页面 | 演示内容 |
|------|----------|
| Angular CLI | 命令预览与文件结构生成器 |
| 库结构 | 可展开的项目目录树 |
| 组件检查器 | 模拟 DevTools 组件树 |
| 语言服务 | 代码补全与诊断模拟 |

## 架构

```
src/app/
├── layout/          # 侧边栏布局
├── shared/          # 共享组件、服务、Mock 拦截器
├── intro/           # 简介模块
├── guide/           # 深度指南（各 Demo 组件）
└── tools/           # 开发者工具演示
```

HTTP 请求通过 `mock-api.interceptor.ts` 在本地拦截 `/api/*`，不会访问外部网络。

## 构建

```bash
ng build
```
