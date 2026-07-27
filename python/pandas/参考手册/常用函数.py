# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 常用函数速查（参考手册）
'''
按用途归类的高频 API，便于查阅。
'''
import pandas as pd

df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})

# 创建 / 查看
pd.Series([1, 2, 3])
pd.DataFrame({'a': [1]})
df.head(); df.tail(); df.info(); df.describe()

# 选取
df['A']; df.loc[0]; df.iloc[0]

# 缺失 / 重复
df.isna(); df.fillna(0); df.dropna(); df.drop_duplicates()

# 统计
df.sum(); df.mean(); df.median(); df.std(); df.corr()

# 排序 / 分组
df.sort_values('A'); df.groupby('A').sum()

# 合并
pd.concat([df, df]); pd.merge(df, df, on='A')

# 字符串 / 时间
pd.Series(['a']).str.upper()
pd.to_datetime(['2024-01-01'])

print('常用函数速查示例运行完成')
