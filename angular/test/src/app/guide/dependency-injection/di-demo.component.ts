import { Component, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { DemoPanelComponent } from '../../shared/demo-panel.component';
import { UserService } from '../../shared/user.service';

@Component({
  selector: 'app-di-demo',
  imports: [DemoPanelComponent, FormsModule],
  template: `
    <h1 class="page-title">依赖注入 (DI)</h1>

    <app-demo-panel title="inject() 注入服务" description="UserService 通过 providedIn: 'root' 注册为全局单例">
      <ul class="user-list">
        @for (u of userService.users(); track u.id) {
          <li>
            <strong>{{ u.name }}</strong>
            <span>{{ u.role }}</span>
          </li>
        }
      </ul>
    </app-demo-panel>

    <app-demo-panel title="通过服务共享状态" description="多个组件注入同一服务时会共享同一份数据">
      <div class="add-form">
        <input [(ngModel)]="name" placeholder="新用户姓名" />
        <input [(ngModel)]="role" placeholder="角色" />
        <button type="button" (click)="add()" [disabled]="!name.trim()">添加到服务</button>
      </div>
      <p class="hint">当前服务中共有 {{ userService.users().length }} 位用户（刷新页面后重置）</p>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 1.25rem; font-size: 1.75rem; }
    .user-list { list-style: none; margin: 0; padding: 0; }
    .user-list li {
      display: flex;
      justify-content: space-between;
      padding: 0.6rem 0;
      border-bottom: 1px solid #f0f0f5;
    }
    .user-list span { color: #888; font-size: 0.875rem; }
    .add-form { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 0.5rem; }
    .add-form input {
      flex: 1; min-width: 120px;
      padding: 0.5rem 0.75rem;
      border: 1px solid #ddd; border-radius: 6px;
    }
    .add-form button {
      padding: 0.5rem 1rem;
      background: #dd0031; color: #fff;
      border: none; border-radius: 6px; cursor: pointer;
    }
    .add-form button:disabled { opacity: 0.5; }
    .hint { margin: 0; font-size: 0.85rem; color: #999; }
  `,
})
export class DiDemoComponent {
  userService = inject(UserService);
  name = '';
  role = '开发者';

  add(): void {
    if (!this.name.trim()) return;
    this.userService.addUser(this.name.trim(), this.role.trim());
    this.name = '';
  }
}
