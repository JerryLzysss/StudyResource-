# 第 26 章 INFORMATION_SCHEMA 表 · STATISTICS

> 对应 SQL：[`sql/refman/ch26-information-schema/05-information-schema-statistics-table.sql`](../../../sql/refman/ch26-information-schema/05-information-schema-statistics-table.sql)

---

26.3.34 INFORMATION_SCHEMA 统计表_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 26 章 INFORMATION_SCHEMA 表 / 26.3 INFORMATION_SCHEMA 总表 / 26.3.34 INFORMATION_SCHEMA 统计表 该STATISTICS表提供有关表索引的信息。 STATISTICS表示表统计信息 的列保存缓存值。系统变量定义缓存表统计信息过期之前的 information_schema_stats_expiry 时间段。默认值为 86400 秒（24 小时）。如果没有缓存统计信息或统计信息已过期，则在查询表统计信息列时从存储引擎中检索统计信息。要随时更新给定表的缓存值，请使用ANALYZE TABLE. 要始终直接从存储引擎检索最新统计信息，请设置 information_schema_stats_expiry=0. 有关详细信息，请参阅 第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”。 笔记 如果innodb_read_only启用了系统变量，ANALYZE TABLE可能会失败，因为它无法更新数据字典中使用 InnoDB. 对于ANALYZE TABLE更新键分布的操作，即使操作更新表本身（例如，如果它是一个MyISAM表）也可能会失败。要获取更新的分布统计信息，请设置 information_schema_stats_expiry=0. 该STATISTICS表有以下列： TABLE_CATALOG 包含索引的表所属目录的名称。该值始终为def.
- TABLE_SCHEMA 包含索引的表所属的模式（数据库）的名称。
- TABLE_NAME 包含索引的表的名称。
- NON_UNIQUE 如果索引不能包含重复项，则为 0，如果可以，则为 1。
- INDEX_SCHEMA 索引所属的模式（数据库）的名称。
- INDEX_NAME 索引的名称。如果索引是主键，则名称始终是PRIMARY。
- SEQ_IN_INDEX 索引中的列序号，从 1 开始。
- COLUMN_NAME 列名称。另请参阅 EXPRESSION列的说明。
- COLLATION 列在索引中的排序方式。这可以具有值 A（升序）、D （降序）或NULL（未排序）。
- CARDINALITY 索引中唯一值数量的估计。要更新此数字，请运行ANALYZE TABLE或（对于MyISAM表） myisamchk -a。 CARDINALITY基于存储为整数的统计信息进行计数，因此即使对于小表，该值也不一定准确。基数越高，MySQL 在进行连接时使用索引的机会就越大。
- SUB_PART 索引前缀。也就是说，如果列仅被部分索引，则索引字符数，NULL如果整个列被索引。 笔记 前缀限制以字节为单位。但是，、 和语句中索引规范的前缀长度被解释为非二进制字符串类型（ 、 、 ）的字符数和二进制字符串类型（ 、 、 ） 的 字节数。在为使用多字节字符集的非二进制字符串列指定前缀长度时，请考虑这一点。 CREATE TABLEALTER TABLECREATE INDEXCHARVARCHARTEXTBINARYVARBINARYBLOB 有关索引前缀的其他信息，请参阅 第 8.3.5 节，“列索引”和 第 13.1.15 节，“CREATE INDEX 语句”。
- PACKED 指示密钥的打包方式。NULL如果不是。
- NULLABLE YES如果列可能包含 值NULL，则包含，''如果不包含。
- INDEX_TYPE 使用的索引方法 ( BTREE, FULLTEXT, HASH, RTREE)。
- COMMENT 有关未在其自己的列中描述的索引的信息，例如disabled索引是否被禁用。
- INDEX_COMMENT COMMENT创建索引时为具有属性的 索引提供的任何注释 。
- IS_VISIBLE 索引是否对优化器可见。请参阅 第 8.3.12 节，“不可见索引”。
- EXPRESSION MySQL 8.0.13 及更高版本支持功能键部分（请参阅 功能键部分），这会同时影响COLUMN_NAME和 EXPRESSION列： 对于非功能性关键部分， COLUMN_NAME指示由关键部分索引的列并且EXPRESSION 是NULL。
- 对于功能键部分，COLUMN_NAME column是NULL和 EXPRESSION表示键部分的表达式。

#### 笔记

- 索引没有标准INFORMATION_SCHEMA 表。MySQL 列列表类似于 SQL Server 2000 为 返回的内容sp_statistics，不同之处在于QUALIFIER和 OWNER分别替换为 CATALOG和SCHEMA。

      有关表索引的信息也可从
      `SHOW INDEX`语句中获得。请参阅
      第 13.7.7.22 节，“SHOW INDEX 语句”。以下语句是等效的：

```sql
SELECT * FROM INFORMATION_SCHEMA.STATISTICS
  WHERE table_name = 'tbl_name'
  AND table_schema = 'db_name'

SHOW INDEX
  FROM tbl_name
  FROM db_name
```

      在MySQL 8.0.30及之后的版本中，生成的不可见主键列的信息默认在该表中是可见的。您可以通过设置隐藏此类信息
      `show_gipk_in_create_table_and_information_schema = OFF`。有关详细信息，请参阅
      第 13.1.20.11 节，“生成的不可见主键”。

---

[← 返回 第 26 章 INFORMATION_SCHEMA 表 索引](00-index.md) · [← 返回总索引](../00-index.md)
