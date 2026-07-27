# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas Series API 手册（常用）
import pandas as pd

s = pd.Series([1, 2, 3, None, 5], index=list('abcde'), name='demo')

# 属性
print(s.values, s.index, s.dtype, s.name, s.shape, s.size)

# 取值 / 切片
print(s['a'], s.iloc[0], s.loc['b':'d'])

# 统计
print(s.sum(), s.mean(), s.min(), s.max(), s.std(), s.quantile(0.5))
print(s.describe())

# 缺失
print(s.isna(), s.fillna(0), s.dropna())

# 变换
print(s.map(lambda x: x), s.apply(lambda x: x), s.astype('float'))
print(s.sort_values(), s.rank(), s.shift(1), s.diff(), s.pct_change())

# 字符串（需 object/string）
print(pd.Series(['a_b']).str.split('_'))
