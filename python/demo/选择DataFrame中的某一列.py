# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 11:34:16 2025

@author: Jerrylzysss
"""

'''
有以下一个 DataFrame，请分别选择 name 列和 math 列，
选择后为一个 Series，并查看这些 Series 的数据类型。
'''
import pandas as pd
data = {
    'name': ['Alice', 'Bob', 'Charlie', 'David', 'Eve'],
    'grade': [10, 11, 10, 12, 11],
    'math': [90, 85, 92, 88, 95],
    'english': [85, 92, 88, 90, 92],
    'science': [92, 90, 88, 93, 89]
}
df=pd.DataFrame(data)
print(df)
#  name列
print('name1:',df['name'])
print('name2:',df.name)
print('name3:',df.loc[:,'name'])
print(df.name.dtype)
print(df.math.dtype)