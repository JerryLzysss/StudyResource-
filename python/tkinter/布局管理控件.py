# -*- coding: utf-8 -*-
"""
Created on Mon May 26 16:04:43 2025

@author: Jerrylzysss
"""
# Frame:Frame 本质上也是一个矩形窗体，同其他控件一样也需要位于主窗口内。
# 我们可以在主窗口内放置多个 Frame 控件，并且每个 Frame 中还可以嵌套一个或者多个Frame
# 从而将主窗口界面划分成多个区域。
'''
import tkinter as tk
win=tk.Tk()
win.title('Frame')
win.geometry('1080x720')
frame1=tk.Frame(win)
frame1.pack()
frame_left = tk.Frame(frame1)
tk.Label(frame_left,text='左侧标签1',bg='green',width=10,height=5).grid(row =0,column=0)
tk.Label(frame_left,text='左侧标签2',bg='blue',width=10,height=5).grid(row = 1 ,column =1)
frame_left.pack(side=tk.LEFT)
frame_right = tk.Frame(frame1)
tk.Label(frame_right,text='右侧标签1',bg='gray',width=10,height=5).grid(row = 0 ,column =1)
tk.Label(frame_right,text='右侧标签2',bg='pink',width=10,height=5).grid(row = 1 ,column =0)
tk.Label(frame_right,text='右侧标签3',bg='purple',width=10,height=5).grid(row= 1,column=1)
frame_right.pack(side=tk.RIGHT)
win.mainloop()
'''
# LabelFrame:效果等同于Label，不同点在于其会在包裹的子组件周围绘制一个边框和一个标题。
# 当我们想要将一些相关的组件分为一组时，就可以使用 LabelFrame 组件.
'''
import tkinter as tk
win = tk.Tk()
win.title("LabelFrame")
win.geometry('1080x720')
# 定义第一个容器，使用 labelanchor ='w' 来设置标题的方位
frame_left = tk.LabelFrame(win, text="教程", labelanchor="w",bg='#5CACEE')
# 使用 place 控制 LabelFrame 的位置
frame_left.place(relx=0.2, rely=0.2, relwidth=0.2, relheight=0.5)
label_1 = tk.Label(frame_left, text="C语言")
label_1.place(relx=0.2, rely=0.2)
label_2 = tk.Label(frame_left, text="Python")
label_2.place(relx=0.6, rely=0.2)
label_3 = tk.Label(frame_left, text="Java")
label_3.place(relx=0.2, rely=0.6)
label_4 = tk.Label(frame_left, text="C++")
label_4.place(relx=0.6, rely=0.6)
# 定义第二个容器，使用 labelanchor ='w' 来设置标题的方位
frame_right = tk.LabelFrame(win, text="辅导班", labelanchor="w",bg='#66CDAA')
# 使用 place 控制 LabelFrame 的位置
frame_right.place(relx=0.5, rely=0.2, relwidth=0.3, relheight=0.6)
label_1 = tk.Label(frame_right, text="C语言辅导班")
label_1.place(relx=0.2, rely=0.2)
label_2 = tk.Label(frame_right, text="数据结构")
label_2.place(relx=0.6, rely=0.2)
label_3 = tk.Label(frame_right, text="C++辅导班")
label_3.place(relx=0.2, rely=0.6)
label_4 = tk.Label(frame_right, text="Python答疑")
label_4.place(relx=0.6, rely=0.6)
win.mainloop()
'''
'''
属性
bg	设置 Frame 的背景颜色
bd	指定 Frame 的边框宽度
colormap	指定  Frame 组件及其子组件的颜色映射
container	布尔值参数，若参数值为 True，则窗体将被用作容器使用，一些其他程序也可以被嵌入。
cursor	指定鼠标在 Frame 上飘过的鼠标样式，默认由系统指定
height/width	设置 Frame 的高度和宽度
highlightbackground	指定当 Frame 没有获得焦点的时候高亮边框的颜色，通常由系统指定为标准颜色
highlightcolor	指定当 Frame 获得焦点的时候高亮边框的颜色
highlightthickness	指定高亮边框的宽度，默认值是 0
padx/pady	距离主窗口在水平/垂直方向上的外边距
relief	指定边框的样式，参数值 "sunken"，"raised"，"groove" 或 "ridge"，"flat"，默认为 "falt'
takefocus	布尔值参数，默认为 False，指定该组件是否接受输入焦点（即用户通过 Tab 键将焦点转移上来）
'''

