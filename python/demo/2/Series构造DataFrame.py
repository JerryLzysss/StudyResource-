# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 15:46:25 2025

@author: Jerrylzysss
"""
'''
用 Series 构造一个 DataFrame，它有 a、b 两列，三行数据。
其中 a 列值为 1、4、7，b 列值为 2、5、8，索引为 x、y、z。
'''
import pandas as pd
a = pd.Series([1,4,7],index=['x','y','z'])
b = pd.Series([2,5,8],index=['x','y','z'])
df =pd.DataFrame({'a':a,'b':b})
print(df)