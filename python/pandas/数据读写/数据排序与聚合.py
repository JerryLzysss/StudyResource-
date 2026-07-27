# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据排序与聚合
'''
排序：sort_values / sort_index
聚合：agg / aggregate，常与 groupby 配合
'''
import pandas as pd

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Dept': ['A', 'B', 'A', 'B'],
    'Score': [88, 92, 79, 85],
    'Age': [25, 30, 28, 22]
})

# 排序
print(df.sort_values('Score', ascending=False))
print(df.sort_values(['Dept', 'Score'], ascending=[True, False]))
print(df.sort_index(ascending=False))

# 聚合
print(df.agg({'Score': ['mean', 'max'], 'Age': 'min'}))
print(df.groupby('Dept').agg(avg_score=('Score', 'mean'), max_age=('Age', 'max')))
