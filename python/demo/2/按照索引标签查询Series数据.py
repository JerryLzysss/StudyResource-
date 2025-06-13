# -*- coding: utf-8 -*-
"""
Created on Fri May 30 17:23:31 2025

@author: Jerrylzysss
"""

'''
有一个名为 ser 的 Series，需求查询其部分内容（即 ser 的 子集）。
查询仅有标签 e 的数据（注意，返回的是一个值的 Series）
查询标签 d、f、b 的数据（以此标签为顺序）
查询标签 c 到 g 的数据
查询标签 d 及之前的数据
查询 d 及之前每两个选择一个的数据
查询 Series 的所有数据
'''
import pandas as pd

series = pd.Series([*'97625313'], index=[*'abcdefgh'])
print(series)
print(series['e'])
print(series[['d','f','b']])
print(series['c':'g'])
print(series[:'d'])
print(series[:'d':2])