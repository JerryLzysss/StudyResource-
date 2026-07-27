# -*- coding: utf-8 -*-
"""
Created on Fri May 16 16:34:44 2025

@author: Jerrylzysss
"""

# 输出值
'''
1.表达式语句
2.print()函数
3.write()方法
'''
# 输出形式 str.format()
# 转字符串
'''
str():字符串形式
repr():解释器形式
'''
s="hello,World\n"
print(str(s),repr(s))
print('hello:{name}'.format(name=s))
# % 操作符
import math
print('PI:%5.3f' % math.pi)
# input 读取键盘输入
str = input('请输入:')
print('您输入的内容是:',str)