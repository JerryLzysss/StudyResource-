# 使用原生 Node 模块

> 官方文档：[Using Native Node Modules | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/using-native-node-modules)

## 概述

原生 Node 模块是用 C/C++ 编写的 Node.js 插件。由于 Electron 使用不同版本的 Node.js，需要为 Electron 重新编译原生模块。

## 使用 @electron/rebuild

```sh
npm install --save-dev @electron/rebuild
npx electron-rebuild
```

## 手动编译

```sh
HOME=~/.electron-gyp node-gyp rebuild --target=VERSION --arch=x64 --dist-url=https://electronjs.org/headers
```

## 常见问题

- 确保安装了构建工具（Windows: Visual Studio Build Tools, macOS: Xcode CLI Tools）
- 使用 `electron-rebuild` 而非 `node-gyp rebuild`
- 检查模块是否支持当前 Electron 版本

更多教程请参阅 [原生代码教程](./原生代码教程/概述.md)。
