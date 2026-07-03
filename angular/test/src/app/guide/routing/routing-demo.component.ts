import { Component, inject, signal } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet, ActivatedRoute } from '@angular/router';
import { DemoPanelComponent } from '../../shared/demo-panel.component';
import { UserService } from '../../shared/user.service';

@Component({
  selector: 'app-routing-list',
  imports: [DemoPanelComponent, RouterLink, RouterLinkActive],
  template: `
    <app-demo-panel title="用户列表" description="点击用户查看详情（嵌套路由演示）">
      <ul class="nav-list">
        @for (u of userService.users(); track u.id) {
          <li>
            <a [routerLink]="['detail', u.id]" routerLinkActive="active">{{ u.name }}</a>
          </li>
        }
      </ul>
    </app-demo-panel>
  `,
  styles: `
    .nav-list { list-style: none; margin: 0; padding: 0; }
    .nav-list a {
      display: block; padding: 0.6rem 0.75rem; border-radius: 6px;
      text-decoration: none; color: #444;
    }
    .nav-list a:hover { background: #f4f4f8; }
    .nav-list a.active { background: #fef0f2; color: #dd0031; font-weight: 500; }
  `,
})
export class RoutingListComponent {
  userService = inject(UserService);
}

@Component({
  selector: 'app-routing-detail',
  imports: [DemoPanelComponent, RouterLink],
  template: `
    @if (user(); as u) {
      <app-demo-panel [title]="u.name" description="通过 ActivatedRoute 读取路由参数 :id">
        <dl class="detail">
          <dt>ID</dt><dd>{{ u.id }}</dd>
          <dt>姓名</dt><dd>{{ u.name }}</dd>
          <dt>角色</dt><dd>{{ u.role }}</dd>
        </dl>
        <a routerLink="../" class="back">← 返回列表</a>
      </app-demo-panel>
    } @else {
      <app-demo-panel title="未找到用户">
        <p>该 ID 不存在</p>
        <a routerLink="../" class="back">← 返回列表</a>
      </app-demo-panel>
    }
  `,
  styles: `
    .detail { display: grid; grid-template-columns: 80px 1fr; gap: 0.35rem 1rem; margin: 0 0 1rem; }
    .detail dt { color: #888; font-size: 0.875rem; }
    .detail dd { margin: 0; }
    .back { color: #dd0031; text-decoration: none; font-size: 0.9rem; }
  `,
})
export class RoutingDetailComponent {
  private route = inject(ActivatedRoute);
  private userService = inject(UserService);

  user = () => {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    return this.userService.getById(id);
  };
}

@Component({
  selector: 'app-routing-demo',
  imports: [RouterOutlet, RoutingListComponent],
  template: `
    <h1 class="page-title">路由 (Routing)</h1>
    <p class="page-desc">嵌套路由演示：左侧列表固定，右侧 router-outlet 切换详情视图。</p>
    <div class="routing-layout">
      <aside class="sidebar"><app-routing-list /></aside>
      <main class="detail-area">
        <router-outlet (activate)="childActive.set(true)" (deactivate)="childActive.set(false)" />
        @if (!childActive()) {
          <p class="hint">← 选择用户查看详情</p>
        }
      </main>
    </div>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .routing-layout { display: grid; grid-template-columns: 260px 1fr; gap: 1rem; }
    .hint { color: #ccc; padding: 2rem; text-align: center; margin: 0; }
    @media (max-width: 640px) { .routing-layout { grid-template-columns: 1fr; } }
  `,
})
export class RoutingDemoComponent {
  childActive = signal(false);
}
