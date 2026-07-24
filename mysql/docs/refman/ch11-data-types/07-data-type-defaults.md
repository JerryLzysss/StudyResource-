# 第 11 章 数据类型 · 数据类型默认值

> 对应 SQL：[`sql/refman/ch11-data-types/07-data-type-defaults.sql`](../../../sql/refman/ch11-data-types/07-data-type-defaults.sql)

---

## 11.6 数据类型默认值

      数据类型规范可以具有显式或隐式默认值。

      数据类型规范中的
      子句明确指示列的默认值。例子：
    `DEFAULT value`

```sql
CREATE TABLE t1 (
  i     INT DEFAULT -1,
  c     VARCHAR(10) DEFAULT '',
  price DOUBLE(16,2) DEFAULT 0.00
);
```

      `SERIAL DEFAULT VALUE`是一个特例。在整数列的定义中，它是 的别名`NOT NULL AUTO_INCREMENT UNIQUE`。

      显式子句处理的某些方面`DEFAULT`是依赖于版本的，如下所述。

- 从 MySQL 8.0.13 开始的显式默认处理
- MySQL 8.0.13 之前的显式默认处理
- 隐式默认处理

### 从 MySQL 8.0.13 开始的显式默认处理

        子句中指定的默认值`DEFAULT`
        可以是文字常量或表达式。除了一个例外，将表达式默认值括在括号内以将它们与文字常量默认值区分开来。例子：

```sql
CREATE TABLE t1 (
  -- literal defaults
  i INT         DEFAULT 0,
  c VARCHAR(10) DEFAULT '',
  -- expression defaults
  f FLOAT       DEFAULT (RAND() * RAND()),
  b BINARY(16)  DEFAULT (UUID_TO_BIN(UUID())),
  d DATE        DEFAULT (CURRENT_DATE + INTERVAL 1 YEAR),
  p POINT       DEFAULT (Point(0,0)),
  j JSON        DEFAULT (JSON_ARRAY())
);
```

        例外情况是，对于
        `TIMESTAMP`和
        `DATETIME`列，您可以将`CURRENT_TIMESTAMP`函数指定为默认函数，而不用括号括起来。请参阅
        第 11.2.5 节，“TIMESTAMP 和 DATETIME 的自动初始化和更新”。

        , `BLOB`,
         `TEXT`,
        `GEOMETRY`和
        `JSON`数据类型只有当值写成表达式时才能被赋予默认值，即使表达式值是文字：

- 这是允许的（文字默认指定为表达式）： ```sql CREATE TABLE t2 (b BLOB DEFAULT ('abc')); ```
- 这会产生错误（未指定为表达式的文字默认值）： ```sql CREATE TABLE t2 (b BLOB DEFAULT 'abc'); ```

        表达式默认值必须遵守以下规则。如果表达式包含不允许的构造，则会发生错误。

- 允许使用文字、内置函数（确定性和非确定性）和运算符。
- 不允许使用子查询、参数、变量、存储函数和可加载函数。
- 表达式默认值不能依赖于具有AUTO_INCREMENT属性的列。
- 一列的表达式默认值可以引用其他表列，但对生成的列或具有表达式默认值的列的引用必须指向表定义中较早出现的列。也就是说，表达式默认值不能包含对生成的列或具有表达式默认值的列的前向引用。 排序约束也适用于对 ALTER TABLE表列重新排序的使用。如果结果表的表达式默认值包含对生成的列或具有表达式默认值的列的前向引用，则语句失败。

笔记

          如果表达式默认值的任何组成部分取决于 SQL 模式，则表的不同使用可能会产生不同的结果，除非在所有使用过程中 SQL 模式都相同。

        对于`CREATE TABLE ... LIKE`和
        `CREATE TABLE ... SELECT`，目标表保留原始表中的表达式默认值。

        如果表达式默认值引用不确定函数，则导致计算表达式的任何语句对于基于语句的复制都是不安全的。这包括诸如
        `INSERT`and
        之类的语句`UPDATE`。在这种情况下，如果禁用二进制日志记录，则该语句将正常执行。如果启用二进制日志记录并
        `binlog_format`设置为
        `STATEMENT`，则会记录并执行该语句，但会将一条警告消息写入错误日志，因为复制从属可能会发生分歧。当
        `binlog_format`设置为
        `MIXED`or`ROW`时，语句正常执行。

        插入新行时，可以通过省略列名或将列指定为`DEFAULT`
        （就像具有文字默认值的列一样）来插入具有表达式 default 的列的默认值：

