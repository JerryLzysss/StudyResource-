import { Component, input } from '@angular/core';

@Component({
  selector: 'app-demo-panel',
  template: `
    <section class="panel">
      <header class="panel-header">
        <h2>{{ title() }}</h2>
        @if (description()) {
          <p>{{ description() }}</p>
        }
      </header>
      <div class="panel-body">
        <ng-content />
      </div>
    </section>
  `,
  styles: `
    .panel {
      background: #fff;
      border: 1px solid #e8e8ef;
      border-radius: 10px;
      margin-bottom: 1.25rem;
      overflow: hidden;
    }
    .panel-header {
      padding: 1rem 1.25rem;
      border-bottom: 1px solid #f0f0f5;
      background: #fafafa;
    }
    .panel-header h2 {
      margin: 0;
      font-size: 1rem;
      font-weight: 600;
      color: #1a1a2e;
    }
    .panel-header p {
      margin: 0.35rem 0 0;
      font-size: 0.875rem;
      color: #666;
    }
    .panel-body {
      padding: 1.25rem;
    }
  `,
})
export class DemoPanelComponent {
  title = input.required<string>();
  description = input<string>('');
}
