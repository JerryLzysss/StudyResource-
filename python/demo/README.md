# Demo — Series / DataFrame 练习

本目录是围绕 Pandas `Series`、`DataFrame` 的短练习，文件名一般即题目意图。适合在学完 [pandas/教程](../pandas/教程/) 后巩固。

上级总览：[../README.md](../README.md) · Pandas 总览：[../pandas/README.md](../pandas/README.md)

## 依赖

```bash
pip install pandas numpy
```

请在本目录下运行脚本，以便找到同目录 CSV。

## Series

| 文件 | 说明 |
|------|------|
| [列表转Series.py](列表转Series.py) | 列表构造带标签 Series |
| [字典构造Series.py](字典构造Series.py) | 字典相关构造示例 |
| [标量构造Series.py](标量构造Series.py) | 标量 + index 构造 |
| [元组对列表转为指定名称Series.py](元组对列表转为指定名称Series.py) | `(标签, 值)` 列表转 Series |
| [构造Series指定值为浮点类型.py](构造Series指定值为浮点类型.py) | 指定 `dtype='float'` |
| [用array构造Series后array不被同步修改.py](用array构造Series后array不被同步修改.py) | `copy=True` 避免共享内存 |
| [获取Series的相关属性.py](获取Series的相关属性.py) | `index` / `values` / `dtype` / `size` |
| [获取Series中指定位置和标签.py](获取Series中指定位置和标签.py) | 位置与标签相关操作 |
| [按照位置索引查询Series数据.py](按照位置索引查询Series数据.py) | `iloc` 查询与切片 |
| [按照索引标签查询Series数据.py](按照索引标签查询Series数据.py) | `loc` 查询与切片 |
| [根据多个大小对比条件查询Series.py](根据多个大小对比条件查询Series.py) | 多条件布尔索引 |
| [根据字符串包含情况查询Series.py](根据字符串包含情况查询Series.py) | `==` / `isin` / `str.contains` |
| [检测一个值是否在Series.py](检测一个值是否在Series.py) | 成员检测 / 删除等相关示例 |
| [修改Series标签和值.py](修改Series标签和值.py) | 修改标签与值 |
| [批量修改Series指定标签值.py](批量修改Series指定标签值.py) | 批量更新 |
| [删除Series指定内容的项.py](删除Series指定内容的项.py) | 删除项 |
| [迭代Series值和索引.py](迭代Series值和索引.py) | 迭代 / `update` 等 |
| [两个相同标签Series相加.py](两个相同标签Series相加.py) | 索引对齐与 `fill_value` |
| [初始值按40计算变化百分比.py](初始值按40计算变化百分比.py) | `pct_change` |
| [将部分信息替换为星号.py](将部分信息替换为星号.py) | 字符串正则替换脱敏 |

## DataFrame

| 文件 | 说明 |
|------|------|
| [二维列表构造DataFrame.py](二维列表构造DataFrame.py) | 二维列表 + index/columns |
| [数据字典构造DataFrame.py](数据字典构造DataFrame.py) | `from_dict` 等字典构造 |
| [字典键为索引构造DataFrame.py](字典键为索引构造DataFrame.py) | 字典键作索引相关示例 |
| [Series构造DataFrame.py](Series构造DataFrame.py) | 多个 Series 作列构造 |
| [numPy构造DataFrame.py](numPy构造DataFrame.py) | NumPy 数组构造 |
| [numPy转为DataFrame.py](numPy转为DataFrame.py) | 结构化数组转 DataFrame |
| [namedtuple构造DataFrame.py](namedtuple构造DataFrame.py) | namedtuple 列表构造 |
| [dataClasses构造DataFrame.py](dataClasses构造DataFrame.py) | dataclass 列表构造 |
| [选择DataFrame中的某一列.py](选择DataFrame中的某一列.py) | 单列选取 |
| [选择DataFrame多列.py](选择DataFrame多列.py) | 多列选取 |
| [删除DataFrame的某一列.py](删除DataFrame的某一列.py) | `pop` / `del` / `drop` |

## 综合小案例

| 文件 | 说明 |
|------|------|
| [时间两列间隔秒数.py](时间两列间隔秒数.py) | 配合 [时间两列间隔秒数.csv](时间两列间隔秒数.csv) |
| [分组后按列取最后一值和平均值.py](分组后按列取最后一值和平均值.py) | 分组聚合；可生成/使用配套 CSV |

## 说明

部分文件名与脚本内容可能不完全一致（练习过程中改写过），以文件内代码为准。
