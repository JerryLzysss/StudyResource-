# -*- coding: utf-8 -*-
"""
Created on Mon May 19 16:17:43 2025

@author: Jerrylzysss
"""

# 三种命名空间
'''
built-in names 内置名称，例如函数abs,char和异常Exception等等
global names 模块定义名称,记录模块变量,包括函数/类/和其他导入的模块.
local names 函数定义名称,记录函数变量,包括函数参数和局部定义的变量.
注意:
    搜索顺序为局部->全局->内置
    如果搜索不到变量将抛出NameError.
    因此又由于命名空间的生命周期取决于对象作用域,如果对象执行完成，则命名空间的生命周期结束.
    无法从外部命名空间访问内部命名空间的对象.
'''
# 作用域
'''
作用域就是一个 Python 程序可以直接访问命名空间的正文区域。
L（Local）：最内层，包含局部变量，比如一个函数/方法内部。
E（Enclosing）：包含了非局部(non-local)也非全局(non-global)的变量。比如两个嵌套函数，一个函数（或类） A 里面又包含了一个函数 B ，那么对于 B 中的名称来说 A 中的作用域就为 nonlocal。
G（Global）：当前脚本的最外层，比如当前模块的全局变量。
B（Built-in）： 包含了内建的变量/关键字等，最后被搜索。
LEGB 规则（Local, Enclosing, Global, Built-in）：Python 查找变量时的顺序是： L –> E –> G –> B。
Local：当前函数的局部作用域。
Enclosing：包含当前函数的外部函数的作用域（如果有嵌套函数）。
Global：当前模块的全局作用域。
Built-in：Python 内置的作用域。
'''

# global 和 nonlocal

# 通过global可以实现在内部修改外部值的效果
num = 1
def fun1():
    global num  # 需要使用 global 关键字声明
    print(num) 
    num = 123
    print(num)
fun1()
print(num)
# 通过nonlocal可以实现修改嵌套作用域中外部值的效果.
def outer():
    num2 = 10
    def inner():
        nonlocal num2   # nonlocal关键字声明
        num2 = 100
        print(num2)
    inner()
    print(num2)
outer()