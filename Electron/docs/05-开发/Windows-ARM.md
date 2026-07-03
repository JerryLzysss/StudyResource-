# Windows ARM

> 官方文档：[Windows ARM | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/windows-arm)

Electron 支持在 Windows ARM64 设备上运行。打包时需要指定目标架构：

```sh
npm install --arch=arm64 electron
```

或使用 Forge / electron-builder 配置 ARM64 构建目标。
