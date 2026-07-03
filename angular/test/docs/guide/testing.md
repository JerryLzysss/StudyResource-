# 测试 (Testing)

Angular 提供了完整的测试工具链，支持单元测试、组件测试和端到端测试。

## 单元测试

Angular CLI 默认使用 [Karma](https://karma-runner.github.io) + [Jasmine](https://jasmine.github.io) 进行单元测试：

```bash
ng test
```

### 测试组件

```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppComponent } from './app.component';

describe('AppComponent', () => {
  let component: AppComponent;
  let fixture: ComponentFixture<AppComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppComponent],
    }).compileComponents();

    fixture = TestBed.createComponent(AppComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
```

## 测试服务

```typescript
import { TestBed } from '@angular/core/testing';
import { UserService } from './user.service';

describe('UserService', () => {
  let service: UserService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(UserService);
  });

  it('should return users', () => {
    expect(service.getUsers().length).toBeGreaterThan(0);
  });
});
```

## 端到端测试

```bash
ng e2e
```

Angular CLI 不附带默认的 E2E 框架，你可以选择 Playwright、Cypress 等。

## 测试最佳实践

- 使用 `TestBed` 配置测试模块
- 模拟 HTTP 请求使用 `HttpTestingController`
- 使用 `fakeAsync` 和 `tick` 测试异步代码
- 保持测试独立、可重复

---

> 参考：[Angular 测试指南](https://angular.cn/guide/testing)
