# VS Code 调试

> 官方文档：[Debugging with VS Code | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/debugging-vscode)

## launch.json 配置

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Main Process",
      "type": "node",
      "request": "launch",
      "cwd": "${workspaceFolder}",
      "runtimeExecutable": "${workspaceFolder}/node_modules/.bin/electron",
      "windows": {
        "runtimeExecutable": "${workspaceFolder}/node_modules/.bin/electron.cmd"
      },
      "args": ["."],
      "outputCapture": "std"
    },
    {
      "name": "Debug Renderer Process",
      "type": "chrome",
      "request": "attach",
      "port": 9222,
      "webRoot": "${workspaceFolder}"
    }
  ]
}
```

## 调试渲染器

在 `webPreferences` 中启用 `devTools`，或使用 `win.webContents.openDevTools()`。
