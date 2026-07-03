# 从其他应用 URL 启动

> 官方文档：[Launch App from URL | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/launch-app-from-url-in-another-app)

注册自定义 URL 协议，使其他应用可以通过 URL 启动你的 Electron 应用。

```js
// macOS
app.setAsDefaultProtocolClient('myapp')

// Windows（需要在安装时注册）
if (process.defaultApp) {
  if (process.argv.length >= 2) {
    app.setAsDefaultProtocolClient('myapp', process.execPath, [path.resolve(process.argv[1])])
  }
} else {
  app.setAsDefaultProtocolClient('myapp')
}
```
