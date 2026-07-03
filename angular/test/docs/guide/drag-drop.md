# 拖放 (Drag and Drop)

Angular CDK 提供了 `@angular/cdk/drag-drop` 模块，用于实现拖放交互。

## 安装

Angular CDK 通常随 Angular Material 一起安装：

```bash
ng add @angular/material
```

或单独安装 CDK：

```bash
npm install @angular/cdk
```

## 基本拖放

```typescript
import { Component } from '@angular/core';
import { DragDropModule, CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';

@Component({
  selector: 'app-drag-list',
  imports: [DragDropModule],
  template: `
    <div cdkDropList (cdkDropListDropped)="drop($event)">
      @for (item of items; track item) {
        <div cdkDrag>{{ item }}</div>
      }
    </div>
  `,
})
export class DragListComponent {
  items = ['Item 1', 'Item 2', 'Item 3'];

  drop(event: CdkDragDrop<string[]>) {
    moveItemInArray(this.items, event.previousIndex, event.currentIndex);
  }
}
```

## 跨列表拖放

```typescript
import { transferArrayItem } from '@angular/cdk/drag-drop';

drop(event: CdkDragDrop<string[]>) {
  if (event.previousContainer === event.container) {
    moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
  } else {
    transferArrayItem(
      event.previousContainer.data,
      event.container.data,
      event.previousIndex,
      event.currentIndex,
    );
  }
}
```

## 自定义拖放预览

使用 `cdkDragPreview` 指令自定义拖动时的预览元素。

## 拖放约束

- `cdkDragLockAxis` — 锁定拖动轴
- `cdkDragBoundary` — 限制拖动范围
- `cdkDropListSortingDisabled` — 禁用排序

---

> 参考：[Angular 拖放指南](https://angular.cn/guide/drag-drop)
