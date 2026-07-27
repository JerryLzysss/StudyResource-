# -*- coding: utf-8 -*-
"""
Created on Fri May 30 16:54:44 2025

@author: Jerrylzysss
"""
'''
以下有一个名为 ser 的 Series，需要将标签 a 对应的值修改为 11，标签 b 对应的值修改为 55
'''
import pandas as pd
series =pd.Series([1,3,5],index=['a','b','c'])
# update方法更新
d={'a':11,'c':55}
series.update(d)
print(series)
e=pd.Series([22,110],index=['a','c'])
series.update(e)
print(series)