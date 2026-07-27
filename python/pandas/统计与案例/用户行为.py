# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 用户行为案例（模拟）
'''
场景：埋点日志 -> 活跃、留存粗算、事件转化。
'''
import pandas as pd

logs = pd.DataFrame({
    'user_id': [1, 1, 2, 2, 2, 3, 3, 4, 1, 2],
    'event': ['view', 'click', 'view', 'click', 'buy',
              'view', 'buy', 'view', 'buy', 'view'],
    'date': pd.to_datetime([
        '2024-01-01', '2024-01-01', '2024-01-01', '2024-01-02', '2024-01-02',
        '2024-01-01', '2024-01-03', '2024-01-02', '2024-01-03', '2024-01-03'
    ])
})

# DAU
print('DAU:')
print(logs.groupby('date')['user_id'].nunique())

# 事件漏斗粗算
funnel = logs['event'].value_counts()
print('事件次数:')
print(funnel)
view_users = set(logs.loc[logs['event'] == 'view', 'user_id'])
click_users = set(logs.loc[logs['event'] == 'click', 'user_id'])
buy_users = set(logs.loc[logs['event'] == 'buy', 'user_id'])
print('view->click 转化用户数:', len(view_users & click_users))
print('click->buy 转化用户数:', len(click_users & buy_users))

# 每用户事件数
print(logs.groupby('user_id')['event'].count().sort_values(ascending=False))
