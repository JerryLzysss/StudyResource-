# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据类型
'''
常见 dtype：int64/float64/bool/object/string/category/datetime64[ns] 等。
合理选型可降低内存、加快计算。
'''
import pandas as pd

df = pd.DataFrame({
    'i': [1, 2, 3],
    'f': [1.5, 2.5, 3.5],
    's': ['a', 'b', 'c'],
    'b': [True, False, True]
})
print(df.dtypes)

# 转换类型
df['i'] = df['i'].astype('int32')
df['f'] = df['f'].astype('float32')
df['s'] = df['s'].astype('string')
print(df.dtypes)

# 推断更优类型（注意：可能改变语义，需检查）
df2 = df.convert_dtypes()
print(df2.dtypes)

# 查看内存
print(df.memory_usage(deep=True))
