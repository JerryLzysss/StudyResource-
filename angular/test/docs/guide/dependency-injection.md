# 依赖注入 (Dependency Injection)

依赖注入 (DI) 是 Angular 的核心设计模式，允许你在组件、指令、管道和服务之间轻松共享代码。

## 什么是依赖注入？

依赖注入是一种设计模式，其中类从外部源接收其依赖项，而不是自己创建它们。Angular 的 DI 框架负责实例化和管理这些依赖项。

## 创建服务

```typescript
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class UserService {
  getUsers() {
    return ['Alice', 'Bob', 'Charlie'];
  }
}
```

`providedIn: 'root'` 表示该服务在整个应用中作为单例提供。

## 注入依赖

使用 `inject()` 函数（推荐）或构造函数注入：

```typescript
import { Component, inject } from '@angular/core';
import { UserService } from './user.service';

@Component({
  selector: 'app-users',
  template: `<ul>@for (u of users(); track u) { <li>{{ u }}</li> }</ul>`,
})
export class UsersComponent {
  private userService = inject(UserService);
  users = signal(this.userService.getUsers());
}
```

## 注入层级

Angular 的注入器形成层级结构：

- **根注入器** — 应用级别，单例服务
- **组件注入器** — 每个组件可以有自己的注入器
- **子注入器** — 子组件可以访问父组件的注入器

## 注入令牌

对于接口或非类依赖，使用 `InjectionToken`：

```typescript
import { InjectionToken } from '@angular/core';

export const API_URL = new InjectionToken<string>('api.url');

// 提供
providers: [{ provide: API_URL, useValue: 'https://api.example.com' }]

// 注入
private apiUrl = inject(API_URL);
```

---

> 参考：[Angular 依赖注入指南](https://angular.cn/guide/di)
