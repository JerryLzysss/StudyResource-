# 第 24 章 分区 · 分区管理

> 对应 SQL：[`sql/refman/ch24-partitioning/04-partitioning-management.sql`](../../../sql/refman/ch24-partitioning/04-partitioning-management.sql)

---

## 24.3 分区管理

      有多种使用 SQL 语句修改分区表的方法；`ALTER TABLE`可以使用语句的分区扩展来添加、删除、重新定义、合并或拆分现有分区
      。还有一些方法可以获取有关分区表和分区的信息。我们将在接下来的部分中讨论这些主题。

- 有关由RANGE或 分区的表中的分区管理的信息LIST，请参阅 第 24.3.1 节，“RANGE 和 LIST 分区的管理”。
- 有关管理HASH和 KEY分区的讨论，请参阅 第 24.3.2 节，“管理 HASH 和 KEY 分区”。
- 有关MySQL 8.0 中提供的用于获取有关分区表和分区的信息的机制的讨论， 请参阅第 24.3.5 节，“获取有关分区的信息”。
- 有关对分区执行维护操作的讨论，请参阅第 24.3.4 节，“分区维护”。

笔记

        分区表的所有分区必须具有相同数量的子分区；一旦创建了表，就不可能更改子分区。

      要改变表的分区方案，只需要使用
      `ALTER TABLE`带
      *`partition_options`*选项的语句，其语法与`CREATE TABLE`创建分区表时使用的语句相同；此选项（也）始终以关键字开头`PARTITION BY`。假设使用以下
      `CREATE TABLE`语句创建一个按范围分区的表：

```sql
CREATE TABLE trb3 (id INT, name VARCHAR(50), purchased DATE)
    PARTITION BY RANGE( YEAR(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990),
        PARTITION p1 VALUES LESS THAN (1995),
        PARTITION p2 VALUES LESS THAN (2000),
        PARTITION p3 VALUES LESS THAN (2005)
    );
```

`id`要重新分区此表，以便使用列值作为键的基础，将其

      按键分成两个分区，您可以使用以下语句：

```sql
ALTER TABLE trb3 PARTITION BY KEY(id) PARTITIONS 2;
```

      这对表的结构具有与删除表并使用重新创建表相同的效果`CREATE TABLE trb3 PARTITION BY KEY(id) PARTITIONS 2;`。

      `ALTER TABLE ... ENGINE = ...`仅更改表使用的存储引擎，并保持表的分区方案不变。仅当目标存储引擎提供分区支持时，该语句才会成功。您可以使用
      `ALTER TABLE ... REMOVE PARTITIONING`删除表的分区；参见第 13.1.9 节，“ALTER TABLE 语句”。

重要的

        在给定的语句中只能使用单个`PARTITION BY`, `ADD PARTITION`, `DROP PARTITION`,
        `REORGANIZE PARTITION`或`COALESCE PARTITION`子句
        `ALTER TABLE`。如果您（例如）希望删除分区并重新组织表的剩余分区，则必须在两个单独的
        `ALTER TABLE`语句中执行此操作（一个使用`DROP PARTITION`，然后第二个使用
        `REORGANIZE PARTITION`）。

      您可以使用 删除一个或多个选定分区中的所有行
      `ALTER TABLE ... TRUNCATE PARTITION`。

---

[← 返回 第 24 章 分区 索引](00-index.md) · [← 返回总索引](../00-index.md)
