# -*- coding: utf-8 -*-
"""
Created on Thu May 22 16:38:16 2025

@author: Jerrylzysss
"""

import tkinter
from tkinter import ttk # 导入ttk模块，下拉菜单控件位于ttk子模块中

# 创建窗口
win = tkinter.Tk()
win.title("ComboBox")
# win.geometry('400x200')
win.geometry('400x250')
win.resizable(0,0)
# 创建下拉菜单
cbox = ttk.Combobox(win)
# 使用 grid() 来控制控件的位置
cbox.grid(row = 1, sticky="NW")
# 设置下拉菜单中的值
cbox['value'] = ('C','C#','Go','Python','Java')

#通过 current() 设置下拉菜单选项的默认值
cbox.current(3)

# 编写回调函数，绑定执行事件,向文本插入选中文本
def func(event):
    text.insert('insert',cbox.get()+"\n")
# 绑定下拉菜单事件
cbox.bind("<<ComboboxSelected>>",func)
# 新建文本框
text = tkinter.Text(win)
# 布局
text.grid(pady = 5)
win.mainloop()