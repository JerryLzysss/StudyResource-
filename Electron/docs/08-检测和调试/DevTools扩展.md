# DevTools 扩展

> 官方文档：[DevTools Extension | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/devtools-extension)

## 加载扩展

```js
const { session } = require('electron')

await session.defaultSession.loadExtension('path/to/extension')
```

## 常用扩展

- React Developer Tools
- Redux DevTools
- Vue.js devtools

> 注意：仅支持未打包的扩展（开发目录），不支持 Chrome Web Store 的 .crx 文件。
