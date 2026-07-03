import { Component, signal } from '@angular/core';
import { DemoPanelComponent } from '../../shared/demo-panel.component';

export class CalculatorService {
  add(a: number, b: number): number {
    return a + b;
  }
  subtract(a: number, b: number): number {
    return a - b;
  }
  multiply(a: number, b: number): number {
    return a * b;
  }
}

interface TestResult {
  name: string;
  pass: boolean;
}

@Component({
  selector: 'app-testing-demo',
  imports: [DemoPanelComponent],
  template: `
    <h1 class="page-title">测试 (Testing)</h1>
    <p class="page-desc">在浏览器内模拟单元测试运行，展示 TestBed + 断言的工作方式（不执行 ng test）。</p>

    <app-demo-panel title="CalculatorService 单元测试" description="点击运行，查看各测试用例通过/失败">
      <button type="button" class="run-btn" (click)="runTests()">运行测试</button>

      @if (results().length > 0) {
        <ul class="results">
          @for (r of results(); track r.name) {
            <li [class.pass]="r.pass" [class.fail]="!r.pass">
              {{ r.pass ? '✓' : '✗' }} {{ r.name }}
            </li>
          }
        </ul>
        <p class="summary">
          {{ passCount() }} / {{ results().length }} 通过
          @if (passCount() === results().length) { — 全部通过 🎉 }
        </p>
      }
    </app-demo-panel>

    <app-demo-panel title="测试代码示例">
      <pre class="code">{{ testCode }}</pre>
    </app-demo-panel>
  `,
  styles: `
    .page-title { margin: 0 0 0.5rem; font-size: 1.75rem; }
    .page-desc { margin: 0 0 1.25rem; color: #666; font-size: 0.9rem; }
    .run-btn {
      padding: 0.5rem 1.25rem; background: #dd0031; color: #fff;
      border: none; border-radius: 6px; cursor: pointer;
    }
    .results { list-style: none; margin: 1rem 0 0; padding: 0; }
    .results li { padding: 0.4rem 0.75rem; border-radius: 4px; margin-bottom: 0.25rem; font-family: monospace; font-size: 0.875rem; }
    .pass { background: #e8f5e9; color: #2e7d32; }
    .fail { background: #ffebee; color: #c62828; }
    .summary { margin: 0.75rem 0 0; font-weight: 500; }
    .code {
      background: #1e1e2e; color: #cdd6f4;
      padding: 1rem; border-radius: 8px;
      font-size: 0.8rem; overflow-x: auto; margin: 0;
    }
  `,
})
export class TestingDemoComponent {
  private calc = new CalculatorService();
  results = signal<TestResult[]>([]);

  testCode = `it('should add numbers', () => {
  expect(calc.add(2, 3)).toBe(5);
});

it('should subtract numbers', () => {
  expect(calc.subtract(5, 2)).toBe(3);
});`;

  passCount = () => this.results().filter((r) => r.pass).length;

  runTests(): void {
    this.results.set([
      { name: 'add(2, 3) === 5', pass: this.calc.add(2, 3) === 5 },
      { name: 'add(-1, 1) === 0', pass: this.calc.add(-1, 1) === 0 },
      { name: 'subtract(5, 2) === 3', pass: this.calc.subtract(5, 2) === 3 },
      { name: 'multiply(3, 4) === 12', pass: this.calc.multiply(3, 4) === 12 },
      { name: 'multiply(0, 99) === 1 (故意失败)', pass: this.calc.multiply(0, 99) === 1 },
    ]);
  }
}
