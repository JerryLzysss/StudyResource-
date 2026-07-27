# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数组（PandasArray / ExtensionArray 概念）
'''
Pandas 底层可用 NumPy 数组，也支持扩展数组（如 StringDtype、Categorical）。
.values 多返回 ndarray；.array 返回 PandasArray；.to_numpy() 明确转 NumPy。
'''
import pandas as pd
import numpy as np

s = pd.Series([1, 2, 3], dtype='Int64')
print(type(s.array))
print(s.to_numpy())
print(s.to_numpy(dtype=float, na_value=np.nan))

# 分类 / 字符串扩展类型
cat = pd.array(['a', 'b', 'a'], dtype='category')
text = pd.array(['x', 'y', None], dtype='string')
print(cat)
print(text)

df = pd.DataFrame({'num': s, 'cat': cat, 'text': text})
print(df.dtypes)
print(df.to_numpy())
