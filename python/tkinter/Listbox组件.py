# -*- coding: utf-8 -*-
"""
Created on Thu May 22 16:20:44 2025

@author: Jerrylzysss
"""
# Listbox 即列表框，列表中的选项可以是多个条目也可以是单个条目
from tkinter import *
win = Tk()
win.title('Listbox')
win.geometry('1080x720')
# 创建滚动条
s = Scrollbar(win)
# 设置垂直滚动条显示的位置，使得滚动条，靠右侧；通过 fill 沿着 Y 轴填充
s.pack(side = RIGHT,fill = Y)
# 将 selectmode 设置为多选模式，并为Listbox控件添加滚动条
listbox1 =Listbox(win,selectmode = MULTIPLE,height =5, yscrollcommand = s.set)
# i 表示索引值，item 表示值，根据索引值的位置依次插入
for i,item in enumerate(range(1,50)):
    listbox1.insert(i,item)
listbox1.pack()
# 设置滚动条，使用 yview使其在垂直方向上滚动 Listbox 组件的内容，通过绑定 Scollbar 组件的 command 参数实现
s.config(command = listbox1.yview)
# 使用匿名函数,创建删除函数，点击删除按钮，会删除选项
bt = Button(win,text='删除',command = lambda x = listbox1:x.delete(ACTIVE))
# 将按钮放置在底部
bt.pack(side = BOTTOM)
# 显示窗口
win.mainloop()
'''
方法	说明
activate(index)	将给定索引号对应的选项激活，即文本下方画一条下划线
bbox(index)	返回给定索引号对应的选项的边框，返回值是一个以像素为单位的 4 元祖表示边框：(xoffset, yoffset, width, height)， xoffset 和 yoffset 表示距离左上角的偏移位置
curselection()	返回一个元组，包含被选中的选项序号（从 0 开始）
delete(first, last=None)	 删除参数 first 到 last 范围内（包含 first 和 last）的所有选项
get(first, last=None)	返回一个元组，包含参数 first 到 last 范围内（包含 first 和 last）的所有选项的文本
index(index)	返回与 index 参数相应选项的序号
itemcget(index, option)	获得 index 参数指定的项目对应的选项（由 option 参数指定）
itemconfig(index, **options)	设置 index 参数指定的项目对应的选项（由可变参数 **option 指定）
nearest(y)	返回与给定参数 y 在垂直坐标上最接近的项目的序号
selection_set(first, last=None)	设置参数 first 到 last 范围内（包含 first 和 last）选项为选中状态，使用 selection_includes(序号) 可以判断选项是否被选中。 
size()	返回 Listbox 组件中选项的数量
xview(*args)	该方法用于在水平方向上滚动 Listbox 组件的内容，一般通过绑定 Scollbar 组件的 command 选项来实现。 如果第一个参数是 "moveto"，则第二个参数表示滚动到指定的位置：0.0 表示最左端，1.0 表示最右端；如果第一个参数是 "scroll"，则第二个参数表示滚动的数量，第三个参数表示滚动的单位（可以是 "units" 或 "pages"），例如：xview("scroll", 2, "pages")表示向右滚动二行。
yview(*args)	该方法用于在垂直方向上滚动 Listbox 组件的内容，一般通过绑定 Scollbar 组件的 command 选项来实现
属性	说明
listvariable	1. 指向一个 StringVar 类型的变量，该变量存放 Listbox 中所有的项目
2. 在 StringVar 类型的变量中，用空格分隔每个项目，例如 var.set("c c++ java python")
selectbackground	1. 指定当某个项目被选中的时候背景颜色，默认值由系统指定
selectborderwidth	1. 指定当某个项目被选中的时候边框的宽度
2. 默认是由 selectbackground 指定的颜色填充，没有边框
3. 如果设置了此选项，Listbox 的每一项会相应变大，被选中项为 "raised" 样式
selectforeground	1. 指定当某个项目被选中的时候文本颜色，默认值由系统指定
selectmode	1. 决定选择的模式，tk 提供了四种不同的选择模式，分别是："single"（单选）、"browse"（也是单选，但拖动鼠标或通过方向键可以直接改变选项）、"multiple"（多选）和 "extended"（也是多选，但需要同时按住 Shift 键或 Ctrl 键或拖拽鼠标实现），默认是 "browse"
setgrid	指定一个布尔类型的值，决定是否启用网格控制，默认值是 False
takefocus	指定该组件是否接受输入焦点（用户可以通过 tab 键将焦点转移上来），默认值是 True
xscrollcommand	为 Listbox 组件添加一条水平滚动条，将此选项与 Scrollbar 组件相关联即可
yscrollcommand	为 Listbox 组件添加一条垂直滚动条，将此选项与 Scrollbar 组件相关联即可
'''