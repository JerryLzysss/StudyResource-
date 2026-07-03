# 路由 (Routing)

路由帮助你在单页应用中更改用户看到的内容。

Angular Router (`@angular/router`) 是管理 Angular 应用导航的官方库，是所有 Angular CLI 创建项目的核心部分。

## 为什么 SPA 需要路由？

在单页应用 (SPA) 中，浏览器只对第一个页面（`index.html`）向 Web 服务器发起请求。之后，客户端路由器接管，根据 URL 控制显示的内容。当用户导航到不同 URL 时，路由器就地进行页面内容更新，而不会触发整页重新加载。

## Angular 路由的三个核心部分

1. **Routes（路由）** — 定义用户访问特定 URL 时显示哪个组件
2. **Outlets（出口）** — 模板中的占位符，根据活动路由动态加载和渲染组件
3. **Links（链接）** — 允许用户在应用的不同路由之间导航

## 定义路由

```typescript
import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: '**', component: NotFoundComponent },
];
```

## 路由出口与链接

```html
<nav>
  <a routerLink="/home" routerLinkActive="active">首页</a>
  <a routerLink="/about" routerLinkActive="active">关于</a>
</nav>
<router-outlet />
```

## 惰性加载

```typescript
{
  path: 'admin',
  loadChildren: () => import('./admin/admin.routes').then(m => m.adminRoutes),
}
```

## 路由守卫

路由守卫控制导航行为：

| 守卫 | 说明 |
|------|------|
| `CanActivate` | 控制是否可以进入路由 |
| `CanDeactivate` | 控制是否可以离开路由 |
| `CanMatch` | 控制路由是否匹配 |

## 路由参数

```typescript
// 路由定义
{ path: 'user/:id', component: UserDetailComponent }

// 读取参数
private route = inject(ActivatedRoute);
userId = this.route.snapshot.paramMap.get('id');
```

---

> 参考：[Angular 路由指南](https://angular.cn/guide/routing)
