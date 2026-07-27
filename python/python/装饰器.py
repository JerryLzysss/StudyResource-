# -*- coding: utf-8 -*-
"""
Created on Fri May 16 15:47:49 2025

@author: Jerrylzysss
"""

# 装饰器（decorators）是 Python 中的一种高级功能，它允许你动态地修改函数或类的行为。

# 应用场景
'''
日志记录: 装饰器可用于记录函数的调用信息、参数和返回值。
性能分析: 可以使用装饰器来测量函数的执行时间。
权限控制: 装饰器可用于限制对某些函数的访问权限。
缓存: 装饰器可用于实现函数结果的缓存，以提高性能。
'''

'''
@time_logger
def target_function():
    pass
其效果等同于:
def target_function():
    pass
target_function = time_logger(target_function)
'''
# 无参装饰器
def my_decorator(func):
    def wrapper():
        print("在原函数之前执行")
        func()
        print("在原函数之后执行")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")

say_hello()
# 有参装饰器
def my_decorator(func):
    def wrapper(*args, **kwargs):
        print("在原函数之前执行")
        func(*args, **kwargs)
        print("在原函数之后执行")
    return wrapper

@my_decorator
def greet(name):
    print(f"Hello, {name}!")

greet("Alice")

# 类装饰器
'''
@staticmethod: 将方法定义为静态方法，不需要实例化类即可调用。
@classmethod: 将方法定义为类方法，第一个参数是类本身（通常命名为 cls）。
@property: 将方法转换为属性，使其可以像属性一样访问。
'''
class MyClass:
    @staticmethod
    def static_method():
        print("This is a static method.")

    @classmethod
    def class_method(cls):
        print(f"This is a class method of {cls.__name__}.")

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

MyClass.static_method()
MyClass.class_method()

obj = MyClass()
obj.name = "Alice"
print(obj.name)
# 多个装饰器

def decorator1(func):
    def wrapper():
        print("Decorator 1")
        func()
    return wrapper

def decorator2(func):
    def wrapper():
        print("Decorator 2")
        func()
    return wrapper

@decorator1
@decorator2
def say_hello():
    print("Hello!")

say_hello()