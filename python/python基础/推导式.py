# -*- coding: utf-8 -*-
"""
Created on Wed May 14 16:06:48 2025

@author: Jerrylzysss
"""
# 推导式 其作用相当于把数据序列中所需要的数据过滤出来
# 列表推导式
# 结构为:表达式 for 变量 in 列表 if 条件(if 条件这部分可以省略)
# 例如下述name表达式意思为name的结构，可以为name.upper()等等
# 变量表示遍历单位
# 列表也就是对应的列表
names=['Bob','Tom','Alice','Jerry','Wendy','Smith']
namesF=[name for name in names if len(name)>3]
print(namesF)
# 字典推导式
dictDemo=['Google','Taobao']
newdict={key:len(key) for key in dictDemo if len(key)>=7}
print(newdict)
dic={x:x**2 for x in (2,4,6)}
print(dic)
# 集合推导式
setNew={i**2 for i in (2,3,4)}
print(setNew)
# 两者区别在于字典和集合之间生成的最终效果不同
# 字典为x:x,集合为x
# 元组推导式
a=(x for x in range(1,10) if x>=3)
print(tuple(a))