# 第 16 章 替代存储引擎 · 章首

> 对应 SQL：[`sql/refman/ch16-alt-engines/01-storage-engines.sql`](../../../sql/refman/ch16-alt-engines/01-storage-engines.sql)

---

# 第 16 章替代存储引擎

    存储引擎是处理不同表类型的 SQL 操作的 MySQL 组件。`InnoDB`是默认和最通用的存储引擎，Oracle 建议将它用于表，特殊用例除外。（`CREATE TABLE`MySQL 8.0 中的语句`InnoDB`默认创建表。）

    MySQL 服务器使用可插拔存储引擎架构，使存储引擎能够加载到正在运行的 MySQL 服务器或从中卸载。

    要确定您的服务器支持哪些存储引擎，请使用该
    `SHOW ENGINES`语句。列中的值`Support`指示是否可以使用引擎。值`YES`、
    `NO`或`DEFAULT`指示引擎可用、不可用或可用且当前设置为默认存储引擎。

```sql
mysql> SHOW ENGINES\G
*************************** 1. row ***************************
      Engine: PERFORMANCE_SCHEMA
     Support: YES
     Comment: Performance Schema
Transactions: NO
          XA: NO
  Savepoints: NO
*************************** 2. row ***************************
      Engine: InnoDB
     Support: DEFAULT
     Comment: Supports transactions, row-level locking, and foreign keys
Transactions: YES
          XA: YES
  Savepoints: YES
*************************** 3. row ***************************
      Engine: MRG_MYISAM
     Support: YES
     Comment: Collection of identical MyISAM tables
Transactions: NO
          XA: NO
  Savepoints: NO
*************************** 4. row ***************************
      Engine: BLACKHOLE
     Support: YES
     Comment: /dev/null storage engine (anything you write to it disappears)
Transactions: NO
          XA: NO
  Savepoints: NO
*************************** 5. row ***************************
      Engine: MyISAM
     Support: YES
     Comment: MyISAM storage engine
Transactions: NO
          XA: NO
  Savepoints: NO
...
```

    本章涵盖了专用 MySQL 存储引擎的用例。它不涵盖默认
    `InnoDB`存储引擎或
    第 15 章*InnoDB 存储引擎*和
    第 23 章*MySQL NDB Cluster 8.0*`NDB`中涵盖
    的存储引擎。对于高级用户，它还包含可插入存储引擎架构的描述（请参阅第 16.11 节，“MySQL 存储引擎架构概述”）。
  ****

    有关商业 MySQL 服务器二进制文件中提供的功能的信息，请参阅
    MySQL 网站上的[*MySQL 版本*](https://www.mysql.com/products/)。可用的存储引擎可能取决于您使用的 MySQL 版本。

    有关 MySQL 存储引擎的常见问题解答，请参阅第 A.2 节，“MySQL 8.0 FAQ：存储引擎”。

## MySQL 8.0 支持的存储引擎

- InnoDB: MySQL 8.0 中的默认存储引擎。 InnoDB是 MySQL 的事务安全（符合 ACID）存储引擎，具有提交、回滚和崩溃恢复功能以保护用户数据。 InnoDB行级锁定（无需升级到更粗粒度的锁定）和 Oracle 风格的一致非锁定读取可提高多用户并发性和性能。InnoDB将用户数据存储在聚簇索引中，以减少基于主键的常见查询的 I/O。为了保持数据完整性， InnoDB还支持FOREIGN KEY引用完整性约束。有关 的更多信息InnoDB，请参阅 第 15 章，InnoDB 存储引擎。
- MyISAM：这些表占地面积小。 表级锁定 限制了读/写工作负载的性能，因此它通常用于 Web 和数据仓库配置中的只读或以读为主的工作负载。
- Memory：将所有数据存储在 RAM 中，以便在需要快速查找非关键数据的环境中进行快速访问。该发动机以前称为HEAP发动机。它的用例正在减少；InnoDB凭借其缓冲池内存区域，提供了一种通用且持久的方式来将大部分或全部数据保存在内存中，并 NDBCLUSTER为庞大的分布式数据集提供快速键值查找。
- CSV: 它的表格实际上是具有逗号分隔值的文本文件。CSV 表允许您以 CSV 格式导入或转储数据，以便与读写相同格式的脚本和应用程序交换数据。由于 CSV 表没有索引，您通常InnoDB在正常操作期间将数据保留在表中，并且仅在导入或导出阶段使用 CSV 表。
- Archive：这些紧凑的、未索引的表用于存储和检索大量很少引用的历史、存档或安全审计信息。
- Blackhole: Blackhole 存储引擎接受但不存储数据，类似于 Unix/dev/null设备。查询总是返回一个空集。这些表可用于将 DML 语句发送到副本服务器的复制配置，但源服务器不保留其自己的数据副本。
- NDB（也称为 NDBCLUSTER）：此集群数据库引擎特别适用于需要尽可能高的正常运行时间和可用性的应用程序。
- Merge：使 MySQL DBA 或开发人员能够对一系列相同的MyISAM表进行逻辑分组，并将它们作为一个对象进行引用。适用于数据仓库等 VLDB 环境。
- Federated：提供链接独立的 MySQL 服务器以从许多物理服务器创建一个逻辑数据库的能力。非常适合分布式或数据集市环境。
- Example：该引擎作为 MySQL 源代码中的示例，说明如何开始编写新的存储引擎。它主要是开发人员感兴趣的。存储引擎是一个 什么都不做的“存根” 。您可以使用此引擎创建表，但不能在其中存储或从中检索任何数据。

    您不限于对整个服务器或模式使用相同的存储引擎。您可以为任何表指定存储引擎。例如，一个应用程序可能主要使用
    `InnoDB`表，其中一个`CSV`
    表用于将数据导出到电子表格，而一些
    `MEMORY`表用于临时工作区。

    **选择存储引擎**

    MySQL 提供的各种存储引擎在设计时考虑了不同的用例。下表概述了 MySQL 提供的一些存储引擎，并在表后附有说明。

**表 16.1 存储引擎功能摘要**

| 特征 | MyISAM | 记忆 | InnoDB | 档案 | 新开发银行 |
| --- | --- | --- | --- | --- | --- |
| B树索引 | 是的 | 是的 | 是的 | 不 | 不 |
| 备份/时间点恢复（注 1） | 是的 | 是的 | 是的 | 是的 | 是的 |
| 集群数据库支持 | 不 | 不 | 不 | 不 | 是的 |
| 聚簇索引 | 不 | 不 | 是的 | 不 | 不 |
| 压缩数据 | 是（注 2） | 不 | 是的 | 是的 | 不 |
| 数据缓存 | 不 | 不适用 | 是的 | 不 | 是的 |
| 加密数据 | 是（注 3） | 是（注 3） | 是（注4） | 是（注 3） | 是（注 3） |
| 外键支持 | 不 | 不 | 是的 | 不 | 是（注 5） |
| 全文搜索索引 | 是的 | 不 | 是（注 6） | 不 | 不 |
| 地理空间数据类型支持 | 是的 | 不 | 是的 | 是的 | 是的 |
| 地理空间索引支持 | 是的 | 不 | 是（注 7） | 不 | 不 |
| 哈希索引 | 不 | 是的 | 否（注 8） | 不 | 是的 |
| 索引缓存 | 是的 | 不适用 | 是的 | 不 | 是的 |
| 锁定粒度 | 桌子 | 桌子 | 排 | 排 | 排 |
| MVCC | 不 | 不 | 是的 | 不 | 不 |
| 复制支持（注释 1） | 是的 | 有限（注 9） | 是的 | 是的 | 是的 |
| 存储限制 | 256TB | 内存 | 64TB | 没有任何 | 384EB |
| T树索引 | 不 | 不 | 不 | 不 | 是的 |
| 交易 | 不 | 不 | 是的 | 不 | 是的 |
| 更新数据字典的统计信息 | 是的 | 是的 | 是的 | 是的 | 是的 |

**笔记：**

1.在服务器中实现，而不是在存储引擎中。

2. 仅在使用压缩行格式时才支持压缩的 MyISAM 表。在 MyISAM 中使用压缩行格式的表是只读的。

3.通过加密功能在服务器端实现。

4.通过加密功能在服务器端实现；在 MySQL 5.7 及更高版本中，支持静态数据加密。

5. MySQL Cluster NDB 7.3 及更高版本支持外键。

6. MySQL 5.6 及更高版本支持全文索引。

7. MySQL 5.7 及更高版本支持地理空间索引。

8. InnoDB 在内部利用哈希索引来实现其自适应哈希索引功能。

9. 请参阅本节后面的讨论。

---

[← 返回 第 16 章 替代存储引擎 索引](00-index.md) · [← 返回总索引](../00-index.md)
