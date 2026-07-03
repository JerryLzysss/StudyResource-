import { Component, signal, computed } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

const COMPLETIONS: Record<string, string[]> = {
  '@Component': ['selector', 'imports', 'template', 'templateUrl', 'styleUrl', 'styles'],
  'input': ['input()', 'input.required()'],
  'output': ['output()'],
  'signal': ['signal()', 'computed()', 'effect()'],
  'inject': ['inject()'],
  'Router': ['RouterLink', 'RouterOutlet', 'ActivatedRoute'],
};

@Component({
  selector: 'app-language-service-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">语言服务 (Language Service)</h1>
    <p class="page-desc">模拟 IDE 中的代码补全与实时诊断（本地演示，无需安装 VS Code 扩展）。</p>

    <app-demo-panel title="代码补全模拟" description="输入前缀，查看补全建议">
      <div class="editor">
        <input
          class="code-input"
          [value]="code()"
          (input)="onInput($event)"
          placeholder="输入 @Component、signal、inject..."
        />
        @if (suggestions().length) {
          <ul class="suggestions">
            @for (s of suggestions(); track s) {
              <li (click)="applySuggestion(s)">{{ s }}</li>
            }
          </ul>
        }
      </div>
    </app-demo-panel>

    <app-demo-panel title="实时诊断模拟" description="检测常见模板/类型错误">
      <textarea
        class="template-input"
        [value]="templateCode()"
        (input)="onTemplateInput($event)"
        rows="4"
        placeholder="输入模板代码，如 unknownVar 或 app-unknown"
      ></textarea>
      <ul class="diagnostics">
        @for (d of diagnostics(); track d.message) {
          <li [class.error]="d.severity === 'error'" [class.warn]="d.severity === 'warn'">
            {{ d.severity === 'error' ? '✗' : '⚠' }} {{ d.message }}
          </li>
        } @empty {
          <li class="ok">✓ 未发现错误</li>
        }
      </ul>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .editor { position: relative; }
    .code-input {
      width: 100%; padding: 0.75rem 1rem;
      font-family: monospace; font-size: 0.9rem;
      border: 1px solid #ddd; border-radius: 8px;
    }
    .suggestions {
      list-style: none; margin: 0.35rem 0 0; padding: 0;
      border: 1px solid #e8e8ef; border-radius: 8px; overflow: hidden;
    }
    .suggestions li {
      padding: 0.5rem 0.75rem; font-family: monospace; font-size: 0.85rem;
      cursor: pointer; border-bottom: 1px solid #f0f0f5;
    }
    .suggestions li:hover { background: #fef0f2; color: #dd0031; }
    .template-input {
      width: 100%; padding: 0.75rem; font-family: monospace; font-size: 0.85rem;
      border: 1px solid #ddd; border-radius: 8px; resize: vertical; margin-bottom: 0.75rem;
    }
    .diagnostics { list-style: none; margin: 0; padding: 0; }
    .diagnostics li { padding: 0.4rem 0.75rem; border-radius: 4px; margin-bottom: 0.25rem; font-size: 0.875rem; }
    .error { background: #ffebee; color: #c62828; }
    .warn { background: #fff3e0; color: #e65100; }
    .ok { color: #2e7d32; }
  `,
})
export class LanguageServiceDemoComponent {
  code = signal('');
  templateCode = signal('<app-unknown />');

  suggestions = computed(() => {
    const val = this.code().trim();
    if (!val) return [];
    for (const [prefix, items] of Object.entries(COMPLETIONS)) {
      if (prefix.toLowerCase().startsWith(val.toLowerCase()) || val.toLowerCase().startsWith(prefix.toLowerCase().slice(0, 3))) {
        return items.filter((i) => i.toLowerCase().includes(val.toLowerCase()) || val.length < 3);
      }
    }
    return Object.keys(COMPLETIONS).filter((k) => k.toLowerCase().includes(val.toLowerCase()));
  });

  diagnostics = computed(() => {
    const tpl = this.templateCode();
    const issues: { severity: 'error' | 'warn'; message: string }[] = [];
    if (tpl.includes('unknownVar')) {
      issues.push({ severity: 'error', message: "Property 'unknownVar' does not exist on type 'Component'" });
    }
    if (tpl.includes('app-unknown')) {
      issues.push({ severity: 'error', message: "'app-unknown' is not a known element" });
    }
    if (tpl.includes('*ngIf')) {
      issues.push({ severity: 'warn', message: 'Consider using @if instead of *ngIf (control flow)' });
    }
    return issues;
  });

  onInput(event: Event): void {
    this.code.set((event.target as HTMLInputElement).value);
  }

  onTemplateInput(event: Event): void {
    this.templateCode.set((event.target as HTMLTextAreaElement).value);
  }

  applySuggestion(s: string): void {
    this.code.set(s);
  }
}
