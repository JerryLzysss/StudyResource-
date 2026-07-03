# ESM

> 官方文档：[ESM | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/esm)

Electron 支持 ECMAScript 模块 (ESM)。在 `package.json` 中设置 `"type": "module"` 即可使用 `import/export` 语法。

```json
{
  "type": "module"
}
```

```js
// main.mjs
import { app, BrowserWindow } from 'electron'
```

注意：ESM 与 CommonJS 混用时需要注意 `__dirname` 等变量的替代方案。
