# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 重复数据处理
'''
duplicated 检测重复；drop_duplicates 删除重复。
'''
import pandas as pd

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 25, 28, 35],
    'City': ['BJ', 'SH', 'BJ', 'SH', 'GZ']
})

print(df.duplicated())                      # 默认全部列
print(df.duplicated(subset=['Name']))
print(df.drop_duplicates())
print(df.drop_duplicates(subset=['Name'], keep='first'))
print(df.drop_duplicates(subset=['Name'], keep='last'))
print(df.drop_duplicates(subset=['Name'], keep=False))  # 重复的全删
