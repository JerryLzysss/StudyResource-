# -*- coding: utf-8 -*-
"""
Created on Fri May 30 16:42:03 2025

@author: Jerrylzysss
"""
'''
以下有一个名为 ser 的 Series，需要对以下内容用 for 循环进行迭代输出：
迭代 Series 的值，打印每个值
迭代 Series 的索引，打印每个标签
迭代 Series 的项，打印出索引标签和值
迭代 Series 的项，打印出位置索引和值
'''
import pandas as pd
series =pd.Series([1,3,5],index=['a','b','c'])
for i in series.items():
    print(i)
for i,v in series.items():
    print(f'{i}:{v}')