# 第 24 章 分区 · 分区限制

> 对应 SQL：[`sql/refman/ch24-partitioning/06-partitioning-limitations.sql`](../../../sql/refman/ch24-partitioning/06-partitioning-limitations.sql)

---

## 24.6 分区的约束和限制

      本节讨论 MySQL 分区支持的当前约束和限制。

**禁止构造。**
        分区表达式中不允许使用以下构造：

- 存储过程、存储函数、可加载函数或插件。
- 声明的变量或用户变量。

      有关分区表达式中允许的 SQL 函数的列表，请参阅
      第 24.6.3 节，“与函数相关的分区限制”。

**算术和逻辑运算符。**

        在分区表达式中允许

        使用算术运算符
        `+`、
        `-`和
        。`*`但是，结果必须是整数值或`NULL`（
        `[LINEAR] KEY`分区的情况除外，如本章其他地方所讨论的；有关更多信息，请参见
        第 24.2 节，“分区类型”）。

`DIV`也支持运营商
      ；`/`操作员是不允许
    的。

分区表达式中不允许

      使用位运算符
      `|`,
       `&`,
       `^`,
       `>`和
      。`~`

**服务器 SQL 模式。**

        使用用户定义分区的表不会保留创建它们时有效的 SQL 模式。正如本手册其他地方所讨论的（参见
        第 5.1.11 节，“服务器 SQL 模式”），许多 MySQL 函数和运算符的结果可能会根据服务器 SQL 模式而改变。因此，在创建分区表后随时更改 SQL 模式可能会导致此类表的行为发生重大变化，并且很容易导致数据损坏或丢失。由于这些原因，*强烈建议您永远不要在创建分区表后更改服务器 SQL 模式*。

      对于导致分区表不可用的服务器 SQL 模式中的一个此类更改，请考虑以下
      语句，只有在该模式生效
    `CREATE TABLE`时才能成功执行
      该语句：`NO_UNSIGNED_SUBTRACTION`

```sql
mysql> SELECT @@sql_mode;
+------------+
| @@sql_mode |
+------------+
|            |
+------------+
1 row in set (0.00 sec)

mysql> CREATE TABLE tu (c1 BIGINT UNSIGNED)
    ->   PARTITION BY RANGE(c1 - 10) (
    ->     PARTITION p0 VALUES LESS THAN (-5),
    ->     PARTITION p1 VALUES LESS THAN (0),
    ->     PARTITION p2 VALUES LESS THAN (5),
    ->     PARTITION p3 VALUES LESS THAN (10),
    ->     PARTITION p4 VALUES LESS THAN (MAXVALUE)
    -> );
ERROR 1563 (HY000): Partition constant is out of partition function domain

mysql> SET sql_mode='NO_UNSIGNED_SUBTRACTION';
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT @@sql_mode;
+-------------------------+
| @@sql_mode              |
+-------------------------+
| NO_UNSIGNED_SUBTRACTION |
+-------------------------+
1 row in set (0.00 sec)

mysql> CREATE TABLE tu (c1 BIGINT UNSIGNED)
    ->   PARTITION BY RANGE(c1 - 10) (
    ->     PARTITION p0 VALUES LESS THAN (-5),
    ->     PARTITION p1 VALUES LESS THAN (0),
    ->     PARTITION p2 VALUES LESS THAN (5),
    ->     PARTITION p3 VALUES LESS THAN (10),
    ->     PARTITION p4 VALUES LESS THAN (MAXVALUE)
    -> );
Query OK, 0 rows affected (0.05 sec)
```

      如果
      `NO_UNSIGNED_SUBTRACTION`在创建后删除服务器 SQL 模式`tu`，您可能无法再访问此表：

```sql
mysql> SET sql_mode='';
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM tu;
ERROR 1563 (HY000): Partition constant is out of partition function domain
mysql> INSERT INTO tu VALUES (20);
ERROR 1563 (HY000): Partition constant is out of partition function domain
```

      另见第 5.1.11 节，“服务器 SQL 模式”。

      服务器 SQL 模式也会影响分区表的复制。源和副本上不同的 SQL 模式可能导致分区表达式的计算方式不同；这可能会导致分区之间的数据分布在给定表的源副本和副本副本中不同，甚至可能导致插入分区表在源上成功但在副本上失败。为获得最佳结果，您应该始终在源和副本上使用相同的服务器 SQL 模式。

**性能考虑。**
        以下列表给出了分区操作对性能的一些影响：

