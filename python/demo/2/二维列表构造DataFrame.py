# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 15:29:48 2025

@author: Jerrylzysss
"""
'''
用 Python 的二维列表构造一个 DataFrame，
它有 a、b 两列，三行数据。
其中 a 列值为 1、4、7，b 列值为 2、5、8，索引为 x、y、z。
'''
import pandas as pd
data=[[1,2],[4,5],[7,8]]
df=pd.DataFrame(data,index=['x','y','z'],columns=['a','b'])
print(df)

