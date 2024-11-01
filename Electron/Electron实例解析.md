<!--
 * @Description: 
-->
# Electron 实例解析
```
---main.js---
// app 应用程序的事件生命周期
// BrowserWindow 创建和管理应用窗口
const { app, BrowserWindow } = require('electron')
/*
    命名规范
    BrowserWindow,Tray,Notification 诸如此类帕斯卡命名法命名为可实例化类
    app,ipcRenderer,webContents 诸如此类驼峰命名法命名为不可实例化类
 */


const createWindow = () => {
  //该函数将页面加载到BrowserWindow实例中.
  const win = new BrowserWindow({
    width: 800,
    height: 600
  })
  win.loadFile('index.html')
}
//应用准备就绪时调用函数
//在Electron中，只有在app模块的ready事件触发后才能创建BrowserWindows实例，
//可以通过app.whenReady()来对事件进行监听，并在成功后调用createWindow()
app.whenReady().then(() => {
  createWindow()
})
/*
app.on('ready',()=>{}) 表示监听Node.js事件但是 Electron 暴露了 app.whenReady() 方法
作为其 ready 事件的专用监听器，这样可以避免直接监听 .on 事件带来的一些问题。
 */

您应用中的每个页面都在一个单独的进程中运行，我们称这些进程为 渲染器 (renderer) 。
 渲染进程使用与常规Web开发相同的JavaScript API和工具，
 例如使用 webpack来打包和压缩您的代码，或使用 React 构建用户界面。
---
```
```
应用窗口在不同操作系统中的行为也不同。 Electron 允许您自行实现这些行为来遵循操作系统的规范，而不是采用默认的强制执行。
您可以通过监听 app 和 BrowserWindow 模组的事件，自行实现基础的应用窗口规范。

通过检查 Node.js 的 process.platform 变量，您可以针对特定平台运行特定代码。 
请注意，Electron 目前只支持三个平台：win32 (Windows), linux (Linux) 和 darwin (macOS) 。

在 Windows 和 Linux 上，我们通常希望在关闭一个应用的所有窗口后让它退出。 要在您的Electron应用中实现这一点，您可以监听 app 模块的 window-all-closed 事件，并调用 app.quit() 来退出您的应用程序。此方法不适用于 macOS。

app.on('window-all-closed', () => {
  //获取当前进程的操作系统:macos/windows/linux
  if (process.platform !== 'darwin') app.quit()
})

与前二者相比，即使没有打开任何窗口，macOS 应用通常也会继续运行。 在没有窗口可用时调用 app 会打开一个新窗口。
为了实现这一特性，可以监听模组的 activate 事件，如果没有任何活动的 BrowserWindow，调用 createWindow() 方法新建一个。
因为窗口无法在 ready 事件前创建，你应当在你的应用初始化后仅监听 activate 事件。 要实现这个，仅监听 whenReady() 回调即可。

app.whenReady().then(() => {
  createWindow()

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})
```