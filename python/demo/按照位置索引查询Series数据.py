# -*- coding: utf-8 -*-
"""
Created on Fri May 30 17:35:18 2025

@author: Jerrylzysss
"""

'''
有一个名为 ser 的 Series，需求按位置（即位置索引）查询其部分内容（即 ser 的 子集）。
查询仅包含第一个值的内容
查询仅包含最后一个值的内容
查询第 2、6、3 个内容（以此位置为顺序）
查询第 2 个到第5个之间的内容
查询第 3 个及以后的内容
查询第 2、4 等偶数位置上的内容
'''
import pandas as pd
series = pd.Series([*'97625313'],index=[*'abcdefgh'])
print(series.iloc[0])
print(series.iloc[[-1]])
print(series.iloc[[1,5,2]])
print(series.iloc[1:4])
print(series.iloc[2:])
print(series.iloc[1::2])