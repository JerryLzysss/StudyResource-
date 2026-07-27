# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 多层索引（MultiIndex）
'''
多层索引用于表示高维数据在二维表中的层次结构。
'''
import pandas as pd

arrays = [
    ['A', 'A', 'B', 'B'],
    ['one', 'two', 'one', 'two']
]
index = pd.MultiIndex.from_arrays(arrays, names=('letter', 'number'))
df = pd.DataFrame({'value': [1, 2, 3, 4]}, index=index)
print(df)

# 创建方式
print(pd.MultiIndex.from_product([['A', 'B'], [1, 2]], names=['L', 'N']))
print(pd.MultiIndex.from_tuples([('A', 1), ('A', 2), ('B', 1)], names=['L', 'N']))

# 选取
print(df.loc['A'])
print(df.loc[('A', 'one')])
print(df.xs('one', level='number'))

# stack / unstack
print(df.unstack())
print(df.unstack().stack())
