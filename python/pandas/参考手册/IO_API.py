# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas Input/Output API 手册
'''
读写入口集中在 pandas 顶层函数与 DataFrame.to_* 方法。
'''
# 读取
'''
pd.read_csv / read_table / read_fwf
pd.read_excel / ExcelFile.parse
pd.read_json / read_html / read_xml
pd.read_sql / read_sql_query / read_sql_table
pd.read_parquet / read_feather / read_orc
pd.read_hdf / read_pickle / read_sas / read_spss / read_stata
'''

# 写出（DataFrame / Series）
'''
to_csv / to_excel / to_json / to_html / to_xml / to_markdown
to_sql / to_parquet / to_feather / to_orc
to_hdf / to_pickle / to_clipboard / to_latex / to_string
'''

import pandas as pd
df = pd.DataFrame({'x': [1, 2], 'y': [3, 4]})
print(df.to_string())
print('详见官方文档：https://pandas.pydata.org/docs/reference/io.html')
