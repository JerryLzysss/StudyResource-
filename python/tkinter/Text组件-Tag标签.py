# -*- coding: utf-8 -*-
"""
Created on Thu May 22 16:02:47 2025

@author: Jerrylzysss
"""
'''
Tag（标签）用来给一定范围内的文字起一个标签名，通过该标签名就能操控某一范围内的文字，
比如修改文本的字体、尺寸和颜色。除此之外，该标签还可以和事件函数绑定在一起使用。
'''
# 创建多行文本框控件
from tkinter import *
# 创建主窗口
win = Tk()
win.title(string = "Tag")
# 创建一个Text控件
text = Text (win)
# 在Text控件内插入- -段文字 ，INSERT表示在光标处插入，END表示在末尾处插入
text.insert (INSERT,  "hello,this is ok GG")
# 跳下一行
text.insert (INSERT, "\n\n")
# 在Text控件内插入- -个按钮
button = Button(text, text="关闭",command=win.quit)
text.window_create (END, window=button)
# 填充水平和垂直方向,这里设置 expand为 True 否则不能垂直方向延展
text.pack (fill=BOTH,expand=True)
# 在第一行文字的第0个字符到第6个字符处插入标签，标签名称为"name"
text.tag_add("name", "1.0", "1.6")
# 将插入的按钮设置其标签名为"button"
text.tag_add ("button", button)
#使用 tag_config() 来改变标签"name"的前景与背景颜色,并加下画线，通过标签控制字符的样式
text.tag_config("name", font=('微软雅黑',18,'bold'),background="yellow", foreground= "blue",underline=1)
#设置标签"button"的居中排列
text.tag_config("button", justify="center")
#开始程序循环
win.mainloop()
'''
方法	                           说明
tag_add(tagName,index1,index2)	为指定索引范围内的内容添加一个标签名字，如果 index2 不存在，则单独为 Index1 指定的内容添加 Tag
tag_bind(tagName, sequence, func, add=None)	为 Tag 绑定事件，解除绑定使用 tag_unbind() 方法
tag_cget（tagName,option）	返回 tagName 指定的 option 选项的值
tag_configure(tagName, cnf=None, **kw)	设置 tagName 的选项
tag_delete(tagNames)	删除单个或者多个 tagNames 指定的标签
tag_lower(tagName, belowThis=None)	降低 Tag 的优先级，如果 belowThis 参数不为空，则表示 tagName 需要比 belowThis 指定的 Tag 优先级更低
tag_names(index=None)	如果不带参数，表示返回 Text 组件中所有 Tags 的名字，若存在 index 参数则返回该位置上所有 Tags 的名字
tag_nextrange(tagName, index1, index2=None)	 在 index1 到 index2 的范围内第一个 tagName 的位置，若不存在则返回空字符串。
tag_raise(tagName, aboveThis=None)	提高 Tag 的优先级，如果 aboveThis 参数不为空，则表示 tagName 需要比 aboveThis 指定的 Tag 优先级更高
tag_ranges(tagName)	返回所有 tagName 指定的文本，并将它们的范围以列表的形式返回
tag_remove(tagName, index1, index2=None)	删除 index1 到 index2 之间所有的 tagName，如果忽略 index2 参数，那么只删除 index1 指定字符的 tagName
'''