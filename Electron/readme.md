# Electron 学习笔记

> 参考文档：[Electron 官方中文文档](https://www.electronjs.org/zh/docs/latest/)

Electron 是一个使用 JavaScript、HTML 和 CSS 构建桌面应用程序的框架。它将 Chromium 和 Node.js 嵌入到二进制文件中，允许你保持一个 JavaScript 代码库，并创建在 Windows、macOS 和 Linux 上运行的跨平台应用——不需要本地开发经验。

## Electron Fiddle

[Electron Fiddle](https://www.electronjs.org/fiddle) 是由 Electron 开发并由其维护者支持的沙盒程序。强烈建议将其作为学习工具安装，以便在开发过程中对 Electron 的 API 进行实验或对特性进行原型化。

浏览官方教程中的例子时，你会发现代码示例中有「Open In Electron Fiddle」按钮，点击即可在 Fiddle 中加载示例。

## 文档目录

### [01 - 开始上手](./docs/01-开始上手/简介.md)

- [简介](./docs/01-开始上手/简介.md)
- [为什么选择 Electron](./docs/01-开始上手/为什么选择Electron.md)
- **教程**
  - [01 基本要求](./docs/01-开始上手/教程/01-基本要求.md)
  - [02 第一个应用](./docs/01-开始上手/教程/02-第一个应用.md)
  - [02 第一个应用 - 解析](./docs/01-开始上手/教程/02-第一个应用-解析.md)
  - [03 预加载脚本](./docs/01-开始上手/教程/03-预加载脚本.md)
  - [04 添加功能](./docs/01-开始上手/教程/04-添加功能.md)
  - [05 打包程序](./docs/01-开始上手/教程/05-打包程序.md)
  - [06 发布和更新](./docs/01-开始上手/教程/06-发布和更新.md)

### [02 - Electron 中的流程](./docs/02-Electron中的流程/流程模型.md)

- [流程模型](./docs/02-Electron中的流程/流程模型.md)
- [上下文隔离](./docs/02-Electron中的流程/上下文隔离.md)
- [进程间通信](./docs/02-Electron中的流程/进程间通信.md)
- [沙盒](./docs/02-Electron中的流程/沙盒.md)
- [MessagePorts](./docs/02-Electron中的流程/MessagePorts.md)

### [03 - 最佳实践](./docs/03-最佳实践/性能.md)

- [性能](./docs/03-最佳实践/性能.md)
- [安全](./docs/03-最佳实践/安全.md)

### [04 - 示例](./docs/04-示例/示例预览.md)

- [示例预览](./docs/04-示例/示例预览.md)
- [深色模式](./docs/04-示例/深色模式.md) · [设备](./docs/04-示例/设备.md) · [应用内购买](./docs/04-示例/应用内购买.md) · [键盘快捷键](./docs/04-示例/键盘快捷键.md)
- [从其他应用 URL 启动](./docs/04-示例/从其他应用URL启动.md) · [Linux 桌面操作](./docs/04-示例/Linux桌面操作.md)
- **菜单**：[应用菜单](./docs/04-示例/菜单/应用菜单.md) · [上下文菜单](./docs/04-示例/菜单/上下文菜单.md) · [macOS Dock](./docs/04-示例/菜单/macOS-Dock.md) · [托盘](./docs/04-示例/菜单/托盘.md)
- [多线程](./docs/04-示例/多线程.md) · [原生文件拖放](./docs/04-示例/原生文件拖放.md) · [导航历史](./docs/04-示例/导航历史.md)
- [通知](./docs/04-示例/通知.md) · [离屏渲染](./docs/04-示例/离屏渲染.md) · [在线/离线检测](./docs/04-示例/在线离线检测.md)
- [进度条](./docs/04-示例/进度条.md) · [最近文档](./docs/04-示例/最近文档.md) · [表示文件](./docs/04-示例/表示文件.md)
- [拼写检查](./docs/04-示例/拼写检查.md) · [Web 嵌入](./docs/04-示例/Web嵌入.md) · [Windows 任务栏](./docs/04-示例/Windows任务栏.md)
- **窗口自定义**：[自定义标题栏](./docs/04-示例/窗口自定义/自定义标题栏.md) · [自定义窗口交互](./docs/04-示例/窗口自定义/自定义窗口交互.md) · [自定义窗口样式](./docs/04-示例/窗口自定义/自定义窗口样式.md)

### [05 - 开发](./docs/05-开发/无障碍.md)

- [无障碍](./docs/05-开发/无障碍.md) · [安装指导](./docs/05-开发/安装指导.md) · [ASAR 归档](./docs/05-开发/ASAR归档.md)
- [ASAR 完整性](./docs/05-开发/ASAR完整性.md) · [样板与 CLI](./docs/05-开发/样板与CLI.md) · [ESM](./docs/05-开发/ESM.md)
- [Fuses](./docs/05-开发/Fuses.md) · [Windows ARM](./docs/05-开发/Windows-ARM.md)

### [06 - Native Node Modules](./docs/06-Native-Node-Modules/使用原生Node模块.md)

- [使用原生 Node 模块](./docs/06-Native-Node-Modules/使用原生Node模块.md)
- **原生代码与 Electron 教程**：[概述](./docs/06-Native-Node-Modules/原生代码教程/概述.md) · [C++ Win32](./docs/06-Native-Node-Modules/原生代码教程/C++-Win32.md) · [Swift macOS](./docs/06-Native-Node-Modules/原生代码教程/Swift-macOS.md) · [C++ Linux](./docs/06-Native-Node-Modules/原生代码教程/C++-Linux.md)

### [07 - 分发](./docs/07-分发/Electron-Forge概述.md)

- [Electron Forge 概述](./docs/07-分发/Electron-Forge概述.md)
- **高级参考**：[分发概述](./docs/07-分发/高级参考/分发概述.md) · [应用分发](./docs/07-分发/高级参考/应用分发.md) · [代码签名](./docs/07-分发/高级参考/代码签名.md) · [更新](./docs/07-分发/高级参考/更新.md)
- **应用商店指南**：[Mac App Store](./docs/07-分发/高级参考/应用商店/Mac-App-Store.md) · [Windows Store](./docs/07-分发/高级参考/应用商店/Windows-Store.md) · [Snapcraft](./docs/07-分发/高级参考/应用商店/Snapcraft.md)

### [08 - 检测和调试](./docs/08-检测和调试/自动化测试.md)

- [自动化测试](./docs/08-检测和调试/自动化测试.md) · [调试主进程](./docs/08-检测和调试/调试主进程.md) · [VS Code 调试](./docs/08-检测和调试/VS-Code调试.md)
- [REPL](./docs/08-检测和调试/REPL.md) · [DevTools 扩展](./docs/08-检测和调试/DevTools扩展.md)
- [应用调试](./docs/08-检测和调试/应用调试.md) · [无头 CI 测试](./docs/08-检测和调试/无头CI测试.md)

## 本项目代码

| 文件 | 说明 |
|------|------|
| `main.js` | 主进程：窗口、菜单、托盘、IPC 处理 |
| `preload.js` | 预加载脚本：通过 contextBridge 安全暴露 API |
| `renderer.js` | 渲染器逻辑：UI 交互与 IPC 调用 |
| `index.html` | 渲染器页面 |
| `styles.css` | 界面样式（支持深色模式） |
| `forge.config.js` | Electron Forge 打包配置 |

## 运行项目

```sh
# 安装依赖（国内建议配置镜像）
set ELECTRON_MIRROR=https://npmmirror.com/mirrors/electron/
set ELECTRON_CUSTOM_DIR={{ version }}
npm install

# 开发模式运行
npm run dev
# 或使用 Forge
npm start

# 打包
npm run make
```

## 已实现功能

对应文档教程的代码演示：

| 功能 | 对应文档 |
|------|----------|
| BrowserWindow + 生命周期 | 教程 02 |
| 预加载脚本 + contextBridge | 教程 03 |
| IPC invoke/handle (ping) | 教程 03 |
| 应用菜单 | 教程 04 |
| 文件打开/保存对话框 | 教程 04 |
| 窗口标题 IPC | 教程 04 |
| 系统通知 | 示例 - 通知 |
| 深色模式切换 | 示例 - 深色模式 |
| 在线状态检测 | 示例 - 在线/离线 |
| 系统托盘 | 示例 - 托盘 |
| 安全最佳实践 | 安全（CSP、沙盒、上下文隔离） |
