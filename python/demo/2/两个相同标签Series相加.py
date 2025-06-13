# -*- coding: utf-8 -*-
"""
Created on Fri May 30 17:09:45 2025

@author: Jerrylzysss
"""
'''
有两个索引不同的 Series，分别是 s1 和 s2，需求为：
两个 Series 相加，将相同标签的值相加，双方都不存在的标签值删除
两个 Series 相加，将相同标签的值相加，对方都不存在的标签按 0 计算
'''
import pandas as pd
a,b=[1,2,3],[4,5,6]
s1, s2 = (
    pd.Series(a, index=[*'bcd']),
    pd.Series(b, index=[*'abc'])
)
print(s1,s2)
# 删除不存在标签
s1.add(s2).dropna()
print(s1,s2)
# 不存在的标签按0计算
s1.add(s2,fill_value=0)
print(s1,s2)