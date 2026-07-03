import { Component, input, output } from '@angular/core';

@Component({
  selector: 'app-user-card',
  template: `
    <div class="card">
      <div class="info">
        <strong>{{ name() }}</strong>
        <span>{{ role() }}</span>
      </div>
      <button type="button" (click)="remove.emit(id())">移除</button>
    </div>
  `,
  styles: `
    .card {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0.75rem 1rem;
      border: 1px solid #e8e8ef;
      border-radius: 8px;
      margin-bottom: 0.5rem;
    }
    .info {
      display: flex;
      flex-direction: column;
      gap: 0.15rem;
    }
    .info span {
      font-size: 0.85rem;
      color: #666;
    }
    button {
      border: 1px solid #dd0031;
      background: #fff;
      color: #dd0031;
      border-radius: 6px;
      padding: 0.3rem 0.75rem;
      cursor: pointer;
    }
    button:hover {
      background: #fef0f2;
    }
  `,
})
export class UserCardComponent {
  id = input.required<number>();
  name = input.required<string>();
  role = input.required<string>();
  remove = output<number>();
}
