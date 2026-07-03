# Snapcraft

> 官方文档：[Snapcraft | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/snapcraft)

## 概述

使用 Snap 格式在 Linux 上分发 Electron 应用。

## 配置

Electron Forge 支持 `@electron-forge/maker-snap`：

```js
makers: [{
  name: '@electron-forge/maker-snap',
  config: {
    summary: '应用描述',
    grade: 'stable'
  }
}]
```

Snap 应用通过 Snap Store 分发，支持自动更新。
