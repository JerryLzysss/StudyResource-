# -*- coding: utf-8 -*-
"""
Created on Thu May 15 11:46:59 2025

@author: Jerrylzysss
"""
# CSV（Comma-Separated Values，逗号分隔值，有时也称为字符分隔值，因为分隔字符也可以不是逗号）.
# 其文件以纯文本形式存储表格数据（数字和文本）。
import pandas as pd


# read_csv 读取csv文件
df = pd.read_csv('demo.csv',header=0)

'''pd.read
filepath_or_buffer	CSV 文件的路径或文件对象（支持 URL、文件路径、文件对象等）	必需参数
sep	定义字段分隔符，默认是逗号（,），可以改为其他字符，如制表符（\t）	','
header	指定行号作为列标题，默认为 0（表示第一行），或者设置为 None 没有标题	0
names	自定义列名，传入列名列表	None
index_col	用作行索引的列的列号或列名	None
usecols	读取指定的列，可以是列的名称或列的索引	None
dtype	强制将列转换为指定的数据类型	None
skiprows	跳过文件开头的指定行数，或者传入一个行号的列表	None
nrows	读取前 N 行数据	None
na_values	指定哪些值应视为缺失值（NaN）	None
skipfooter	跳过文件结尾的指定行数	0
encoding	文件的编码格式（如 utf-8，latin1 等）	None
'''
# 全部输出,不带to_string()那么只输出前面5行和末尾5行
print(df)
# to_csv 转化csv文件
dict_2=pd.DataFrame({'Title1':['a','b','c'],'Title2':['d','e','f'],'Title3':['g','h','i']})
csv=dict_2.to_csv('demoTransform.csv',header="Demo")
print(dict_2)
print(pd.read_csv('demoTransform.csv'))
'''
参数	说明	默认值
path_or_buffer	CSV 文件的路径或文件对象（支持文件路径、文件对象）	必需参数
sep	定义字段分隔符，默认是逗号（,），可以改为其他字符，如制表符（\t）	','
index	是否写入行索引，默认 True 表示写入索引	True
columns	指定写入的列，可以是列的名称列表	None
header	是否写入列名，默认 True 表示写入列名，设置为 False 表示不写列名	True
mode	写入文件的模式，默认是 w（写模式），可以设置为 a（追加模式）	'w'
encoding	文件的编码格式，如 utf-8，latin1 等	None
line_terminator	定义行结束符，默认为 \n	None
quoting	设置如何对文件中的数据进行引号处理（0-3，具体引用方式可查文档）	None
quotechar	设置用于引用的字符，默认为双引号 "	'"'
date_format	自定义日期格式，如果列包含日期数据，则可以使用此参数指定日期格式	None
doublequote	如果为 True，则在写入时会将包含引号的文本使用双引号括起来	True
'''