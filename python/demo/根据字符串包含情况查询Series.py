# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 14:30:51 2025

@author: Jerrylzysss
"""

'''
有一个名为 ser 的 Series，需要根据以下条件查询数据。
字符串为 bc 的数据
字符串为 bc 或者 d 的数据
字符串包含 b 的数据
'''
import pandas as pd
series =pd.Series(['ab','bc','d','cc'])
# 字符串为bc
print(series[series=='bc'])
# 字符串为bc或者d的数据
print(series[series.isin(['bc','d'])])
# 字符串包含b的数据
print(series[series.str.contains('b')])