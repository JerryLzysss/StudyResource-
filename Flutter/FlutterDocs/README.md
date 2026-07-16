# FlutterDocs

学习文档与示例源码目录。仓库总说明、环境安装与真机调试见上级 [README.md](../README.md)。

## 主模块

| 模块 | 说明 |
|------|------|
| [用户界面](./用户界面/README.md) | Widget、布局、主题、交互、导航、动画等 |
| [界面以外的开发](./界面以外的开发/README.md) | 数据后端、架构、平台集成、测试、性能、部署 |
| [Dart 语言](./Dart语言/README.md) | 语言简介、类型、异步、模式匹配等笔记 |

## 子模块结构

每个子模块包含：

- `README.md` — [Flutter 中文文档](https://docs.flutter.cn/) 对应的 **Markdown 原文**
- `example.dart` — 对应主题的 Flutter 示例代码

## 运行示例 App

示例合集工程已移至仓库根目录的 [`../app/`](../app/)：

```bash
cd ../app
flutter pub get
flutter run
```
