# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 相关性分析
'''
corr() 计算列之间的相关系数；常用 pearson / spearman / kendall。
'''
import pandas as pd

df = pd.DataFrame({
    'height': [170, 165, 180, 175, 160],
    'weight': [65, 55, 80, 70, 50],
    'score': [88, 92, 75, 85, 95]
})

print(df.corr())                      # 默认 pearson
print(df.corr(method='spearman'))     # 秩相关
print(df['height'].corr(df['weight']))  # 两列相关

# 协方差
print(df.cov())