- 文件系统操作。 分区和重新分区操作（例如 ALTER TABLEwith PARTITION BY ...、 REORGANIZE PARTITION或REMOVE PARTITIONING）的实现取决于文件系统操作。这意味着这些操作的速度受文件系统类型和特性、​​磁盘速度、交换空间、操作系统的文件处理效率以及与文件处理相关的 MySQL 服务器选项和变量等因素的影响。特别是，您应该确保它 large_files_support已启用并且 open_files_limit设置正确。涉及的分区和重新分区操作InnoDB启用 .table 可以提高效率 innodb_file_per_table。 另请参阅 最大分区数。
- 表锁。 通常，对表执行分区操作的进程会对该表进行写锁定。从这些表中读取相对不受影响；pending INSERT和 UPDATE操作在分区操作完成后立即执行。有关InnoDB此限制的特定例外情况，请参阅 分区操作。
- 索引；分区修剪。 与非分区表一样，正确使用索引可以显着加快分区表的查询速度。此外，设计分区表和对这些表的查询以利用 分区修剪可以显着提高性能。有关详细信息，请参阅 第 24.4 节，“分区修剪”。 分区表支持索引条件下推。请参阅第 8.2.1.6 节，“索引条件下推优化”。
- 负载数据的性能。 在 MySQL 8.0 中，LOAD DATA使用缓冲来提高性能。您应该知道缓冲区使用每个分区 130 KB 内存来实现此目的。

**最大分区数。**
        不使用存储引擎的给定表的最大可能分区数`NDB`是 8192。这个数字包括子分区。

      使用存储引擎的表的用户定义分区的最大可能数量`NDB`取决于所使用的 NDB Cluster 软件的版本、数据节点的数量和其他因素。有关详细信息，请参阅
      NDB 和用户定义的分区。

      如果在创建具有大量分区（但少于最大值）的表时遇到错误消息，例如
      Got error ... from storage engine: Out of resources when opening file，您也许可以解决该问题通过增加
      `open_files_limit`系统变量的值。但是，这取决于操作系统，可能并非在所有平台上都可行或不可取；有关详细信息，请参阅
      第 B.3.2.16 节“未找到文件和类似错误”。在某些情况下，出于其他考虑，使用大量（数百个）分区可能也是不可取的，因此使用更多分区不会自动带来更好的结果。

      另请参阅
      文件系统操作。

**分区 InnoDB 表不支持外键。**
        使用存储引擎的分区表`InnoDB`
        不支持外键。更具体地说，这意味着以下两个陈述是正确的：

- InnoDB使用用户定义分区 的表的定义不得包含外键引用；不能InnoDB对定义包含外键引用的表进行分区。
- 任何InnoDB表定义都不能包含对用户分区表的外键引用；没有 InnoDB带有用户定义分区的表可能包含外键引用的列。

      刚刚列出的限制范围包括所有使用`InnoDB`存储引擎的表。

      不允许使用会导致表违反这些限制的语句
    `CREATE TABLE`。`ALTER TABLE`

**更改表 ... 排序依据。**针对分区表运行

        的语句会导致仅在每个分区内对行进行排序。`ALTER TABLE ... ORDER BY column`

**添加列 ... 算法 = 即时。**
        一旦
        `ALTER TABLE ... ADD COLUMN ... ALGORITHM=INSTANT`对分区表执行操作，就无法再与该表交换分区。

**通过修改主键对 REPLACE 语句的影响。**
        在某些情况下（请参阅
        第 24.6.1 节，“分区键、主键和唯一键”）可能需要修改表的主键。请注意，如果您的应用程序使用`REPLACE`
        语句并且您这样做，则这些语句的结果可能会发生巨大变化。有关更多信息和示例，
      请参阅第 13.2.9 节，“REPLACE 语句” 。

**全文索引。**
        分区表不支持`FULLTEXT`
        索引或搜索。

**空间列。**分区表中不能使用
      `POINT`
        或
        等空间数据类型的列。`GEOMETRY`

**临时表。**
        临时表不能分区。

**日志表。**
        无法对日志表进行分区；对此类表的
        `ALTER TABLE ... PARTITION BY ...`语句失败并出现错误。

**分区键的数据类型。**
        分区键必须是整数列或解析为整数的表达式。`ENUM`不能使用使用列的表达式
        。列或表达式值也可以是`NULL`；参见第 24.2.7 节，“MySQL 分区如何处理 NULL”。

      此限制有两个例外：

