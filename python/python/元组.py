# -*- coding: utf-8 -*-
"""
Created on Wed May 14 14:32:34 2025

@author: jerrylzysss
"""
# 只包含一个元素需要添加,
num1=(1)
tup1=(1,)
tup2=(1,2,3,4)
print(type(num1),type(tup1),type(tup2))
# 元组中的内容不可以变化，指的是只想内存的内容不可变。
# 但是可以整体赋值,通过这种方式之后的元组指向内存发生改变
tup=('r','s','q')
print("before",tup,id(tup))
tup=(1,2,3)
print("after",tup,id(tup))
