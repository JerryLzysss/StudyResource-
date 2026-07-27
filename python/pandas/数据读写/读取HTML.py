# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 读取 HTML
'''
pd.read_html 会解析页面中的 <table>，返回 DataFrame 列表。
依赖：lxml / html5lib / BeautifulSoup4（至少其一）。
'''
import pandas as pd

html = '''
<table>
  <tr><th>Site</th><th>Age</th></tr>
  <tr><td>Google</td><td>25</td></tr>
  <tr><td>Runoob</td><td>30</td></tr>
  <tr><td>Taobao</td><td>35</td></tr>
</table>
'''
tables = pd.read_html(html)
df = tables[0]
print(df)

# 也可传入 URL（需要网络）
# tables = pd.read_html('https://www.runoob.com/...')

'''常用参数
io           HTML 字符串、文件路径或 URL
match        用正则匹配要保留的表格
header       表头行
attrs        按 HTML 属性筛选 table，如 {'id': 'table1'}
encoding     编码
flavor       解析引擎：lxml / html5lib / bs4
'''