- 当按 [ LINEAR] 分区时KEY，可以使用除 TEXT或 BLOB作为分区键之外的任何有效 MySQL 数据类型的列，因为内部键哈希函数从这些类型中生成正确的数据类型。例如，以下两个 CREATE TABLE语句是有效的： ```sql CREATE TABLE tkc (c1 CHAR) PARTITION BY KEY(c1) PARTITIONS 4; CREATE TABLE tke ( c1 ENUM('red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet') ) PARTITION BY LINEAR KEY(c1) PARTITIONS 6; ```
- RANGE COLUMNS按或 分区时LIST COLUMNS，可以使用字符串 DATE、 和 DATETIME列。例如，以下每个CREATE TABLE语句都是有效的： ```sql CREATE TABLE rc (c1 INT, c2 DATE) PARTITION BY RANGE COLUMNS(c2) ( PARTITION p0 VALUES LESS THAN('1990-01-01'), PARTITION p1 VALUES LESS THAN('1995-01-01'), PARTITION p2 VALUES LESS THAN('2000-01-01'), PARTITION p3 VALUES LESS THAN('2005-01-01'), PARTITION p4 VALUES LESS THAN(MAXVALUE) ); CREATE TABLE lc (c1 INT, c2 CHAR(1)) PARTITION BY LIST COLUMNS(c2) ( PARTITION p0 VALUES IN('a', 'd', 'g', 'j', 'm', 'p', 's', 'v', 'y'), PARTITION p1 VALUES IN('b', 'e', 'h', 'k', 'n', 'q', 't', 'w', 'z'), PARTITION p2 VALUES IN('c', 'f', 'i', 'l', 'o', 'r', 'u', 'x', NULL) ); ```

      上述异常均不适用于
      `BLOB`或
      `TEXT`列类型。

**子查询。**
        分区键可能不是子查询，即使该子查询解析为整数值或`NULL`。

**键分区不支持列索引前缀。**
        创建按键分区的表时，分区键中使用列前缀的任何列都不会在表的分区函数中使用。考虑以下
        `CREATE TABLE`语句，它有三`VARCHAR`列，其主键使用所有三列并为其中两列指定前缀：

```sql
CREATE TABLE t1 (
    a VARCHAR(10000),
    b VARCHAR(25),
    c VARCHAR(10),
    PRIMARY KEY (a(10), b, c(2))
) PARTITION BY KEY() PARTITIONS 2;
```

      此语句被接受，但结果表实际上是像您发出以下语句一样创建的，仅使用不包含
      `b`分区键前缀（列）的主键列：

```sql
CREATE TABLE t1 (
    a VARCHAR(10000),
    b VARCHAR(25),
    c VARCHAR(10),
    PRIMARY KEY (a(10), b, c(2))
) PARTITION BY KEY(b) PARTITIONS 2;
```

      在 MySQL 8.0.21 之前，如果发生这种情况，则不会发出警告或任何其他指示，除非为分区键指定的所有列都使用前缀，在这种情况下语句失败，但会出现误导性的错误消息，如显示在这里：

```sql
mysql> CREATE TABLE t2 (
    ->     a VARCHAR(10000),
    ->     b VARCHAR(25),
    ->     c VARCHAR(10),
    ->     PRIMARY KEY (a(10), b(5), c(2))
    -> ) PARTITION BY KEY() PARTITIONS 2;
ERROR 1503 (HY000): A PRIMARY KEY must include all columns in the
table's partitioning function
```

`ALTER TABLE`在执行或升级此类表时

      也会发生这种情况。

      从 MySQL 8.0.21 开始，这种允许行为已被弃用（并且在未来的 MySQL 版本中可能会被删除）。从 MySQL 8.0.21 开始，在分区键中使用一个或多个具有前缀的列会导致对每个此类列发出警告，如下所示：

```sql
mysql> CREATE TABLE t1 (
    ->     a VARCHAR(10000),
    ->     b VARCHAR(25),
    ->     c VARCHAR(10),
    ->     PRIMARY KEY (a(10), b, c(2))
    -> ) PARTITION BY KEY() PARTITIONS 2;
Query OK, 0 rows affected, 2 warnings (1.25 sec)

mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
  Level: Warning
   Code: 1681
Message: Column 'test.t1.a' having prefix key part 'a(10)' is ignored by the
partitioning function. Use of prefixed columns in the PARTITION BY KEY() clause
is deprecated and will be removed in a future release.
*************************** 2. row ***************************
  Level: Warning
   Code: 1681
Message: Column 'test.t1.c' having prefix key part 'c(2)' is ignored by the
partitioning function. Use of prefixed columns in the PARTITION BY KEY() clause
is deprecated and will be removed in a future release.
2 rows in set (0.00 sec)
```

      这包括通过使用空`PARTITION BY KEY()`子句将分区函数中使用的列隐式定义为表主键中的列的情况。

      在 MySQL 8.0.21 及更高版本中，如果为分区键指定的所有列都使用前缀，则使用的`CREATE TABLE`语句将失败并显示一条正确标识问题的错误消息：

