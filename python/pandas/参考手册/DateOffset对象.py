# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas DateOffset 对象
'''
DateOffset 表示相对时间偏移（按日历规则），不同于固定时长的 Timedelta。
'''
import pandas as pd

ts = pd.Timestamp('2024-01-31')
print(ts + pd.DateOffset(months=1))      # 2024-02-29（考虑月末）
print(ts + pd.Timedelta(days=30))        # 固定 30 天

# 常用偏移别名
print(pd.Timestamp('2024-01-01') + pd.offsets.Day(3))
print(pd.Timestamp('2024-01-01') + pd.offsets.BusinessDay(2))
print(pd.Timestamp('2024-01-01') + pd.offsets.MonthEnd(1))
print(pd.Timestamp('2024-01-15') + pd.offsets.MonthBegin(1))
print(pd.Timestamp('2024-01-01') + pd.offsets.Week(weekday=4))  # 到周五

idx = pd.date_range('2024-01-01', periods=4, freq=pd.offsets.BusinessDay())
print(idx)
