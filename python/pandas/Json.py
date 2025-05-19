# -*- coding: utf-8 -*-
"""
Created on Fri May 16 11:11:16 2025

@author: Jerrylzysss
"""
# pd.read_json() - 读取 JSON 数据
import pandas as pd
df=pd.read_json('demo.json')
'''
df = pd.read_json(
    path_or_buffer="demo.json",      # JSON 文件路径、JSON 字符串或 URL
    orient=None,         # JSON 数据的结构方式，默认是 'columns'
    dtype=None,          # 强制指定列的数据类型
    convert_axes=True,   # 是否转换行列索引
    convert_dates=True,  # 是否将日期解析为日期类型
    keep_default_na=True # 是否保留默认的缺失值标记
)
'''
# to_string返回DataFrame类型数据，也可以用来直接处理JSON
print(df.to_string())

# DataFrame转换为JSON
'''
df.to_json(
    path_or_buffer=None,    # 输出的文件路径或文件对象，如果是 None 则返回 JSON 字符串
    orient=None,            # JSON 格式方式，支持 'split', 'records', 'index', 'columns', 'values'
    date_format=None,       # 日期格式，支持 'epoch', 'iso'
    default_handler=None,   # 自定义非标准类型的处理函数
    lines=False,            # 是否将每行数据作为一行（适用于 'records' 或 'split'）
    encoding='utf-8'        # 编码格式
)
'''
df_2 = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 35],
    'City': ['New York', 'Los Angeles', 'Chicago']
  })
json_str=df_2.to_json()
print(json_str)