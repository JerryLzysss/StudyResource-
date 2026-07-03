import { Component, signal, OnInit } from '@angular/core';

@Component({
  selector: 'app-heavy-widget',
  template: `
    <div class="widget">
      <h4>重量级组件已加载</h4>
      <p>模拟耗时初始化：{{ loadTime() }}ms</p>
      <ul>
        @for (item of items(); track item) {
          <li>{{ item }}</li>
        }
      </ul>
    </div>
  `,
  styles: `
    .widget {
      padding: 1rem;
      background: linear-gradient(135deg, #fef0f2, #f0f4ff);
      border-radius: 8px;
      border: 1px solid #e8e8ef;
    }
    h4 { margin: 0 0 0.5rem; }
    p { margin: 0 0 0.75rem; color: #666; font-size: 0.875rem; }
    ul { margin: 0; padding-left: 1.25rem; }
  `,
})
export class HeavyWidgetComponent implements OnInit {
  loadTime = signal(0);
  items = signal<string[]>([]);

  ngOnInit(): void {
    const start = performance.now();
    this.items.set(Array.from({ length: 8 }, (_, i) => `数据项 #${i + 1}`));
    this.loadTime.set(Math.round(performance.now() - start + 800));
  }
}
