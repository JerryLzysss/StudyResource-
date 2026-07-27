# -*- coding: utf-8 -*-
"""
Created on Fri May 30 17:01:55 2025

@author: Jerrylzysss
"""
'''
现有两个 Series，分别是 s1 和 s2，需求为：
对 s1 的所有值乘以 2，得到新的 Series
s1 和 s1 对应位置（相同索引标签）相加得到新的 Series
'''
import pandas as pd
a,b=[1,2,3],[4,5,6]
idx=[*'abc']
series1=pd.Series(a,index=idx)
series2=pd.Series(b,index=idx)
print(series1,series2)
print(series1.mul(2))
print(series1.add(series2))
