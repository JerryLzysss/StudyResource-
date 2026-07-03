# 语言服务 (Language Service)

Angular 语言服务为你在喜爱的编辑器中提供代码补全、导航、重构和实时诊断功能。

## 支持的语言服务协议编辑器

- Visual Studio Code
- WebStorm / IntelliJ IDEA
- Vim / Neovim (通过 coc.nvim 等)
- Sublime Text

## Visual Studio Code 设置

安装官方扩展：

**Angular Language Service** (`Angular.ng-template`)

该扩展提供：

- 模板中的智能代码补全
- 组件、指令、管道的 Go to Definition
- 模板类型检查和错误诊断
- 内联提示和文档
- 重构支持（重命名符号等）

## 主要功能

### 代码补全

在 TypeScript 和 HTML 模板中提供上下文感知的自动补全：

- 组件选择器
- 输入/输出属性
- 管道名称
- 指令属性

### 实时诊断

在编辑时检测常见错误：

- 模板类型不匹配
- 未知组件或指令
- 缺少必需的输入
- 语法错误

### 导航

- 从模板跳转到组件定义
- 从组件跳转到模板
- 查找所有引用

### 重构

- 安全重命名组件、指令、服务
- 自动更新所有引用

## 配置

在 `tsconfig.json` 中确保包含 Angular 编译器选项：

```json
{
  "angularCompilerOptions": {
    "strictTemplates": true
  }
}
```

启用 `strictTemplates` 可获得更严格的模板类型检查。

---

> 参考：[Angular 语言服务文档](https://angular.cn/tools/language-service)
