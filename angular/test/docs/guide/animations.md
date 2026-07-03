# 动画 (Animations)

Angular 提供了 `@angular/animations` 包，用于在应用中创建流畅的动画效果。

## 安装

```bash
ng add @angular/animations
```

## 基本用法

定义动画触发器：

```typescript
import { Component } from '@angular/core';
import { trigger, transition, style, animate } from '@angular/animations';

@Component({
  selector: 'app-animated',
  animations: [
    trigger('fadeInOut', [
      transition(':enter', [
        style({ opacity: 0 }),
        animate('300ms ease-in', style({ opacity: 1 })),
      ]),
      transition(':leave', [
        animate('300ms ease-out', style({ opacity: 0 })),
      ]),
    ]),
  ],
  template: `
    @if (visible()) {
      <div @fadeInOut>动画内容</div>
    }
  `,
})
export class AnimatedComponent {
  visible = signal(true);
}
```

## 常用动画函数

| 函数 | 说明 |
|------|------|
| `trigger()` | 定义动画触发器 |
| `state()` | 定义动画状态 |
| `transition()` | 定义状态之间的过渡 |
| `animate()` | 定义动画时长和缓动 |
| `style()` | 定义 CSS 样式 |
| `keyframes()` | 定义关键帧动画 |

## 路由过渡动画

结合路由可以实现页面切换动画：

```typescript
trigger('routeAnimations', [
  transition('* <=> *', [
    style({ opacity: 0 }),
    animate('200ms', style({ opacity: 1 })),
  ]),
])
```

## 性能建议

- 优先使用 CSS transform 和 opacity 属性
- 避免动画 layout 属性（width、height 等）
- 考虑使用 `@angular/animations` 的 `useAnimations` 配置禁用动画以提升可访问性

---

> 参考：[Angular 动画指南](https://angular.cn/guide/animations)
