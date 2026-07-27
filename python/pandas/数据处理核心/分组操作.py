# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 分组操作（groupby）
'''
拆分-应用-合并：groupby + 聚合 / 转换 / 过滤
'''
import pandas as pd

df = pd.DataFrame({
    'Dept': ['A', 'A', 'B', 'B', 'A'],
    'Name': ['Alice', 'Bob', 'Charlie', 'David', 'Eva'],
    'Score': [88, 92, 79, 85, 95],
    'Age': [25, 30, 28, 22, 26]
})

g = df.groupby('Dept')
print(g['Score'].mean())
print(g.agg({'Score': ['mean', 'max'], 'Age': 'min'}))
print(g.size())
print(df.groupby('Dept').filter(lambda x: x['Score'].mean() > 85))
print(df.groupby('Dept')['Score'].transform('mean'))

for name, group in df.groupby('Dept'):
    print(name)
    print(group)
