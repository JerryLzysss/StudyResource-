# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 股票数据分析（示例）
'''
用模拟行情演示：收益率、滚动均线、简单统计。
真实数据可用 akshare / yfinance 等库获取。
'''
import pandas as pd
import numpy as np

np.random.seed(42)
dates = pd.date_range('2024-01-01', periods=30, freq='B')
price = 100 + np.cumsum(np.random.randn(30))
df = pd.DataFrame({'close': price}, index=dates)

df['return'] = df['close'].pct_change()
df['ma5'] = df['close'].rolling(5).mean()
df['ma10'] = df['close'].rolling(10).mean()

print(df.tail())
print('累计收益:', (1 + df['return'].fillna(0)).prod() - 1)
print(df[['close', 'ma5', 'ma10']].describe())
