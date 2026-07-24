# MySQL 教程模块索引

> 按模块学习：先执行 [00-setup.sql](../../sql/tutorial/00-setup.sql)，再逐个打开对应文档与 SQL。

| 模块 | 文档 | SQL |
|------|------|-----|
| 00 环境初始化 | — | [00-setup.sql](../../sql/tutorial/00-setup.sql) |
| 01 入门概述 | [01-intro.md](01-intro.md) | — |
| 02 连接与管理 | [02-connect.md](02-connect.md) | [02-connect.sql](../../sql/tutorial/02-connect.sql) |
| 03 创建 / 删除 / 选择数据库 | [03-database.md](03-database.md) | [03-database.sql](../../sql/tutorial/03-database.sql) |
| 04 数据类型 | [04-data-types.md](04-data-types.md) | [04-data-types.sql](../../sql/tutorial/04-data-types.sql) |
| 05 创建 / 删除数据表 | [05-create-table.md](05-create-table.md) | [05-create-table.sql](../../sql/tutorial/05-create-table.sql) |
| 06 插入数据（INSERT） | [06-insert.md](06-insert.md) | [06-insert.sql](../../sql/tutorial/06-insert.sql) |
| 07 查询数据（SELECT） | [07-select.md](07-select.md) | [07-select.sql](../../sql/tutorial/07-select.sql) |
| 08 WHERE 子句 | [08-where.md](08-where.md) | [08-where.sql](../../sql/tutorial/08-where.sql) |
| 09 UPDATE 更新 | [09-update.md](09-update.md) | [09-update.sql](../../sql/tutorial/09-update.sql) |
| 10 DELETE 删除 | [10-delete.md](10-delete.md) | [10-delete.sql](../../sql/tutorial/10-delete.sql) |
| 11 LIKE 模糊查询 | [11-like.md](11-like.md) | [11-like.sql](../../sql/tutorial/11-like.sql) |
| 12 排序（ORDER BY） | [12-order-by.md](12-order-by.md) | [12-order-by.sql](../../sql/tutorial/12-order-by.sql) |
| 13 分组（GROUP BY） | [13-group-by.md](13-group-by.md) | [13-group-by.sql](../../sql/tutorial/13-group-by.sql) |
| 14 表连接（JOIN） | [14-join.md](14-join.md) | [14-join.sql](../../sql/tutorial/14-join.sql) |
| 15 NULL 值处理 | [15-null.md](15-null.md) | [15-null.sql](../../sql/tutorial/15-null.sql) |
| 16 正则表达式（REGEXP） | [16-regexp.md](16-regexp.md) | [16-regexp.sql](../../sql/tutorial/16-regexp.sql) |
| 17 事务（Transaction） | [17-transaction.md](17-transaction.md) | [17-transaction.sql](../../sql/tutorial/17-transaction.sql) |
| 18 ALTER 修改表结构 | [18-alter.md](18-alter.md) | [18-alter.sql](../../sql/tutorial/18-alter.sql) |
| 19 索引 | [19-index.md](19-index.md) | [19-index.sql](../../sql/tutorial/19-index.sql) |
| 20 临时表 | [20-temporary-table.md](20-temporary-table.md) | [20-temporary-table.sql](../../sql/tutorial/20-temporary-table.sql) |
| 21 复制表 | [21-copy-table.md](21-copy-table.md) | [21-copy-table.sql](../../sql/tutorial/21-copy-table.sql) |
| 22 元数据 | [22-metadata.md](22-metadata.md) | [22-metadata.sql](../../sql/tutorial/22-metadata.sql) |
| 23 序列 / 自增（AUTO_INCREMENT） | [23-auto-increment.md](23-auto-increment.md) | [23-auto-increment.sql](../../sql/tutorial/23-auto-increment.sql) |
| 24 处理重复数据 | [24-duplicate.md](24-duplicate.md) | [24-duplicate.sql](../../sql/tutorial/24-duplicate.sql) |
| 25 SQL 注入防范 | [25-sql-injection.md](25-sql-injection.md) | — |
| 26 导出 / 导入数据 | [26-import-export.md](26-import-export.md) | [26-import-export.sql](../../sql/tutorial/26-import-export.sql) |

## 建议顺序

1. `00-setup` → `03` → `05` → `06` → `07`
2. `08` → `11` → `12` → `13` → `14`
3. `17` → `18` → `19` → 其余进阶模块
4. 再学习 [函数模块](../functions/00-index.md)
