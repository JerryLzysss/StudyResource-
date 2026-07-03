const { contextBridge, ipcRenderer } = require('electron')

contextBridge.exposeInMainWorld('electronAPI', {
  // 教程 03：版本信息
  versions: {
    node: () => process.versions.node,
    chrome: () => process.versions.chrome,
    electron: () => process.versions.electron
  },

  // 教程 03：IPC invoke
  ping: () => ipcRenderer.invoke('ping'),

  // 教程 04：文件对话框
  openFile: () => ipcRenderer.invoke('dialog:openFile'),
  saveFile: () => ipcRenderer.invoke('dialog:saveFile'),

  // IPC：设置窗口标题
  setTitle: (title) => ipcRenderer.send('set-title', title),

  // 示例：系统通知
  showNotification: (title, body) =>
    ipcRenderer.invoke('notification:show', { title, body }),

  // 示例：深色模式
  getTheme: () => ipcRenderer.invoke('theme:get'),
  setTheme: (source) => ipcRenderer.invoke('theme:set', source),
  onThemeChanged: (callback) => {
    const handler = (_event, data) => callback(data)
    ipcRenderer.on('theme:changed', handler)
    return () => ipcRenderer.removeListener('theme:changed', handler)
  },

  // 示例：应用信息
  getAppInfo: () => ipcRenderer.invoke('app:getInfo'),

  // 打开外部链接
  openExternal: (url) => ipcRenderer.invoke('shell:openExternal', url),

  // 菜单事件
  onMenuOpenFile: (callback) => {
    const handler = () => callback()
    ipcRenderer.on('menu:open-file', handler)
    return () => ipcRenderer.removeListener('menu:open-file', handler)
  }
})
