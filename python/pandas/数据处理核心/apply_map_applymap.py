# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas apply / map / applymap
'''
map：Series 逐元素映射（也用于 DataFrame 新版本逐元素）
apply：对行/列应用函数
applymap：旧版 DataFrame 逐元素；新版推荐 DataFrame.map
'''
import pandas as pd

df = pd.DataFrame({'A': [1, 2, 3, 4], 'B': [5, 6, 7, 8]})

# Series.map
print(df['A'].map(lambda x: x ** 2))
print(df['A'].map({1: 'one', 2: 'two'}))

# DataFrame.apply：默认按列
print(df.apply(lambda col: col.max() - col.min()))
print(df.apply(lambda row: row['A'] + row['B'], axis=1))

# 逐元素
if hasattr(df, 'map'):
    print(df.map(lambda x: x * 10))
else:
    print(df.applymap(lambda x: x * 10))
