# 17 事务（Transaction）

> 独立模块。对应 SQL：[`sql/tutorial/17-transaction.sql`](../../sql/tutorial/17-transaction.sql)

---

仅 **InnoDB** 等引擎支持。ACID：原子性、一致性、隔离性、持久性。

| 语句 | 作用 |
|------|------|
| `START TRANSACTION` / `BEGIN` | 开始事务 |
| `COMMIT` | 提交 |
| `ROLLBACK` | 回滚 |
| `SAVEPOINT name` | 保存点 |
| `ROLLBACK TO name` | 回滚到保存点 |

[← 返回教程索引](00-index.md)
