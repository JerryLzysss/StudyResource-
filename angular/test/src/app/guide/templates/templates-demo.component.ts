import { Component, signal } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

@Component({
  selector: 'app-templates-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">模板 (Templates)</h1>

    <app-demo-panel title="属性绑定 & 事件绑定" description="[disabled] 属性绑定，(click) 事件绑定">
      <p>点击次数：<strong>{{ clickCount() }}</strong></p>
      <button type="button" (click)="increment()">点击我</button>
      <button type="button" [disabled]="clickCount() === 0" (click)="resetClicks()">重置</button>
    </app-demo-panel>

    <app-demo-panel title="@if 条件渲染">
      <label class="toggle">
        <input type="checkbox" [checked]="isLoggedIn()" (change)="isLoggedIn.set($any($event.target).checked)" />
        已登录
      </label>
      @if (isLoggedIn()) {
        <p class="msg success">欢迎回来！</p>
      } @else {
        <p class="msg warn">请先登录</p>
      }
    </app-demo-panel>

    <app-demo-panel title="@for 列表渲染">
      <ul class="list">
        @for (item of items(); track item.id) {
          <li>{{ item.name }} — {{ item.status }}</li>
        } @empty {
          <li class="empty">列表为空</li>
        }
      </ul>
    </app-demo-panel>

    <app-demo-panel title="@switch 分支渲染">
      <select [value]="status()" (change)="status.set($any($event.target).value)">
        <option value="idle">idle</option>
        <option value="loading">loading</option>
        <option value="done">done</option>
        <option value="error">error</option>
      </select>
      @switch (status()) {
        @case ('loading') { <p class="badge loading">加载中...</p> }
        @case ('done') { <p class="badge done">完成 ✓</p> }
        @case ('error') { <p class="badge error">出错了 ✗</p> }
        @default { <p class="badge idle">空闲</p> }
      }
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 1.25rem; font-size: 1.75rem; }
    button {
      padding: 0.4rem 0.9rem;
      margin-right: 0.5rem;
      border: 1px solid #ddd;
      border-radius: 6px;
      background: #fff;
      cursor: pointer;
    }
    button:disabled { opacity: 0.4; cursor: not-allowed; }
    .toggle { display: flex; align-items: center; gap: 0.5rem; }
    .msg { margin: 0.75rem 0 0; padding: 0.5rem 0.75rem; border-radius: 6px; }
    .success { background: #e8f5e9; color: #2e7d32; }
    .warn { background: #fff3e0; color: #e65100; }
    .list { margin: 0; padding-left: 1.25rem; line-height: 1.8; }
    .empty { color: #999; }
    select { padding: 0.4rem 0.75rem; border-radius: 6px; border: 1px solid #ddd; margin-bottom: 0.75rem; }
    .badge { display: inline-block; padding: 0.35rem 0.75rem; border-radius: 6px; margin: 0; font-size: 0.9rem; }
    .loading { background: #e3f2fd; color: #1565c0; }
    .done { background: #e8f5e9; color: #2e7d32; }
    .error { background: #ffebee; color: #c62828; }
    .idle { background: #f5f5f5; color: #666; }
  `,
})
export class TemplatesDemoComponent {
  clickCount = signal(0);
  isLoggedIn = signal(false);
  status = signal<'idle' | 'loading' | 'done' | 'error'>('idle');
  items = signal([
    { id: 1, name: '任务 A', status: '进行中' },
    { id: 2, name: '任务 B', status: '已完成' },
    { id: 3, name: '任务 C', status: '待处理' },
  ]);

  increment(): void { this.clickCount.update((v) => v + 1); }
  resetClicks(): void { this.clickCount.set(0); }
}
