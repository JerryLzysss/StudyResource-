[TOC]
# Electron 加载脚本
Electron 的主进程是一个拥有着完全操作系统访问权限的 Node.js 环境。 除了 Electron 模组 之外，您也可以访问 Node.js 内置模块 和所有通过 npm 安装的包。 另一方面，出于安全原因，渲染进程默认跑在网页页面上，而并非 Node.js里。

为了将 Electron 的不同类型的进程桥接在一起，我们需要使用被称为 预加载 的特殊脚本。


# 沙盒化
BrowserWindow 的预加载脚本运行在具有 HTML DOM 和 Node.js、Electron API 的有限子集访问权限的环境中。
::: info 预加载脚本沙盒化
从 Electron 20 开始，预加载脚本默认 沙盒化 ，不再拥有完整 Node.js 环境的访问权。 实际上，这意味着你只拥有一个 polyfilled 的 require 函数，这个函数只能访问一组有限的 API。
API|详细信息
---|---
Electron|渲染进程
Node.js|events,timers,url
polyfilled|Buffer,Process,clearImmediate,setImmediate

(具体查看https://nodejs.org/api/events.html)

# 脚本实现
与 Chrome 扩展的内容脚本（Content Script）类似，预加载脚本在渲染器加载网页之前注入。 如果你想为渲染器添加需要特殊权限的功能，可以通过 contextBridge 接口定义 全局对象。
新建一个 preload.js 文件。该脚本通过 versions 这一全局变量，将 Electron 的 process.versions 对象暴露给渲染器。
```
---preload.js---
const { contextBridge } = require('electron')
//contextBridge是electron里面的一个API,用来建立安全通信通道
contextBridge.exposeInMainWorld('versions', {
  node: () => process.versions.node,
  chrome: () => process.versions.chrome,
  electron: () => process.versions.electron
  // 除函数之外，我们也可以暴露变量
})

---main.js---
const { app, BrowserWindow } = require('electron')
const path = require('node:path')

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    //preload引入preload.js
    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  })

  win.loadFile('index.html')
}

app.whenReady().then(() => {
  createWindow()
})
```
Node.js函数
* __dirname 字符串指向当前正在执行的脚本的路径(在本例中，它指向你的项目的根文件夹)。
* path.join API 将多个路径联结在一起，创建一个跨平台的路径字符串。

现在渲染器能够全局访问 versions 了，让我们快快将里边的信息显示在窗口中。
 这个变量不仅可以通过 window.versions 访问，也可以很简单地使用 versions 来访问。
 ```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta
      http-equiv="Content-Security-Policy"
      content="default-src 'self'; script-src 'self'"
    />
    <meta
      http-equiv="X-Content-Security-Policy"
      content="default-src 'self'; script-src 'self'"
    />
    <title>来自 Electron 渲染器的问好！</title>
  </head>
  <body>
    <h1>来自 Electron 渲染器的问好！</h1>
    <p>👋</p>
    <p id="info"></p>
  </body>
  <script src="./renderer.js"></script>
</html>
 ```
 # 进程通信

我们之前提到，Electron 的主进程和渲染进程有着清楚的分工并且不可互换。 这代表着无论是从渲染进程直接访问 Node.js 接口，亦或者是从主进程访问 HTML 文档对象模型 (DOM)，都是不可能的。
解决这一问题的方法是使用进程间通信 (IPC)。可以使用 Electron 的 ipcMain 模块和 ipcRenderer 模块来进行进程间通信。 为了从你的网页向主进程发送消息，你可以使用 ipcMain.handle 设置一个主进程处理程序（handler），然后在预处理脚本中暴露一个被称为 ipcRenderer.invoke 的函数来触发该处理程序（handler）。

我们将向渲染器添加一个叫做 ping() 的全局函数来演示这一点。这个函数将返回一个从主进程翻山越岭而来的字符串。

首先，在预处理脚本中设置 invoke 调用：
```
---preload.js---
const { contextBridge, ipcRenderer } = require('electron')

contextBridge.exposeInMainWorld('versions', {
  node: () => process.versions.node,
  chrome: () => process.versions.chrome,
  electron: () => process.versions.electron,
  ping: () => ipcRenderer.invoke('ping')
  // 除函数之外，我们也可以暴露变量
})
```
可以注意到我们使用了一个辅助函数来包裹 ipcRenderer.invoke('ping') 调用，而并非直接通过 context bridge 暴露 ipcRenderer 模块。 你永远都不会想要通过预加载直接暴露整个 ipcRenderer 模块。 这将使得你的渲染器能够直接向主进程发送任意的 IPC 信息，会使得其成为恶意代码最强有力的攻击媒介。

然后，在主进程中设置你的 handle 监听器。 我们在 HTML 文件加载之前完成了这些，所以才能保证在你从渲染器发送 invoke 调用之前处理程序能够准备就绪。
```
---main.js---
const { app, BrowserWindow, ipcMain } = require('electron/main')
const path = require('node:path')

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  })
  win.loadFile('index.html')
}
app.whenReady().then(() => {
  ipcMain.handle('ping', () => 'pong')
  createWindow()
})
经过上述操作，可以获得到ping函数的返回值
const func = async () => {
  const response = await window.versions.ping()
  console.log(response) // 打印 'pong'
}
func()
```
