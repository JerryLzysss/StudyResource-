# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据清洗
'''
清洗常见问题：缺失值、重复行、异常值、类型错误、空白字符等。
'''
import pandas as pd
import numpy as np

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Alice', '  Charlie  ', None],
    'Age': [25, np.nan, 25, 35, 40],
    'Score': [90, 85, 90, -1, 88]
})
print('原始数据：')
print(df)

# 去重
df = df.drop_duplicates()
# 去空白
df['Name'] = df['Name'].str.strip()
# 缺失值：删除或填充
df = df.dropna(subset=['Name'])
df['Age'] = df['Age'].fillna(df['Age'].mean())
# 异常值处理示例：负分改为 NaN 再填充
df.loc[df['Score'] < 0, 'Score'] = np.nan
df['Score'] = df['Score'].fillna(df['Score'].median())
# 类型转换
df['Age'] = df['Age'].astype(int)

print('清洗后：')
print(df)
print(df.info())
