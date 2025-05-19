# -*- coding: utf-8 -*-
"""
Created on Thu May 15 09:34:41 2025

@author: Jerrylzysss
"""

# 介绍
"""
Series 是 Pandas 中的一个核心数据结构，类似于一个一维的数组，具有数据和索引。
Series 可以存储任何数据类型（整数、浮点数、字符串等），并通过标签（索引）来访问元素。
Series 的数据结构是非常有用的，因为它可以处理各种数据类型，同时保持了高效的数据操作能力，比如可以通过标签来快速访问和操作数据。
"""
import pandas as pd
# Series 构造
"""
基本构造
pandas.Series(data=None, index=None, dtype=None, name=None, copy=False, fastpath=False)
data：Series 的数据部分，可以是列表、数组、字典、标量值等。如果不提供此参数，则创建一个空的 Series。
index：Series 的索引部分，用于对数据进行标记。可以是列表、数组、索引对象等。如果不提供此参数，则创建一个默认的整数索引。
dtype：指定 Series 的数据类型。可以是 NumPy 的数据类型，例如 np.int64、np.float64 等。如果不提供此参数，则根据数据自动推断数据类型。
name：Series 的名称，用于标识 Series 对象。如果提供了此参数，则创建的 Series 对象将具有指定的名称。
copy：是否复制数据。默认为 False，表示不复制数据。如果设置为 True，则复制输入的数据。
fastpath：是否启用快速路径。默认为 False。启用快速路径可能会在某些情况下提高性能。
"""
series=pd.Series([1,2,3,4],name='A')
cutom_series=pd.Series([1,2,3,4],index=[3,4,5,6],name='B')
print(series)
# 允许通过字典取值
sites={1:"Google",2:"Running"}
dict_trans=pd.Series(sites,name='C')
transcute_dict=pd.Series(sites,index=[1])
print(sites)
print(sites[1])
print(transcute_dict)

# 方法
series=pd.Series([1,2,3,4,5,6,7,8,9,10])

