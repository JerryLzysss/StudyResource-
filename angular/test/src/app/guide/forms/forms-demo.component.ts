import { Component, inject, signal, computed } from '@angular/core';
import { JsonPipe } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

@Component({
  selector: 'app-forms-demo',
  imports: [DemoPanelComponent, ReactiveFormsModule, JsonPipe],
  template: `
    <h1 class="page-title">表单 (Forms)</h1>

    <app-demo-panel title="响应式表单 + 验证" description="FormBuilder 创建 FormGroup，Validators 校验">
      <form [formGroup]="form" (ngSubmit)="onSubmit()" class="form">
        <div class="field">
          <label>邮箱</label>
          <input formControlName="email" type="email" placeholder="user@example.com" />
          @if (form.controls.email.touched && form.controls.email.errors?.['required']) {
            <span class="error">邮箱必填</span>
          }
          @if (form.controls.email.touched && form.controls.email.errors?.['email']) {
            <span class="error">邮箱格式不正确</span>
          }
        </div>
        <div class="field">
          <label>密码</label>
          <input formControlName="password" type="password" placeholder="至少 6 位" />
          @if (form.controls.password.touched && form.controls.password.errors?.['minlength']) {
            <span class="error">密码至少 6 位</span>
          }
        </div>
        <button type="submit" [disabled]="form.invalid">提交</button>
      </form>

      @if (submitted()) {
        <div class="success-box">提交成功：{{ submittedData() | json }}</div>
      }
    </app-demo-panel>

    <app-demo-panel title="表单状态">
      <ul class="status">
        <li>valid: {{ form.valid }}</li>
        <li>touched: {{ form.touched }}</li>
        <li>dirty: {{ form.dirty }}</li>
        <li>value: {{ formValue() }}</li>
      </ul>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 1.25rem; font-size: 1.75rem; }
    .form { max-width: 360px; }
    .field { margin-bottom: 1rem; }
    .field label { display: block; margin-bottom: 0.35rem; font-size: 0.875rem; color: #555; }
    .field input { width: 100%; padding: 0.5rem 0.75rem; border: 1px solid #ddd; border-radius: 6px; }
    .field input.ng-invalid.ng-touched { border-color: #dd0031; }
    .error { display: block; color: #dd0031; font-size: 0.8rem; margin-top: 0.25rem; }
    button[type=submit] { padding: 0.5rem 1.25rem; background: #dd0031; color: #fff; border: none; border-radius: 6px; cursor: pointer; }
    button:disabled { opacity: 0.5; cursor: not-allowed; }
    .success-box { margin-top: 1rem; padding: 0.75rem 1rem; background: #e8f5e9; border-radius: 6px; font-size: 0.875rem; color: #2e7d32; }
    .status { margin: 0; padding-left: 1.25rem; font-size: 0.875rem; line-height: 1.8; font-family: monospace; }
  `,
})
export class FormsDemoComponent {
  private fb = inject(FormBuilder);
  submitted = signal(false);
  submittedData = signal<Record<string, string> | null>(null);

  form = this.fb.group({
    email: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required, Validators.minLength(6)]],
  });

  formValue = computed(() => JSON.stringify(this.form.value));

  onSubmit(): void {
    if (this.form.invalid) return;
    this.submittedData.set(this.form.value as Record<string, string>);
    this.submitted.set(true);
  }
}
