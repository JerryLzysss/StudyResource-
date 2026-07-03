# 库 (Libraries)

Angular 库是可重用的代码包，可以在多个 Angular 应用之间共享。

## 创建库

```bash
ng generate library my-lib
```

这会在工作区中创建一个 `projects/my-lib` 目录。

## 库结构

```
projects/my-lib/
├── src/
│   ├── lib/
│   │   └── my-lib.component.ts
│   └── public-api.ts      # 公开 API 入口
├── ng-package.json         # ng-packagr 配置
└── package.json
```

## 构建库

```bash
ng build my-lib
```

构建产物位于 `dist/my-lib` 目录。

## 在应用中使用

```typescript
import { MyLibComponent } from 'my-lib';

@Component({
  imports: [MyLibComponent],
  template: `<lib-my-lib />`,
})
export class AppComponent {}
```

## 发布到 npm

```bash
cd dist/my-lib
npm publish
```

## 库 vs 应用

| 特性 | 应用 | 库 |
|------|------|-----|
| 入口 | `main.ts` | `public-api.ts` |
| 输出 | 可部署的 Web 应用 | 可发布的 npm 包 |
| 引导 | 需要 bootstrap | 由消费应用引导 |

## 最佳实践

- 通过 `public-api.ts` 明确导出公开 API
- 使用 `ng-packagr` 进行优化的库打包
- 为库编写单元测试和文档
- 遵循语义化版本控制

---

> 参考：[Angular 库指南](https://angular.cn/tools/libraries)
