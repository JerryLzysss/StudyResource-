# -*- coding: utf-8 -*-
"""
Created on Thu May 22 17:10:44 2025

@author: Jerrylzysss
"""

# 目标
'''
    1.按照列判断正负数
    2.把正数放到第一列，负数放到第二列
    3.每一列分别写入到一个文件中的不同sheet
'''

import pandas as pd
xls = pd.read_excel('oneSheet.xlsx',header=0)
df=pd.DataFrame(xls)
df2=pd.DataFrame({
    'name':['1','2','3'],
    'age':[10,15,20],
    'city':['beijing','shanghai','guangzhou']
})

def Deal(df,col):
    df_new=pd.DataFrame({'BigThanZero':[None,None,None,None,None],'LessThanZero':[None,None,None,None,None]})
    
    for index,item in df[col].items():
        
        if float(item)>=0:
            df_new.loc[index,'BigThanZero']=item
        else:
            df_new.loc[index,'LessThanZero']=item
        
    return df_new;

with pd.ExcelWriter('output.xlsx') as writer:
     for index,item in enumerate(df.columns):
        Deal(df,item).to_excel(writer,sheet_name=item)

    
    