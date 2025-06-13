# -*- coding: utf-8 -*-
"""
Created on Tue May 27 14:32:50 2025

@author: Jerrylzysss
"""

'''
以下有一个名为 ser 的 Series，需要获取它的以下信息：

Series 的索引对象
Series 值的 ndarray 对象
Series 的数据类型
Series 的长度
'''
import pandas as pd
ser = pd.Series([1, 2, 3, 4],
                index=['a', 'b', 'c', 'd'],
                name='age',
                dtype='float'
               )
print("索引",ser.index)
print("值",ser.values)
print("数据类型",ser.dtype)
print("长度",ser.size)