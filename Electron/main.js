const {
  app,
  BrowserWindow,
  ipcMain,
  Menu,
  dialog,
  Notification,
  nativeTheme,
  Tray,
  nativeImage,
  shell
} = require('electron')
const path = require('node:path')

if (require('electron-squirrel-startup')) app.quit()

let mainWindow = null
let tray = null

const isDev = !app.isPackaged

function validateSender(event) {
  const win = BrowserWindow.fromWebContents(event.sender)
  return win === mainWindow
}

function createMenu() {
  const template = [
    {
      label: '文件',
      submenu: [
        {
          label: '打开文件',
          accelerator: 'CmdOrCtrl+O',
          click: () => mainWindow?.webContents.send('menu:open-file')
        },
        { type: 'separator' },
        { role: 'quit', label: '退出' }
      ]
    },
    {
      label: '编辑',
      submenu: [
        { role: 'undo', label: '撤销' },
        { role: 'redo', label: '重做' },
        { type: 'separator' },
        { role: 'cut', label: '剪切' },
        { role: 'copy', label: '复制' },
        { role: 'paste', label: '粘贴' },
        { role: 'selectAll', label: '全选' }
      ]
    },
    {
      label: '视图',
      submenu: [
        { role: 'reload', label: '重新加载' },
        { role: 'toggleDevTools', label: '开发者工具' },
        { type: 'separator' },
        { role: 'resetZoom', label: '重置缩放' },
        { role: 'zoomIn', label: '放大' },
        { role: 'zoomOut', label: '缩小' }
      ]
    },
    {
      label: '帮助',
      submenu: [
        {
          label: '关于',
          click: () => {
            dialog.showMessageBox(mainWindow, {
              type: 'info',
              title: '关于',
              message: 'Electron 学习示例',
              detail: `版本 ${app.getVersion()}\n基于 Electron 官方教程实现`
            })
          }
        }
      ]
    }
  ]

  Menu.setApplicationMenu(Menu.buildFromTemplate(template))
}

function createTrayIcon() {
  // 16x16 蓝色方块图标，避免依赖外部资源文件
  const size = 16
  const canvas = Buffer.alloc(size * size * 4)
  for (let i = 0; i < size * size; i++) {
    const offset = i * 4
    canvas[offset] = 9       // R
    canvas[offset + 1] = 132 // G
    canvas[offset + 2] = 227 // B
    canvas[offset + 3] = 255 // A
  }
  return nativeImage.createFromBuffer(canvas, { width: size, height: size })
}

function createTray() {
  tray = new Tray(createTrayIcon())
  tray.setToolTip('Electron 学习示例')
  tray.setContextMenu(
    Menu.buildFromTemplate([
      {
        label: '显示窗口',
        click: () => {
          mainWindow?.show()
          mainWindow?.focus()
        }
      },
      { type: 'separator' },
      { label: '退出', click: () => app.quit() }
    ])
  )
  tray.on('click', () => {
    mainWindow?.show()
    mainWindow?.focus()
  })
}

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 900,
    height: 700,
    minWidth: 600,
    minHeight: 500,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      nodeIntegration: false,
      contextIsolation: true,
      sandbox: true,
      webSecurity: true
    }
  })

  mainWindow.loadFile('index.html')

  if (isDev) {
    mainWindow.webContents.openDevTools({ mode: 'detach' })
  }

  mainWindow.on('closed', () => {
    mainWindow = null
  })
}

function registerIpcHandlers() {
  // 教程 03：进程通信 ping/pong
  ipcMain.handle('ping', (event) => {
    if (!validateSender(event)) return null
    return 'pong'
  })

  // 教程 04：打开文件对话框
  ipcMain.handle('dialog:openFile', async (event) => {
    if (!validateSender(event)) return null
    const { canceled, filePaths } = await dialog.showOpenDialog(mainWindow, {
      properties: ['openFile'],
      filters: [
        { name: '文本文件', extensions: ['txt', 'md'] },
        { name: '所有文件', extensions: ['*'] }
      ]
    })
    if (!canceled && filePaths.length > 0) {
      return filePaths[0]
    }
    return null
  })

  // 教程 04：保存文件对话框
  ipcMain.handle('dialog:saveFile', async (event) => {
    if (!validateSender(event)) return null
    const { canceled, filePath } = await dialog.showSaveDialog(mainWindow, {
      filters: [{ name: '文本文件', extensions: ['txt'] }]
    })
    return canceled ? null : filePath
  })

  // IPC：设置窗口标题
  ipcMain.on('set-title', (event, title) => {
    if (!validateSender(event)) return
    const win = BrowserWindow.fromWebContents(event.sender)
    win?.setTitle(title)
  })

  // 示例：系统通知
  ipcMain.handle('notification:show', (event, { title, body }) => {
    if (!validateSender(event)) return false
    if (!Notification.isSupported()) return false
    new Notification({ title, body }).show()
    return true
  })

  // 示例：深色模式
  ipcMain.handle('theme:get', (event) => {
    if (!validateSender(event)) return null
    return {
      shouldUseDarkColors: nativeTheme.shouldUseDarkColors,
      themeSource: nativeTheme.themeSource
    }
  })

  ipcMain.handle('theme:set', (event, source) => {
    if (!validateSender(event)) return false
    nativeTheme.themeSource = source
    return true
  })

  // 示例：获取平台信息
  ipcMain.handle('app:getInfo', (event) => {
    if (!validateSender(event)) return null
    return {
      platform: process.platform,
      version: app.getVersion(),
      name: app.getName()
    }
  })

  // 打开外部链接
  ipcMain.handle('shell:openExternal', (event, url) => {
    if (!validateSender(event)) return false
    if (typeof url === 'string' && url.startsWith('https://')) {
      shell.openExternal(url)
      return true
    }
    return false
  })
}

app.whenReady().then(() => {
  registerIpcHandlers()
  createMenu()
  createWindow()
  createTray()

  nativeTheme.on('updated', () => {
    mainWindow?.webContents.send('theme:changed', {
      shouldUseDarkColors: nativeTheme.shouldUseDarkColors,
      themeSource: nativeTheme.themeSource
    })
  })

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow()
    }
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})
