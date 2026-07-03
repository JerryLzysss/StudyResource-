# 服务端渲染与混合渲染

Angular 支持服务端渲染 (SSR)、静态站点生成 (SSG) 以及完整的 DOM 水合 (Hydration)。

## 什么是 SSR？

服务端渲染在服务器上生成完整的 HTML 页面，然后发送给浏览器。这可以：

- 改善首屏加载性能
- 提升 SEO 友好性
- 在慢速网络下提供更好的用户体验

## 启用 SSR

创建项目时添加 SSR：

```bash
ng new my-app --ssr
```

或在现有项目中添加：

```bash
ng add @angular/ssr
```

## 混合渲染

Angular 支持混合渲染策略，允许不同路由使用不同的渲染模式：

```typescript
// app.routes.server.ts
export const serverRoutes: ServerRoute[] = [
  { path: '', renderMode: RenderMode.Prerender },
  { path: 'dashboard', renderMode: RenderMode.Server },
  { path: '**', renderMode: RenderMode.Client },
];
```

| 模式 | 说明 |
|------|------|
| `Prerender` | 构建时预渲染为静态 HTML (SSG) |
| `Server` | 每次请求在服务端渲染 (SSR) |
| `Client` | 仅在客户端渲染 (CSR) |

## DOM 水合

水合是将服务端渲染的 HTML 与客户端 Angular 应用"连接"的过程。Angular 的水合功能：

- 复用服务端生成的 DOM
- 避免不必要的重新渲染
- 保持应用状态一致性

## @defer 延迟加载

模板中的 `@defer` 控制块可以声明式地划分可惰性加载的部分，与水合配合实现更优的性能。

---

> 参考：[Angular SSR 指南](https://angular.cn/guide/ssr)