```sql
mysql> CREATE TABLE t1 (
    ->     a VARCHAR(10000),
    ->     b VARCHAR(25),
    ->     c VARCHAR(10),
    ->     PRIMARY KEY (a(10), b(5), c(2))
    -> ) PARTITION BY KEY() PARTITIONS 2;
ERROR 1503 (HY000): A PRIMARY KEY must include all columns in the table's
partitioning function (prefixed columns are not considered).
```

      有关按键分区表的一般信息，请参阅
      第 24.2.5 节，“KEY 分区”。

**子分区的问题。**
        子分区必须使用`HASH`或
        `KEY`分区。只有
        `RANGE`和`LIST`分区可以被子分区；`HASH`并且
        `KEY`分区不能被子分区。

      `SUBPARTITION BY KEY`要求显式指定一个或多个子分区列，这与 的情况不同`PARTITION BY KEY`，后者可以省略（在这种情况下默认使用表的主键列）。考虑此语句创建的表：

```sql
CREATE TABLE ts (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30)
);
```

      您可以使用如下语句创建一个具有相同列并按 分区的表
      `KEY`：

```sql
CREATE TABLE ts (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30)
)
PARTITION BY KEY()
PARTITIONS 4;
```

      前面的语句被认为是这样写的，表的主键列用作分区列：

```sql
CREATE TABLE ts (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30)
)
PARTITION BY KEY(id)
PARTITIONS 4;
```

      但是，以下尝试使用默认列作为子分区列创建子分区表的语句失败，必须指定该列才能使语句成功，如下所示：

```sql
mysql> CREATE TABLE ts (
    ->     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(30)
    -> )
    -> PARTITION BY RANGE(id)
    -> SUBPARTITION BY KEY()
    -> SUBPARTITIONS 4
    -> (
    ->     PARTITION p0 VALUES LESS THAN (100),
    ->     PARTITION p1 VALUES LESS THAN (MAXVALUE)
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that
corresponds to your MySQL server version for the right syntax to use near ')

mysql> CREATE TABLE ts (
    ->     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(30)
    -> )
    -> PARTITION BY RANGE(id)
    -> SUBPARTITION BY KEY(id)
    -> SUBPARTITIONS 4
    -> (
    ->     PARTITION p0 VALUES LESS THAN (100),
    ->     PARTITION p1 VALUES LESS THAN (MAXVALUE)
    -> );
Query OK, 0 rows affected (0.07 sec)
```

      这是一个已知问题（请参阅错误 #51470）。

**数据目录和索引目录选项。**
        表级`DATA DIRECTORY`和`INDEX DIRECTORY`选项被忽略（参见错误 #32091）。您可以对表的单个分区或子分区使用这些选项`InnoDB`。从 MySQL 8.0.21 开始，子句中指定的目录`DATA DIRECTORY`必须为
        `InnoDB`. 有关详细信息，请参阅
        使用 DATA DIRECTORY 子句。

**修复和重建分区表。**分区表支持

        语句`CHECK TABLE`、
         `OPTIMIZE TABLE`、
        `ANALYZE TABLE`和
        。`REPAIR TABLE`

      此外，您可以使用`ALTER TABLE ... REBUILD PARTITION`重建分区表的一个或多个分区；`ALTER TABLE ... REORGANIZE PARTITION`也会导致分区重建。有关这两个语句的更多信息，
    请参见
      第 13.1.9 节，“ALTER TABLE 语句” 。

      `ANALYZE`、`CHECK`、
       `OPTIMIZE`、`REPAIR`和
      `TRUNCATE`子分区支持操作。请参阅
      第 13.1.9.1 节，“ALTER TABLE 分区操作”。

**分区和子分区的文件名分隔符。**
        表分区和子分区文件名包括生成的分隔符，例如`#P#`和
        `#SP#`。此类分隔符的字母大小写可能会有所不同，不应依赖于此。

---

[← 返回 第 24 章 分区 索引](00-index.md) · [← 返回总索引](../00-index.md)
