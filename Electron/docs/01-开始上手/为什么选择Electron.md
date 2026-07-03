[TOC]

# 为什么选择 Electron

> 官方文档：[Why Electron](https://www.electronjs.org/docs/latest/why-electron)

## 为什么选择 Web 技术

Web 技术（HTML、CSS、JavaScript、WebAssembly）是现代互联网的用户界面基础，也是构建用户界面的最佳选择之一。

### 通用性

现代 HTML 和 CSS 让开发者和设计师能够充分表达创意。Google Earth、Netflix、Spotify、Gmail 等知名应用都基于 Web 技术构建。

### 可靠性

Web 技术是地球上使用最广泛的用户界面基础，已经过充分验证和优化。设备制造商会确保浏览器能正常运行，这也意味着你的应用有稳定的基础。

### 互操作性

无论你需要与哪个服务集成，对方很可能已经提供了 Web 集成方案。使用 Web 技术，你的应用几乎可以在任何有显示屏的设备上运行。

### 普及性

拥有 Web 技术经验的开发者很容易找到，遇到问题也更容易在网上找到解决方案。

## 为什么选择 Electron

Electron 将 Chromium、Node.js 和自定义原生代码的能力组合到一个框架中，用于构建强大的桌面应用程序。

### 企业级

Electron 可靠、安全、稳定且成熟。Slack、Discord、Signal、VS Code、Notion、Docker 等知名应用都基于 Electron 构建。

### 成熟

Electron 由 Microsoft、Slack/Salesforce、Notion 等多家公司共同维护，隶属于 OpenJS 基金会。提供可靠的发布节奏，与 Chromium 大版本同步更新。

### 稳定性、安全性、性能

Electron 将最新版本的 Chromium、V8 和 Node.js 直接与应用二进制文件捆绑在一起，在稳定性、安全性和性能方面提供最佳体验。

**为什么捆绑 Chromium 和 Node.js？**

- **稳定性**：不依赖操作系统内置的 WebView 版本，避免旧系统上的兼容问题
- **安全性**：可以通过应用更新推送安全修复，无需用户升级操作系统
- **性能**：对于大型应用，捆绑最新 Chromium 通常比系统 WebView 性能更好

### 开发者体验

- **强大的生态**：npm 上的任何包都可以在 Electron 中运行
- **丰富的内置能力**：窗口定制、推送通知、自定义 URL 协议等
- **开源**：整个技术栈开源，可自由扩展和修复
- **原生代码**：通过 Node.js 原生插件，可以调用任何系统 API

## 什么时候选择其他方案

| 场景 | 建议 |
|------|------|
| 资源受限的 IoT 设备 | 使用低级语言直接操作显示 |
| 磁盘空间要求极小 | Electron 应用通常 80-100MB+ |
| 主要使用系统原生 UI 组件 | 考虑 WinUI、SwiftUI、AppKit |
| 高性能 3D 游戏 | Unity、Unreal Engine 等 |
| 原生应用中嵌入少量网页 | 使用系统 WebView |
