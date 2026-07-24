# 第 15 章 InnoDB 存储引擎 · 锁与事务模型

> 对应 SQL：[`sql/refman/ch15-innodb/05-innodb-locking-transaction-model.sql`](../../../sql/refman/ch15-innodb/05-innodb-locking-transaction-model.sql)

---

## 15.7 InnoDB 锁定和事务模型

    要实现大规模、繁忙或高度可靠的数据库应用程序，从不同的数据库系统移植大量代码，或调整 MySQL 性能，了解
    `InnoDB`锁定和`InnoDB`
    事务模型很重要。

    本节讨论与
    `InnoDB`锁定和`InnoDB`
    您应该熟悉的事务模型相关的几个主题。

- 第 15.7.1 节，“InnoDB 锁定”描述了 InnoDB.
- 第 15.7.2 节，“InnoDB 事务模型”描述了事务隔离级别和每个级别使用的锁定策略。它还讨论了 autocommit、一致的非锁定读取和锁定读取的使用。
- 第 15.7.3 节，“InnoDB 中不同 SQL 语句设置的锁”InnoDB讨论了为各种语句 设置的特定类型的锁。
- 第 15.7.4 节，“幻影行”描述了如何 InnoDB使用下一键锁定来避免幻影行。
- 第 15.7.5 节，“InnoDB 中的死锁”提供了一个死锁示例，讨论了死锁检测，并提供了最小化和处理InnoDB.

---

[← 返回 第 15 章 InnoDB 存储引擎 索引](00-index.md) · [← 返回总索引](../00-index.md)
