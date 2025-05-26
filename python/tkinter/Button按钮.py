# -*- coding: utf-8 -*-
"""
Created on Thu May 22 11:37:19 2025

@author: Jerrylzysss
"""
'''
Button 控件是 Tkinter 中常用的窗口部件之一，同时也是实现程序与用户交互的主要控件。
通过用户点击按钮的行为来执行回调函数，是 Button 控件的主要功能。
'''
import tkinter as tk
window =tk.Tk()
# 设置回调函数
def callback():
    print('click')
b=tk.Button(window,text='点击回调',command=callback).pack()
tk.mainloop();
'''
属性 说明
anchor 控制文本所在位置，默认为中心
activebackground 放上鼠标时按钮的背景颜色
activeforeground 放上鼠标时按钮的前景色
bd 按钮边框大小
bg 按钮背景色
command 执行按钮的回调函数
fg 按钮的前景色
font 按钮文本
height 按钮高度
highlightcolor 按钮控件高亮
image 按钮显示图片
justify 按钮显示多行文本指定对其方向
padx,pady 距离x轴y轴的间距大小
ipadx,ipxdy 距离标签文字与标签容器的距离
state 按钮的可用状态
text 按钮的显示文本
'''