# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas DataFrame API 手册（常用）
import pandas as pd

df = pd.DataFrame({
    'A': [1, 2, 3, 2],
    'B': [10, 20, 30, 40],
    'C': ['x', 'y', 'x', 'z']
})

# 属性
print(df.shape, df.columns, df.index, df.dtypes, df.values)

# 查看
print(df.head(), df.tail(), df.info(), df.describe(include='all'))

# 选取 / 过滤
print(df.loc[0:1, ['A', 'B']], df.iloc[:2, :2])
print(df.query('A > 1'))

# 增删改
df2 = df.copy()
df2['D'] = df2['A'] * 10
df2 = df2.drop(columns=['D'])
df2 = df2.rename(columns={'A': 'AA'})
print(df2)

# 统计 / 分组
print(df.mean(numeric_only=True), df.corr(numeric_only=True))
print(df.groupby('C')['B'].sum())

# 重塑 / 合并相关
print(df.T)
print(pd.concat([df, df], ignore_index=True))
