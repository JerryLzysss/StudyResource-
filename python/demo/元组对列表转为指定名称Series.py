# -*- coding: utf-8 -*-
"""
Created on Tue May 27 11:43:30 2025

@author: Jerrylzysss
"""

'''
将元组对列表 info 转为 pandas 的 Series，
要求元组对中的第一个元素为索引标签，第二个元素为值，
并将这个 Series 的名称指定为「age」。
info = [('Alice', 25),
        ('Bob', 30),
        ('Charlie', 35),
        ('David', 40)]
'''
import pandas as pd

info =[('Alice',25),('Bob',30),('Charlie',35),('David',40)]
# 将元组的元素以字典的形式存入
series =pd.Series(dict(info),name='age')
print(series)
