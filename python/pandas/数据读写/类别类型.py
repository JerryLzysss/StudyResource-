# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 类别类型（category）
'''
重复值多的字符串列转 category，用整数码表示类别，节省内存并加速分组。
'''
import pandas as pd

df = pd.DataFrame({
    'city': ['北京', '上海', '北京', '广州', '上海', '北京'],
    'sales': [100, 120, 90, 80, 110, 95]
})

df['city'] = df['city'].astype('category')
print(df.dtypes)
print(df['city'].cat.categories)
print(df['city'].cat.codes)

# 有序类别
size = pd.Series(['M', 'S', 'L', 'M'], dtype='category')
size = size.cat.set_categories(['S', 'M', 'L'], ordered=True)
print(size)
print(size.min(), size.max())

# 增删类别
df['city'] = df['city'].cat.add_categories(['深圳'])
df['city'] = df['city'].cat.remove_unused_categories()
print(df['city'].cat.categories)
