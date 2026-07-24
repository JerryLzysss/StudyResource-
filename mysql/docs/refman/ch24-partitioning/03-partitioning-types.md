# 第 24 章 分区 · 分区类型

> 对应 SQL：[`sql/refman/ch24-partitioning/03-partitioning-types.sql`](../../../sql/refman/ch24-partitioning/03-partitioning-types.sql)

---

## 24.2 分区类型

      本节讨论 MySQL 8.0 中可用的分区类型。这些包括此处列出的类型：

- 范围分区。 这种类型的分区根据落在给定范围内的列值将行分配给分区。请参阅 第 24.2.1 节，“RANGE 分区”。有关此类型的扩展的信息RANGE COLUMNS，请参阅第 24.2.3.1 节，“RANGE COLUMNS 分区”。
- 列表分区。 类似于 分区RANGE，不同之处在于分区是根据与一组离散值中的一个相匹配的列来选择的。请参阅 第 24.2.2 节，“LIST 分区”。有关此类型的扩展的信息LIST COLUMNS，请参阅第 24.2.3.2 节，“LIST COLUMNS 分区”。
- 哈希分区。 使用这种类型的分区，分区是根据用户定义的表达式返回的值来选择的，该表达式对要插入到表中的行中的列值进行操作。该函数可以由任何在 MySQL 中有效且产生整数值的表达式组成。请参阅 第 24.2.4 节，“散列分区”。 此类型的扩展LINEAR HASH，也可用，请参阅 第 24.2.4.1 节，“线性散列分区”。
- KEY分区。 这种类型的分区类似于按 分区 HASH，除了只提供一个或多个要评估的列，并且 MySQL 服务器提供自己的哈希函数。这些列可以包含整数值以外的值，因为 MySQL 提供的散列函数保证了整数结果，而不管列数据类型如何。此类型的扩展 LINEAR KEY，也可用。请参阅 第 24.2.5 节，“密钥分区”。

      数据库分区的一个非常常见的用途是按日期分隔数据。一些数据库系统支持显式日期分区，MySQL 在 8.0 中没有实现。`DATE`但是，在 MySQL 中创建基于、
      `TIME`或
      `DATETIME`列或基于使用此类列的表达式的
    分区方案并不困难
      。

`KEY`按或
      分区时`LINEAR KEY`，您可以使用`DATE`、
      `TIME`或
      `DATETIME`列作为分区列，而无需对列值执行任何修改。例如，这条建表语句在 MySQL 中是完全有效的：

```sql
CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)
PARTITION BY KEY(joined)
PARTITIONS 6;
```

      在 MySQL 8.0 中，也可以使用
      `DATE`or
      `DATETIME`列作为 using `RANGE COLUMNS`and `LIST COLUMNS`partitioning 的分区列。

      其他分区类型需要生成整数值或 的分区表达式`NULL`。如果您希望按`RANGE`、
       `LIST`、`HASH`或
      来使用基于日期的分区`LINEAR HASH`，您可以简单地使用对 、 或 列进行操作`DATE`并
      `TIME`返回
      `DATETIME`此类值的函数，如下所示：

```sql
CREATE TABLE members (
    firstname VARCHAR(25) NOT NULL,
    lastname VARCHAR(25) NOT NULL,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(35),
    joined DATE NOT NULL
)
PARTITION BY RANGE( YEAR(joined) ) (
    PARTITION p0 VALUES LESS THAN (1960),
    PARTITION p1 VALUES LESS THAN (1970),
    PARTITION p2 VALUES LESS THAN (1980),
    PARTITION p3 VALUES LESS THAN (1990),
    PARTITION p4 VALUES LESS THAN MAXVALUE
);
```

      在本章的以下部分中可以找到使用日期进行分区的其他示例：

- 第 24.2.1 节，“RANGE 分区”
- 第 24.2.4 节，“哈希分区”
- 第 24.2.4.1 节，“线性散列分区”

      有关基于日期的分区的更复杂示例，请参阅以下部分：

- 第 24.4 节，“分区修剪”
- 第 24.2.6 节，“子分区”

      MySQL 分区针对与 、 和 函数一起使用进行
      `TO_DAYS()`了
      `YEAR()`优化
      `TO_SECONDS()`。但是，您可以使用其他返回整数或 的日期和时间函数`NULL`，例如
      `WEEKDAY()`、
      `DAYOFYEAR()`或
      `MONTH()`。有关此类函数的更多信息，
    请参阅
      第 12.7 节，“日期和时间函数” 。

      重要的是要记住——无论您使用的分区类型如何——分区总是在创建时自动按顺序编号，从
      `0`. 将新行插入分区表时，正是这些分区号用于识别正确的分区。例如，如果您的表使用 4 个分区，则这些分区的编号为`0`、
       `1`、`2`和
      `3`。对于分区类型`RANGE`，
      `LIST`需要保证每个分区号都有定义的分区。对于`HASH`分区，用户提供的表达式的计算结果必须为整数值。为了
      `KEY`分区，这个问题由 MySQL 服务器内部使用的散列函数自动处理。

      分区的名称通常遵循管理其他 MySQL 标识符的规则，例如表和数据库的名称。但是，您应该注意分区名称不区分大小写。例如，以下
      `CREATE TABLE`语句失败，如下所示：

```sql
mysql> CREATE TABLE t2 (val INT)
    -> PARTITION BY LIST(val)(
    ->     PARTITION mypart VALUES IN (1,3,5),
    ->     PARTITION MyPart VALUES IN (2,4,6)
    -> );
ERROR 1488 (HY000): Duplicate partition name mypart
```

      失败是因为 MySQL 认为分区名称`mypart`和
      `MyPart`.

      当您指定表的分区数时，这必须表示为不带前导零的正非零整数文字，并且不能是诸如
      `0.8E+01`or之类的表达式`6-2`，即使它的计算结果为整数值也是如此。不允许使用小数。

      在接下来的部分中，我们不必提供可用于创建每种分区类型的语法的所有可能形式；有关此信息，请参阅
      第 13.1.20 节，“CREATE TABLE 语句”。

---

[← 返回 第 24 章 分区 索引](00-index.md) · [← 返回总索引](../00-index.md)
