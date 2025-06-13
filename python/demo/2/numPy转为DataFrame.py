# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 11:09:08 2025

@author: Jerrylzysss
"""

'''
以下为一个 NumPy 的结构化数组（ndarray），将其转为 DataFrame，
列名为数据的字段名，同时不包含 C 列。
'''
import numpy as np
import pandas as pd
data =np.array([(1,2.,b'Hello'),(2,3.,b'World')],dtype=[('A','<i4'),('B','<f4'),('C','S10')]);
df =pd.DataFrame.from_records(data,exclude='C')
print(df)
