[TOC]

# MessagePorts

> 官方文档：[MessagePorts | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/message-ports)

## 概述

`MessagePort` 是 HTML 标准的一部分，允许在不同上下文之间建立直接的通信通道。在 Electron 中，MessagePort 可用于：

- 主进程与渲染器进程之间的通信
- 渲染器进程之间的通信
- 实用进程与渲染器进程之间的通信

## 基本用法

### 主进程创建 MessageChannel

```js
const { MessageChannelMain } = require('electron')

const { port1, port2 } = new MessageChannelMain()
win.webContents.postMessage('port', null, [port1])

port2.on('message', (event) => {
  console.log('from renderer:', event.data)
})
port2.start()
```

### 渲染器接收 MessagePort

```js
// 预加载脚本
const { contextBridge, ipcRenderer } = require('electron')

contextBridge.exposeInMainWorld('api', {
  onPort: (callback) => {
    ipcRenderer.on('port', (event) => {
      callback(event.ports[0])
    })
  }
})
```

## 与 IPC 的区别

| 特性 | IPC | MessagePort |
|------|-----|-------------|
| 通信方式 | 请求/响应 | 双向消息流 |
| 性能 | 适合低频调用 | 适合高频数据传输 |
| 使用场景 | API 调用 | 实时数据流、Worker 通信 |

## 实用进程通信

实用进程（UtilityProcess）可以使用 MessagePort 与渲染器进程建立通信通道，这是其与 `child_process.fork` 的主要区别。
