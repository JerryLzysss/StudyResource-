# -*- coding: utf-8 -*-
"""
Created on Fri May 16 17:51:58 2025

@author: Jerrylzysss
"""
# try...catch...finally

import sys

try:
    f = open('myfile.txt')
    s = f.readline()
    i = int(s.strip())
except OSError as err:
    print("OS error: {0}".format(err))
except ValueError:
    print("Could not convert data to an integer.")
except:
    print("Unexpected error:", sys.exc_info()[0])
    raise # 抛出异常
finally:
    print("finish")

# 使用with 相当于try..catch..finally
with open("myfile.txt") as f:
    for line in f:
        print(line, end="")