# -*- coding: utf-8 -*-
"""
Created on Mon May 26 15:45:49 2025

@author: Jerrylzysss
"""

# Pack:按照控件添加顺序进行排列,灵活性较差
'''
from tkinter import *
win=Tk()
win.title('Pack')
lb_red=Label(win,text="红色",bg="Red")
lb_red.pack()
lb_blue=Label(win,text="蓝色",bg="blue")
lb_blue.pack(fill=X,pady='5px')
lb_green=Label(win,text="绿色",bg="green")
lb_green.pack(side='left',expand=1,fill='both')
win.mainloop()
'''
'''
参数
anchor	组件在窗口中的对齐方式，有 9 个方位参数值，比如"n"/"w"/"s"/"e"/"ne"，以及 "center" 等（这里的 e w s n分别代表，东西南北）
expand	是否可扩展窗口，参数值为 True（扩展）或者 False（不扩展），默认为 False，若设置为 True，则控件的位置始终位于窗口的中央位置
fill	参数值为 X/Y/BOTH/NONE，表示允许控件在水平/垂直/同时在两个方向上进行拉伸，比如当 fill = X 时，控件会占满水平方向上的所有剩余的空间。
ipadx,ipady	需要与 fill 参数值共同使用，表示组件与内容和组件边框的距离（内边距），比如文本内容和组件边框的距离，单位为像素(p)，或者厘米(c)、英寸(i)
padx,pady	用于控制组件之间的上下、左右的距离（外边距），单位为像素(p)，或者厘米(c)、英寸(i)
side	组件放置在窗口的哪个位置上，参数值 'top','bottom','left','right'。注意，单词小写时需要使用字符串格式，若为大写单词则不必使用字符串格式
'''

# grid: grid() 函数是一种基于网格式的布局管理方法，相当于把窗口看成了一张由行和列组成的表格。
# 当使用该 grid 函数进行布局的时，表格内的每个单元格都可以放置一个控件,从而实现对界面的布局管理。
'''
from tkinter import *
win=Tk()
win.config(bg='#87CEEB')
win.title('Grid')
win.geometry('1080x720')
for i in range(10):
    for j in range(10):
        Button(win,text=str(i)+","+str(j)+" ",bg='#D1EEEE').grid(row=i,column=j)
win.mainloop()
'''
'''
参数
column	控件位于表格中的第几列，窗体最左边的为起始列，默认为第 0 列
columnsapn	控件实例所跨的列数，默认为 1 列，通过该参数可以合并一行中多个领近单元格。
ipadx,ipady	用于控制内边距，在单元格内部，左右、上下方向上填充指定大小的空间。
padx,pady	用于控制外边距，在单元格外部，左右、上下方向上填充指定大小的空间。
row	控件位于表格中的第几行，窗体最上面为起始行，默认为第 0 行
rowspan	控件实例所跨的行数，默认为 1 行，通过该参数可以合并一列中多个领近单元格。
sticky	该属性用来设置控件位于单元格那个方位上，参数值和 anchor 相同，若不设置该参数则控件在单元格内居中
'''

# Place:指定空间在窗口内的绝对位置或者相对位置
from tkinter import *
win = Tk()
win.title('Place')
frame = Frame(win,relief='sunken',borderwidth=2,width=450,height=250)
frame.pack(side='top',fill='both',expand=1)
Label1 = Label(frame,text="位置1",bg="blue")
Label1.place(x=40,y=40,width=60,height=30)
Label2 = Label(frame,text="位置2",bg="purple")
Label2.place(x=180,y=80,anchor='ne',width=60,height=30)
Label3 = Label(frame,text="位置3",bg="red")
Label3.place(relx=0.6,y=80,width=60,height=30)
Label4 = Label(frame,text="位置4",bg="green")
Label4.place(relx=0.01,y=80,relheight=0.4,width=80)
win.mainloop()
'''
参数
anchor	       定义控件在窗体内的方位，参数值N/NE/E/SE/S/SW/W/NW 或 CENTER，默认值是 NW
bordermode	   定义控件的坐标是否要考虑边界的宽度，参数值为 OUTSIDE（排除边界） 或 INSIDE（包含边界），默认值 INSIDE。
                x、y	定义控件在根窗体中水平和垂直方向上的起始绝对位置
relx、rely	    1. 定义控件相对于根窗口（或其他控件）在水平和垂直方向上的相对位置（即位移比例），取值范围再 0.0~1.0 之间
                2. 可设置 in_ 参数项，相对于某个其他控件的位置
height、width	控件自身的高度和宽度（单位为像素）
relheight、relwidth	控件高度和宽度相对于根窗体高度和宽度的比例，取值也在 0.0~1.0 之间
'''