# -*- coding: utf-8 -*-
"""
Created on Thu May 22 15:46:11 2025

@author: Jerrylzysss
"""

'''
Text 控件类似 HTML 中的<textarea>标签，允许用户以不同的样式、
属性来显示和编辑文本，它可以包含纯文本或者格式化文本，
同时支持嵌入图片、显示超链接以及带有 CSS 格式的 HTML 等。
'''
from tkinter import *
win=Tk()
win.title('Text')
win.geometry('1080x720')
text = Text(win, width=50, height=30, undo=True, autoseparators=False)
# 适用 pack(fill=X) 可以设置文本域的填充模式。比如 X表示沿水平方向填充，Y表示沿垂直方向填充，BOTH表示沿水平、垂直方向填充
text.grid()
# INSERT 光标处插入；END 末尾处插入
text.insert(INSERT, 'Hello')

# 定义撤销和恢复方法，调用edit_undo()和 edit_redo()方法
def backout():
    text.edit_undo()
def regain():
    text.edit_redo()
Button(win,text = '撤销',command = backout).grid(row=3, column=0, sticky="w", padx=10, pady=5)
Button(win,text = '恢复',command = regain).grid(row=3, column=0, sticky="e", padx=10, pady=5)
win.mainloop()
'''
autoseparators	默认为 True，表示执行撤销操作时是否自动插入一个“分隔符”（其作用是用于分隔操作记录）
exportselection	默认值为 True，表示被选中的文本是否可以被复制到剪切板，若是 False 则表示不允许。
insertbackground	设置插入光标的颜色，默认为 BLACK
insertborderwidth	设置插入光标的边框宽度，默认值为 0
insertofftime	该选项控制光标的闪烁频频率（灭的状态）
insertontime	该选项控制光标的闪烁频频率（亮的状态）
selectbackground	指定被选中文本的背景颜色，默认由系统决定
selectborderwidth	指定被选中文本的背景颜色，默认值是0
selectforeground	指定被选中文本的字体颜色，默认值由系统指定
setgrid	默认值是 False，指定一个布尔类型的值，确定是否启用网格控制
spacing1	指定 Text 控件文本块中每一行与上方的空白间隔，注意忽略自动换行，且默认值为 0。
spacing2	指定 Text 控件文本块中自动换行的各行间的空白间隔，忽略换行符，默认值为0
spacing3	指定 Text 组件文本中每一行与下方的空白间隔，忽略自动换行，默认值是 0
tabs	定制 Tag 所描述的文本块中 Tab 按键的功能，默认被定义为 8 个字符宽度，比如 tabs=('1c', '2c', '8c') 表示前 3 个 Tab 宽度分别为 1厘米，2厘米，8厘米。
undo	该参数默认为 False，表示关闭 Text 控件的“撤销”功能，若为 True 则表示开启
wrap	该参数用来设置当一行文本的长度超过 width 选项设置的宽度时，是否自动换行，参数值 none（不自动换行）、char（按字符自动换行）、word（按单词自动换行）
xscrollcommand	该参数与 Scrollbar 相关联，表示沿水平方向上下滑动
yscrollcommand	该参数与 Scrollbar 相关联，表示沿垂直方向左右滑动
'''
