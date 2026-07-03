# 表单 (Forms)

Angular 提供了两种处理用户输入的方式：响应式表单和模板驱动表单。

## 响应式表单

响应式表单提供直接、显式的方式来管理表单状态。使用 `FormBuilder` 创建：

```typescript
import { Component, inject } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule],
  template: `
    <form [formGroup]="form" (ngSubmit)="onSubmit()">
      <input formControlName="email" />
      <input formControlName="password" type="password" />
      <button type="submit">登录</button>
    </form>
  `,
})
export class LoginComponent {
  private fb = inject(FormBuilder);
  form = this.fb.group({
    email: ['', [Validators.required, Validators.email]],
    password: ['', Validators.required],
  });

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form.value);
    }
  }
}
```

## 模板驱动表单

模板驱动表单依赖指令在模板中创建和管理表单控件：

```html
<form #loginForm="ngForm" (ngSubmit)="onSubmit(loginForm)">
  <input name="email" ngModel required email />
  <input name="password" ngModel required type="password" />
  <button type="submit" [disabled]="loginForm.invalid">登录</button>
</form>
```

## 表单验证

| 验证器 | 说明 |
|--------|------|
| `Validators.required` | 必填 |
| `Validators.email` | 邮箱格式 |
| `Validators.minLength(n)` | 最小长度 |
| `Validators.maxLength(n)` | 最大长度 |
| `Validators.pattern(regex)` | 正则匹配 |

## 选择指南

- **响应式表单** — 适合复杂表单、动态表单、单元测试
- **模板驱动表单** — 适合简单表单、快速原型

---

> 参考：[Angular 表单指南](https://angular.cn/guide/forms)
