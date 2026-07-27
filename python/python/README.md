# Python 语言基础

本目录为 Python 语法与核心特性的入门笔记，示例风格为「注释说明 + 可运行代码」。

上级总览：[../README.md](../README.md)

## 建议学习顺序

1. 基础语法 → 基本类型 → 数字 / 字符串 / 列表 / 元组 / 字典 / 集合  
2. 运算符 → 类型转换 → 条件判断 / 条件和循环 → 推导式  
3. 函数 → lambda → 装饰器 → 迭代器与生成器  
4. 命名空间和作用域 → 模块 → `__name__` / `__main__`  
5. 输入输出 → 文件 → 错误和异常  

## 文件索引

| 文件 | 说明 |
|------|------|
| [基础语法.py](基础语法.py) | 标识符、关键字、注释 |
| [基本类型.py](基本类型.py) | int / float / str / bool / list / set / tuple / dict / bytes 等 |
| [数字.py](数字.py) | 整型、浮点、复数 |
| [字符串.py](字符串.py) | 切片、转义、格式化 |
| [列表.py](列表.py) | 索引访问与删除 |
| [元组.py](元组.py) | 元组与单元素写法 |
| [字典.py](字典.py) | 创建、访问与键的特性 |
| [集合.py](集合.py) | 去重与成员检测 |
| [类型转换.py](类型转换.py) | 显式转换与类型提升 |
| [运算符.py](运算符.py) | 算术、比较、位、逻辑、成员/身份运算 |
| [条件判断.py](条件判断.py) | `if` / `match-case` / `while` |
| [条件和循环.py](条件和循环.py) | 条件分支与 `for` / `range` 循环 |
| [推导式.py](推导式.py) | 列表 / 字典 / 集合推导式与生成器表达式 |
| [函数.py](函数.py) | 定义、返回值、各类参数 |
| [lambda函数.py](lambda函数.py) | 匿名函数 |
| [装饰器.py](装饰器.py) | 装饰器及 `@staticmethod` / `@classmethod` / `@property` |
| [迭代器与生成器.py](迭代器与生成器.py) | `iter` / `next` / `yield` |
| [命名空间和作用域.py](命名空间和作用域.py) | LEGB、`global` / `nonlocal` |
| [模块.py](模块.py) | `import` 相关用法 |
| [moduleTest.py](moduleTest.py) | 供模块示例导入的辅助文件 |
| [__name__与__main__.py](__name__与__main__.py) | 脚本入口判断 |
| [输入和输出.py](输入和输出.py) | `print` / `input` / 格式化 |
| [File.py](File.py) | 文件读写（依赖同目录 `file.txt`） |
| [错误和异常.py](错误和异常.py) | `try` / `except` / `finally` / `with` |

## 运行说明

在本目录下执行，例如：

```bash
python 基础语法.py
```

`File.py` 会读写同目录的 `file.txt`。部分示例若引用外部模块或文件，需自行补齐后再运行。
