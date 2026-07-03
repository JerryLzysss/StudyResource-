import { Component, signal } from '@angular/core';
import { NgTemplateOutlet } from '@angular/common';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

interface TreeNode {
  name: string;
  type: 'folder' | 'file';
  children?: TreeNode[];
  expanded?: boolean;
}

@Component({
  selector: 'app-libraries-demo',
  imports: [DemoPanelComponent, NgTemplateOutlet],
  template: `
    <h1 class="page-title">库结构 (Libraries)</h1>
    <p class="page-desc">可视化 Angular 工作区中 library 的典型目录结构（本地展示，不发布 npm）。</p>

    <app-demo-panel title="projects/my-lib 结构" description="点击文件夹展开/折叠">
      <ul class="tree">
        @for (node of tree(); track node.name) {
          <ng-container *ngTemplateOutlet="nodeTpl; context: { $implicit: node, depth: 0 }" />
        }
      </ul>
    </app-demo-panel>

    <app-demo-panel title="public-api.ts 导出示例">
      <pre class="code">{{ publicApi }}</pre>
    </app-demo-panel>

    <ng-template #nodeTpl let-node let-depth="depth">
      <li [style.paddingLeft.px]="depth * 20">
        @if (node.type === 'folder') {
          <button type="button" class="folder" (click)="toggle(node)">
            {{ node.expanded ? '▼' : '▶' }} {{ node.name }}/
          </button>
          @if (node.expanded && node.children) {
            <ul class="tree">
              @for (child of node.children; track child.name) {
                <ng-container *ngTemplateOutlet="nodeTpl; context: { $implicit: child, depth: depth + 1 }" />
              }
            </ul>
          }
        } @else {
          <span class="file">📄 {{ node.name }}</span>
        }
      </li>
    </ng-template>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .tree { list-style: none; margin: 0; padding: 0; }
    .folder {
      border: none; background: none; cursor: pointer;
      font-family: monospace; font-size: 0.875rem; padding: 0.2rem 0; color: #444;
    }
    .folder:hover { color: #dd0031; }
    .file { font-family: monospace; font-size: 0.875rem; color: #666; display: block; padding: 0.2rem 0; }
    .code {
      background: #1e1e2e; color: #cdd6f4;
      padding: 1rem; border-radius: 8px; font-size: 0.8rem; margin: 0;
    }
  `,
})
export class LibrariesDemoComponent {
  tree = signal<TreeNode[]>([
    {
      name: 'projects',
      type: 'folder',
      expanded: true,
      children: [
        {
          name: 'my-lib',
          type: 'folder',
          expanded: true,
          children: [
            {
              name: 'src',
              type: 'folder',
              expanded: true,
              children: [
                {
                  name: 'lib',
                  type: 'folder',
                  expanded: true,
                  children: [
                    { name: 'my-lib.component.ts', type: 'file' },
                    { name: 'my-lib.service.ts', type: 'file' },
                  ],
                },
                { name: 'public-api.ts', type: 'file' },
              ],
            },
            { name: 'ng-package.json', type: 'file' },
            { name: 'package.json', type: 'file' },
          ],
        },
      ],
    },
  ]);

  publicApi = `export * from './lib/my-lib.component';
export * from './lib/my-lib.service';`;

  toggle(node: TreeNode): void {
    node.expanded = !node.expanded;
    this.tree.update((t) => [...t]);
  }
}
