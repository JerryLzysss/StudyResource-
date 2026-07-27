# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据分箱（binning）
'''
cut：按数值区间分箱；qcut：按分位数分箱。
'''
import pandas as pd

ages = pd.Series([18, 22, 25, 30, 35, 40, 48, 55, 62, 70], name='age')

# 等宽分箱
print(pd.cut(ages, bins=3))
print(pd.cut(ages, bins=[0, 18, 35, 60, 100], labels=['未成年', '青年', '中年', '老年']))

# 等频分箱（分位数）
print(pd.qcut(ages, q=4))
print(pd.qcut(ages, q=4, labels=['Q1', 'Q2', 'Q3', 'Q4']))

df = ages.to_frame()
df['age_bin'] = pd.cut(df['age'], bins=[0, 30, 50, 100], labels=['低', '中', '高'])
print(df.groupby('age_bin', observed=True).size())
