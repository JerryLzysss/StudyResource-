# 03 创建 / 删除 / 选择数据库

> 独立模块。对应 SQL：[`sql/tutorial/03-database.sql`](../../sql/tutorial/03-database.sql)

---

## 说明

创建、选择、删除数据库。

```sql
CREATE DATABASE IF NOT EXISTS W3CSCHOOL
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE W3CSCHOOL;

-- DROP DATABASE IF EXISTS W3CSCHOOL;  -- 谨慎
```

命令行：`mysqladmin -u root -p create W3CSCHOOL`

[← 返回教程索引](00-index.md)