# PanedWindow:窗格界面，其目的在于为其他组件提供容器或者框架从而以分块的形式完成对图形界面的布局.
# 允许用户自主调整界面划分以及每块区域的大小.
'''
import tkinter as tk
win = tk.Tk()
win.title('PanedWindow')
win.geometry('1080x720')
p_window1=tk.PanedWindow(win)
p_window1.pack(fill='both',expand=1)

l1=tk.Label(p_window1,text='left1',width=10,font=('微软雅黑',15),bg='blue')
p_window1.add(l1)
l2=tk.Label(p_window1,text='left2',width=10,font=('微软雅黑',15),bg='red')
p_window1.add(l2)

p_window2=tk.PanedWindow(orient=tk.VERTICAL,showhandle=True)
p_window1.add(p_window2)

top_label=tk.Label(p_window2,text='top',font=('宋体',15),bg='yellow')
p_window2.add(top_label)
bottom_label=tk.Label(p_window2,text='bottom',font=('宋体',15),bg='green')
p_window2.add(bottom_label)

win.mainloop()
'''
'''
属性
handlepad	1. 调节“手柄”的位置
2. 比如当 orient ='vertical' 设置垂直时，handlepad 表示“分割线”上的手柄与左端的距离，默认为 8 像素
handlesize	设置“手柄”的尺寸（由于“手柄”必须是一个正方形，所以是设置正方形的边长）默认为 8 像素
opaqueresize	1. 该选项定义了用户调整窗格尺寸的操作，如果该选项的值为 True（默认），窗格的尺寸随用户鼠标的拖拽而改变
2.  如果该选项的值为 False，那么窗格的尺寸，在用户释放鼠标时才会更新到新的位置上
orient	指定窗格的分布方式，默认为水平方向分布（"horizontal"），或者还可以设置为垂直纵向分布（"vertical"）
relif	指定边框的样式，默认为 "flat"，还可以设置为  "sunken"，"raised"，"groove" 或 "ridge"
sashpad	设置每一条分割线到窗格间的间距
sashrelief	设置分割线的样式，默认值是："flat"，还可以设置 "sunken"，"raised"，"groove" 或 "ridge"
sashwidth	设置分割线的宽度
showhandle	设置是否显示调节窗格的手柄，默认为 False
height/width	设置 PanedWindow 的高度、宽度，若不设置，则其大小由其子组件的尺寸决定
方法
add(child)	添加一个新的子组件到窗格中语法格式 add(child,**option)，参数值 after、before、sticky
forget(child)	删除一个子组件
panecget(child, option)	获得子组件指定选项的值
paneconfig(child, **options)	设置子组件的各种选项
panes()	将父组件中包含的子组件以列表的形式返回
sash_coord(index)	返回一个二元组表示指定分割线的起点坐标
sash_place(index, x, y)	将指定的分割线移动到一个新的位置
'''
# TopLevel:顶级窗口控件,同样类似于Frame,不过该控件会脱离根窗口另行创建独立窗口
'''
import tkinter as tk
root = tk.Tk()
root.config(bg='#87CEEB')
root.title('topLevel')
root.geometry('1080x720')
def create_toplevel():
    top = tk.Toplevel()
    top.geometry('800x600')
    top.title('sub-toplevel')
    msg=tk.Label(top,text='subTitle')
    msg.pack()
create_toplevel()
root.mainloop()
'''
'''
属性
deiconify()	在使用 iconify() 或 withdraw() 方法后，即窗口最小化和移除窗口后（只是看不见，并没销毁），使用该方法来显示该窗口
frame()	返回一个系统特定的窗口识别码
group(window)	将顶级窗口加入 window 窗口群组中，如果忽略该参数，将返回当前窗口群的主窗口
 iconify()	将窗口图标化（最小化），需要重新显示窗口，使用 deiconify() 方法
 protocol(name, function)	将回调函数 function 与相应的规则 name 绑定；
1) name 参数可以是 "WM_DELETE_WINDOW"：窗口被关闭的时候；
2) name 参数可以是 "WM_SAVE_YOURSELF"：窗口被保存的时候；
3) name 参数可以是 "WM_TAKE_FOCUS"：窗口获得焦点的时候。
 state()	设置和获得当前窗口的状态，参数值 "normal"（正常状态），"withdrawn（移除窗口）"，"icon"（最小化）和 "zoomed"（放大）
transient(master)	指定为 master 的临时窗口
withdraw()	将窗口从屏幕上移除，只是移动到了窗口之外，并没销毁，需要重新显示窗口，使用 deiconify() 方法
'''