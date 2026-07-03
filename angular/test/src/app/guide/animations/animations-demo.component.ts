import { Component, signal } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

@Component({
  selector: 'app-animations-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">动画 (Animations)</h1>
    <p class="page-desc">使用 CSS 过渡与 class 绑定实现进入/离开动画（无需外部动画库）。</p>

    <app-demo-panel title="淡入淡出" description="切换 visible 信号触发 CSS transition">
      <button type="button" class="toggle-btn" (click)="toggleVisible()">
        {{ visible() ? '隐藏' : '显示' }}
      </button>

      @if (visible()) {
        <div class="box fade-in">动画盒子 — 已显示</div>
      }
    </app-demo-panel>

    <app-demo-panel title="列表动画" description="新增/移除列表项时带过渡效果">
      <div class="add-row">
        <input #itemInput placeholder="输入项目名" (keyup.enter)="addItem(itemInput)" />
        <button type="button" (click)="addItem(itemInput)">添加</button>
      </div>
      <ul class="anim-list">
        @for (item of items(); track item.id) {
          <li class="list-item">
            {{ item.text }}
            <button type="button" (click)="removeItem(item.id)">×</button>
          </li>
        }
      </ul>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .toggle-btn {
      padding: 0.45rem 1rem; background: #dd0031; color: #fff;
      border: none; border-radius: 6px; cursor: pointer; margin-bottom: 1rem;
    }
    .box {
      padding: 1.5rem; background: linear-gradient(135deg, #fef0f2, #f0f4ff);
      border-radius: 8px; text-align: center; font-weight: 500;
    }
    .fade-in { animation: fadeIn 0.4s ease; }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .add-row { display: flex; gap: 0.5rem; margin-bottom: 0.75rem; }
    .add-row input { flex: 1; padding: 0.45rem 0.75rem; border: 1px solid #ddd; border-radius: 6px; }
    .add-row button { padding: 0.45rem 0.75rem; border: 1px solid #ddd; border-radius: 6px; background: #fff; cursor: pointer; }
    .anim-list { list-style: none; margin: 0; padding: 0; }
    .list-item {
      display: flex; justify-content: space-between; align-items: center;
      padding: 0.6rem 0.75rem; margin-bottom: 0.35rem;
      background: #f8f8fc; border-radius: 6px;
      animation: slideIn 0.3s ease;
    }
    @keyframes slideIn {
      from { opacity: 0; transform: translateX(-12px); }
      to { opacity: 1; transform: translateX(0); }
    }
    .list-item button {
      border: none; background: none; color: #999; cursor: pointer; font-size: 1.1rem;
    }
    .list-item button:hover { color: #dd0031; }
  `,
})
export class AnimationsDemoComponent {
  visible = signal(true);
  items = signal([{ id: 1, text: '动画项 A' }, { id: 2, text: '动画项 B' }]);
  private nextId = 3;

  addItem(input: HTMLInputElement): void {
    const text = input.value.trim();
    if (!text) return;
    this.items.update((list) => [...list, { id: this.nextId++, text }]);
    input.value = '';
  }

  removeItem(id: number): void {
    this.items.update((list) => list.filter((i) => i.id !== id));
  }

  toggleVisible(): void {
    this.visible.update((v) => !v);
  }
}
