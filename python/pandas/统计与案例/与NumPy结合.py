# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 与 NumPy 结合
'''
Pandas 建立在 NumPy 之上：可互转，也可对底层数组做向量化计算。
'''
import pandas as pd
import numpy as np

df = pd.DataFrame({
    'A': [1, 2, 3, 4],
    'B': [10, 20, 30, 40]
})

arr = df.to_numpy()
print(arr, type(arr))

# NumPy 结果可包装回 DataFrame
print(pd.DataFrame(arr * 2, columns=df.columns))

# 使用 NumPy ufunc
print(np.sqrt(df['A']))
print(np.where(df['A'] > 2, 'big', 'small'))

# 从 ndarray 创建
print(pd.Series(np.arange(5)))
print(pd.DataFrame(np.random.randn(3, 2), columns=['x', 'y']))
