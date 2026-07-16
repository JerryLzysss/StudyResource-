# app（原 demo_app）

Flutter 中文文档示集合集 — 通过路由统合 **203** 个主题（含 Dart 语言笔记）的示例与 Markdown 原文。

文档源码位于 [`../FlutterDocs/`](../FlutterDocs/)。仓库总说明见 [`../README.md`](../README.md)。

## 运行

### Web（国内网络 / 离线环境）

默认 Flutter Web 会从 `gstatic.com` 加载 CanvasKit，容易 `ERR_CONNECTION_TIMED_OUT`。
请使用**本地 CanvasKit** 方式运行：

```bash
# 开发
flutter run -d chrome --no-web-resources-cdn --pwa-strategy=none

# 或直接双击
run_web.bat
```

```bash
# 构建可离线部署的包（canvaskit 已打包在 build/web 内）
flutter build web --no-web-resources-cdn --release --pwa-strategy=none
# 或 build_web.bat
```

项目已配置 `web/flutter_bootstrap.js`，强制 `canvasKitBaseUrl: 'canvaskit/'`，不访问 Google CDN。

**Roboto 字体**：已打包在 `assets/fonts/`，pubspec 族名为 `AppRoboto`（避免与 Google Fonts 的 `Roboto` 同名触发联网下载）。

**中文字体**：本地 `NotoSansSC-*.ttf`，pubspec 族名为 `AppNotoSansSC`（勿使用 `Noto Sans SC` 作为族名，否则 Flutter Web 仍会访问 `fonts.gstatic.com`）。

```bash
flutter clean
flutter pub get
```

然后重新运行 `run_web.bat`（需完全重启，不要仅热重载）。

### 桌面 / 移动端（推荐，无 CDN 问题）

```bash
flutter run -d windows
flutter run -d android
```

## 导航结构

```
/  →  主模块列表
/section/:sectionId  →  子模块列表
/section/:sectionId/module/:moduleId  →  主题列表
/demo/:demoId  →  示例 + 官方文档（Tab）
```

## 依赖

- `go_router` — 路由
- `flutter_markdown` — 应用内渲染官方文档
