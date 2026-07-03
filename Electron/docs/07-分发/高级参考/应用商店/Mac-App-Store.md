# Mac App Store

> 官方文档：[Mac App Store | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/mac-app-store-submission-guide)

## 概述

将 Electron 应用提交到 Mac App Store 需要：

1. Apple Developer 账号
2. Mac App Store 分发证书
3. 启用 App Sandbox
4. 使用 `electron-osx-sign` 签名

## 关键配置

```js
// forge.config.js
packagerConfig: {
  osxSign: {
    identity: '3rd Party Mac Developer Application: ...',
    'hardened-runtime': true,
    entitlements: 'entitlements.plist'
  },
  osxNotarize: {
    appleId: process.env.APPLE_ID,
    appleIdPassword: process.env.APPLE_PASSWORD
  }
}
```
