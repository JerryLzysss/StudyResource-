# -*- coding: utf-8 -*-
"""
Created on Wed May 14 09:43:40 2025

@author: Jerrylzysss
"""

var1 = 'helloWorld!'
var2 = 'Runnoob'
print(var1[0])
print(var2[1:5])
# 转义字符
'''
\ 续行符
\\反斜杠
\'单引号
\"双引号
\a响铃
\b退格
\000空
\n换行
\v纵向制表符
\t横向制表符
\r回车
\f换页
\R百分比进度
'''
# 字符串格式化
print("%s %d"%('小明',10))
# 与C一样可以通过格式化符号来获取
'''
%c 格式化字符及其ASCII
%s 格式化字符串
%d 格式化整数
%u 格式化无符号整型
%o 格式化无符号八进制
%x 格式化无符号十六进制
%f 格式化浮点数
%e 科学计数法格式化浮点数
%p 十六进制格式化地址
