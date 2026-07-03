import { Component, signal, computed } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

@Component({
  selector: 'app-signals-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">信号 (Signals)</h1>

    <app-demo-panel title="可写信号 + 计算信号" description="count 是可写信号，doubleCount 由 computed 自动派生">
      <div class="counter">
        <span class="value">{{ count() }}</span>
        <span class="hint">双倍值：{{ doubleCount() }}</span>
        <div class="actions">
          <button type="button" (click)="decrement()">−</button>
          <button type="button" (click)="reset()">重置</button>
          <button type="button" (click)="increment()">+</button>
        </div>
      </div>
    </app-demo-panel>

    <app-demo-panel title="条件计算" description="showDouble 为 false 时，doubleCount 不会被读取，修改 count 不会触发重算">
      <label class="toggle">
        <input type="checkbox" [checked]="showDouble()" (change)="showDouble.set($any($event.target).checked)" />
        显示双倍值
      </label>
      @if (showDouble()) {
        <p class="result">当前双倍：{{ doubleCount() }}</p>
      } @else {
        <p class="result muted">双倍值未追踪（showDouble = false）</p>
      }
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 1.25rem; font-size: 1.75rem; }
    .counter { text-align: center; }
    .value { display: block; font-size: 3rem; font-weight: 700; color: #dd0031; }
    .hint { display: block; color: #666; margin-bottom: 1rem; }
    .actions { display: flex; gap: 0.5rem; justify-content: center; }
    .actions button {
      padding: 0.5rem 1.25rem;
      border: 1px solid #ddd;
      border-radius: 6px;
      background: #fff;
      cursor: pointer;
      font-size: 1.1rem;
    }
    .actions button:hover { border-color: #dd0031; color: #dd0031; }
    .toggle { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; }
    .result { margin: 0.75rem 0 0; }
    .muted { color: #999; }
  `,
})
export class SignalsDemoComponent {
  count = signal(0);
  showDouble = signal(true);
  doubleCount = computed(() => this.count() * 2);

  increment(): void { this.count.update((v) => v + 1); }
  decrement(): void { this.count.update((v) => v - 1); }
  reset(): void { this.count.set(0); }
}
