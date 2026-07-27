# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 14:28:47 2025

@author: Jerrylzysss
"""

'''
有以下一个 DataFrame，请在原数据中：
删除 science 列
删除第 2 列
'''
import pandas as pd
index = ['Alice', 'Bob', 'Charlie', 'David', 'Eve']
data = {
    'grade': [10, 11, 10, 12, 11],
    'math': [90, 85, 92, 88, 95],
    'english': [85, 92, 88, 90, 92],
    'science': [92, 90, 88, 93, 89]
}
df = pd.DataFrame(data, index=index)
# 删除Science列
df.pop('science') # 使用pop返回可以获得其对应值
# del df['science']
# df.drop(columns=['science'],inplace=True)
# 删除第2列
df.pop(df.columns[1])
# del df[df.columns[1]]
# df.drop(columns=df.columns[1],inplace=True)