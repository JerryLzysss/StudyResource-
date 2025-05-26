# -*- coding: utf-8 -*-
"""
Created on Wed May 21 16:37:02 2025

@author: Jerrylzysss
"""
import tkinter as tk
from tkinter import Message
win = tk.Tk()
# 添加label
win.title("Label")
win.geometry('1080x720')
label = tk.Label(win,text="demo",font=('宋体',20,'bold italic'),bg="#7CCD7C",width=10,height=5,padx=20,pady=15,borderwidth=10,relief="sunken")
label.pack()
txt="hello,this is a test about the Python label and message."
msg=Message(win,text=txt,width=100,font=('微软雅黑',10,'bold'))
msg.pack(side="right")
win.mainloop()
# Message控件
'''
作用与Label类似，用来显示多行不可编辑的文本内容，但是可以自动分行
'''


# 属性与作用
'''
anchor:控制文本在label中显示的位置,用n,ne,e,se...形式来调整，默认为center居中.
bg:用来设置背景色
bd:用来指定label控件的边框宽度,单位默认为2个像素
bitmap:指定显示在Label空间上的位图，乳沟制定了image参数,该参数会被忽略
compound:控制label中文本和图像的混合模式,若选项设置为Center则显示在图像上,其他则在文本旁边
disableforeground:指定label为不可用状态时的前景色
font:指定label的文本元组参数格式
fg:用来设置前景色
height/width:设置宽度和高度
highlightbackground:没有获得焦点的时候高亮边框颜色
highlightcolor:获得焦点时高亮边框的颜色
image:指定label显示的图片
justify:多行文本的对齐方式
padx/pady:指定label水平和垂直方向的间距.
relief:指定边框样式,默认是flat.其他有groove,raised,ridge,solid,sunken...
state:参数用来指定label状态,默认为normal,可选的有active和disabled。
text:用来指定label显示的文本,可以包含换行符
underline:给指定的字符添加下划线
wraplength:将label显示的文本分行，参数指定每行长度，默认为0
'''
