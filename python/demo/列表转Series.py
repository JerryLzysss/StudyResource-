# -*- coding: utf-8 -*-
"""
Created on Tue May 27 09:47:37 2025

@author: Jerrylzysss
"""

'''
将以下数字列表 numbers 转为 pandas 的 Series 类型，并索引的标签值分别是 a、b、c、d。
numbers = [23, 56, 12, 89]
'''
import pandas as pd
numbers=[23,56,12,89]
series=pd.Series(numbers,index=['a','b','c','d'])
print(series)