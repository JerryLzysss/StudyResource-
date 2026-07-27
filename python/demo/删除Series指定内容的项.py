# -*- coding: utf-8 -*-
"""
Created on Fri May 30 14:40:13 2025

@author: 13797
"""

'''
以下有一个名为 series 的 Series，需要修改以下内容：

修改索引标签为 a 的值为 111
修改第 2 个项的值为 222
修改值为 5 的值为 555
修改索引标签 c 为 ccc
'''
import pandas as pd
series = pd.Series([1,3,5],index=['a','b','c'])
# series.a = 111
# series['a']=111
series.loc['a']=111
series.iloc[1]=222
# series[series==5]=555
# series.replace({5:555},inplace=True)
series = series.replace({5:555})
series = series.rename(index={'c':'ccc'})
series.rename(index={'c':'ccc'},inplace=True)
print(series,series.index)
