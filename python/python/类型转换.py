# -*- coding: utf-8 -*-
"""
Created on Tue May 13 15:01:44 2025

@author: Jerrylzysss
"""

# 类型转换 小->大
num_int = 10
num_float = 3.12
num_final=num_int+num_float
print(num_final,type(num_final))
# str_final=num_int+"123" 
# print(str_final) string不支持整数类型转换
# 显式类型转换
print(int(1),int(2.8),int("3"))
print(float(1),float(2.8),float("4.2"))