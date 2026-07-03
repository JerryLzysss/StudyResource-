# Windows 任务栏

> 官方文档：[Custom Windows Taskbar | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/windows-taskbar)

> 仅支持 Windows

自定义 Windows 任务栏按钮，如跳转列表、缩略图工具栏等。

```js
app.setUserTasks([
  {
    program: process.execPath,
    arguments: '--new-window',
    title: '新建窗口',
    description: '创建一个新窗口'
  }
])
```
