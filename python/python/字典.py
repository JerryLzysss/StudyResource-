# -*- coding: utf-8 -*-
"""
Created on Wed May 14 14:38:23 2025

@author: Jerrylzysss
"""
# 空字典
emptyDict={}
print(emptyDict)
print(type(emptyDict))
tinyDict={'name':'noob','Age':3}
print(tinyDict['name'])
tinyDict['name']='gg'
print(tinyDict['name'])
# 字典的特性为:不允许同一个键key出现两次
# UniqueDict={'name':'hello','name':'gg'}
# 键必须不可变,因此列表不可用
# constDict={['name']:'123'}