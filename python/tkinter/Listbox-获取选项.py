# -*- coding: utf-8 -*-
"""
Created on Thu May 22 16:36:31 2025

@author: Jerrylzysss
"""
import tkinter as tk
from tkinter import messagebox

window = tk.Tk()

window.title("GetListBox")
window.geometry('400x180')

# 创建变量，用var1用来接收鼠标点击的具体选项内容
var1 = tk.StringVar()
l = tk.Label(window, bg='#B0B0B0', font=('微软雅黑', 15), width=20, textvariable=var1)
l.pack()

# 创建一个按钮的点击事件
def click_button():
    # 使用 curselection来选中文本
    try:
        val = lb.get(lb.curselection())
    # 设置label值
        var1.set(val)
    except Exception as e:
        e = '发现一个错误'
        messagebox.showwarning(e,'没有选择任何条目')

# 创建一个按钮并放置，点击按钮调用print_selection函数
b1 = tk.Button(window, text='获取当前选项', command=click_button)
b1.pack()


# 创建Listbox并为其添加内容
var2 = tk.StringVar()
var2.set(("C语言辅导班", "Python答疑辅导", "Java答疑辅导", "C++辅导"))
# 创建Listbox，通过 listvariable来传递变量
lb = tk.Listbox(window, listvariable=var2)
# 新建一个序列，然后将值循环添加到Listbox控件中
items = ["C", "Java", "Python", "C#", "Golang", "Runby"]
for i in items:
    lb.insert('end', i)  # 从最后一个位置开始加入值
lb.insert(0, '编程学习')  # 在第一个位置插入一段字符串
lb.delete(4)  # 删除第2个位置处的索引
lb.pack()

#主窗显示
window.mainloop()
