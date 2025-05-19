# -*- coding: utf-8 -*-
"""
Created on Wed May 14 17:39:47 2025

@author: Jerrylzysss
"""

def maxn(a,b):
    if a > b:
        return a
    else:
        return b
print(maxn(3,5))
# 参数传递

# 可变:list,dict.
# 不可变:string,tuple,number.
# 不可变赋值 a=5 再赋值 a=10,实际上是生成一个新对象，再指向.而5被抛弃
# 可变赋值 a=[1,2,3,4]再赋值a[2]=2.本身列表没有被重新生成，只是对某个索引进行修改.

# 参数类型

# 必须参数
# def ptime(str) str必须传递
# 关键字参数
# def ptime(str) ptime(str="123") 可以根据关键字进行定位
# 默认参数
# def ptime(name,age=35) 允许提供参数然后重新赋值
# 不定长参数
# def ptime(arg1,*arg) 此处第一个参数对应arg1,而其他参数则以元组的形式存储在arg.
# arg的长度可以为0-inf
# def ptime(arg1,**arg) 此处arg将会以字典形式导入.
# 例如ptime(1,a=2,b=3)=>1,{'a':2,'b':3}