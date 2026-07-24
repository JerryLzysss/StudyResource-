# 第 13 章 SQL 语句 · 事务与锁定语句

> 对应 SQL：[`sql/refman/ch13-sql-statements/07-sql-transactional-statements.sql`](../../../sql/refman/ch13-sql-statements/07-sql-transactional-statements.sql)

---

## 13.3 事务和锁定语句

`SET autocommit`MySQL 通过、
     `START TRANSACTION`、
    `COMMIT`和

    等语句支持本地事务（在给定的客户端会话中）
     `ROLLBACK`。请参阅
    第 13.3.1 节，“START TRANSACTION、COMMIT 和 ROLLBACK 语句”。XA 事务支持使 MySQL 也可以参与分布式事务。请参阅
    第 13.3.8 节，“XA 事务”。

---

[← 返回 第 13 章 SQL 语句 索引](00-index.md) · [← 返回总索引](../00-index.md)
