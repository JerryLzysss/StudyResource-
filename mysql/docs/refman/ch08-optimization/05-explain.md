# 第 8 章 优化 · EXPLAIN

> 对应 SQL：[`sql/refman/ch08-optimization/05-explain.sql`](../../../sql/refman/ch08-optimization/05-explain.sql)

---

13.8.2 EXPLAIN 语句_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 13 章 SQL 语句 / 13.8 效用语句 / 13.8.2 EXPLAIN 语句 ```sql {EXPLAIN | DESCRIBE | DESC} tbl_name [col_name | wild] {EXPLAIN | DESCRIBE | DESC} [explain_type] {explainable_stmt | FOR CONNECTION connection_id} {EXPLAIN | DESCRIBE | DESC} ANALYZE [FORMAT = TREE] select_statement explain_type: { FORMAT = format_name } format_name: { TRADITIONAL | JSON | TREE } explainable_stmt: { SELECT statement | TABLE statement | DELETE statement | INSERT statement | REPLACE statement | UPDATE statement } ``` 和DESCRIBE语句 EXPLAIN是同义词。在实践中，DESCRIBE关键字更多的是用来获取表结构的信息，而EXPLAIN用来获取查询的执行计划（即MySQL将如何执行查询的解释）。 以下讨论 根据这些用途使用DESCRIBE和 EXPLAIN关键字，但 MySQL 解析器将它们视为完全同义词。 获取表结构信息
- 获取执行计划信息
- 使用 EXPLAIN ANALYZE 获取信息

#### 获取表结构信息

        `DESCRIBE`提供有关表中列的信息：

```sql
mysql> DESCRIBE City;
+------------+----------+------+-----+---------+----------------+
| Field      | Type     | Null | Key | Default | Extra          |
+------------+----------+------+-----+---------+----------------+
| Id         | int(11)  | NO   | PRI | NULL    | auto_increment |
| Name       | char(35) | NO   |     |         |                |
| Country    | char(3)  | NO   | UNI |         |                |
| District   | char(20) | YES  | MUL |         |                |
| Population | int(11)  | NO   |     | 0       |                |
+------------+----------+------+-----+---------+----------------+
```

        `DESCRIBE`是 的快捷方式
        `SHOW COLUMNS`。这些语句还显示视图的信息。的描述
        `SHOW COLUMNS`提供了有关输出列的更多信息。请参阅
        第 13.7.7.5 节，“显示列语句”。

        默认情况下，`DESCRIBE`显示有关表中所有列的信息。
        *`col_name`*，如果给定，是表中列的名称。在这种情况下，该语句仅显示指定列的信息。
        *`wild`*，如果给定，是一个模式字符串。它可以包含 SQL`%`和
        `_`通配符。在这种情况下，该语句仅显示名称与字符串匹配的列的输出。除非字符串包含空格或其他特殊字符，否则无需将字符串括在引号内。

        提供该`DESCRIBE`语句是为了与 Oracle 兼容。

        、`SHOW CREATE TABLE`和
        语句还提供有关表的信息`SHOW TABLE STATUS`。
        `SHOW INDEX`请参阅第 13.7.7 节，“SHOW 语句”。

#### 获取执行计划信息

        该`EXPLAIN`语句提供了有关 MySQL 如何执行语句的信息：

- EXPLAIN适用于 SELECT, DELETE, INSERT, REPLACE, 和 UPDATE语句。在 MySQL 8.0.19 及更高版本中，它也适用于 TABLE语句。
- 当EXPLAIN与可解释的语句一起使用时，MySQL 会显示来自优化器的有关语句执行计划的信息。也就是说，MySQL 解释了它将如何处理该语句，包括有关表如何连接以及连接顺序的信息。有关使用 EXPLAIN获取执行计划信息的信息，请参阅第 8.8.2 节，“EXPLAIN 输出格式”。
- 当EXPLAIN与 而不是可解释的语句一起使用时，它显示在命名连接中执行的语句的执行计划。请参阅第 8.8.4 节，“获取命名连接的执行计划信息”。 FOR CONNECTION connection_id
- 对于可解释的语句， EXPLAIN生成可​​以使用显示的附加执行计划信息 SHOW WARNINGS。请参阅 第 8.8.3 节，“扩展 EXPLAIN 输出格式”。
- EXPLAIN对于检查涉及分区表的查询很有用。请参阅 第 24.3.5 节，“获取有关分区的信息”。
- 该FORMAT选项可用于选择输出格式。TRADITIONAL以表格格式显示输出。如果没有 FORMAT选项，这是默认值。 JSONformat 以 JSON 格式显示信息。在 MySQL 8.0.16 及更高版本中， TREE提供树状输出，其中对查询处理的描述比 TRADITIONAL格式更精确；它是显示散列连接用法的唯一格式（请参阅 第 8.2.1.4 节，“散列连接优化”）并且始终用于 EXPLAIN ANALYZE.

        `EXPLAIN`需要执行解释语句所需的相同权限。此外，`EXPLAIN`还需要`SHOW VIEW`任何解释视图的权限。
        如果指定的连接属于不同的用户，
      `EXPLAIN ... FOR CONNECTION`也需要
        特权。`PROCESS`

        在 的帮助下`EXPLAIN`，您可以看到应该在何处向表添加索引，以便通过使用索引查找行来更快地执行语句。您还可以使用它
        `EXPLAIN`来检查优化器是否以最佳顺序连接表。要提示优化器使用与表在语句中的命名顺序相对应的连接顺序，请
        以而不是仅以.`SELECT`开始语句。（请参阅
        第 13.2.10 节，“SELECT 语句”。）
      `SELECT STRAIGHT_JOIN``SELECT`

        优化器跟踪有时可能会提供与`EXPLAIN`. 但是，优化器跟踪格式和内容可能会因版本而异。有关详细信息，请参阅
        MySQL 内部结构：跟踪优化器。

        如果您遇到索引在您认为应该使用时未被使用的问题，请运行`ANALYZE TABLE`以更新表统计信息，例如键的基数，这可能会影响优化器所做的选择。请参阅
        第 13.7.3.1 节，“ANALYZE TABLE 语句”。

