# Fuses

> 官方文档：[Fuses | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/fuses)

Electron Fuses 允许你在打包时修改 Electron 二进制文件的行为，用于增强安全性。

常用 Fuses：

| Fuse | 说明 |
|------|------|
| `RunAsNode` | 禁用 `ELECTRON_RUN_AS_NODE` |
| `EnableCookieEncryption` | 启用 Cookie 加密 |
| `EnableNodeOptionsEnvironmentVariable` | 禁用 `NODE_OPTIONS` 环境变量 |
| `EnableEmbeddedAsarIntegrityValidation` | 启用 ASAR 完整性验证 |
| `OnlyLoadAppFromAsar` | 只从 ASAR 加载应用 |

```js
const { flipFuses, FuseVersion, FuseV1Options } = require('@electron/fuses')

flipFuses(appPath, {
  version: FuseVersion.V1,
  [FuseV1Options.RunAsNode]: false
})
```
