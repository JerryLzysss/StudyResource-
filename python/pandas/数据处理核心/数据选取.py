# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据选取
'''
常用：[]、loc（标签）、iloc（位置）、at / iat（单值快速访问）
'''
import pandas as pd

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [25, 30, 35, 28],
    'Score': [88, 92, 79, 85]
}, index=['a', 'b', 'c', 'd'])

print(df['Name'])                 # 选列 -> Series
print(df[['Name', 'Score']])      # 多列 -> DataFrame
print(df.loc['b'])                # 按标签选行
print(df.loc['a':'c', 'Name':'Age'])
print(df.iloc[0])                 # 按位置选行
print(df.iloc[0:2, 0:2])
print(df.at['b', 'Age'])          # 单值（标签）
print(df.iat[1, 1])               # 单值（位置）
