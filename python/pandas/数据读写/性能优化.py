# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 性能优化
'''
参考：https://www.runoob.com/pandas/pandas-optimization.html
要点：合适 dtype、向量化、合理索引、分块读取、避免链式赋值等。
'''
import pandas as pd

# 1. 使用更小的数值类型
df = pd.DataFrame({'A': [100, 200, 300, 400], 'B': [1000, 2000, 3000, 4000]})
df['A'] = df['A'].astype('int16')
df['B'] = df['B'].astype('int32')
print(df.dtypes)

# 2. 重复字符串用 category 省内存
df2 = pd.DataFrame({'Category': ['A', 'B', 'A', 'C', 'B', 'A']})
df2['Category'] = df2['Category'].astype('category')
print(df2.dtypes)

# 3. 向量化代替循环
df3 = pd.DataFrame({'A': [1, 2, 3, 4], 'B': [5, 6, 7, 8]})
df3['C'] = df3['A'] + df3['B']
print(df3)

# 4. apply / map（比纯 Python 循环更好，但仍不如纯向量化）
df3['D'] = df3['A'].map(lambda x: x ** 2)
# 逐元素：新版用 DataFrame.map，旧版用 applymap
try:
    df3 = df3.map(lambda x: x * 10)
except Exception:
    df3 = df3.applymap(lambda x: x * 10)
print(df3)

# 5. 合适索引加速查找
df4 = pd.DataFrame({'A': [1, 2, 3, 4], 'B': [5, 6, 7, 8]})
df4 = df4.set_index('A')
print(df4.loc[2])

# 6. 分块读取大 CSV
# for chunk in pd.read_csv('large_file.csv', chunksize=10000):
#     process(chunk)

# 7. 避免链式赋值，改用 loc
df5 = pd.DataFrame({'A': [1, 2, 3, 4]})
# 不推荐：df5['A'][df5['A'] > 2] = 0
df5.loc[df5['A'] > 2, 'A'] = 0
print(df5)

# 8. 合并时明确 on / how
df_a = pd.DataFrame({'ID': [1, 2, 3], 'Value': ['A', 'B', 'C']})
df_b = pd.DataFrame({'ID': [1, 2, 3], 'Value': ['X', 'Y', 'Z']})
print(pd.merge(df_a, df_b, on='ID', how='inner'))
