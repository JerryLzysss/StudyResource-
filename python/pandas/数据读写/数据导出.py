# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 数据导出
'''
把 DataFrame 写出到多种目标：文件、数据库、剪贴板、字符串等。
'''
import pandas as pd

df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 35],
    'City': ['NY', 'LA', 'Chicago']
})

# 导出为常见文本/表格格式
df.to_csv('export_demo.csv', index=False, encoding='utf-8')
df.to_json('export_demo.json', orient='records', force_ascii=False)
df.to_html('export_demo.html', index=False)
# df.to_excel('export_demo.xlsx', index=False)  # 需 openpyxl / xlsxwriter

# 导出为字符串（不写文件）
print(df.to_csv(index=False))
print(df.to_markdown(index=False))

# 其他
# df.to_sql('table_name', con)
# df.to_clipboard()
# df.to_pickle('demo.pkl')
# df.to_hdf('demo.h5', key='df')

print('导出完成')
