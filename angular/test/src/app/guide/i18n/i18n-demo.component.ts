import { Component, signal, computed } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

const MESSAGES: Record<string, Record<string, string>> = {
  'zh-CN': {
    greeting: '你好',
    welcome: '欢迎使用 Angular 国际化演示',
    items: '项目数量',
    switch: '切换语言',
  },
  'en-US': {
    greeting: 'Hello',
    welcome: 'Welcome to Angular i18n demo',
    items: 'Item count',
    switch: 'Switch language',
  },
};

@Component({
  selector: 'app-i18n-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">国际化 (i18n)</h1>
    <p class="page-desc">运行时切换语言（本地字典，无需构建时 extract-i18n）。</p>

    <app-demo-panel [title]="msg('switch')" description="切换 locale 信号，模板自动更新">
      <div class="lang-switch">
        <button type="button" [class.active]="locale() === 'zh-CN'" (click)="locale.set('zh-CN')">中文</button>
        <button type="button" [class.active]="locale() === 'en-US'" (click)="locale.set('en-US')">English</button>
      </div>

      <div class="message-box">
        <p class="greeting">{{ msg('greeting') }}，Angular!</p>
        <p>{{ msg('welcome') }}</p>
        <p>{{ msg('items') }}: {{ itemCount() }}</p>
      </div>

      <div class="counter">
        <button type="button" (click)="decrementCount()">−</button>
        <span>{{ itemCount() }}</span>
        <button type="button" (click)="incrementCount()">+</button>
      </div>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .lang-switch { display: flex; gap: 0.5rem; margin-bottom: 1rem; }
    .lang-switch button {
      padding: 0.4rem 1rem; border: 1px solid #ddd;
      border-radius: 6px; background: #fff; cursor: pointer;
    }
    .lang-switch button.active { background: #dd0031; color: #fff; border-color: #dd0031; }
    .message-box { padding: 1rem; background: #f8f8fc; border-radius: 8px; margin-bottom: 1rem; }
    .greeting { font-size: 1.25rem; font-weight: 600; margin: 0 0 0.5rem; }
    .message-box p { margin: 0.25rem 0; color: #444; }
    .counter { display: flex; align-items: center; gap: 0.75rem; }
    .counter button {
      width: 32px; height: 32px; border: 1px solid #ddd;
      border-radius: 6px; background: #fff; cursor: pointer;
    }
    .counter span { font-size: 1.25rem; font-weight: 600; min-width: 2rem; text-align: center; }
  `,
})
export class I18nDemoComponent {
  locale = signal<'zh-CN' | 'en-US'>('zh-CN');
  itemCount = signal(3);
  private messages = computed(() => MESSAGES[this.locale()]);

  msg(key: string): string {
    return this.messages()[key];
  }

  incrementCount(): void { this.itemCount.update((v) => v + 1); }
  decrementCount(): void { this.itemCount.update((v) => v - 1); }
}
