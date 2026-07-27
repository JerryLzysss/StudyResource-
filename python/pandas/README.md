# Pandas 学习笔记

基于 [菜鸟教程 Pandas](https://www.runoob.com/pandas/pandas-tutorial.html) 分类整理的学习示例，风格为「注释说明 + 可运行代码」。

参考：[Pandas 性能优化](https://www.runoob.com/pandas/pandas-optimization.html) · [Pandas 官网](https://pandas.pydata.org/)

## 目录结构

```
pandas/
├── README.md                 # 本说明
├── 教程/                     # 入门基础
├── 数据读写/                 # 读写、清洗、类型与性能等
├── 数据处理核心/             # 选取、清洗、变换、合并、分组
├── 参考手册/                 # API 速查与自测
└── 统计与案例/               # 统计方法与业务案例
```

---

## 〇、教程（入门基础）

| 文件 | 说明 |
|------|------|
| [pandas介绍.py](教程/pandas介绍.py) | Pandas 作用与功能概览 |
| [pandas安装.py](教程/pandas安装.py) | 安装与版本验证 |
| [Series.py](教程/Series.py) | Series 构造与基本用法 |
| [Series方法.py](教程/Series方法.py) | Series 常用方法 |
| [DataFrame.py](教程/DataFrame.py) | DataFrame 介绍与创建 |
| [csv.py](教程/csv.py) | CSV 读写 |
| [excel.py](教程/excel.py) | Excel 读写 |
| [Json.py](教程/Json.py) | JSON 读写 |

示例数据：`demo.csv` / `demo.json` / `demo.xlsx` / `demoTransform.csv` / `df_demo.xlsx`（与上述脚本同目录，请在 `教程/` 下运行相关读写示例）。

---

## 一、数据读写

| 文件 | 说明 |
|------|------|
| [数据读写.py](数据读写/数据读写.py) | 读写总览 |
| [读取SQL.py](数据读写/读取SQL.py) | `read_sql` / `to_sql`（sqlite 演示） |
| [读取HTML.py](数据读写/读取HTML.py) | `read_html` |
| [Parquet_Feather.py](数据读写/Parquet_Feather.py) | Parquet / Feather（需 pyarrow） |
| [数据导出.py](数据读写/数据导出.py) | 多格式导出 |
| [数据清洗.py](数据读写/数据清洗.py) | 缺失、重复、异常值等 |
| [常用函数.py](数据读写/常用函数.py) | 查看与概览常用函数 |
| [相关性分析.py](数据读写/相关性分析.py) | `corr` / `cov` |
| [数据排序与聚合.py](数据读写/数据排序与聚合.py) | 排序与 `agg` |
| [数据可视化.py](数据读写/数据可视化.py) | `DataFrame.plot` |
| [高级功能.py](数据读写/高级功能.py) | `query` / `eval` / `pipe` 等 |
| [性能优化.py](数据读写/性能优化.py) | dtype、向量化、分块、避免链式赋值等 |
| [股票数据分析.py](数据读写/股票数据分析.py) | 模拟行情与均线示例 |
| [Index详解.py](数据读写/Index详解.py) | Index 用法 |
| [多层索引.py](数据读写/多层索引.py) | MultiIndex |
| [数据类型.py](数据读写/数据类型.py) | dtype 与转换 |
| [类别类型.py](数据读写/类别类型.py) | `category` |

CSV / Excel / JSON 入门见 [教程/](教程/)。

---

## 二、数据处理核心

| 文件 | 说明 |
|------|------|
| [数据选取.py](数据处理核心/数据选取.py) | `[]` / `loc` / `iloc` / `at` / `iat` |
| [过滤与条件查询.py](数据处理核心/过滤与条件查询.py) | 布尔索引、`query`、`isin` |
| [缺失值处理.py](数据处理核心/缺失值处理.py) | `isna` / `dropna` / `fillna` |
| [重复数据处理.py](数据处理核心/重复数据处理.py) | `duplicated` / `drop_duplicates` |
| [字符串操作.py](数据处理核心/字符串操作.py) | `Series.str` |
| [日期与时间.py](数据处理核心/日期与时间.py) | `to_datetime`、日期属性 |
| [时间序列分析.py](数据处理核心/时间序列分析.py) | `resample` / `rolling` / `shift` |
| [apply_map_applymap.py](数据处理核心/apply_map_applymap.py) | `apply` / `map` / `applymap` |
| [数据合并.py](数据处理核心/数据合并.py) | `merge` |
| [数据拼接.py](数据处理核心/数据拼接.py) | `concat` / `join` |
| [数据重塑.py](数据处理核心/数据重塑.py) | `pivot` / `melt` / `stack` |
| [分组操作.py](数据处理核心/分组操作.py) | `groupby` |
| [窗口函数.py](数据处理核心/窗口函数.py) | `rolling` / `expanding` / `ewm` |

---

## 三、参考手册

| 文件 | 说明 |
|------|------|
| [常用函数.py](参考手册/常用函数.py) | 高频 API 速查 |
| [IO_API.py](参考手册/IO_API.py) | Input/Output API 一览 |
| [Series_API.py](参考手册/Series_API.py) | Series 常用 API |
| [DataFrame_API.py](参考手册/DataFrame_API.py) | DataFrame 常用 API |
| [数组.py](参考手册/数组.py) | 与 NumPy / 扩展数组 |
| [Index对象.py](参考手册/Index对象.py) | Index 对象 |
| [DateOffset对象.py](参考手册/DateOffset对象.py) | DateOffset / 业务日偏移 |
| [测验.py](参考手册/测验.py) | 简单自测题 |

---

## 四、统计与案例

| 文件 | 说明 |
|------|------|
| [描述性统计.py](统计与案例/描述性统计.py) | `describe`、均值方差等 |
| [抽样与随机数据.py](统计与案例/抽样与随机数据.py) | `sample`、随机生成 |
| [数据分箱.py](统计与案例/数据分箱.py) | `cut` / `qcut` |
| [处理大文件.py](统计与案例/处理大文件.py) | 分块读取、降内存 |
| [与NumPy结合.py](统计与案例/与NumPy结合.py) | Pandas ↔ NumPy |
| [可视化.py](统计与案例/可视化.py) | 柱状图 / 折线 / 饼图示例 |
| [电商数据.py](统计与案例/电商数据.py) | 模拟订单分析 |
| [用户行为.py](统计与案例/用户行为.py) | 模拟埋点与转化 |

---

## 运行说明

1. 在对应子目录下运行脚本，或用绝对/相对路径指定文件。
2. 读写示例请在 `教程/` 目录执行，以便找到同目录示例数据。
3. 部分功能需额外依赖，例如：
   - Excel：`openpyxl` / `xlsxwriter`
   - Parquet / Feather：`pyarrow`
   - HTML 表格：`lxml` / `html5lib` / `bs4`
   - 图表显示：`matplotlib`
4. 验证安装：

```bash
python -c "import pandas; print(pandas.__version__)"
```
