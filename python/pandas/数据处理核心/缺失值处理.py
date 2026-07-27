# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 缺失值处理
'''
缺失通常表示为 NaN / None / NaT。
检测：isna / notna；删除：dropna；填充：fillna / interpolate
'''
import pandas as pd
import numpy as np

df = pd.DataFrame({
    'A': [1, np.nan, 3, np.nan],
    'B': [np.nan, 2, 3, 4],
    'C': [1, 2, np.nan, 4]
})
print(df.isna())
print(df.isna().sum())

print(df.dropna())                 # 删除含缺失的行
print(df.dropna(axis=1))           # 删除含缺失的列
print(df.dropna(subset=['A']))     # 仅看某列

print(df.fillna(0))
print(df.fillna({'A': 0, 'B': df['B'].mean()}))
print(df.ffill())                  # 向前填充
print(df.bfill())                  # 向后填充
print(df.interpolate())            # 插值
