# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据重塑
'''
透视：pivot / pivot_table
长短表：melt
行列互换：stack / unstack / T
'''
import pandas as pd

df = pd.DataFrame({
    'date': ['2024-01', '2024-01', '2024-02', '2024-02'],
    'city': ['BJ', 'SH', 'BJ', 'SH'],
    'sales': [100, 120, 110, 130]
})

print(df.pivot(index='date', columns='city', values='sales'))
print(pd.pivot_table(df, index='date', columns='city', values='sales', aggfunc='sum'))

wide = df.pivot(index='date', columns='city', values='sales').reset_index()
print(wide.melt(id_vars='date', var_name='city', value_name='sales'))

stacked = df.set_index(['date', 'city'])
print(stacked.unstack())
print(stacked.unstack().stack())
print(df[['sales']].T)
