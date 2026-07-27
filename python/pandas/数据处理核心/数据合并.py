# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据合并（merge）
'''
类似 SQL JOIN：inner / left / right / outer。
'''
import pandas as pd

df1 = pd.DataFrame({'ID': [1, 2, 3], 'Name': ['A', 'B', 'C']})
df2 = pd.DataFrame({'ID': [1, 2, 4], 'Score': [90, 85, 88]})

print(pd.merge(df1, df2, on='ID', how='inner'))
print(pd.merge(df1, df2, on='ID', how='left'))
print(pd.merge(df1, df2, on='ID', how='right'))
print(pd.merge(df1, df2, on='ID', how='outer'))

# 不同列名
df3 = pd.DataFrame({'user_id': [1, 2], 'city': ['BJ', 'SH']})
print(pd.merge(df1, df3, left_on='ID', right_on='user_id', how='left'))
