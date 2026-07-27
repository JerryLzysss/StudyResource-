# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 窗口函数
'''
rolling：固定窗口滚动统计
expanding：扩展窗口（从起点累计）
ewm：指数加权窗口
'''
import pandas as pd

s = pd.Series([1, 2, 3, 4, 5, 6, 7, 8])

print(s.rolling(window=3).mean())
print(s.rolling(3).sum())
print(s.rolling(3).std())
print(s.expanding().mean())
print(s.ewm(span=3).mean())

df = pd.DataFrame({'A': range(1, 9), 'B': range(10, 18)})
print(df.rolling(3).agg({'A': 'mean', 'B': 'sum'}))
