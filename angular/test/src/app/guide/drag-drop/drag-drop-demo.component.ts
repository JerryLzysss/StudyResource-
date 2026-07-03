import { Component, signal } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

@Component({
  selector: 'app-drag-drop-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">拖放 (Drag & Drop)</h1>
    <p class="page-desc">使用 HTML5 原生拖放 API 实现列表重排（无需 Angular CDK）。</p>

    <app-demo-panel title="拖拽排序" description="拖动列表项到目标位置释放即可重排">
      <ul class="drag-list">
        @for (item of items(); track item.id; let i = $index) {
          <li
            draggable="true"
            class="drag-item"
            [class.dragging]="dragIndex() === i"
            [class.over]="overIndex() === i"
            (dragstart)="onDragStart(i)"
            (dragover)="onDragOver($event, i)"
            (dragleave)="overIndex.set(-1)"
            (drop)="onDrop($event, i)"
            (dragend)="onDragEnd()"
          >
            <span class="handle">⠿</span>
            {{ item.label }}
            <span class="index">#{{ i + 1 }}</span>
          </li>
        }
      </ul>
    </app-demo-panel>

    <app-demo-panel title="双列表拖放" description="在「待办」与「完成」之间拖动任务">
      <div class="two-columns">
        <div class="column">
          <h4>待办</h4>
          @for (task of todo(); track task) {
            <div
              class="task"
              draggable="true"
              (dragstart)="dragTask.set({ task, from: 'todo' })"
            >{{ task }}</div>
          }
        </div>
        <div
          class="column drop-zone"
          (dragover)="onTaskDragOver($event)"
          (drop)="onTaskDrop('done')"
        >
          <h4>完成</h4>
          @for (task of done(); track task) {
            <div
              class="task done-task"
              draggable="true"
              (dragstart)="dragTask.set({ task, from: 'done' })"
            >{{ task }}</div>
          }
          @if (done().length === 0) {
            <p class="drop-hint">拖放到此处</p>
          }
        </div>
      </div>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .drag-list { list-style: none; margin: 0; padding: 0; }
    .drag-item {
      display: flex; align-items: center; gap: 0.75rem;
      padding: 0.75rem 1rem; margin-bottom: 0.35rem;
      background: #fff; border: 1px solid #e8e8ef; border-radius: 8px;
      cursor: grab; user-select: none; transition: box-shadow 0.15s, transform 0.15s;
    }
    .drag-item.dragging { opacity: 0.5; cursor: grabbing; }
    .drag-item.over { border-color: #dd0031; box-shadow: 0 2px 8px rgba(221,0,49,0.12); transform: scale(1.02); }
    .handle { color: #ccc; }
    .index { margin-left: auto; color: #999; font-size: 0.85rem; }
    .two-columns { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
    .column h4 { margin: 0 0 0.75rem; color: #555; }
    .task {
      padding: 0.6rem 0.75rem; margin-bottom: 0.35rem;
      background: #f8f8fc; border-radius: 6px; cursor: grab;
    }
    .done-task { background: #e8f5e9; }
    .drop-zone { min-height: 120px; padding: 0.75rem; border: 2px dashed #e8e8ef; border-radius: 8px; }
    .drop-hint { color: #ccc; text-align: center; margin: 1rem 0 0; font-size: 0.875rem; }
  `,
})
export class DragDropDemoComponent {
  items = signal([
    { id: 1, label: '第一项' },
    { id: 2, label: '第二项' },
    { id: 3, label: '第三项' },
    { id: 4, label: '第四项' },
  ]);
  dragIndex = signal(-1);
  overIndex = signal(-1);

  todo = signal(['学习 Signals', '编写组件', '配置路由']);
  done = signal<string[]>([]);
  dragTask = signal<{ task: string; from: 'todo' | 'done' } | null>(null);

  onDragStart(index: number): void {
    this.dragIndex.set(index);
  }

  onDragOver(event: DragEvent, index: number): void {
    event.preventDefault();
    this.overIndex.set(index);
  }

  onDrop(event: DragEvent, toIndex: number): void {
    event.preventDefault();
    const from = this.dragIndex();
    if (from < 0 || from === toIndex) return;
    this.items.update((list) => {
      const copy = [...list];
      const [moved] = copy.splice(from, 1);
      copy.splice(toIndex, 0, moved);
      return copy;
    });
    this.onDragEnd();
  }

  onDragEnd(): void {
    this.dragIndex.set(-1);
    this.overIndex.set(-1);
  }

  onTaskDragOver(event: DragEvent): void {
    event.preventDefault();
  }

  onTaskDrop(target: 'todo' | 'done'): void {
    const drag = this.dragTask();
    if (!drag || drag.from === target) return;
    if (drag.from === 'todo') {
      this.todo.update((list) => list.filter((t) => t !== drag.task));
      this.done.update((list) => [...list, drag.task]);
    } else {
      this.done.update((list) => list.filter((t) => t !== drag.task));
      this.todo.update((list) => [...list, drag.task]);
    }
    this.dragTask.set(null);
  }
}
