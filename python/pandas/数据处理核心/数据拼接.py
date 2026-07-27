# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据拼接（concat / join）
'''
concat：沿轴拼接多个对象
join：按索引对齐拼接列
'''
import pandas as pd

df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})
df3 = pd.DataFrame({'C': [9, 10]})

print(pd.concat([df1, df2], ignore_index=True))          # 纵向
print(pd.concat([df1, df3], axis=1))                     # 横向
print(pd.concat([df1, df2], keys=['part1', 'part2']))    # 多层索引

left = pd.DataFrame({'A': [1, 2, 3]}, index=['a', 'b', 'c'])
right = pd.DataFrame({'B': [4, 5]}, index=['a', 'c'])
print(left.join(right, how='left'))
