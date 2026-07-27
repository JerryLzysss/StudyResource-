# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas Index 详解
'''
Index 是轴标签对象，用于行/列标记、对齐、查找。
常见类型：Index、RangeIndex、Int64Index、DatetimeIndex、MultiIndex 等。
'''
import pandas as pd

df = pd.DataFrame({'A': [10, 20, 30], 'B': [1, 2, 3]}, index=['x', 'y', 'z'])
print(df.index)
print(df.index.tolist())

# 重置 / 设置索引
print(df.reset_index())
print(df.set_index('A'))

# 重命名索引
df2 = df.rename_axis('row_id')
print(df2)

# 索引运算
idx1 = pd.Index([1, 2, 3, 4])
idx2 = pd.Index([3, 4, 5, 6])
print(idx1.intersection(idx2))
print(idx1.union(idx2))
print(idx1.difference(idx2))

# 是否唯一、是否单调
print(df.index.is_unique)
print(pd.Index([1, 2, 3]).is_monotonic_increasing)
