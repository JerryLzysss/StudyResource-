# -*- coding: utf-8 -*-
"""
Created on Tue May 27 11:45:34 2025

@author: Jerrylzysss
"""

'''
有一个字典 d，将它转为一个 Series，标签为 key，值为 value，要求 Series 只包含 a、b 两个键的数据。
d = {'a': 1, 'b': 2, 'c': 3, 'd': 4}
'''
import pandas as pd
d = {'a': 1, 'b': 2, 'c': 3, 'd': 4}
series = pd.Series(data=d,index=['a','b'])
print(series)