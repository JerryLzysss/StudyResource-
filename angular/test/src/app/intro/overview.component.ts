import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { DemoPanelComponent } from '../shared/demo-panel.component';

@Component({
  selector: 'app-overview',
  imports: [DemoPanelComponent, RouterLink],
  template: `
    <h1 class="page-title">Angular 交互演示</h1>
    <p class="page-desc">
      本项目基于 <a href="https://angular.cn/overview" target="_blank" rel="noopener">Angular 中文文档</a>
      的结构，通过可运行的示例演示核心概念——左侧导航切换各模块即可动手操作。
    </p>

    <app-demo-panel title="框架特性一览" description="点击下方卡片跳转到对应演示">
      <div class="feature-grid">
        @for (f of features; track f.path) {
          <a [routerLink]="linkTo(f.path)" class="feature-card">
            <strong>{{ f.title }}</strong>
            <span>{{ f.desc }}</span>
          </a>
        }
      </div>
    </app-demo-panel>

    <app-demo-panel title="技术栈" description="当前脚手架使用的核心技术">
      <ul class="tech-list">
        <li>Angular 19 独立组件 (Standalone Components)</li>
        <li>Signal 响应式状态管理</li>
        <li>内置控制流（if / for / switch）</li>
        <li>路由惰性加载 + defer 延迟渲染</li>
        <li>HttpClient + 本地 Mock 拦截器（无外部请求）</li>
      </ul>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.5rem; color: #666; line-height: 1.6; }
    .page-desc a { color: #dd0031; }
    .feature-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 0.75rem;
    }
    .feature-card {
      display: flex;
      flex-direction: column;
      gap: 0.25rem;
      padding: 1rem;
      border: 1px solid #e8e8ef;
      border-radius: 8px;
      text-decoration: none;
      color: inherit;
      transition: border-color 0.15s, box-shadow 0.15s;
    }
    .feature-card:hover {
      border-color: #dd0031;
      box-shadow: 0 2px 8px rgba(221, 0, 49, 0.08);
    }
    .feature-card strong { color: #1a1a2e; }
    .feature-card span { font-size: 0.85rem; color: #888; }
    .tech-list { margin: 0; padding-left: 1.25rem; line-height: 1.8; color: #444; }
  `,
})
export class OverviewComponent {
  features = [
    { title: '信号', path: 'guide/signals', desc: 'signal / computed 计数器' },
    { title: '组件', path: 'guide/components', desc: 'input / output 父子通信' },
    { title: '模板', path: 'guide/templates', desc: '绑定与控制流' },
    { title: 'HTTP', path: 'guide/http-client', desc: '异步加载 / 错误 / 重试' },
    { title: '表单', path: 'guide/forms', desc: '响应式表单验证' },
    { title: '路由', path: 'guide/routing', desc: '嵌套路由导航' },
  ];

  linkTo(path: string): string[] {
    const [root, ...rest] = path.split('/');
    return ['/' + root, ...rest];
  }
}
