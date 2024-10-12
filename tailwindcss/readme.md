[TOC]

参考文档:1.https://juejin.cn/column/7362805232647487514 2.https://www.w3cschool.cn/tailwind_css/

# TailwindCSS 介绍

本 CSS 框架本质上是一个工具集，包含了大量类似 flex、 pt-4、 text-center 以及 rotate-90 等工具类，可以组合使用并直接在 HTML 代码上实现任何 UI 设计。
总的来说就是不需要写入 CSS 而是在 html 中以类名的形式引入 CSS 内容,类似于 bootstrap 的形式.

# TailwindCSS 注意点

Tailwind CSS 使用许多自定义 CSS 规则，例如 ​@tailwind​、​@apply​ 和 ​@screen​，在许多编辑器中，这可能会在无法识别这些规则的情况下触发警告或错误。
解决这个问题的方法几乎总是为您的编辑器/IDE 安装一个插件来支持 PostCSS 语言，而不是常规的 CSS。例如，VS Code 有一个 PostCSS 语言支持插件，你可以使用它与 Tailwind CSS 配合得很好。
在某些情况下，如果您的编辑器对 CSS 文件中预期的语法非常严格，您可能需要禁用原生 CSS linting/validations。

vscode 的 tailwindcss 语法支持拓展:[网址](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss)

# TailwindCSS 目录

- 安装
