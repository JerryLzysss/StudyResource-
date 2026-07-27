# 总结

Tkinter库作为一个GUI工具框架，其作用在于简单实现一个基础面板,可以实现比较简易的效果，同时其组件上大部分都有点类似于html中的内容,因此大部分内容只要通过API去查询其对应参数即可使用,上手难度不高.

---

# Tkinter — GUI 笔记

本目录为 Tkinter 学习示例索引。上级总览：[../README.md](../README.md)  
文档：[Tkinter 官方文档](https://docs.python.org/zh-cn/3/library/tkinter.html)

> 说明：在 Windows 上 `README.md` 与 `readme.md` 是同一文件，故将原 `readme.md` 总结保留在上方，下方为详细目录。

## 建议学习顺序

1. 主窗口 → 基本使用 → 常用控件  
2. 布局（管理方法 / 控件 / 控件管理布局）  
3. Label / Button / Entry / Text / Listbox / …  
4. 事件处理 → 对话框  

## 入门与布局

| 文件 | 说明 |
|------|------|
| [主窗口.py](主窗口.py) | 主窗口创建与基础属性 |
| [基本使用.py](基本使用.py) | Tkinter 基本用法 |
| [常用控件.py](常用控件.py) | 常用控件概览 |
| [布局管理方法.py](布局管理方法.py) | pack / grid / place 等方法 |
| [布局管理控件.py](布局管理控件.py) | 布局相关控件 |
| [控件管理布局.py](控件管理布局.py) | 控件与布局综合 |

## 常用组件

| 文件 | 说明 |
|------|------|
| [Label标签.py](Label标签.py) | Label |
| [Button按钮.py](Button按钮.py) | Button |
| [Button示例.py](Button示例.py) | Button 示例 |
| [Entry组件-基础设置与验证.py](Entry组件-基础设置与验证.py) | Entry 基础与验证 |
| [Entry组件-动态数据.py](Entry组件-动态数据.py) | Entry 动态数据 |
| [Entry组件-Spinbox.py](Entry组件-Spinbox.py) | Spinbox |
| [Text组件.py](Text组件.py) | Text |
| [Text组件-Tag标签.py](Text组件-Tag标签.py) | Text Tag |
| [Text组件-Mark文本.py](Text组件-Mark文本.py) | Text Mark |
| [Listbox组件.py](Listbox组件.py) | Listbox |
| [Listbox-获取选项.py](Listbox-获取选项.py) | 获取选中项 |
| [Combobox组件.py](Combobox组件.py) | Combobox |
| [Scale组件.py](Scale组件.py) | Scale |
| [Scrollbar滚动条.py](Scrollbar滚动条.py) | Scrollbar |
| [Menu菜单.py](Menu菜单.py) | Menu |
| [Canvas画布.py](Canvas画布.py) | Canvas |
| [对话框组件.py](对话框组件.py) | 对话框 |

## 事件与其它

| 文件 | 说明 |
|------|------|
| [Event事件处理.py](Event事件处理.py) | 事件绑定与处理 |
| [favicon.ico](favicon.ico) | 窗口图标资源 |

## 运行说明

Tkinter 一般随 CPython 安装。在本目录下运行，例如：

```bash
python 主窗口.py
```

部分示例会弹出 GUI 窗口，需在图形界面环境中执行。
