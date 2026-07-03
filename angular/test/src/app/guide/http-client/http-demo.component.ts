import { Component, inject, signal, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

type LoadState = 'idle' | 'loading' | 'success' | 'error';

interface ApiUser {
  id: number;
  name: string;
  email: string;
}

@Component({
  selector: 'app-http-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">HTTP 客户端</h1>
    <p class="page-desc">所有请求由本地 Mock 拦截器处理，不会访问外部网络。</p>

    <app-demo-panel title="异步数据加载" description="演示 loading → success / error 状态切换">
      <div class="controls">
        <button type="button" (click)="fetchUsers(false)" [disabled]="state() === 'loading'">加载用户</button>
        <button type="button" (click)="fetchUsers(true)" [disabled]="state() === 'loading'">模拟错误</button>
        <label>
          延迟
          <select [value]="delay()" (change)="delay.set(+$any($event.target).value)">
            <option [value]="500">500ms</option>
            <option [value]="1200">1200ms</option>
            <option [value]="2500">2500ms</option>
          </select>
        </label>
      </div>

      @switch (state()) {
        @case ('idle') {
          <p class="state idle">点击「加载用户」开始请求</p>
        }
        @case ('loading') {
          <div class="state loading">
            <span class="spinner"></span>
            加载中，请稍候…
          </div>
        }
        @case ('success') {
          <ul class="user-list">
            @for (u of users(); track u.id) {
              <li><strong>{{ u.name }}</strong> — {{ u.email }}</li>
            }
          </ul>
        }
        @case ('error') {
          <div class="state error">
            <p>{{ errorMsg() }}</p>
            <button type="button" (click)="fetchUsers(false)">重试</button>
          </div>
        }
      }
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .controls { display: flex; gap: 0.75rem; align-items: center; flex-wrap: wrap; margin-bottom: 1rem; }
    .controls button {
      padding: 0.45rem 1rem; border: 1px solid #ddd;
      border-radius: 6px; background: #fff; cursor: pointer;
    }
    .controls button:hover:not(:disabled) { border-color: #dd0031; color: #dd0031; }
    .controls button:disabled { opacity: 0.5; cursor: not-allowed; }
    .controls select { margin-left: 0.35rem; padding: 0.3rem; border-radius: 4px; }
    .state { padding: 1rem; border-radius: 8px; }
    .idle { color: #999; background: #f8f8fc; margin: 0; }
    .loading { display: flex; align-items: center; gap: 0.75rem; background: #e3f2fd; color: #1565c0; }
    .error { background: #ffebee; color: #c62828; }
    .error p { margin: 0 0 0.75rem; }
    .error button { padding: 0.35rem 0.75rem; border: 1px solid #c62828; background: #fff; color: #c62828; border-radius: 6px; cursor: pointer; }
    .spinner {
      width: 20px; height: 20px;
      border: 2px solid #90caf9; border-top-color: #1565c0;
      border-radius: 50%; animation: spin 0.8s linear infinite;
    }
    @keyframes spin { to { transform: rotate(360deg); } }
    .user-list { list-style: none; margin: 0; padding: 0; }
    .user-list li { padding: 0.5rem 0; border-bottom: 1px solid #f0f0f5; }
    .user-list span { color: #888; }
  `,
})
export class HttpDemoComponent implements OnInit {
  private http = inject(HttpClient);

  state = signal<LoadState>('idle');
  users = signal<ApiUser[]>([]);
  errorMsg = signal('');
  delay = signal(1200);

  ngOnInit(): void {
    this.fetchUsers(false);
  }

  fetchUsers(simulateError: boolean): void {
    this.state.set('loading');
    this.errorMsg.set('');

    const headers = new HttpHeaders({
      'X-Mock-Delay': String(this.delay()),
      ...(simulateError ? { 'X-Mock-Error': 'true' } : {}),
    });

    this.http.get<ApiUser[]>('/api/users', { headers }).subscribe({
      next: (data) => {
        this.users.set(data);
        this.state.set('success');
      },
      error: () => {
        this.errorMsg.set('请求失败：模拟服务器错误 (500)');
        this.state.set('error');
      },
    });
  }
}
