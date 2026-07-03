const api = window.electronAPI

function $(id) {
  return document.getElementById(id)
}

function initVersions() {
  const { node, chrome, electron } = api.versions
  $('version-info').textContent =
    `Chrome v${chrome()} · Node.js v${node()} · Electron v${electron()}`
}

async function initPing() {
  $('btn-ping').addEventListener('click', async () => {
    const response = await api.ping()
    $('ping-result').textContent = `收到回复：${response}`
    $('ping-result').classList.add('success')
  })
}

async function initFileDialog() {
  $('btn-open-file').addEventListener('click', async () => {
    const filePath = await api.openFile()
    $('file-result').textContent = filePath
      ? `已选择：${filePath}`
      : '未选择文件'
  })

  $('btn-save-file').addEventListener('click', async () => {
    const filePath = await api.saveFile()
    $('file-result').textContent = filePath
      ? `保存路径：${filePath}`
      : '取消保存'
  })

  api.onMenuOpenFile(async () => {
    const filePath = await api.openFile()
    if (filePath) {
      $('file-result').textContent = `菜单打开：${filePath}`
    }
  })
}

function initTitle() {
  $('btn-set-title').addEventListener('click', () => {
    const title = $('title-input').value.trim()
    if (title) {
      api.setTitle(title)
    }
  })
}

async function initNotification() {
  $('btn-notification').addEventListener('click', async () => {
    const ok = await api.showNotification('Electron 通知', '这是一条来自主进程的系统通知！')
    $('notification-result').textContent = ok
      ? '通知已发送'
      : '当前系统不支持通知'
  })
}

function applyThemeToDOM(shouldUseDarkColors) {
  document.documentElement.dataset.theme = shouldUseDarkColors ? 'dark' : 'light'
}

function updateThemeDisplay(data) {
  const mode = data.shouldUseDarkColors ? '深色' : '浅色'
  const source = { system: '跟随系统', light: '浅色', dark: '深色' }
  $('theme-result').textContent =
    `当前主题：${mode}（来源：${source[data.themeSource] || data.themeSource}）`
  applyThemeToDOM(data.shouldUseDarkColors)
}

async function initTheme() {
  const theme = await api.getTheme()
  updateThemeDisplay(theme)

  document.querySelectorAll('[data-theme]').forEach((btn) => {
    btn.addEventListener('click', async () => {
      await api.setTheme(btn.dataset.theme)
    })
  })

  api.onThemeChanged(updateThemeDisplay)
}

function initStatus() {
  function updateOnlineStatus() {
    $('online-status').textContent = `网络：${navigator.onLine ? '在线' : '离线'}`
  }

  window.addEventListener('online', updateOnlineStatus)
  window.addEventListener('offline', updateOnlineStatus)
  updateOnlineStatus()

  api.getAppInfo().then((info) => {
    const platformMap = { win32: 'Windows', darwin: 'macOS', linux: 'Linux' }
    $('platform-info').textContent =
      `平台：${platformMap[info.platform] || info.platform} · 应用 v${info.version}`
  })
}

function initDocLink() {
  $('doc-link').addEventListener('click', (e) => {
    e.preventDefault()
    api.openExternal('https://www.electronjs.org/zh/docs/latest/')
  })
}

document.addEventListener('DOMContentLoaded', () => {
  initVersions()
  initPing()
  initFileDialog()
  initTitle()
  initNotification()
  initTheme()
  initStatus()
  initDocLink()
})
