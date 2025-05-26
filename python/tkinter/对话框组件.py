# -*- coding: utf-8 -*-
"""
Created on Mon May 26 16:38:20 2025

@author: Jerrylzysss
"""

# fileDialog:文件选择对话框
'''
from tkinter import *
import tkinter.filedialog
def askfile():
    filename=tkinter.filedialog.askopenfilename()
    if filename !='':
        lb.config(text=filename)
    else:
        lb.config(text='none')
root=Tk()
root.config(bg='#87CEEB')
root.title('FileDialog')
root.geometry('1080x720')
btn=Button(root,text='选择文件',command=askfile)
btn.grid(row=0,column=0)
lb=Label(root,text='',bg='#87CEEB')
lb.grid(row=0,column=1,padx=5)
root.mainloop()
'''
'''
参数
Open()	打开个某个文件
SaveAs()	打开一个保存文件的对话框
askopenfilename()	打开某个文件，并以包函文件名的路径作为返回值
askopenfilenames()	同时打开多个文件，并以元组形式返回多个文件名
askopenfile()	打开文件，并返回文件流对象
askopenfiles()	打开多个文件，并以列表形式返回多个文件流对象
asksaveasfilename()	选择以什么文件名保存文件，并返回文件名
asksaveasfile()	选择以什么类型保存文件，并返回文件流对象
askdirectory	选择目录，并返回目录名
参数值
defaultextension	指定文件的后缀名，当保存文件时自动添加文件名，如果自动添加了文件的后缀名，则该选项值不会生效
filetypes	指定筛选文件类型的下拉菜单选项，该选项值是由 2 元祖构成的列表，其中每个二元祖由两部分组成 (类型名,后缀)，比如 filetypes = [("PNG","*.png"), ("JPG", "*.jpg"), ("GIF","*.gif"),("文本文件","*.txt")...] 
initialdir	指定打开/保存文件的默认路径，默认路径是当前文件夹
parent	 如果不指定该选项，那么对话框默认显示在根窗口上，通过设置该参数可以使得对话框显示在子窗口上
title	指定文件对话框的标题
'''
# colorchooser:颜色面板，允许用户选择所需要的颜色，返回二元组(RGB颜色值,16进制颜色值)
'''
import tkinter as tk
from tkinter import colorchooser
root = tk.Tk()
root.title('颜色选择')
root.geometry('1080x720')
def callback():
    colorvalue=tk.colorchooser.askcolor()
    lb.config(text='颜色值'+str(colorvalue))
lb=tk.Label(root,text='',font=('宋体',10))
lb.pack()
tk.Button(root,text='点击选择颜色',command=callback,width=10,bg='#9AC0CD').pack()
root.mainloop()
'''
'''
方法
askcolor()	打开一个颜色对话框，并将用户选择的颜色值以元组的形式返回（没选择返回None），格式为((R, G, B), "#rrggbb")
Chooser()	打开一个颜色对话框，并用户选择颜色确定后，返回一个二元组，格式为（(R, G, B), "#rrggbb"）
属性	
default	要显示的初始的颜色，默认颜色是浅灰色（light gray）
title	指定颜色选择器标题栏的文本，默认标题为“颜色”
parent	1. 如果不指定该选项，那么对话框默认显示在根窗口上
        2. 如果想要将对话框显示在子窗口上，那么可以设置 parent = 子窗口对象
'''
# messagebox:信息对话框,主要起到信息提示、警告、说明、询问等作用，通常配合“事件函数”一起使用.
'''
import tkinter.messagebox
result=tkinter.messagebox.askokcancel('提示','你确定关闭窗口吗?')
print(result)
'''
'''
方法
askokcancel(title=None, message=None)	打开一个“确定／取消”的对话框
askquestion(title=None, message=None)	打开一个“是／否”的对话框。
askretrycancel(title=None, message=None)	打开一个“重试／取消”的对话框
askyesno(title=None, message=None)	打开一个“是／否”的对话框
showerror(title=None, message=None)	打开一个错误提示对话框
showinfo(title=None, message=None)	打开一个信息提示对话框
showwarning(title=None, message=None)	打开一个警告提示对话框
属性
default	1. 设置默认的按钮（也就是按下回车响应的那个按钮）
2. 默认是第一个按钮（像“确定”，“是”或“重试”）
3. 可以设置的值根据对话框函数的不同，可以选择 CANCEL，IGNORE，OK，NO，RETRY 或 YES
icon	1. 指定对话框显示的图标
2. 可以指定的值有：ERROR，INFO，QUESTION 或 WARNING
3. 注意：不能指定自己的图标
parent	1. 如果不指定该选项，那么对话框默认显示在根窗口上
2. 如果想要将对话框显示在子窗口上，那么可以设置 parent= 子窗口对象
'''
