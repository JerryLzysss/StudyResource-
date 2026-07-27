# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 11:19:35 2025

@author: Jerrylzysss
"""

'''
有以下一个 DataFrame，请从中选择 name 和 english 这两列形成一个 DataFrame。
'''

import pandas as pd

data = {
    'name': ['Alice', 'Bob', 'Charlie', 'David', 'Eve'],
    'grade': [10, 11, 10, 12, 11],
    'math': [90, 85, 92, 88, 95],
    'english': [85, 92, 88, 90, 92],
    'science': [92, 90, 88, 93, 89]
}

df = pd.DataFrame(data)
print('data1:',df[['name','english']])
print('data2:',df.loc[:,['name','english']])
print('data3:',df.filter(['name','english']))