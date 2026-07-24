# 05 创建 / 删除数据表

> 独立模块。对应 SQL：[`sql/tutorial/05-create-table.sql`](../../sql/tutorial/05-create-table.sql)

---

## 语法

```sql
CREATE TABLE table_name (
  column_name column_type
  [, ...]
);
```

要点：`NOT NULL`、`AUTO_INCREMENT`、`PRIMARY KEY`。

```sql
DROP TABLE IF EXISTS w3cschool_tbl;
```

[← 返回教程索引](00-index.md)
