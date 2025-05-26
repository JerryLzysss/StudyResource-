# -*- coding: utf-8 -*-
"""
Created on Thu May 22 16:08:00 2025

@author: Jerrylzysss
"""

# Mark（标记）通常被用来当作书签。
# 它可以帮助用户快速找到内容的指定位置,并且跟随相应的字符一起移动。
import tkinter as tk
root = tk.Tk()
root.title("Mark")
root.geometry('400x200')

text = tk.Text(root, width=35, heigh=15)
text.pack()
text.insert("insert", "This is a text")
# 设置标记，这里的 1.end 表示 第一行最后一个字符，当然也可以使用数字来表示比如 1.5 表示第一行第五个字符
text.mark_set("name", "1.2")
# 在标记之后插入相应的文字
text.insert("name", ",Test")
# 跟着自动移动，往后插入，而不是停留在原位置
text.insert("name", ",欢迎光临")
# 若使用 mark_unset() 可以删除指定的标记
# text.mark_unset("name")
# 但使用delete来清楚所有的内容， mark 标记依旧会存在
# text.delete("1.0","end")
# 依然可以使用 name标记来插入
# text.insert("name", "Python答疑")
# 显示窗口
root.mainloop()

'''
方法	                                    说明
mark_gravity(markName, direction=None)	设置 Mark 的移动方向，默认是 "right"，也可以设置为 "left" ，表示即如果在 Mark 处插入文本的话，Mark 的标记移动方向，也就是文本的插入方向。
mark_names()	返回 Text 组件中所有 Marks 的名字
mark_next(index)	返回在 index 指定的位置后边的一个 Mark 的名字
mark_previous(index)	返回在 index 指定的位置前边的一个 Mark 的名字
mark_set(markName, index)	移动 Mark 到 index 参数指定的位置，如果 markName 参数指定的 Mark 不存在，则创建一个新的 Mark
mark_unset(MarkName)	删除指定的 Mark
注意：如果在 Mark 标记的位置之前插入或删除文本，那么 Mark 跟着一起移动。如果要删除 Mark 需要使用 mark_unset() 方法
但是只会删除 Mark 周围的文本，并不会删除 Mark 标记本身。
'''