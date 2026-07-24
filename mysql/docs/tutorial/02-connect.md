# 02 连接与管理

> 独立模块。对应 SQL：[`sql/tutorial/02-connect.sql`](../../sql/tutorial/02-connect.sql)

---

登录与查看当前连接信息。

```sql
-- 登录（命令行）
-- mysql -u root -p

SELECT USER();
SELECT VERSION();
SELECT DATABASE();
SHOW DATABASES;
SHOW TABLES;
```

[← 返回教程索引](00-index.md)
