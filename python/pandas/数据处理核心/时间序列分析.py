# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 时间序列分析
'''
重采样 resample、滚动 rolling、移位 shift、频率转换等。
'''
import pandas as pd
import numpy as np

np.random.seed(0)
idx = pd.date_range('2024-01-01', periods=12, freq='D')
ts = pd.Series(np.random.randn(12).cumsum(), index=idx, name='value')
print(ts)

print(ts.resample('W').mean())          # 按周聚合
print(ts.rolling(3).mean())             # 滚动均值
print(ts.shift(1))                      # 向下平移
print(ts.diff())                        # 差分
print(ts.pct_change())                  # 环比变化

# 按时间切片
print(ts['2024-01-03':'2024-01-07'])
