# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 15:21:21 2025

@author: Jerrylzysss
"""

'''
本题需要传入标量来构造以下 Series：
只有一个值为 6 的 Series
标签为 a、b、c 三个值均为 6 的 Series
'''
import pandas as pd;
print(pd.Series(6))
print(pd.Series(6,index=['a','b','c']))

