# Flutter

> 基于 [Flutter 中文文档](https://docs.flutter.cn/) 整理的学习仓库：环境说明、文档模块与可运行示例 App。

## Flutter 简介

Flutter 是一个由 Google 开发的跨平台应用开发框架，主要用于开发移动应用、Web 应用和桌面应用。

## 核心特点

- 跨平台：一套代码可以同时运行在多个平台上
- 高性能：使用 Dart 语言编译成原生代码
- 热重载：快速预览修改效果
- 丰富的 UI 组件：提供大量现成的 UI 组件
- 响应式编程：支持声明式 UI 编程

## 仓库结构

| 路径 | 说明 |
|------|------|
| [`app/`](./app/) | 示例合集 Flutter 工程（路由浏览文档与示例） |
| [`FlutterDocs/`](./FlutterDocs/) | 用户界面 / 界面以外的开发 / Dart 语言 文档与 `example.dart` |

## 环境准备

在运行示例 App 之前，请先完成 Flutter SDK 安装与环境校验。

### 国内镜像（推荐）

国内网络访问 Google 资源较慢，建议配置 Flutter 中国社区镜像。详见 [在中国网络环境下使用 Flutter](https://docs.flutter.cn/community/china/)。

**Windows（PowerShell，当前用户）：**

```powershell
[System.Environment]::SetEnvironmentVariable('PUB_HOSTED_URL', 'https://pub.flutter-io.cn', 'User')
[System.Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL', 'https://storage.flutter-io.cn', 'User')
```

**Windows（命令提示符，当前会话）：**

```cmd
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

配置完成后请**重新打开终端**，使环境变量生效。

### 安装 Flutter SDK

1. 从 [Flutter 官网](https://docs.flutter.cn/get-started/install) 下载并解压 SDK。
2. 将 `<Flutter 安装目录>/bin` 加入系统环境变量 `Path`。
3. 新开终端，执行 `flutter doctor` 检查依赖是否就绪。

期望输出中各项均为 `[√]`，例如：

```
[√] Flutter (Channel stable, 3.27.0, ...)
[√] Windows Version (Installed version of Windows is version 10 or higher)
[√] Android toolchain - develop for Android devices
[√] Chrome - develop for the web
[√] Visual Studio - develop Windows apps
[√] Android Studio
[√] Connected device
[√] Network resources
```

若某项为 `[!]` 或 `[×]`，按 `flutter doctor` 提示安装对应组件（Android SDK、Chrome、Visual Studio 等）后再次校验。

## 编辑器配置

### Android Studio

1. 启动 Android Studio。
2. 打开 **File → Settings → Plugins**（macOS 为 **Android Studio → Settings → Plugins**）。
3. 在 Marketplace 中搜索并安装 **Flutter** 与 **Dart**（安装 Flutter 时会自动提示安装 Dart）。
4. 重启 IDE 使插件生效。

创建或打开项目：**File → Open** 选择本仓库的 `app` 目录。

### VS Code

1. 启动 VS Code。
2. 打开 **View → Command Palette**（快捷键 `Ctrl+Shift+P`）。
3. 输入 `Extensions: Install Extensions`，搜索 **Flutter** 并安装（会自动安装 Dart 扩展）。
4. 安装完成后，在终端中确认 `flutter` 命令可用，即可打开 `app` 文件夹进行开发。

## Android 真机调试

本机需已通过 `flutter doctor` 校验 **Android toolchain**。Windows 下可调试 Android 真机；iOS 真机需 macOS + Xcode。

### 手机准备

1. 打开 **设置 → 关于手机**，连续点击「版本号」约 7 次，开启开发者模式。
2. 进入 **设置 → 系统 → 开发者选项**（路径因品牌略有不同）。
3. 打开 **USB 调试**；可选打开 **USB 安装** / **通过 USB 验证应用**。
4. 用数据线连接电脑；手机弹出「允许 USB 调试」时点 **允许**（可勾选始终允许）。

> 部分品牌（小米 / 华为 / OPPO 等）还需打开「USB 调试（安全设置）」，或将 USB 模式改为 **文件传输 (MTP)**，不要停在「仅充电」。

### 确认设备已识别

```powershell
adb devices
flutter devices
```

`adb devices` 应显示 `device`（不是 `unauthorized` 或空白）。`flutter devices` 中应出现你的机型。

| 现象 | 处理 |
|------|------|
| `unauthorized` | 手机上重新点允许；或撤销 USB 调试授权后再插线 |
| 列表为空 | 换线 / 换口；安装手机厂商 USB 驱动；在设备管理器检查是否有感叹号 |
| 小米等 | 尝试关闭「MIUI 优化」，并开启「USB 调试（安全设置）」 |

### USB 有线运行

```powershell
cd app
flutter pub get
flutter run -d android
```

或先查看设备 id，再指定运行：

```powershell
flutter devices
flutter run -d <设备id>
```

也可在 Android Studio 顶部设备列表中选择真机后点 Run。

### 无线调试：`adb pair` + `adb connect`（Android 11+）

手机与电脑须在**同一 Wi‑Fi**。

1. 手机：**开发者选项 → 无线调试** → 打开开关。
2. 点 **使用配对码配对设备**，记下 **IP:配对端口** 与 **配对码**。
3. 电脑执行配对（端口以手机界面为准，例如 `37333`）：

```powershell
adb pair <手机IP>:<配对端口>
# 按提示输入配对码，成功会提示 Successfully paired
```

4. 回到「无线调试」主界面，记下 **IP:连接端口**（与配对端口通常不同，例如 `5555` 或 `41234`），再连接：

```powershell
adb connect <手机IP>:<连接端口>
adb devices
flutter devices
```

5. 确认设备状态为 `device` 后运行：

```powershell
cd app
flutter run -d android
```

**备选（先 USB 再切无线）：** 部分机型也可先 USB 授权一次，再：

```powershell
adb tcpip 5555
adb connect <手机IP>:5555
```

| 现象 | 处理 |
|------|------|
| pair 失败 | 确认配对码未过期；手机与电脑同一局域网；关闭VPN/访客网络隔离 |
| connect 失败 | 确认用的是「连接端口」而非「配对端口」；重新打开无线调试后再试 |
| 断线后找不到设备 | 重新 `adb connect`；必要时重新 `adb pair` |

## 文档主模块

文档与示例源码位于 [`FlutterDocs/`](./FlutterDocs/)：

| 模块 | 说明 |
|------|------|
| [用户界面](./FlutterDocs/用户界面/README.md) | Widget、布局、主题、交互、导航、动画等 |
| [界面以外的开发](./FlutterDocs/界面以外的开发/README.md) | 数据后端、架构、平台集成、测试、性能、部署 |
| [Dart 语言](./FlutterDocs/Dart语言/README.md) | 语言简介、类型、异步、模式匹配等笔记 |

### 子模块结构

每个子模块包含：

- `README.md` — [Flutter 中文文档](https://docs.flutter.cn/) 对应的 **Markdown 原文**
- `example.dart` — 对应主题的 Flutter 示例代码

## 示例合集 App（路由统合）

目录：[`app/`](./app/)

```bash
cd app
flutter pub get
flutter run
```

功能：

- **首页** → 三大主模块（用户界面 / 界面以外的开发 / Dart 语言）
- **二级** → 11 + 8 + 10 个子模块
- **三级** → 203 个主题条目
- **详情页** → Tab 切换「示例运行」与「官方文档 Markdown」

路由使用 `go_router`，示例与文档内容已预置在项目中。更多细节见 [`app/README.md`](./app/README.md)。

### Web 运行（国内网络 / 离线）

默认 Flutter Web 可能从 Google CDN 拉取 **CanvasKit** 与字体，国内环境常见 `Failed to fetch` / 超时。请使用本地资源方式：

```bash
cd app
flutter run -d chrome --no-web-resources-cdn --pwa-strategy=none
```

或双击 [`app/run_web.bat`](./app/run_web.bat)。离线构建：

```bash
cd app
flutter build web --no-web-resources-cdn --release --pwa-strategy=none
# 或 build_web.bat
```

项目已配置 `app/web/flutter_bootstrap.js`，强制使用本地 `canvaskit/`，不访问 Google CDN。

### 本地字体（避免 fonts.gstatic.com）

中文与西文字体均已打包在 [`app/assets/fonts/`](./app/assets/fonts/)，并在 `app/pubspec.yaml` 中声明。**不要**把族名写成 Google Fonts 的官方名称（如 `Noto Sans SC`、`Roboto`），否则 Flutter Web 仍会按该名字去 `fonts.gstatic.com` 下载子集，出现类似：

```text
Failed to load font Noto Sans SC ... at https://fonts.gstatic.com/...
TypeError: Failed to fetch
```

本仓库使用的本地族名：

| 资源文件 | pubspec 族名 | 用途 |
|----------|--------------|------|
| `NotoSansSC-*.ttf` | `AppNotoSansSC` | 中文主字体 |
| `Roboto-*.ttf` | `AppRoboto` | 西文 / 代码回退 |

主题与文档排版在 `app/lib/main.dart`、`doc_typography.dart` 中统一引用上述族名；fallback 仅使用系统 Emoji 字体，不再包含会联网的 `Noto Color Emoji`。

修改字体配置后请 **完全重启** Web 进程（不要只热重载）：

```bash
cd app
flutter clean
flutter pub get
flutter run -d chrome --no-web-resources-cdn --pwa-strategy=none
```

## Git 忽略（不影响 App 运行）

以下内容已写入 [`.gitignore`](./.gitignore) 与 [`app/.gitignore`](./app/.gitignore)。它们**不参与**业务源码，删除或忽略后只要重新 `flutter pub get` / 编译即可恢复；**不会**导致示例功能缺失。

| 类别 | 典型路径 | 说明 |
|------|----------|------|
| 构建产物 | `app/build/` | `flutter build` / `flutter run` 输出，体积大 |
| Dart 工具缓存 | `app/.dart_tool/` | 分析器、包解析缓存 |
| 插件锁临时文件 | `.flutter-plugins`、`.flutter-plugins-dependencies` | `pub get` 自动再生 |
| IDE 配置 | `.idea/`、`*.iml`、`.vscode/` | 本机编辑器状态 |
| 平台 ephemeral | `**/ephemeral/`、`ios/Flutter/.last_build_id` | 桌面/iOS 工具生成 |
| Android 本机 | `android/local.properties`、`android/.gradle/`、`.cxx/` | SDK 路径与 Gradle 缓存 |
| 密钥相关 | `key.properties`、`*.jks`、`*.keystore` | 切勿提交 |
| 日志 / 系统垃圾 | `*.log`、`.DS_Store`、`.history/` | |
| 一次性脚本 | `app/_check_docs.py`、`PLEASE_DELETE.txt` | 维护用，不参与编译运行 |
| 本地 Flutter SDK 拷贝 | `SDK/` | 请用官方安装方式，勿提交 |

**需要纳入版本库（运行必需）的示例：**

- `app/lib/`、`app/assets/`（含字体与文档 Markdown）、`app/pubspec.yaml`、`app/web/`
- 各平台工程目录中的源码与配置（`android/`、`ios/`、`windows/` 等，不含上面忽略项）
- `FlutterDocs/` 文档与 `example.dart`
- `app/run_web.bat`、`app/build_web.bat`、`app/tool/`（维护脚本，可选但建议保留）

克隆仓库后首次运行：

```bash
cd app
flutter pub get
flutter run
# Web：
# flutter run -d chrome --no-web-resources-cdn --pwa-strategy=none
```
