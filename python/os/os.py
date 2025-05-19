# -*- coding: utf-8 -*-
"""
Created on Fri May 16 17:46:32 2025

@author: Jerrylzysss
"""

import os
# 获取当前目录
cur_dir=os.getcwd()
print("当前目录为:",cur_dir)
# 改变当前目录
' os.chdir("目录") '
# 列出目录内容
file_dir=os.listdir()
print("目录内容:",file_dir)
# 创建目录
'os.mkdir()'
# 删除目录
'os.rmdir(path)'
# 删除文件
'os.remove(file)'
# 重命名文件或目录
'os.rename("oldname","newname")'
# 获取环境变量
home_dir=os.getenv("HOME")
print("环境目录:",home_dir)
# 执行系统命令
'os.system("ls -l")'