# -*- coding: utf-8 -*-
"""
Created on Wed May 14 16:57:45 2025

@author: Jerrylzysss
"""
# 迭代器
list=[1,2,3]
it = iter(list)
print(next(it))
print(next(it))
list_point =[2,3,4,5,6]
'''
import sys
while it:
    try:
        print(next(it))
    except StopIteration:
       sys.exit()
'''
# 生成器
# 通过yield可以将值进行分步处理，此时函数执行暂停
# 通过for和while可以逐步产生值，不需要一次性计算返回所有结果
def countdown(n):
    while n > 0:
        yield n
        n-=1
generator = countdown(5)
print(next(generator))
print(next(generator))
for value in generator:
    print(value)