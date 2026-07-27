# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# 介绍
'''
Pandas 数据读写：把外部数据读入 DataFrame / Series，或把内存中的数据写出到文件、数据库等。
常用格式：CSV、Excel、JSON、SQL、HTML、Parquet、Feather、HDF5 等。
CSV / Excel / JSON 入门示例见 ../教程/ 目录，其余格式见本目录其他文件。
参考：https://www.runoob.com/pandas/pandas-tutorial.html
'''
import pandas as pd

# 常见读写 API 一览
'''
读取：
  pd.read_csv / read_excel / read_json / read_html
  pd.read_sql / read_sql_query / read_sql_table
  pd.read_parquet / read_feather / read_hdf / read_pickle
写出：
  DataFrame.to_csv / to_excel / to_json / to_sql
  DataFrame.to_parquet / to_feather / to_hdf / to_pickle / to_html
'''

df = pd.DataFrame({
    'Name': ['Google', 'Runoob', 'Taobao'],
    'Age': [25, 30, 35]
})
print(df)
# 内存中快速预览
print(df.head())
print(df.info())
