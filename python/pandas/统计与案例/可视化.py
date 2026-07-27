# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 可视化（统计与案例）
'''
结合 Matplotlib 做基础图表；复杂图可用 Seaborn。
'''
import pandas as pd

df = pd.DataFrame({
    'category': ['A', 'B', 'C', 'D'],
    'sales': [120, 90, 150, 80],
    'profit': [30, 20, 45, 15]
})

df.set_index('category')[['sales', 'profit']].plot(kind='bar', title='Sales & Profit')
df.plot(kind='line', x='category', y='sales', marker='o', title='Sales Trend')
df['sales'].plot(kind='pie', labels=df['category'], autopct='%1.1f%%', title='Sales Share')

# import matplotlib.pyplot as plt
# plt.tight_layout()
# plt.show()
print(df)
