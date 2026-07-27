# -*- coding: utf-8 -*-
"""
Spyder 编辑器

这是一个临时脚本文件。
"""
# 正确的
age = 25
user_name = "Alice"
_total = 100
MAX_SIZE =1024
# 错误的
# 2nd_place ="silver" 以数字开头
# user-name ="Bob" 包含-字符
# class = "Math" 使用关键字class
# $price = 9.99 包含特殊字符$
# for ="loop" 关键字loop
def is_valid_identifer(name):
    try:
        exec(f"{name}=None")
        return True
    except:
        return False
print(is_valid_identifer("2var"))
# 关键字大全
import keyword
print(keyword.kwlist)
# 注释
# 单行注释:以#开头
# 多行注释:可以用多个#号，还有'''和"""
# 保留字
'''
True 布尔真值
False 布尔假值
None 空值或无值
and 逻辑与
or 逻辑或
not 逻辑非
if 条件判断
elif 条件判断
else 条件判断
for 迭代循环
while 条件循环
break 跳出循环
continue 跳过当前循环的剩余部分
try except finally 尝试捕获最终
raise 抛出
def 定义函数
return 返回
lambda 创建匿名函数
class 定义类
del 删除对象引用
import 从模块导入
from 导入特定部分
as 创建别名
global 声明全局
nonlocal 声明非局部
async/await 声明异步
assert 断言
in 检查成员关系
is 检查对象身份
pass 空语句
with上下文管理
yield 从生成器函数返回值
'''
# 多行语句
# 可以使用\来表承接上下
