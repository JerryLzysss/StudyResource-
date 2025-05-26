# -*- coding: utf-8 -*-
"""
Created on Thu May 22 14:42:31 2025

@author: Jerrylzysss
"""
'''
import tkinter as tk
win=tk.Tk()
win.geometry('1080x720')
win.title('Entry2')
entry1=tk.Entry(win)
entry1.pack(padx=20,pady=20)
entry1.insert(0,"hello")
print(entry1.get())
win.mainloop()
'''
'''
基本设置
delete():根据索引值删除输入框内的值
get():获取输入框内的值
set():设置输入框内的值
insert():在指定位置插入字符串
index():返回指定的索引值
select_clear():取消选中状态
select_adjust():确保输入框选中的范围包含index所指定的字符
select_from(index):设置一个新的选中范围,通过索引值index类设置
select_present():返回输入框是否有处于选中状态的文本，有则返回true,否则返回false
select_to():选中指定索引与光标之间的所有值
select_range():同理，参数为start-end.
'''

'''
验证
validate:指定验证方式,字符串参数,参数值有focus,focusin,focusout,key,all,none
validatecommand:指定用户自定义的验证函数,只能为true/false
invalidcommand:当validatecommand指定的验证函数返回false时，可以使用该参数再指定一个验证函数
参数
focus:组件获得或者失去焦点的时候验证
focusin:组件获得焦点时验证
focuson:组件失去焦点时验证
key:输入框被编辑时验证
all:出现上述情况时验证
none:默认不启用验证
'''
import tkinter as tk
from tkinter import messagebox
win=tk.Tk()
win.geometry('1080x720')
win.title('Entry2')
label=tk.Label(win,text="账号:") 
label.grid(row=0)
def check():
    if entry.get()=='hello':
        messagebox.showinfo("Ok")
        return True
    else:
        messagebox.showwarning("Not ok")
        entry.delete(0,tk.END)
        return False
Valid_String = tk.StringVar()
entry=tk.Entry(win,textvariable=Valid_String,validate="focusout",validatecommand=check)
entry.grid(row=0,column=1)
win.mainloop()