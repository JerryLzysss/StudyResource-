# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 高级功能（概览）
'''
常见进阶能力：管道 pipe、eval/query、样式 style、扩展数组、
分类类型、稀疏数据、多级索引、时间序列等。
'''
import pandas as pd

df = pd.DataFrame({
    'A': [1, 2, 3, 4],
    'B': [10, 20, 30, 40],
    'C': ['x', 'y', 'x', 'z']
})

# query：用表达式筛选
print(df.query('A >= 2 and B < 40'))

# eval：用表达式计算列
df = df.eval('D = A * B')
print(df)

# pipe：把自定义处理串成管道
def add_flag(frame):
    frame = frame.copy()
    frame['flag'] = frame['A'] > 2
    return frame

print(df.pipe(add_flag))

# style：输出带样式的表格（Notebook 中更直观）
styled = df.style.highlight_max(subset=['A', 'B'])
print(styled)  # 终端中主要看到 Styler 对象
