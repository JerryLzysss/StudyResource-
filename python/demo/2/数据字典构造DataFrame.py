# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 11:05:45 2025

@author: Jerrylzysss
"""

'''
如下有一个需要构造为 DataFrame 的数据 data，它是一个字典，字典的各个信息如下：

index 代表 DataFrame 的索引标签
columns 为列索引标签
data 是一个二维列表，是 DataFrame 的数据
index_names 和 column_names 分别是行索引和列索引的名称

# 数据字典
data = {'index': ['x', 'y'],
        'columns': ['a', 'b'],
        'data': [[1, 2], [3, 4]],
        'index_names': 'e',
        'column_names': 'f'
       }

# 构造完成的 DataFrame

f  a  b
e
x  1  2
y  3  4

'''
import pandas as pd;
data = {'index': ['x', 'y'],
        'columns': ['a', 'b'],
        'data': [[1, 2], [3, 4]],
        'index_names': 'e',
        'column_names': 'f'
       }
df = pd.DataFrame.from_dict(data,orient='tight')
print(df)
