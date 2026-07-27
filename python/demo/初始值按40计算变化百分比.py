# -*- coding: utf-8 -*-
"""
Created on Tue Jun 10 10:07:26 2025

@author: Jerrylzysss
"""

'''
有以下一个 Series，需要计算所在值的变化百分比和值，
其中第一个值所在的位置由于没有初始值会为 NaN，请将初始值按 40 计算。
'''
import pandas as pd
series =pd.Series([20,30,2,5,10])
print(series.pct_change(fill_value=40).mul(100))