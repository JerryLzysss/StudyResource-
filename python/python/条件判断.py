# -*- coding: utf-8 -*-
"""
Created on Wed May 14 14:50:46 2025

@author: Jerrylzysss
"""

var1 = 10
# if elif(else if) else
if var1>=10:
    print('ok')
elif var1>=5:
    print('soso')
else:
    print('bad')
# match(switch)
match var1:
    case 5:print('5')
    case 19:print('3')
    case 21|32:print('21 or 32')
    case _:print('no')

# while
sum = 0
while sum<=10:
    sum+=1
else:
    print(sum)
