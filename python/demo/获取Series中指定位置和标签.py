# -*- coding: utf-8 -*-
"""
Created on Wed May 28 17:02:58 2025

@author: Jerrylzysss
"""
'''
以下有一个名为 ser 的 Series，需要检测（成员检测 in 操作）：

数字 5 是否在这个 Series 的值中
字符串 d 是否在 这个 Series 的标签中
'''
import pandas as pd
series =pd.Series([1,3,5],index=['a','b','c'])
