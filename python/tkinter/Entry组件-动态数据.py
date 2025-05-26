# -*- coding: utf-8 -*-
"""
Created on Thu May 22 14:17:01 2025

@author: Jerrylzysss
"""
'''

'''
import tkinter as tk
import time
window =tk.Tk()
window.title('Entry')
window.geometry('1080x720')
def gettime():
    dstr.set(time.strftime("%H:%M:%S"))
    window.after(1000,gettime)
# StringVar 动态数据类型
dstr=tk.StringVar()
lb=tk.Label(window,textvariable=dstr,fg='green',font=('微软雅黑',85))
lb.pack()
gettime()
window.mainloop()
'''
exportselection :默认情况，如果输入框选中文本会复制到粘贴板，忽略则需要使该参数为0
selectbackground:选中文字时的背景颜色
selectforeground:选中文字时的前景色
show:指定文本框内容以何种样式字符显示
textvariable:输入库那个内值，使用StringVar()设置动态,text设置为静态
xscrollcommand:设置输入框内容滚动
'''