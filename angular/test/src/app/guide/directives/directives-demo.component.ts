import { Component, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { DemoPanelComponent } from '../../shared/demo-panel.component';
import { HighlightDirective } from '../../shared/highlight.directive';

@Component({
  selector: 'app-directives-demo',
  imports: [DemoPanelComponent, HighlightDirective, NgClass],
  template: `
    <h1 class="page-title">指令 (Directives)</h1>

    <app-demo-panel title="自定义属性指令 appHighlight" description="通过 input 动态改变背景色">
      <p appHighlight [appHighlight]="highlightColor()">这段文字由 HighlightDirective 控制背景色</p>
      <div class="color-picker">
        @for (c of colors; track c.value) {
          <button
            type="button"
            class="swatch"
            [style.background]="c.value"
            [class.active]="highlightColor() === c.value"
            (click)="highlightColor.set(c.value)"
            [title]="c.label"
          ></button>
        }
      </div>
    </app-demo-panel>

    <app-demo-panel title="NgClass 动态类名">
      <p [ngClass]="{ 'text-bold': isBold(), 'text-italic': isItalic(), 'text-red': isRed() }">
        可切换样式的文本
      </p>
      <div class="toggles">
        <label><input type="checkbox" [checked]="isBold()" (change)="isBold.set($any($event.target).checked)" /> 粗体</label>
        <label><input type="checkbox" [checked]="isItalic()" (change)="isItalic.set($any($event.target).checked)" /> 斜体</label>
        <label><input type="checkbox" [checked]="isRed()" (change)="isRed.set($any($event.target).checked)" /> 红色</label>
      </div>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 1.25rem; font-size: 1.75rem; }
    p { padding: 0.75rem 1rem; border-radius: 6px; margin: 0 0 0.75rem; }
    .color-picker { display: flex; gap: 0.5rem; }
    .swatch {
      width: 32px; height: 32px;
      border: 2px solid transparent;
      border-radius: 50%;
      cursor: pointer;
    }
    .swatch.active { border-color: #333; }
    .toggles { display: flex; gap: 1rem; }
    .toggles label { display: flex; align-items: center; gap: 0.35rem; cursor: pointer; }
    .text-bold { font-weight: 700; }
    .text-italic { font-style: italic; }
    .text-red { color: #dd0031; }
  `,
})
export class DirectivesDemoComponent {
  highlightColor = signal('#fff3cd');
  isBold = signal(false);
  isItalic = signal(false);
  isRed = signal(false);
  colors = [
    { label: '黄色', value: '#fff3cd' },
    { label: '蓝色', value: '#cfe2ff' },
    { label: '绿色', value: '#d1e7dd' },
    { label: '粉色', value: '#f8d7da' },
  ];
}
