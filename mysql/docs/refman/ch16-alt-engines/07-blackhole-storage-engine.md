# 第 16 章 替代存储引擎 · BLACKHOLE

> 对应 SQL：[`sql/refman/ch16-alt-engines/07-blackhole-storage-engine.sql`](../../../sql/refman/ch16-alt-engines/07-blackhole-storage-engine.sql)

---

## 16.6 BLACKHOLE存储引擎

`BLACKHOLE`存储引擎充当一个

    “黑洞”，接受数据但丢弃它并且不存储它。检索总是返回空结果：

```sql
mysql> CREATE TABLE test(i INT, c CHAR(10)) ENGINE = BLACKHOLE;
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO test VALUES(1,'record one'),(2,'record two');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM test;
Empty set (0.00 sec)
```

`BLACKHOLE`如果您从源代码构建 MySQL，
    要启用存储引擎，请使用该

    选项
  调用**CMake 。**`-DWITH_BLACKHOLE_STORAGE_ENGINE`

    要检查`BLACKHOLE`引擎的源代码，请查看`sql`MySQL 源代码分发目录。

    创建`BLACKHOLE`表时，服务器会在全局数据字典中创建表定义。没有与表关联的文件。

    存储引擎支持各种`BLACKHOLE`索引。也就是说，您可以在表定义中包含索引声明。

    从 MySQL 8.0.27 开始，最大密钥长度为 3072 字节。在 8.0.27 之前，最大密钥长度为 1000 字节。

`BLACKHOLE`存储引擎不支持分区

    。

    您可以使用该语句
  检查`BLACKHOLE`存储引擎是否可用。`SHOW ENGINES`

    插入`BLACKHOLE`表不会存储任何数据，但如果启用了基于语句的二进制日志记录，则会记录 SQL 语句并将其复制到副本服务器。这可用作中继器或过滤器机制。

    假设你的应用需要副本端的过滤规则，但是先把二进制日志数据全部传到副本，导致流量过大。在这种情况下，可以在复制源服务器上设置一个默认存储引擎为的“虚拟”副本进程，`BLACKHOLE`如下所示：

**图 16.1 使用 BLACKHOLE 进行过滤的复制**

**源写入其二进制日志。“虚拟” mysqld**进程充当副本，应用所需的 和 规则组合，`replicate-do-*`并
    `replicate-ignore-*`写入一个新的、经过过滤的自己的二进制日志。（请参阅
    第 17.1.6 节，“复制和二进制日志记录选项和变量”。）此过滤后的日志提供给副本。

虚拟进程实际上不存储任何数据，因此在复制源服务器上运行额外的**mysqld**进程
    几乎不会产生处理开销
    。这种类型的设置可以用额外的副本重复。

    `INSERT`表的触发器
    `BLACKHOLE`按预期工作。但是，因为该`BLACKHOLE`表实际上没有存储任何数据，`UPDATE`并且
    `DELETE`没有激活触发器：`FOR EACH ROW`触发器定义中的子句不适用，因为没有行。

`BLACKHOLE`存储引擎

    的其他可能用途包括：

- 验证转储文件语法。
- 通过比较BLACKHOLE启用和不启用二进制日志记录的性能，测量二进制日志记录的开销。
- BLACKHOLE本质上是一个 “无操作”存储引擎，因此它可用于查找与存储引擎本身无关的性能瓶颈。

    该`BLACKHOLE`引擎是事务感知的，在这个意义上，提交的事务被写入二进制日志，而回滚的事务则没有。

    **黑洞引擎和自增列**

    该`BLACKHOLE`引擎是一个空操作引擎。使用 对表执行的任何操作`BLACKHOLE`
    都无效。在考虑自动递增的主键列的行为时，应该牢记这一点。引擎不会自动递增字段值，也不会保留自动递增字段状态。这对复制具有重要意义。

    考虑以下所有三个条件都适用的复制方案：

- 在源服务器上有一个黑洞表，它有一个作为主键的自增字段。
- 在副本上存在相同的表，但使用 MyISAM 引擎。
- 插入是在源表中执行的，而无需在 INSERT语句本身或通过使用 SET INSERT_ID语句中显式设置自动增量值。

    在这种情况下，复制失败并在主键列上出现重复条目​​错误。

    在基于语句的复制中，
    `INSERT_ID`上下文事件中的值始终相同。因此，由于尝试插入具有主键列重复值的行，复制失败。

    在基于行的复制中，引擎为行返回的值对于每次插入始终相同。这会导致副本尝试使用相同的主键列值重放两个插入日志条目，因此复制失败。

    **列过滤**

    使用基于行的复制 ( `binlog_format=ROW`) 时，支持表中缺少最后一列的副本，如
    第 17.5.1.9 节“在源和副本上使用不同表定义进行复制”中所述。

    此过滤在副本端起作用，即，列在被过滤掉之前被复制到副本。至少有两种情况不希望将列复制到副本：

- 如果数据是机密的，那么副本服务器不应该访问它。
- 如果源有很多副本，在发送到副本之前进行过滤可能会减少网络流量。

    可以使用
    `BLACKHOLE`引擎实现源列过滤。这是以类似于如何实现源表过滤的方式执行的 - 通过使用
    `BLACKHOLE`引擎和
    `--replicate-do-table`or
    `--replicate-ignore-table`选项。

    源的设置是：

```sql
CREATE TABLE t1 (public_col_1, ..., public_col_N,
                 secret_col_1, ..., secret_col_M) ENGINE=MyISAM;
```

    可信副本的设置是：

```sql
CREATE TABLE t1 (public_col_1, ..., public_col_N) ENGINE=BLACKHOLE;
```

    不可信副本的设置是：

```sql
CREATE TABLE t1 (public_col_1, ..., public_col_N) ENGINE=MyISAM;
```

---

[← 返回 第 16 章 替代存储引擎 索引](00-index.md) · [← 返回总索引](../00-index.md)
