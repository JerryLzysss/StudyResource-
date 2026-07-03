# Angular DevTools

Angular DevTools 是一个浏览器扩展，与你的浏览器开发者工具并排就坐，帮助调试、分析和优化 Angular 应用。

## 安装

- [Chrome 网上应用店](https://chrome.google.com/webstore/detail/angular-devtools/ienfalfjdbdpebioblfackkekamfmbnh)
- [Firefox 附加组件](https://addons.mozilla.org/firefox/addon/angular-devtools/)

## 主要功能

### 组件树检查器

- 可视化浏览组件层次结构
- 检查组件的输入、输出和状态
- 查看组件的变更检测策略

### 依赖注入树

- 查看应用的注入器层级
- 检查已注册的服务和提供者
- 调试 DI 配置问题

### 性能分析

- 自定义性能分析火焰图
- 识别变更检测性能瓶颈
- 分析组件渲染时间

### 路由检查

- 查看当前路由状态
- 检查路由参数和查询字符串
- 调试路由守卫

## 使用 DevTools

1. 安装浏览器扩展
2. 打开 Angular 应用（开发模式）
3. 打开浏览器开发者工具
4. 切换到 **Angular** 标签页

## 调试技巧

- 使用组件检查器查看 Signal 值
- 通过 DI 树确认服务是否正确注入
- 利用性能分析器优化 OnPush 组件
- 检查是否有不必要的变更检测周期

## 要求

- Angular 12+ 应用
- 开发模式构建（生产构建中 DevTools 功能受限）

---

> 参考：[Angular DevTools 文档](https://angular.cn/tools/devtools)
