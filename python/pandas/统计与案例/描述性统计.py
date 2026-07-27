# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 描述性统计
import pandas as pd

df = pd.DataFrame({
    'Score': [88, 92, 79, 85, 95, 70],
    'Age': [25, 30, 28, 22, 26, 40],
    'Dept': ['A', 'B', 'A', 'B', 'A', 'B']
})

print(df.describe())                 # 数值列五数概括等
print(df.describe(include='all'))    # 含非数值列
print(df['Score'].mean(), df['Score'].median(), df['Score'].mode())
print(df['Score'].var(), df['Score'].std())
print(df['Score'].min(), df['Score'].max(), df['Score'].quantile([0.25, 0.75]))
print(df['Dept'].value_counts())
print(df.groupby('Dept')['Score'].agg(['count', 'mean', 'std']))
