# -*- coding: utf-8 -*-
"""
Created on Tue Jun 10 09:26:12 2025

@author: Jerrylzysss
"""

'''
有以下一个 DataFrame，增加一个 C 列，值为 A 列与 B 列表示时间的间隔秒数。
'''
import pandas as pd
import io

df=pd.read_csv('./时间两列间隔秒数.csv')
print(df)
