# -*- coding: utf-8 -*-
"""
Created on Fri May 16 16:48:11 2025

@author:Jerrylzysss
"""

# open() 用于打开一个文件，并返回文件对象
'''
注意:文件需要被打开，否则会抛出OSError
open()方法一定要保证关闭文件对象即调用close()
'''
# 构造
'''
open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)
参数说明:

file: 必需，文件路径（相对或者绝对路径）。
mode: 可选，文件打开模式
buffering: 设置缓冲
encoding: 一般使用utf8
errors: 报错级别
newline: 区分换行符
closefd: 传入的file参数类型
opener: 设置自定义开启器，开启器的返回值必须是一个打开的文件描述符。
'''
f=open("file.txt","r+")
str=f.read()
f.write("Hello,world!")

print("str",str)
f.close()