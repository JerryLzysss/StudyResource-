import { Component, signal, computed } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

const SCHEMATICS: Record<string, { files: string[]; desc: string }> = {
  component: {
    desc: '生成带模板、样式和测试的组件',
    files: ['my-comp.component.ts', 'my-comp.component.html', 'my-comp.component.css', 'my-comp.component.spec.ts'],
  },
  service: {
    desc: '生成可注入的服务',
    files: ['my-service.service.ts', 'my-service.service.spec.ts'],
  },
  directive: {
    desc: '生成属性指令',
    files: ['my-directive.directive.ts', 'my-directive.directive.spec.ts'],
  },
  pipe: {
    desc: '生成管道',
    files: ['my-pipe.pipe.ts', 'my-pipe.pipe.spec.ts'],
  },
};

@Component({
  selector: 'app-cli-demo',
  imports: [DemoPanelComponent, FormsModule],
  template: `
    <h1 class="page-title">Angular CLI</h1>
    <p class="page-desc">本地命令生成器 — 预览 ng generate 会创建什么（不实际执行 CLI）。</p>

    <app-demo-panel title="生成命令预览">
      <div class="form-row">
        <label>类型</label>
        <select [(ngModel)]="schematic">
          @for (s of schematicKeys; track s) {
            <option [value]="s">{{ s }}</option>
          }
        </select>
      </div>
      <div class="form-row">
        <label>名称</label>
        <input [(ngModel)]="name" placeholder="my-feature" />
      </div>

      <div class="command-box">
        <code>{{ command() }}</code>
        <button type="button" (click)="copyCommand()">复制</button>
        @if (copied()) { <span class="copied">已复制</span> }
      </div>
      <p class="desc">{{ currentSchematic().desc }}</p>
    </app-demo-panel>

    <app-demo-panel title="将生成的文件">
      <ul class="file-list">
        @for (f of currentSchematic().files; track f) {
          <li>{{ f.replace('my-', name + '-') }}</li>
        }
      </ul>
    </app-demo-panel>

    <app-demo-panel title="常用命令速查">
      <table class="cmd-table">
        <tr><td><code>ng serve</code></td><td>启动开发服务器</td></tr>
        <tr><td><code>ng build</code></td><td>构建生产版本</td></tr>
        <tr><td><code>ng test</code></td><td>运行单元测试</td></tr>
        <tr><td><code>ng generate</code></td><td>代码脚手架</td></tr>
      </table>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .form-row { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.75rem; }
    .form-row label { width: 50px; font-size: 0.875rem; color: #555; }
    .form-row select, .form-row input {
      flex: 1; padding: 0.45rem 0.75rem; border: 1px solid #ddd; border-radius: 6px;
    }
    .command-box {
      display: flex; align-items: center; gap: 0.75rem;
      padding: 0.75rem 1rem; background: #1e1e2e; border-radius: 8px; margin: 1rem 0 0.5rem;
    }
    .command-box code { color: #a6e3a1; flex: 1; font-size: 0.9rem; }
    .command-box button {
      padding: 0.3rem 0.75rem; border: 1px solid #555; background: transparent;
      color: #cdd6f4; border-radius: 4px; cursor: pointer;
    }
    .copied { color: #a6e3a1; font-size: 0.8rem; }
    .desc { margin: 0; color: #666; font-size: 0.875rem; }
    .file-list { margin: 0; padding-left: 1.25rem; font-family: monospace; font-size: 0.875rem; line-height: 1.8; }
    .cmd-table { width: 100%; border-collapse: collapse; font-size: 0.875rem; }
    .cmd-table td { padding: 0.5rem 0.75rem; border-bottom: 1px solid #f0f0f5; }
    .cmd-table code { background: #f4f4f8; padding: 0.15rem 0.4rem; border-radius: 4px; }
  `,
})
export class CliDemoComponent {
  schematicKeys = Object.keys(SCHEMATICS);
  schematic = 'component';
  name = 'my-feature';
  copied = signal(false);

  currentSchematic = computed(() => SCHEMATICS[this.schematic]);
  command = computed(() => `ng generate ${this.schematic} ${this.name}`);

  copyCommand(): void {
    navigator.clipboard?.writeText(this.command());
    this.copied.set(true);
    setTimeout(() => this.copied.set(false), 1500);
  }
}
