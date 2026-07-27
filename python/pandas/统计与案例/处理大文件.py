# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 处理大文件
'''
技巧：usecols 只读需要的列、dtype 降内存、chunksize 分块、迭代处理后再合并结果。
'''
import pandas as pd

# 1) 只读部分列 / 行
df_part = pd.read_csv('../教程/demo.csv', usecols=[0, 1], nrows=100)
print(df_part.head())
print(df_part.memory_usage(deep=True).sum())

# 2) 分块读取并聚合
total_rows = 0
chunk_stats = []
for chunk in pd.read_csv('../教程/demo.csv', chunksize=100):
    total_rows += len(chunk)
    # 示例：统计每块行数
    chunk_stats.append(len(chunk))

print('总行数:', total_rows)
print('块大小列表:', chunk_stats[:5], '...')

# 3) 类别类型降低内存（读入后转换）
# df['col'] = df['col'].astype('category')
