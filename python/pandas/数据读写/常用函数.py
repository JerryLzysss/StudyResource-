# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 常用函数（读写与基础查看）
'''
数据读入后，常用查看 / 概览函数。
'''
import pandas as pd

df = pd.DataFrame({
    'A': [1, 2, 3, 4, 5],
    'B': [10, 20, 30, 40, 50],
    'C': ['x', 'y', 'x', 'z', 'y']
})

print(df.head(3))       # 前 n 行
print(df.tail(2))       # 后 n 行
print(df.shape)         # (行, 列)
print(df.columns)       # 列名
print(df.index)         # 行索引
print(df.dtypes)        # 各列类型
print(df.info())        # 结构摘要
print(df.describe())    # 数值列描述统计
print(df.nunique())     # 各列唯一值个数
print(df['C'].value_counts())  # 频次统计
print(df.sample(2))     # 随机抽样
print(df.memory_usage(deep=True))  # 内存占用
