# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 15:47:40 2025

@author: 13797
"""
'''
用 NumPy 的随机方法构造一个 DataFrame，要求 10 行 5 列，数值均为 1 到 20 的整型，
列标签为 a、b、c、d、e。
'''
import pandas as pd
import numpy as np
import string
np.random.seed(666)
df=pd.DataFrame(np.random.randint(1,21,size=[10,5]),columns=[*string.ascii_lowercase[:5]])
print(df)