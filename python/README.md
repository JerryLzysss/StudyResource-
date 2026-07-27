# Python 学习笔记

个人 Python 学习与练习仓库，按主题分子目录，示例多为「注释说明 + 可运行代码」。

## 总览

```
python/
├── README.md          # 本说明（统管全目录）
├── python/            # Python 语言基础
├── pandas/            # Pandas 数据分析
├── demo/              # Series / DataFrame 小练习
├── os/                # os 标准库
└── tkinter/           # Tkinter GUI
```

建议顺序：**python（语言基础）→ os → pandas / demo → tkinter（GUI）**。

| 目录 | 内容 | 详细索引 |
|------|------|----------|
| [python/](python/) | 语法、类型、函数、模块、异常等 | [python/README.md](python/README.md) |
| [pandas/](pandas/) | Pandas 教程、读写、处理、手册、案例 | [pandas/README.md](pandas/README.md) |
| [demo/](demo/) | Series / DataFrame 专题小练习 | [demo/README.md](demo/README.md) |
| [os/](os/) | `os` 模块示例 | [os/README.md](os/README.md) |
| [tkinter/](tkinter/) | 窗口与常用控件 | [tkinter/README.md](tkinter/README.md) |

---

## 各目录简介

### [python/](python/) — 语言基础

标识符与类型、容器、运算符、条件循环、函数与装饰器、模块与异常、文件 I/O 等入门笔记。

### [pandas/](pandas/) — 数据分析

按菜鸟教程分类：`教程` / `数据读写` / `数据处理核心` / `参考手册` / `统计与案例`。

### [demo/](demo/) — Series / DataFrame 练习

围绕构造、查询、修改、删除及若干带 CSV 的小案例，适合巩固 Pandas 基础。

### [os/](os/) — 标准库

`getcwd` / `listdir` / 环境变量等常用 `os` API 示例。

### [tkinter/](tkinter/) — GUI

主窗口、布局与 Label / Button / Entry / Text / Listbox / Menu / Canvas 等控件，以及事件与对话框。

---

## 运行说明

1. 多数脚本可直接用 Python 3 运行；建议在对应子目录下执行，以免相对路径找不到数据文件。
2. Pandas / demo 相关需：`pip install pandas numpy`（Excel / Parquet 等另需 `openpyxl`、`pyarrow` 等，详见 [pandas/README.md](pandas/README.md)）。
3. Tkinter 一般为 CPython 自带；图表类示例可能需要 `matplotlib`。

```bash
python -c "import sys; print(sys.version)"
python -c "import pandas; print(pandas.__version__)"
```
