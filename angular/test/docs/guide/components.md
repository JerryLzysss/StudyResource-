# 组件 (Components)

组件是 Angular 应用的基本构建块。每个组件包含：

- 一个 `@Component` 装饰器，包含一些配置
- 控制将渲染到 DOM 中的 HTML **模板**
- 定义组件在 HTML 中如何使用的 CSS **选择器**
- 一个 **TypeScript 类**，包含管理状态、处理用户输入或从服务器获取数据等行为

## 创建组件

使用 Angular CLI 生成组件：

```bash
ng generate component my-component
```

或使用简写：

```bash
ng g c my-component
```

## 使用组件

1. 将组件导入到文件中
2. 将其添加到组件的 `imports` 数组中
3. 在 template 中使用该组件的选择器

```typescript
import { Component } from '@angular/core';
import { MyComponent } from './my-component';

@Component({
  selector: 'app-root',
  imports: [MyComponent],
  template: `<app-my-component />`,
})
export class AppComponent {}
```

## 组件生命周期

Angular 组件有一系列生命周期钩子，允许你在组件生命周期的特定时刻执行逻辑：

| 钩子 | 说明 |
|------|------|
| `ngOnInit` | 组件初始化后调用 |
| `ngOnChanges` | 输入属性变化时调用 |
| `ngOnDestroy` | 组件销毁前调用 |
| `ngAfterViewInit` | 视图初始化后调用 |

## 输入与输出

- **`input()`** — 定义从父组件接收的数据
- **`output()`** — 定义向父组件发送的事件

```typescript
import { Component, input, output } from '@angular/core';

@Component({
  selector: 'app-user-card',
  template: `<h2>{{ name() }}</h2>`,
})
export class UserCardComponent {
  name = input.required<string>();
  selected = output<string>();
}
```

## 组件样式

组件可以拥有独立的样式，通过 `styleUrl` 或内联 `styles` 定义，默认情况下样式是封装（encapsulated）的，不会影响其他组件。

---

> 参考：[Angular 组件指南](https://angular.cn/guide/components)
