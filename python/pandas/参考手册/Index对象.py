# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas Index 对象
'''
Index 是不可变的标签序列，支持集合运算与对齐。
'''
import pandas as pd

idx = pd.Index(['a', 'b', 'c', 'd'], name='label')
print(idx, idx.name, idx.dtype)
print(idx[1], idx[1:3])
print(idx.get_loc('c'))

a = pd.Index([1, 2, 3])
b = pd.Index([3, 4, 5])
print(a.append(b))
print(a.union(b))
print(a.intersection(b))
print(a.difference(b))
print(a.isin([2, 5]))

# 特殊 Index
print(pd.RangeIndex(0, 10, 2))
print(pd.DatetimeIndex(['2024-01-01', '2024-01-02']))
print(pd.CategoricalIndex(['x', 'y', 'x']))
