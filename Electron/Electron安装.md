[TOC]
# Electron 安装
1.前置安装: node.js和npm
2.前置知识: html,css,js,node.js
注意：避免使用 WSL
如果您使用的是Windows系统，在本教程中请不要使用 Windows Subsystem for Linux (WSL)，否则您在尝试运行应用时可能会遇到问题
# 安装过程
1. npm init
2. npm install electron
如果安装失败那么可以尝试使用其他的安装方式[安装指导](https://www.electronjs.org/zh/docs/latest/tutorial/installation)
# 安装指导
1.运行Electron ad-hoc
```npx elecrton .```
通过这个方式将会在当前目录下运行Electron,但是应用的依赖不会被安装.
2. 代理挂载
需要设置环境变量`ELECTRON_GET_USE_PROXY`为任何值,其中需要就node版本进行区分
(Node10以上)[https://github.com/gajus/global-agent/blob/v2.1.5/README.md#environment-variables]
(Node10之前)[https://github.com/np-maintain/global-tunnel/blob/v2.7.1/README.md#auto-config]
3.自定义镜像和缓存
在安装过程中，electron 模块会通过 electron-download 为您的平台下载 Electron 的预编译二进制文件。 这将通过访问 GitHub 的发布下载页面来完成 (https://github.com/electron/electron/releases/tag/v$VERSION, 这里的 $VERSION 是 Electron 的确切版本).
3.1镜像
ELECTRON_MIRROR="https://npmmirror.com/mirrors/electron/"
默认情况下，ELECTRON_CUSTTOM_DIR被设置为 v$VERSION。 要更改格式，请使用 {{ version }} 占位符。 例如，version-{{ version }} 被解析为 version-5.0.0, {{ version }} 被解析为 5.0.0， v{{ version }} 与默认值等价。 更具体的例子，使用中国非CDN镜像：
ELECTRON_MIRROR="https://npmmirror.com/mirrors/electron/"
ELECTRON_CUSTOM_DIR="{{ version }}"
上述配置将从类似于 https://npmmirror.com/mirrors/electron/8.0.0/electron-v8.0.0-linux-x64.zip 这样的网址下载。
3.2缓存
缓存
或者，您可以覆盖本地缓存。 electron-download 会将下载的二进制文件缓存在本地目录中，不会增加网络负担。 您可以使用该缓存文件夹来提供 Electron 的定制版本，或者避免进行网络连接。
Linux: $XDG_CACHE_HOME or ~/.cache/electron/
macOS: ~/Library/Caches/electron/
Windows: $LOCALAPPDATA/electron/Cache or ~/AppData/Local/electron/Cache/
在使用旧版本 Electron 的环境中，您也可以在~/.electron中找到缓存。
4.跳过二进制包
在底层, Electron 的 JavaScript API 绑定了包含默认实现的二进制文件。 由于此二进制文件对于任何 Electron 应用的功能都至关重要，因此每次当你从 npm 注册表安装 electron 时，默认情况下都会在 postinstall 步骤中下载该二进制文件。
但是，如果你想要安装你的项目依赖，但不需要使用 Electron 功能。 你可以设置 ELECTRON_SKIP_BINARY_DOWNLOAD 环境变量来阻止二进制文件被下载。 例如，在运行模拟 electron 模块的单元测试时，此功能在连续集成环境中很有用。
5.故障排查
在运行 npm install electron 时，有些用户会偶尔遇到安装问题。
在大多数情况下，这些错误都是由网络问题导致，而不是因为 electron npm 包的问题。 如 ELIFECYCLE、EAI_AGAIN、ECONNRESET 和 ETIMEDOUT 等错误都是此类网络问题的标志。 最佳的解决方法是尝试切换网络，或是稍后再尝试安装。
如果通过 npm 安装失败，你也可以尝试通过从 electron/electron/release 直接下载 Electron
如果安装失败并报错EACCESS，您可能需要修复npm权限。
如果上述报错持续出现，unsafe-perm 标志可能需要被设置为 true:
`sudo npm install electron --unsafe-perm=true`
在较慢的网络上, 最好使用 --verbose 标志来显示下载进度:
`npm install --verbose electron`
如果需要强制重新下载文件, 并且 SHASUM 文件将 force_no_cache 环境变量设置为 true。

