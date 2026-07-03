import { Component, signal } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';
import { HeavyWidgetComponent } from '../../shared/heavy-widget.component';

@Component({
  selector: 'app-ssr-demo',
  imports: [DemoPanelComponent, HeavyWidgetComponent],
  template: `
    <h1 class="page-title">延迟加载</h1>
    <p class="page-desc">使用 defer 控制块声明式地延迟加载组件，配合 placeholder / loading 展示异步状态。</p>

    <app-demo-panel title="点击触发延迟加载" description="HeavyWidgetComponent 仅在 showWidget 为 true 后才开始加载">
      <button type="button" class="load-btn" (click)="showWidget.set(true)" [disabled]="showWidget()">
        {{ showWidget() ? '已触发加载' : '加载重量级组件' }}
      </button>

      @if (showWidget()) {
        @defer (on idle) {
          <app-heavy-widget />
        } @placeholder {
          <div class="defer-state placeholder">placeholder：等待浏览器空闲…</div>
        } @loading (minimum 600ms) {
          <div class="defer-state loading">loading：正在加载组件…</div>
        } @error {
          <div class="defer-state error">加载失败</div>
        }
      } @else {
        <p class="hint">组件尚未请求，页面保持轻量</p>
      }
    </app-demo-panel>

    <app-demo-panel title="视口触发 (@defer on viewport)" description="滚动到可见区域时自动加载">
      <div class="spacer">↓ 向下滚动 ↓</div>
      @defer (on viewport) {
        <app-heavy-widget />
      } @placeholder {
        <div class="defer-state placeholder">placeholder：滚动到此处后加载</div>
      } @loading (minimum 800ms) {
        <div class="defer-state loading">loading：视口内加载中…</div>
      }
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .load-btn {
      padding: 0.5rem 1.25rem; background: #dd0031; color: #fff;
      border: none; border-radius: 6px; cursor: pointer; margin-bottom: 1rem;
    }
    .load-btn:disabled { opacity: 0.6; cursor: default; }
    .hint { color: #999; margin: 0; }
    .defer-state { padding: 1.25rem; border-radius: 8px; text-align: center; }
    .placeholder { background: #f5f5f5; color: #888; border: 1px dashed #ddd; }
    .loading { background: #e3f2fd; color: #1565c0; }
    .error { background: #ffebee; color: #c62828; }
    .spacer { height: 120px; display: flex; align-items: center; justify-content: center; color: #ccc; }
  `,
})
export class SsrDemoComponent {
  showWidget = signal(false);
}
