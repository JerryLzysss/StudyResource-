[TOC]

# Electron Forge 概述

> 官方文档：[使用 Electron Forge 分发应用程序 | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/forge-overview)
> Forge 文档：[Electron Forge](https://www.electronforge.io/)

## 概述

Electron Forge 是一个用于打包和发布 Electron 应用程序的工具。它将 Electron 的构建工具生态系统统一到一个可扩展的界面中。

## 替代工具

| 工具 | 说明 |
|------|------|
| [Electron Builder](https://www.electron.build/) | 完备的打包和分发解决方案 |
| [Hydraulic Conveyor](https://hydraulic.dev/) | 跨平台构建/签名，支持同步 Web 风格更新 |

## Forge 工作流程

1. **打包 (package)**：将应用代码与 Electron 二进制包结合
2. **生成 (make)**：为每个操作系统生成可执行文件和安装程序
3. **发布 (publish)**：将文件发布到在线平台供用户下载

## 入门

对于初学者，建议跟随 [官方教程](../01-开始上手/教程/05-打包程序.md) 完成开发、构建、打包和发布。

如果已经开发了应用，想直接开始打包和分发，从教程第 5 步开始。

## 寻求帮助

- [Discord 中文社区](https://discord.gg/electronjs)
- [Forge GitHub Issues](https://github.com/electron/forge/issues)

更多高级分发内容请参阅 [高级参考](./高级参考/分发概述.md)。
