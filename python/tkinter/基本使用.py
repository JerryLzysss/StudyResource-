# -*- coding: utf-8 -*-
"""
Created on Tue May 20 10:55:00 2025

@author: Jerrylzysss
"""
# 介绍
'''
Tkinter（即 tk interface，简称“Tk”）本质上是对 Tcl/Tk 软件包的 Python 接口封装，
它是 Python 官方推荐的 GUI 工具包，属于 Python 自带的标准库模块.
'''

# 查看版本
# cmd输入python -m tkinter
import tkinter as tk
# 主程序构造
root_window=tk.Tk()
# 设置标题
root_window.title('hello,world')

# 设置窗口大小宽X高
root_window.geometry('1024x768')
# 设置窗口的背景颜色(可以是常量/颜色16进制)
root_window["background"]="grey"
# 设置窗口的icon图标
root_window.iconbitmap('./favicon.ico')
# 添加文本设置前景色和背景色字体类型和大小
tx=tk.Label(root_window,text="hello",bg="green",fg="red",font=('Times',20,'bold italic'))
tx.pack()
# 添加按钮与文本，设置command
btn=tk.Button(root_window,text="关闭",command=root_window.quit)
btn.pack()
# 添加按钮
# 开启主循环显示窗口
root_window.mainloop()

# 独立运行tkinter
'''
将代码改为.pyw文件，并使用pythonw.exe来执行程序
'''