```sql
mysql> CREATE TABLE t4 (uid BINARY(16) DEFAULT (UUID_TO_BIN(UUID())));
mysql> INSERT INTO t4 () VALUES();
mysql> INSERT INTO t4 () VALUES(DEFAULT);
mysql> SELECT BIN_TO_UUID(uid) AS uid FROM t4;
+--------------------------------------+
| uid                                  |
+--------------------------------------+
| f1109174-94c9-11e8-971d-3bf1095aa633 |
| f110cf9a-94c9-11e8-971d-3bf1095aa633 |
+--------------------------------------+
```

        但是，

        仅允许对具有文字默认值的列使用 指定命名列的默认值，而不允许对具有表达式默认值的列使用。
      `DEFAULT(col_name`)

        并非所有存储引擎都允许表达式默认值。对于那些不这样做的，
        `ER_UNSUPPORTED_ACTION_ON_DEFAULT_VAL_GENERATED`
        会发生错误。

        如果默认值评估为不同于声明的列类型的数据类型，则根据通常的 MySQL 类型转换规则隐式强制转换为声明的类型。请参阅
        第 12.3 节，“表达式计算中的类型转换”。

### MySQL 8.0.13 之前的显式默认处理

        除了一个例外，
        `DEFAULT`子句中指定的默认值必须是文字常量；它不能是函数或表达式。这意味着，例如，您不能将日期列的默认值设置为`NOW()`
        或等函数的值`CURRENT_DATE`。例外情况是，对于`TIMESTAMP`和
        `DATETIME`列，您可以将其指定
        `CURRENT_TIMESTAMP`为默认值。请参阅第 11.2.5 节，“TIMESTAMP 和 DATETIME 的自动初始化和更新”。

        、`BLOB`、
        `TEXT`和
        数据类型不能分配默认值
      `GEOMETRY`。
        `JSON`

        如果默认值评估为不同于声明的列类型的数据类型，则根据通常的 MySQL 类型转换规则隐式强制转换为声明的类型。请参阅
        第 12.3 节，“表达式计算中的类型转换”。

### 隐式默认处理

        如果数据类型规范不包含显式
        `DEFAULT`值，则 MySQL 确定默认值如下：

        如果该列可以`NULL`作为值，则使用显式`DEFAULT NULL`子句定义该列。

        如果该列不能`NULL`作为值，则 MySQL 定义没有显式
        `DEFAULT`子句的列。

`NOT NULL`对于没有显式`DEFAULT`子句

        的列的数据输入，如果`INSERT`or
        `REPLACE`语句不包含该列的值，或者
        `UPDATE`语句将列设置为`NULL`，则 MySQL 根据当时有效的 SQL 模式处理该列：

- 如果开启严格SQL模式，事务表会出错，语句会回滚。对于非事务表，会发生错误，但如果多行语句的第二行或后续行发生这种情况，则会插入前面的行。
- 如果未启用严格模式，MySQL 会将列设置为列数据类型的隐式默认值。

        假设一个表`t`定义如下：

```sql
CREATE TABLE t (i INT NOT NULL);
```

        在这种情况下，`i`没有明确的默认值，因此在严格模式下，以下每个语句都会产生错误并且不会插入任何行。当不使用严格模式时，只有第三条语句产生错误；为前两个语句插入隐式默认值，但第三个失败，因为`DEFAULT(i)`无法生成值：

```sql
INSERT INTO t VALUES();
INSERT INTO t VALUES(DEFAULT);
INSERT INTO t VALUES(DEFAULT(i));
```

        请参阅第 5.1.11 节，“服务器 SQL 模式”。

        对于给定的表，该`SHOW CREATE TABLE`语句显示哪些列具有显式`DEFAULT`子句。

        隐式默认值定义如下：

- 对于数字类型，默认值为0，但对于使用 属性声明的整数或浮点类型AUTO_INCREMENT ，默认值为序列中的下一个值。
- 对于 以外的日期和时间类型 TIMESTAMP，默认值是该类型的适当“零”值。TIMESTAMP如果 explicit_defaults_for_timestamp 启用了系统变量 ，情况也是如此（请参阅第 5.1.8 节，“服务器系统变量”）。否则，对于表中的第一TIMESTAMP列，默认值为当前日期和时间。请参阅 第 11.2 节，“日期和时间数据类型”。
- 对于 以外的字符串类型 ENUM，默认值为空字符串。对于ENUM，默认是第一个枚举值。

---

[← 返回 第 11 章 数据类型 索引](00-index.md) · [← 返回总索引](../00-index.md)
