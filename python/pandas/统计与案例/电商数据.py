# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:10:00 2026

@author: Jerrylzysss
"""
# Pandas 电商数据案例（模拟）
'''
场景：订单明细 -> 销售额统计、热销商品、用户消费排行。
'''
import pandas as pd

orders = pd.DataFrame({
    'order_id': [1001, 1002, 1003, 1004, 1005, 1006],
    'user_id': [1, 2, 1, 3, 2, 1],
    'product': ['手机壳', '耳机', '手机壳', '充电器', '耳机', '贴膜'],
    'qty': [2, 1, 1, 2, 1, 3],
    'price': [29.9, 199, 29.9, 49, 199, 9.9],
    'date': pd.to_datetime([
        '2024-01-02', '2024-01-03', '2024-01-03',
        '2024-01-04', '2024-01-05', '2024-01-05'
    ])
})
orders['amount'] = orders['qty'] * orders['price']

print('总销售额:', orders['amount'].sum())
print('日销售额:')
print(orders.groupby('date')['amount'].sum())
print('热销商品:')
print(orders.groupby('product')['qty'].sum().sort_values(ascending=False))
print('用户消费排行:')
print(orders.groupby('user_id')['amount'].sum().sort_values(ascending=False))
