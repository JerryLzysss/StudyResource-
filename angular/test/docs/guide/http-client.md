# HTTP 客户端

`HttpClient` 是 Angular 提供的用于发起 HTTP 请求的模块，基于 RxJS Observable 构建。

## 设置

在应用配置中提供 HTTP 客户端：

```typescript
import { provideHttpClient, withFetch } from '@angular/common/http';

export const appConfig: ApplicationConfig = {
  providers: [provideHttpClient(withFetch())],
};
```

## 发起请求

```typescript
import { Component, inject, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-users',
  template: `@for (u of users(); track u.id) { <li>{{ u.name }}</li> }`,
})
export class UsersComponent {
  private http = inject(HttpClient);
  users = signal<User[]>([]);

  constructor() {
    this.http.get<User[]>('/api/users').subscribe((data) => {
      this.users.set(data);
    });
  }
}
```

## 常用方法

| 方法 | 说明 |
|------|------|
| `get<T>(url)` | GET 请求 |
| `post<T>(url, body)` | POST 请求 |
| `put<T>(url, body)` | PUT 请求 |
| `delete<T>(url)` | DELETE 请求 |
| `patch<T>(url, body)` | PATCH 请求 |

## 拦截器

HTTP 拦截器允许你在请求发送前或响应返回后执行通用逻辑：

```typescript
import { HttpInterceptorFn } from '@angular/common/http';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem('token');
  if (token) {
    req = req.clone({ setHeaders: { Authorization: `Bearer ${token}` } });
  }
  return next(req);
};
```

## 与 Signal 集成

使用 `httpResource` 或 `rxjs-interop` 将 HTTP 请求与 Signal 系统集成，实现更声明式的数据获取。

---

> 参考：[Angular HTTP 客户端指南](https://angular.cn/guide/http)
