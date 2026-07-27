# -*- coding: utf-8 -*-
"""
Created on Fri May 30 17:50:27 2025

@author: Jerrylzysss
"""
'''
有一个名为 ser 的 Series，需要根据以下条件查询数据。

数值同时小于 6 大于等于 3 的数据
数值大于 6 或者小于 3 的数据
数值等于 1 或者 等于 3 的数据
'''
import pandas as pd
series = pd.Series([*'97625313'],
                index=[*'abcdefgh'],
                dtype=int)
print(series)
print(series[(series<6)&(series>=3)])
print(series[(series>6)|(series<3)])
print(series[(series==6)|(series==3)])