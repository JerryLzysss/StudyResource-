# -*- coding: utf-8 -*-
"""
Created on Thu May 15 10:19:45 2025

@author: Jerrylzysss
"""

import pandas as pd
lists = pd.Series([1,2,3,4],index=[1,2,3,4],name='Test')
lists_2 = pd.Series(['1','hello','gg'])
# index 获取索引
print(lists.index)
# values 获取值
print(lists.values)
# head(n) 头部 N 行
print(lists.head(5))
# tail(n) 尾部 N 行
print(lists.tail(1))
# dtype 查看数据类型
print("dtype",lists.dtype,lists_2.dtype)
# shape 返回形状（元素个数）
print(lists.shape)

