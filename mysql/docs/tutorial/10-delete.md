# 10 DELETE 删除

> 独立模块。对应 SQL：[`sql/tutorial/10-delete.sql`](../../sql/tutorial/10-delete.sql)

---

按条件删除行，或清空表。

- `DELETE FROM ... WHERE ...`：删行
- `TRUNCATE TABLE`：清空并重置自增（不可回滚于部分引擎场景）

本模块演示放在事务中回滚。

[← 返回教程索引](00-index.md)
