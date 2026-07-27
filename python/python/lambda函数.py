# -*- coding: utf-8 -*-
"""
Created on Wed May 14 17:53:41 2025

@author: jerrylzysss
"""

# lambda函数是匿名的，没有函数名称，只能通过赋值给变量或作为参数传递

f=lambda:"Hello,world!"
print(f())
f_2=lambda a,b,c:a+b+c
print(f_2(1,3,5))