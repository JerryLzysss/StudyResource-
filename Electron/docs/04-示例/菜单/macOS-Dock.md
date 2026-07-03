# macOS Dock

> 官方文档：[Custom Dock Menu | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/macos-dock)

> 仅支持 macOS

自定义 macOS Dock 菜单和 Dock 图标行为。

```js
const dockMenu = Menu.buildFromTemplate([
  { label: '新建窗口', click: () => createWindow() }
])
app.dock.setMenu(dockMenu)
```
