# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 过滤与条件查询
'''
布尔索引、isin、query、between、字符串条件等。
'''
import pandas as pd

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie', 'David', 'Eva'],
    'Age': [25, 30, 35, 28, 22],
    'Dept': ['A', 'B', 'A', 'B', 'A'],
    'Score': [88, 92, 79, 85, 95]
})

print(df[df['Score'] >= 90])
print(df[(df['Age'] > 25) & (df['Dept'] == 'A')])
print(df[df['Dept'].isin(['A', 'C'])])
print(df[df['Score'].between(80, 90)])
print(df.query('Age >= 28 and Score > 80'))
print(df[df['Name'].str.startswith('A')])
