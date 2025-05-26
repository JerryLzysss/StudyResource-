# -*- coding: utf-8 -*-
"""
Created on Fri May 23 17:25:04 2025

@author: Jerrylzysss
"""
# Menu 控件（菜单控件）可以说是 GUI 中“精髓所在”.
# 它以可视化的方式将一系列的“功能选项卡”进行分组，并在每个分组下又“隐藏”了许多其他的“选项卡”。
# 当打开菜单时，这些选项卡就会“显式”的呈现出来，方便用户进行选择，
from tkinter import *
import tkinter.messagebox
win =Tk()
win.title('menu')
win.geometry('1080x720')
def menuCommand():
    tkinter.messagebox.showinfo('hello','hello')
main_menu=Menu(win)
# 子菜单
filemenu=Menu(main_menu,tearoff=False)
filemenu.add_command(label='文件',command=menuCommand,accelerator="Ctrl+N")
filemenu.add_command(label='编辑',command=menuCommand)
filemenu.add_command(label='查看',command=menuCommand)
filemenu.add_separator()
# 在主目录菜单通过menu参数与下拉菜单绑定
main_menu.add_cascade(label='文件2',menu=filemenu)
# 绑定主菜单
win.config(menu=main_menu)
win.bind("<Control-n>",menuCommand)
win.bind("<Control-N>",menuCommand)

win.mainloop()
# 创建菜单
'''
add_cascade(**options)	添加一个父菜单，将一个指定的子菜单，通过 menu 参数与父菜单连接，从而创建一个下拉菜单。
add_checkbutton(**options)	添加一个多选按钮的菜单项
add_command(**options)	 添加一个普通的命令菜单项
add_radiobutton(**options)	添加一个单选按钮的菜单项
add_separator(**options)	 添加一条分割线
add(add(itemType, options))	添加菜单项，此处 itemType 参数可以是以下几种："command"、"cascade"，
"checkbutton"、"radiobutton"、"separator" 五种，并使用 options 选项来设置
菜单其他属性。
'''
# 操作
'''
delete(index1, index2=None)	1. 删除 index1 ~ index2（包含）的所有菜单项
                            2. 如果忽略 index2 参数，则删除 index1 指向的菜单项
entrycget(index, option)	获得指定菜单项的某选项的值
entryconfig(index, **options)	设置指定菜单项的选项
index(index)	返回与 index 参数相应的选项的序号
insert(index, itemType, **options)	插入指定类型的菜单项到 index 参数指定的位置，类型可以是
是："command"，"cascade"，"checkbutton"，"radiobutton"
或 "separator" 中的一个，或者也可以使用 insert_类型() 形式来，
比如 insert_cascade(index, **options)..等
invoke(index)	调用 index 指定的菜单项相关联的方法
post(x, y)	在指定的位置显示弹出菜单
type(index)	获得 index 参数指定菜单项的类型
unpost()	移除弹出菜单
yposition(index)	返回 index 参数指定的菜单项的垂直偏移位置
'''
# 属性
'''
accelerator	1. 设置菜单项的快捷键，快捷键会显示在菜单项目的右边，比如 accelerator = "Ctrl+O" 表示打开；
            2. 注意，此选项并不会自动将快捷键与菜单项连接在一起，必须通过按键绑定来实现
command	选择菜单项时执行的 callback 函数
label	定义菜单项内的文字
menu	此属性与 add_cascade() 方法一起使用，用来新增菜单项的子菜单项
selectcolor	指定当菜单项显示为单选按钮或多选按钮时选择中标志的颜色
state	定义菜单项的状态，可以是 normal、active 或 disabled
onvalue/offvalue	1. 默认情况下，variable 选项设置为 1 表示选中状态，反之设置为 0，
                    设置 offvalue/onvalue 的值可以自定义未选中状态的值
tearoff         	1. 如果此选项为 True，在菜单项的上面就会显示一个可选择的分隔线；
                    2. 注意：分隔线会将此菜单项分离出来成为一个新的窗口
underline	       设置菜单项中哪一个字符要有下画线
value	            1. 设置按钮菜单项的值
                    2. 在同一组中的所有按钮应该拥有各不相同的值
                    3. 通过将该值与 variable 选项的值对比，即可判断用户选中了哪个按钮
variable	当菜单项是单选按钮或多选按钮时，与之关联的变量
'''
