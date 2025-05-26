# -*- coding: utf-8 -*-
"""
Created on Mon May 26 15:27:05 2025

@author: Jerrylzysss
"""

# 事件处理，是 GUI 程序中不可或缺的重要组成部分，相比来说，控件只是组成一台机器的零部件， 而事件处理则是驱动这台机器“正常”运转的关键所在，它能够将零部件之间“优雅”的贯穿起来，
# Tkinter 提供的事件处理机制允许我们为“控件”绑定相应的事件和事件处理函数（即 callback函数），从而实现控件与用户的交互

from tkinter import *
def show_key(e):
    # 查看触发事情按钮
    s=e.keysym
    # 将其显示在按钮组件
    lb.config(text=s)
root = Tk()
root.config(bg='#87CEEB')
root.title('Event')
root.geometry('1080x720')
lb=Label(root,text="请按键",fg='blue',font=('微软雅黑',15))
# 事件绑定方法
lb.bind('<Key>',show_key)
# 按钮获取焦点
lb.focus_set()
lb.pack()
root.mainloop()

# 常用事件类型
'''
<modifier-type-detail>
modifier:可选项,事件类型的修饰符，通常用于描述组合键，双击double-button-1，大写锁定Lock，以及alt-shift
type:事件的具体类型
detail:可选项,通常用于描述具体的哪个案件,比如button-1代表鼠标左键

# modifer类型
Control	事件发生时需按下 Control 键
Alt	事件发生时需按下 Alt 键
Shift	事件发生时需按下 Shift 键
Lock	事件发生时需处于大写锁定状态
Double	事件连续发生两次，比如双击鼠标
Triple	事件连续发生三次
Quadruple	事件连续发生四次

# type类型
<ButtonPress-1>	单击鼠标左键，简写为<Button-1>，后面的数字可以是1/2/3，分别代表左键、中间滑轮、右键
<ButtonRelease-1>	释放鼠标左键，后面数字可以是1/2/3，分别代表释放左键、滑轮、右键
<B1-Motion>	按住鼠标左键移动，<B2-Motion>和<B3-Motion>分别表示按住鼠标滑轮移动、右键移动
<MouseWheel>	转动鼠标滑轮
<Double-Button-1>	双击鼠标左键
<Enter>	鼠标光标进入控件实例
<Leave>	鼠标光标离开控件实例
<Key>	按下键盘上的任意键
<KeyPress-字母>/<KeyPress-数字>	按下键盘上的某一个字母或者数字键
<KeyRelease>	释放键盘上的按键
<Return>	回车键，其他同类型键有<Shift>/<Tab>/<Control>/<Alt>
<Space>	空格键
<UP>/<Down>/<Left>/<Right>	方向键
<F1>...<F12>	常用的功能键
<Control-Alt>	组合键，再比如<Control-Shift-KeyPress-T>，表示用户同时点击 Ctrl + Shift + T
<FocusIn>	当控件获取焦点时候触发，比如鼠标点击输入控件输入内容，可以调用 focus_set() 方法使控件获得焦点
<FocusOut>	当控件失去焦点时激活，比如当鼠标离开输入框的时候
<Configure >	控件的发生改变的时候触发事件，比如调整了控件的大小等
<Deactivate>	当控件的状态从“激活”变为“未激活”时触发事件
<Destroy>	当控件被销毁的时候触发执行事件的函数
<Expose>	当窗口或组件的某部分不再被覆盖的时候触发事件
<Visibility>	当应用程序至少有一部分在屏幕中是可见状态时触发事件

# 事件对象常用属性
widget	发生事件的是哪一个控件
x,y	相对于窗口的左上角而言，当前鼠标的坐标位置
x_root,y_root	相对于屏幕的左上角而言，当前鼠标的坐标位置
char	用来显示所按键相对应的字符
keysym	按键名，比如 Control_L 表示左边的 Ctrl 按键
keycode	按键码，一个按键的数字编号，比如 Delete 按键码是107
num	1/2/3中的一个，表示点击了鼠标的哪个按键，按键分为左、中、右
width,height	控件的修改后的尺寸，对应着 <Configure>事件
type	事件类型
'''