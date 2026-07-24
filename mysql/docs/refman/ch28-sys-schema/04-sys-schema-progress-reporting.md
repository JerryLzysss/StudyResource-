# 第 28 章 MySQL 系统模式 · 进度报告

> 对应 SQL：[`sql/refman/ch28-sys-schema/04-sys-schema-progress-reporting.sql`](../../../sql/refman/ch28-sys-schema/04-sys-schema-progress-reporting.sql)

---

## 28.3 sys Schema 进度报告

      以下`sys`模式视图为长时间运行的事务提供进度报告：

```text
processlist
session
x$processlist
x$session
```

      假设启用了所需的工具和消费者`progress`，这些视图的列显示了支持进度报告的阶段的已完成工作百分比。

      阶段进度报告要求
      `events_stages_current`启用消费者，以及需要进度信息的工具。这些阶段的工具目前支持进度报告：

```text
stage/sql/Copying to tmp table
stage/innodb/alter table (end)
stage/innodb/alter table (flush)
stage/innodb/alter table (insert)
stage/innodb/alter table (log apply index)
stage/innodb/alter table (log apply table)
stage/innodb/alter table (merge sort)
stage/innodb/alter table (read PK and internal sort)
stage/innodb/buffer pool load
```

      对于不支持估计和已完成工作报告的阶段，或者如果未启用所需的工具或消费者，则该`progress`列为
      `NULL`。

---

[← 返回 第 28 章 MySQL 系统模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
