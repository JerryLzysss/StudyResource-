# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 14:57:37 2025

@author: Jerrylzysss
"""

import pandas as pd

'''
有以下一个 DataFrame，按照 [x2,test] 分组， v1 到 v3 取取均值，其余不参与分组的列取最后一个值。
'''
data = {
    'x1': ['A', 'A', 'A', 'A', 'B', 'B', 'B', 'B'],
    'x2': ['产品1', '产品2', '产品2', '产品2', '产品3', '产品4', '产品5', '产品5'],
    'test': [1, 2, 2, 2, 3, 4, 5, 5],
    'time': ['1月', '2月', '3月', '4月', '1月', '2月', '3月', '4月'],
    'v1': [1, 2, None, 4, None, 6, 7, 8],
    'v2': [1, 2, 3, None, 5, 6, None, 8],
    'v3': [1, 2, 3, 4, 5, 6, 10, 8]
}
df=pd.DataFrame(data)
df.to_csv('分组后按列取最后一值和平均值.csv',index=False,encoding='utf-8')
print(df.groupby(['x2', 'test'])
    .agg({
        **{i:'last' for i in ['x1', 'time']}, 
        **{i:'mean' for i in ['v1', 'v2', 'v3']}
        })
    .reset_index()
    .reindex(df.columns, axis=1)
    )