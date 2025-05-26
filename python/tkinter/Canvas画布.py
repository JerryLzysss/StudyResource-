# -*- coding: utf-8 -*-
"""
Created on Fri May 23 09:37:43 2025

@author: Jerrylzysss
"""
# Canvas 控件具有两个功能，首先它可以用来绘制各种图形，比如弧形、线条、椭圆形、多边形和矩形等。
# 其次 Canvas 控件还可以用来展示图片（包括位图），我们将这些绘制在画布控件上的图形，称之为“画布对象”。
'''
属性	方法
background(bg)	指定 Canvas 控件的背景颜色
borderwidth(bd)	指定 Canvas 控件的边框宽度
closeenough	    1. 指定一个距离，当鼠标与画布对象的距离小于该值时，认为鼠标位于画布对象上
                2. 该选项是一个浮点类型的值
confine	        1. 指定 Canvas 控件是否允许滚动超出 scrollregion 选项设置的滚动范围，默认值为 True
selectbackground	指定当画布对象（即在 Canvas 画布上绘制的图形）被选中时的背景色，
selectborderwidth	指定当画布对象被选中时的边框宽度（选中边框）
selectforeground	指定当画布对象被选中时的前景色
state	        设置 Canvas 的状态："normal" 或 "disabled"，默认值是 "normal"，注意，该值不会影响画布对象的状态
takefocus	    指定使用 Tab 键可以将焦点移动到输入框中，默认为开启，将该选项设置为 False 避免焦点在此输入框中
width	        指定 Canvas 的宽度，单位为像素
xscrollcommand	与 scrollbar（滚动条）控件相关联（沿着 x 轴水平方向）
xscrollincrement	1. 该选项指定 Canvas 水平滚动的“步长”
                    2. 例如 '3c' 表示 3 厘米，还可以选择的单位有 'i'（英寸），'m'（毫米）和 'p'（DPI，大约是 '1i' 等于 '72p'）
                    3. 默认为 0，表示可以水平滚动到任意位置
yscrollcommand	    与 scrollbar 控件（滚动条）相关联（沿着 y 轴垂直方向）
yscrollincrement	1. 该选项指定 Canvas 垂直滚动的“步长”
                    2. 例如 '3c' 表示 3 厘米，还可以选择的单位有 'i'（英寸），'m'（毫米）和 'p'（DPI，大约是 '1i' 等于 '72p'）
                    3. 默认值是 0，表示可以垂直方向滚动到任意位置
'''
import tkinter as tk
window = tk.Tk()
window.title('Test')
window.geometry('1080x720')
canvas=tk.Canvas(window,bg='#CDC9A5',height=200,width=300)
canvas.pack()
point=[(10,10),(20,20),(30,30),(40,40)]
l1=canvas.create_line(point,fill="red",arrow='last',width=5)
window.mainloop()
'''
图形绘制
create_line(x0, y0, x1, y1, ... , xn, yn, options)	1. 根据给定的坐标创建一条或者多条线段；
                                                    2. 参数 x0,y0,x1,y1,...,xn,yn 定义线条的坐标；
                                                    3. 参数 options 表示其他可选参数
create_oval(x0, y0, x1, y1, options)	1. 绘制一个圆形或椭圆形；
                                                    2. 参数 x0 与 y0 定义绘图区域的左上角坐标；参数 x1 与 y1 定义绘图区域的右下角坐标；
                                                    3. 参数 options 表示其他可选参数
create_polygon(x0, y0, x1, y1, ... , xn, yn, options)	1. 绘制一个至少三个点的多边形；
                                                        2. 参数 x0、y0、x1、y1、...、xn、yn 定义多边形的坐标；
                                                        3. 参数 options 表示其他可选参数
create_rectangle(x0, y0, x1, y1, options)	1. 绘制一个矩形；
                                            2. 参数 x0 与 y0 定义矩形的左上角坐标；参数 x 与 y1 定义矩形的右下角坐标；
                                            3. 参数 options 表示其他可选参数
create_text(x0, y0, text, options)	1. 绘制一个文字字符串。其中
                                    2. 参数 x0 与 y0 定义文字字符串的左上角坐标，参数 text 定义文字字符串的文字；
                                    3. 参数 options 表示其他可选参数
create_image(x, y, image)	1. 创建一个图片;
                            2. 参数 x 与 y 定义图片的左上角坐标；
                            3. 参数 image 定义图片的来源，必须是 tkinter 模块的 BitmapImage 类或 PhotoImage 类的实例变量。
create_bitmap(x, y, bitmap)	1. 创建一个位图；
                            2. 参数 x 与 y 定义位图的左上角坐标；
                            3. 参数 bitmap 定义位图的来源，参数值可以是 gray12、gray25、gray50、gray75、hourglass、error、questhead、info、warning 或 question，或者也可以直接使用 XBM（X Bitmap）类型的文件，此时需要在 XBM 文件名称前添加一个 @ 符号，例如 bitmap=@hello.xbm
create_arc(coord, start, extent, fill)	1. 绘制一个弧形；
                                        2. 参数 coord 定义画弧形区块的左上角与右下角坐标；
                                        3. 参数 start 定义画弧形区块的起始角度（逆时针方向）；
                                        4. 参数 extent 定义画弧形区块的结束角度（逆时针方向）；
                                        5. 参数 fill 定义填充弧形区块的颜色。
'''