# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 日期与时间
'''
to_datetime 解析日期；DatetimeIndex 支持属性提取与运算。
'''
import pandas as pd

s = pd.Series(['2024-01-01', '2024-02-15', '2024/03/20', '20240401'])
dt = pd.to_datetime(s)  # 自动推断多种日期格式
print(dt)

df = pd.DataFrame({'date': dt, 'value': [10, 20, 30, 40]})
df['year'] = df['date'].dt.year
df['month'] = df['date'].dt.month
df['day'] = df['date'].dt.day
df['weekday'] = df['date'].dt.day_name()
print(df)

# 日期范围与偏移
print(pd.date_range('2024-01-01', periods=5, freq='D'))
print(pd.date_range('2024-01-01', periods=5, freq='B'))  # 工作日
print(dt + pd.Timedelta(days=7))