笔记

          MySQL Workbench 具有 Visual Explain 功能，可提供
          `EXPLAIN`输出的可视化表示。请参阅
          教程：使用 Explain 提高查询性能。

#### 使用 EXPLAIN ANALYZE 获取信息

        MySQL 8.0.18 引入了`EXPLAIN ANALYZE`，它运行一个语句并产生
        `EXPLAIN`输出以及时间和额外的、基于迭代器的信息，这些信息关于优化器的期望如何与实际执行相匹配。对于每个迭代器，提供以下信息：

- 估计执行成本 （一些迭代器未被成本模型考虑，因此未包含在估算中。）
- 估计的返回行数
- 返回第一行的时间
- 执行此迭代器（包括子迭代器，但不包括父迭代器）所花费的时间，以毫秒为单位。 （当有多个循环时，此图显示每个循环的平均时间。）
- 迭代器返回的行数
- 循环次数

        查询执行信息使用
        `TREE`输出格式显示，其中节点代表迭代器。`EXPLAIN ANALYZE`始终使用
        `TREE`输出格式。在 MySQL 8.0.21 及更高版本中，可以选择使用显式指定
        `FORMAT=TREE`；其他格式
        `TREE`仍然不受支持。

        `EXPLAIN ANALYZE`可以与
        `SELECT`语句一起使用，也可以与多表`UPDATE`和
        `DELETE`语句一起使用。从 MySQL 8.0.19 开始，它也可以与
        `TABLE`语句一起使用。

        从 MySQL 8.0.20 开始，您可以使用`KILL QUERY`
        或**CTRL-C**终止此语句。

        `EXPLAIN ANALYZE`不能与 一起使用
        `FOR CONNECTION`。

        示例输出：

```sql
mysql> EXPLAIN ANALYZE SELECT * FROM t1 JOIN t2 ON (t1.c1 = t2.c2)\G
*************************** 1. row ***************************
EXPLAIN: -> Inner hash join (t2.c2 = t1.c1)  (cost=4.70 rows=6)
(actual time=0.032..0.035 rows=6 loops=1)
    -> Table scan on t2  (cost=0.06 rows=6)
(actual time=0.003..0.005 rows=6 loops=1)
    -> Hash
        -> Table scan on t1  (cost=0.85 rows=6)
(actual time=0.018..0.022 rows=6 loops=1)

mysql> EXPLAIN ANALYZE SELECT * FROM t3 WHERE i > 8\G
*************************** 1. row ***************************
EXPLAIN: -> Filter: (t3.i > 8)  (cost=1.75 rows=5)
(actual time=0.019..0.021 rows=6 loops=1)
    -> Table scan on t3  (cost=1.75 rows=15)
(actual time=0.017..0.019 rows=15 loops=1)

mysql> EXPLAIN ANALYZE SELECT * FROM t3 WHERE pk > 17\G
*************************** 1. row ***************************
EXPLAIN: -> Filter: (t3.pk > 17)  (cost=1.26 rows=5)
(actual time=0.013..0.016 rows=5 loops=1)
    -> Index range scan on t3 using PRIMARY  (cost=1.26 rows=5)
(actual time=0.012..0.014 rows=5 loops=1)
```

        示例输出中使用的表是由此处显示的语句创建的：

```sql
CREATE TABLE t1 (
    c1 INTEGER DEFAULT NULL,
    c2 INTEGER DEFAULT NULL
);

CREATE TABLE t2 (
    c1 INTEGER DEFAULT NULL,
    c2 INTEGER DEFAULT NULL
);

CREATE TABLE t3 (
    pk INTEGER NOT NULL PRIMARY KEY,
    i INTEGER DEFAULT NULL
);
```

        此语句的输出中显示的值`actual time`以毫秒表示。

---

[← 返回 第 8 章 优化 索引](00-index.md) · [← 返回总索引](../00-index.md)
