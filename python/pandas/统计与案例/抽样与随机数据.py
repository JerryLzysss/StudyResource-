# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 抽样与随机数据
import pandas as pd
import numpy as np

df = pd.DataFrame({
    'id': range(1, 11),
    'value': np.arange(10, 20)
})

print(df.sample(n=3, random_state=42))           # 随机抽 3 行
print(df.sample(frac=0.3, random_state=42))      # 抽 30%
print(df.sample(n=5, replace=True, random_state=1))  # 有放回

# 按权重抽样
weights = [0.05] * 9 + [0.55]
print(df.sample(n=3, weights=weights, random_state=0))

# 生成随机 DataFrame
rng = np.random.default_rng(0)
rand_df = pd.DataFrame(rng.normal(size=(5, 3)), columns=list('ABC'))
print(rand_df)
