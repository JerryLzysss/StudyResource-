# -*- coding: utf-8 -*-
"""
Created on Tue May 13 15:11:10 2025

@author: Jerrylzysss
"""
'''
以下有一个名为 series 的 Series，需要删除以下内容：
删除索引标签为 a 的项
删除值为 5 的项
'''
import pandas as pd
series =pd.Series([1,3,5],index=['a','b','c'])
# series.drop('a',inplace=True)
# series=series.drop('a')
series.pop('a')
# series.drop(series[series==5].index,inplace=True)
series=series.drop(series[series==5].index)
print(series)

