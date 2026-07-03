# 指令 (Directives)

指令是 Angular 中用于扩展 HTML 元素行为的类。Angular 有三种指令：

## 组件指令

组件是最常见的指令类型，带有模板。每个组件同时是一个指令。

## 结构型指令

结构型指令通过添加或移除 DOM 元素来改变 DOM 布局。现代 Angular 推荐使用内置控制流（`@if`、`@for`、`@switch`）替代传统结构型指令。

传统语法（仍可用）：

```html
<div *ngIf="isVisible">可见内容</div>
<li *ngFor="let item of items">{{ item }}</li>
```

## 属性型指令

属性型指令改变元素的外观或行为：

```html
<p appHighlight>高亮文本</p>
<input appFocus />
```

### 创建自定义属性指令

```typescript
import { Directive, ElementRef, input, effect } from '@angular/core';

@Directive({
  selector: '[appHighlight]',
})
export class HighlightDirective {
  color = input('yellow');

  constructor(private el: ElementRef) {
    effect(() => {
      this.el.nativeElement.style.backgroundColor = this.color();
    });
  }
}
```

## 常用内置指令

| 指令 | 说明 |
|------|------|
| `NgClass` | 动态添加/移除 CSS 类 |
| `NgStyle` | 动态设置内联样式 |
| `NgModel` | 双向数据绑定（需导入 FormsModule） |

---

> 参考：[Angular 指令指南](https://angular.cn/guide/directives)
