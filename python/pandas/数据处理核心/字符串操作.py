# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 字符串操作
'''
通过 Series.str 访问向量化字符串方法。
'''
import pandas as pd

s = pd.Series(['  Hello ', 'Pandas', 'Runoob.com', 'AI-2024', None])

print(s.str.lower())
print(s.str.upper())
print(s.str.strip())
print(s.str.len())
print(s.str.replace('o', '0', regex=False))
print(s.str.contains('oo', na=False))
print(s.str.startswith('P', na=False))
print(s.str.split('.'))
print(s.str.extract(r'(\d+)'))
print(s.str.slice(0, 3))
