import { Component, signal } from '@angular/core';
import { NgTemplateOutlet } from '@angular/common';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

interface ComponentNode {
  name: string;
  selector: string;
  inputs: string[];
  children?: ComponentNode[];
  expanded: boolean;
}

@Component({
  selector: 'app-devtools-demo',
  imports: [DemoPanelComponent, NgTemplateOutlet],
  template: `
    <h1 class="page-title">组件检查器</h1>
    <p class="page-desc">模拟 Angular DevTools 的组件树视图（本地组件层级，无需安装浏览器扩展）。</p>

    <app-demo-panel title="组件树" description="点击节点查看详情，点击箭头展开/折叠">
      <div class="inspector">
        <div class="tree-panel">
          @for (node of componentTree(); track node.name) {
            <ng-container *ngTemplateOutlet="treeTpl; context: { $implicit: node, depth: 0 }" />
          }
        </div>
        @if (selected(); as sel) {
          <div class="detail-panel">
            <h4>{{ sel.name }}</h4>
            <dl>
              <dt>selector</dt><dd>{{ sel.selector }}</dd>
              <dt>inputs</dt>
              <dd>
                @if (sel.inputs.length) {
                  @for (inp of sel.inputs; track inp) { <code>{{ inp }}</code> }
                } @else { <span class="muted">无</span> }
              </dd>
            </dl>
          </div>
        } @else {
          <div class="detail-panel empty">← 选择一个组件</div>
        }
      </div>
    </app-demo-panel>

    <ng-template #treeTpl let-node let-depth="depth">
      <div class="tree-node" [style.paddingLeft.px]="depth * 16">
        @if (node.children?.length) {
          <button type="button" class="arrow" (click)="toggleNode(node)">{{ node.expanded ? '▼' : '▶' }}</button>
        } @else {
          <span class="arrow spacer">·</span>
        }
        <button type="button" class="node-btn" [class.selected]="selected()?.name === node.name" (click)="select(node)">
          {{ node.name }}
        </button>
      </div>
      @if (node.expanded && node.children) {
        @for (child of node.children; track child.name) {
          <ng-container *ngTemplateOutlet="treeTpl; context: { $implicit: child, depth: depth + 1 }" />
        }
      }
    </ng-template>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .inspector { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
    .tree-panel { border: 1px solid #e8e8ef; border-radius: 8px; padding: 0.75rem; font-family: monospace; font-size: 0.85rem; }
    .tree-node { display: flex; align-items: center; gap: 0.25rem; }
    .arrow { border: none; background: none; cursor: pointer; width: 20px; color: #888; }
    .spacer { display: inline-block; width: 20px; text-align: center; }
    .node-btn {
      border: none; background: none; cursor: pointer; padding: 0.25rem 0.5rem;
      border-radius: 4px; font-family: inherit; flex: 1; text-align: left;
    }
    .node-btn:hover { background: #f4f4f8; }
    .node-btn.selected { background: #fef0f2; color: #dd0031; font-weight: 600; }
    .detail-panel { border: 1px solid #e8e8ef; border-radius: 8px; padding: 1rem; }
    .detail-panel.empty { color: #999; display: flex; align-items: center; justify-content: center; }
    .detail-panel h4 { margin: 0 0 0.75rem; }
    .detail-panel dl { margin: 0; }
    .detail-panel dt { font-size: 0.75rem; color: #888; margin-top: 0.5rem; }
    .detail-panel dd { margin: 0.15rem 0 0; }
    .detail-panel code { background: #f4f4f8; padding: 0.1rem 0.35rem; border-radius: 3px; margin-right: 0.35rem; font-size: 0.8rem; }
    .muted { color: #999; }
    @media (max-width: 640px) { .inspector { grid-template-columns: 1fr; } }
  `,
})
export class DevtoolsDemoComponent {
  componentTree = signal<ComponentNode[]>([
    {
      name: 'AppComponent',
      selector: 'app-root',
      inputs: [],
      expanded: true,
      children: [
        {
          name: 'DocLayoutComponent',
          selector: 'app-doc-layout',
          inputs: [],
          expanded: true,
          children: [
            {
              name: 'SignalsDemoComponent',
              selector: 'app-signals-demo',
              inputs: [],
              expanded: false,
              children: [
                { name: 'DemoPanelComponent', selector: 'app-demo-panel', inputs: ['title', 'description'], expanded: false },
              ],
            },
            {
              name: 'UserCardComponent',
              selector: 'app-user-card',
              inputs: ['id', 'name', 'role'],
              expanded: false,
            },
          ],
        },
      ],
    },
  ]);

  selected = signal<ComponentNode | null>(null);

  select(node: ComponentNode): void {
    this.selected.set(node);
  }

  toggleNode(node: ComponentNode): void {
    node.expanded = !node.expanded;
    this.componentTree.update((t) => [...t]);
  }
}
