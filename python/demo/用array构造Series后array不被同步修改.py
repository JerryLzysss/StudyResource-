# -*- coding: utf-8 -*-
"""
Created on Thu Jun  5 14:45:24 2025

@author: Jerrylzysss
"""
'''
有一个名为 arr 的 NumPy array 对象，将它构造为 Series，然后修改 Series 第二个值为 66，
会发现 arr 的 6 也会被修改，如何构造 Series 才能让 arr 不被同步修改。
'''
import pandas as pd
import numpy as np
arr = np.array([3,6,9])

# Series添加属性copy=True
Series=pd.Series(arr,copy=True)
# Series = pd.Series(arr)
print("BeforeSeries",Series)
Series[1]=66
print("AfterSeries",Series)
print("arr",arr)
