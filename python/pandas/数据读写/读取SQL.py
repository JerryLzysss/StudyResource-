# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 读取 SQL
'''
通过 SQLAlchemy 或 DBAPI2 连接数据库，将查询结果读成 DataFrame。
常用：pd.read_sql / read_sql_query / read_sql_table
写出：DataFrame.to_sql
'''
import sqlite3
import pandas as pd

# 使用内置 sqlite3 演示（无需额外安装数据库）
conn = sqlite3.connect(':memory:')
raw = pd.DataFrame({
    'id': [1, 2, 3],
    'site': ['Google', 'Baidu', 'Bing'],
    'score': [98, 95, 90]
})
raw.to_sql('sites', conn, index=False, if_exists='replace')

# read_sql：执行 SQL 语句
df = pd.read_sql('SELECT * FROM sites WHERE score >= 95', conn)
print(df)

# read_sql_query：明确表示是查询语句
df2 = pd.read_sql_query('SELECT site, score FROM sites ORDER BY score DESC', conn)
print(df2)

# read_sql_table：按表名读取整张表（需要 SQLAlchemy，sqlite 可用 read_sql 代替）
df3 = pd.read_sql('SELECT * FROM sites', conn)
print(df3)

conn.close()

'''常用参数
sql / table_name   SQL 语句或表名
con                数据库连接
index_col          用作行索引的列
coerce_float       是否尽量转为 float
params             SQL 参数
parse_dates        解析为日期的列
chunksize          分块读取行数
'''
