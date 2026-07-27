# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 15:36:17 2025

@author: Jerrylzysss
"""

'''
用数据类 dataclasses 构造一个 DataFrame，它有 a、b 两列，三行数据。
其中 a 列值为 1、4、7，b 列值为 2、5、8，索引为 x、y、z。
'''
import pandas as pd
from dataclasses import make_dataclass
Point =make_dataclass('Point',[('a',int),('b',int)])
df=pd.DataFrame([Point(1,2),Point(4,5),Point(7,8)],index=['x','y','z'])
print(df)