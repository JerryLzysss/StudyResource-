# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas Parquet / Feather
'''
列式存储格式，读写快、体积小，适合大数据分析中间结果。
Parquet：跨语言通用，压缩好；需要 pyarrow 或 fastparquet。
Feather：读写极快，适合 Python/R 临时交换；需要 pyarrow。
安装：pip install pyarrow
'''
import pandas as pd

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 35],
    'Score': [88.5, 92.0, 79.5]
})

try:
    df.to_parquet('demo.parquet', index=False)
    print(pd.read_parquet('demo.parquet'))

    df.to_feather('demo.feather')
    print(pd.read_feather('demo.feather'))
except ImportError:
    print('需要安装 pyarrow：pip install pyarrow')

'''常用参数（to_parquet / read_parquet）
path / path_or_buf   文件路径
engine               'pyarrow' 或 'fastparquet'
compression          snappy / gzip / brotli / None
columns              只读指定列（read）
'''
