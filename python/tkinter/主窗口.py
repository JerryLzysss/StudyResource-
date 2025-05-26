# -*- coding: utf-8 -*-
"""
Created on Wed May 21 15:52:48 2025

@author: Jerrylzysss
"""

# 创建空白窗口
import tkinter  as tk
from tkinter import messagebox
# 构造
window =tk.Tk()
# 主窗口
window.title('mainWindow')
# 分辨率
window.geometry('1080x720')
# 改变背景颜色
window.config(background='#6fb765')
# 获取电脑屏幕大小
print(window.winfo_screenwidth(),window.winfo_screenheight())
# 刷新一下window,然后获取窗口大小
window.update()
print(window.winfo_width(),window.winfo_height())
# 设置窗口位置
window.attributes('-topmost',True)
# 设置左上角图标(.ico)
window.iconbitmap('./favicon.ico')
# 设置最小范围和最大范围
window.minsize(50,50)
window.maxsize(1080,720)
# 设置属性(例如透明度-alpha,-topmost是否置顶,-fullscreen是否全屏)
window.attributes("-alpha",0.8)
# 设置窗口显示状态(正常显示normal,最小化icon,最大化zoomed)
window.state("normal")
# 隐藏主窗口
window.withdraw()
# 窗口最小化
window.iconify()
# 取消隐藏
window.deiconify()
# protocol协议
def QueryWindow():
    if messagebox.showwarning('警告','error'):
        window.destroy()
# 通过protocol可以重写WM_DELETE_WINDOW方法,也就是关闭窗口
window.protocol('WM_DELETE_WINDOW',QueryWindow)


#主进程循环,开启窗口
window.mainloop()