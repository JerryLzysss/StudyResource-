# -*- coding: utf-8 -*-
"""
Created on Tue May 27 14:30:17 2025

@author: Jerrylzysss
"""

'''
将以下列表 data 构造为 Series，同时类型为浮点型。
data = [82, 43, 64, 23]
'''
import pandas as pd
data=[82,43,64,23]
series=pd.Series(data,dtype='float')
print(series)

