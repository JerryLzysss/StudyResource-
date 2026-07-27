# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据可视化（基于 DataFrame.plot）
'''
DataFrame.plot 底层依赖 Matplotlib。
更复杂图表可用 matplotlib / seaborn 直接绘制。
'''
import pandas as pd

df = pd.DataFrame({
    'Month': [1, 2, 3, 4, 5, 6],
    'Sales': [120, 150, 130, 180, 200, 190],
    'Cost': [80, 90, 85, 100, 110, 105]
})
df = df.set_index('Month')

# 折线图
ax = df.plot(kind='line', title='Sales vs Cost')
# 柱状图
df.plot(kind='bar', title='Bar Chart')
# 散点图
df.plot(kind='scatter', x='Sales', y='Cost', title='Scatter')
# 直方图
df['Sales'].plot(kind='hist', bins=5, title='Sales Hist')

# 在支持 GUI 的环境中取消下一行注释以显示
# import matplotlib.pyplot as plt
# plt.show()
print(df)
