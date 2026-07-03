import { Component, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DemoPanelComponent } from '../../shared/demo-panel.component';
import { UserCardComponent } from '../../shared/user-card.component';

interface Member {
  id: number;
  name: string;
  role: string;
}

@Component({
  selector: 'app-components-demo',
  imports: [DemoPanelComponent, UserCardComponent, FormsModule],
  template: `
    <h1 class="page-title">组件 (Components)</h1>

    <app-demo-panel title="父子组件通信" description="父组件通过 input 传递数据，子组件通过 output 触发事件">
      <div class="add-form">
        <input [(ngModel)]="newName" placeholder="姓名" />
        <input [(ngModel)]="newRole" placeholder="角色" />
        <button type="button" (click)="addMember()" [disabled]="!newName.trim()">添加成员</button>
      </div>

      @if (members().length === 0) {
        <p class="empty">暂无成员，请添加</p>
      } @else {
        @for (m of members(); track m.id) {
          <app-user-card
            [id]="m.id"
            [name]="m.name"
            [role]="m.role"
            (remove)="removeMember($event)"
          />
        }
      }
    </app-demo-panel>

    <app-demo-panel title="组件结构说明">
      <pre class="code">{{ componentCode }}</pre>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 1.25rem; font-size: 1.75rem; }
    .add-form { display: flex; gap: 0.5rem; margin-bottom: 1rem; flex-wrap: wrap; }
    .add-form input {
      flex: 1;
      min-width: 120px;
      padding: 0.5rem 0.75rem;
      border: 1px solid #ddd;
      border-radius: 6px;
    }
    .add-form button {
      padding: 0.5rem 1rem;
      background: #dd0031;
      color: #fff;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
    .add-form button:disabled { opacity: 0.5; cursor: not-allowed; }
    .empty { color: #999; margin: 0; }
    .code {
      background: #1e1e2e;
      color: #cdd6f4;
      padding: 1rem;
      border-radius: 8px;
      font-size: 0.8rem;
      overflow-x: auto;
      margin: 0;
    }
  `,
})
export class ComponentsDemoComponent {
  members = signal<Member[]>([
    { id: 1, name: 'Angular', role: '框架' },
    { id: 2, name: 'TypeScript', role: '语言' },
  ]);
  newName = '';
  newRole = '';
  private nextId = 3;

  componentCode = `@Component({ selector: 'app-user-card' })
export class UserCardComponent {
  id = input.required<number>();
  name = input.required<string>();
  role = input.required<string>();
  remove = output<number>();
}`;

  addMember(): void {
    if (!this.newName.trim()) return;
    this.members.update((list) => [
      ...list,
      { id: this.nextId++, name: this.newName.trim(), role: this.newRole.trim() || '成员' },
    ]);
    this.newName = '';
    this.newRole = '';
  }

  removeMember(id: number): void {
    this.members.update((list) => list.filter((m) => m.id !== id));
  }
}
