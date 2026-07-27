# -*- coding: utf-8 -*-
"""
Created on Fri May 16 16:12:28 2025

@author: Jerrylzysss
"""

# Python 中的模块（Module）是一个包含 Python 定义和语句的文件.
# 文件名就是模块名加上 .py 后缀。

# 作用
'''
代码复用：将常用的功能封装到模块中，可以在多个程序中重复使用。
命名空间管理：模块可以避免命名冲突，不同模块中的同名函数或变量不会互相干扰。
代码组织：将代码按功能划分到不同的模块中，使程序结构更清晰。
'''

# 模块的搜索路径
'''
1.当前目录
2.环境变量PYTHONPATH指定的目录
3.Python标准库目录
4..pth文件指定的目录
'''
import moduleTest
import sys
for i in sys.argv:
    print(i)
moduleTest.print_func()
# from ... import 表示从模块中导入一个指定的部分.
# as .. 表示别名，使用的时候就用as代替
from fibo import fib,fib2 as fb
# import * 表示引入一个模块的所有项目(容易产生命名冲突)
from fibo import *

