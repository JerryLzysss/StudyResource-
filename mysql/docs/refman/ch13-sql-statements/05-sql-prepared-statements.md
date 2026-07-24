# 第 13 章 SQL 语句 · 预处理语句

> 对应 SQL：[`sql/refman/ch13-sql-statements/05-sql-prepared-statements.sql`](../../../sql/refman/ch13-sql-statements/05-sql-prepared-statements.sql)

---

## 13.5 准备好的语句

    MySQL 8.0 提供了对服务器端准备语句的支持。这种支持利用了高效的客户端/服务器二进制协议。使用带有参数值占位符的预准备语句具有以下好处：

- 每次执行语句时解析语句的开销更少。通常，数据库应用程序处理大量几乎相同的语句，仅更改WHERE查询和删除、SET更新和 VALUES插入等子句中的文字或变量值。
- 防止 SQL 注入攻击。参数值可以包含未转义的 SQL 引号和定界符。

    以下部分概述了准备好的语句的特征：

- 应用程序中的准备语句
- SQL 脚本中的准备语句
- PREPARE、EXECUTE 和 DEALLOCATE PREPARE 语句
- 准备好的语句中允许的 SQL 语法

### 应用程序中的准备语句

    您可以通过客户端编程接口使用服务器端准备好的语句，包括用于 C 程序的MySQL
     C API 客户端库、用于 Java 程序的MySQL Connector/J以及用于使用 .NET 技术的程序的MySQL Connector/NET。例如，C API 提供了一组函数调用，这些函数调用构成了其准备好的语句 API。请参阅
    C API 准备语句接口。其他语言接口可以通过在 C 客户端库中链接来为使用二进制协议的准备好的语句提供支持，一个例子是
    [`mysqli` 扩展](http://php.net/mysqli)，在 PHP 5.0 及更高版本中可用。

### SQL 脚本中的准备语句

    准备好的语句的替代 SQL 接口可用。此接口不如通过准备好的语句 API 使用二进制协议高效，但不需要编程，因为它可直接在 SQL 级别使用：

- 当没有可用的编程接口时，您可以使用它。
- 您可以从任何可以将 SQL 语句发送到要执行的服务器的程序中使用它，例如mysql 客户端程序。
- 即使客户端使用的是旧版本的客户端库，您也可以使用它。

    准备好的语句的 SQL 语法旨在用于以下情况：

- 在编码之前测试准备好的语句在您的应用程序中的工作方式。
- 当您无权访问支持它们的编程 API 时使用准备好的语句。
- 使用准备好的语句以交互方式解决应用程序问题。
- 创建一个测试用例来重现准备好的语句的问题，以便您可以提交错误报告。

### PREPARE、EXECUTE 和 DEALLOCATE PREPARE 语句

    准备语句的 SQL 语法基于三个 SQL 语句：

- PREPARE准备执行语句（请参阅第 13.5.1 节，“PREPARE 语句”）。
- EXECUTE执行准备好的语句（请参阅第 13.5.2 节，“EXECUTE 语句”）。
- DEALLOCATE PREPARE发布准备好的语句（请参阅第 13.5.3 节，“DEALLOCATE PREPARE 语句”）。

    以下示例显示了两种等效的方法来准备一个语句，该语句在给定两条边的长度的情况下计算三角形的斜边。

    第一个示例显示如何通过使用字符串文字提供语句文本来创建准备好的语句：

```sql
mysql> PREPARE stmt1 FROM 'SELECT SQRT(POW(?,2) + POW(?,2)) AS hypotenuse';
mysql> SET @a = 3;
mysql> SET @b = 4;
mysql> EXECUTE stmt1 USING @a, @b;
+------------+
| hypotenuse |
+------------+
|          5 |
+------------+
mysql> DEALLOCATE PREPARE stmt1;
```

    第二个示例类似，但将语句的文本作为用户变量提供：

```sql
mysql> SET @s = 'SELECT SQRT(POW(?,2) + POW(?,2)) AS hypotenuse';
mysql> PREPARE stmt2 FROM @s;
mysql> SET @a = 6;
mysql> SET @b = 8;
mysql> EXECUTE stmt2 USING @a, @b;
+------------+
| hypotenuse |
+------------+
|         10 |
+------------+
mysql> DEALLOCATE PREPARE stmt2;
```

    下面是一个附加示例，演示如何通过将表的名称存储为用户变量来选择在运行时执行查询的表：

```sql
mysql> USE test;
mysql> CREATE TABLE t1 (a INT NOT NULL);
mysql> INSERT INTO t1 VALUES (4), (8), (11), (32), (80);

mysql> SET @table = 't1';
mysql> SET @s = CONCAT('SELECT * FROM ', @table);

mysql> PREPARE stmt3 FROM @s;
mysql> EXECUTE stmt3;
+----+
| a  |
+----+
|  4 |
|  8 |
| 11 |
| 32 |
| 80 |
+----+

mysql> DEALLOCATE PREPARE stmt3;
```

    准备好的语句特定于创建它的会话。如果您终止会话而没有取消分配先前准备好的语句，服务器会自动取消分配它。

    准备好的声明对于会话也是全局的。如果您在存储例程中创建准备好的语句，则在存储例程结束时不会释放它。

    为防止同时创建太多准备好的语句，请设置
    `max_prepared_stmt_count`系统变量。要防止使用准备好的语句，请将该值设置为 0。

### 准备好的语句中允许的 SQL 语法

    以下 SQL 语句可以用作准备语句：

```sql
ALTER TABLE
ALTER USER
ANALYZE TABLE
CACHE INDEX
CALL
CHANGE MASTER
CHECKSUM {TABLE | TABLES}
COMMIT
{CREATE | DROP} INDEX
{CREATE | RENAME | DROP} DATABASE
{CREATE | DROP} TABLE
{CREATE | RENAME | DROP} USER
{CREATE | DROP} VIEW
DELETE
DO
FLUSH {TABLE | TABLES | TABLES WITH READ LOCK | HOSTS | PRIVILEGES
  | LOGS | STATUS | MASTER | SLAVE | USER_RESOURCES}
GRANT
INSERT
INSTALL PLUGIN
KILL
LOAD INDEX INTO CACHE
OPTIMIZE TABLE
RENAME TABLE
REPAIR TABLE
REPLACE
RESET {MASTER | SLAVE}
REVOKE
SELECT
SET
SHOW BINLOG EVENTS
SHOW CREATE {PROCEDURE | FUNCTION | EVENT | TABLE | VIEW}
SHOW {MASTER | BINARY} LOGS
SHOW {MASTER | SLAVE} STATUS
SLAVE {START | STOP}
TRUNCATE TABLE
UNINSTALL PLUGIN
UPDATE
```

    不支持其他语句。

    为了符合 SQL 标准，该标准声明诊断语句不可准备，MySQL 不支持以下作为准备语句：

- SHOW WARNINGS,SHOW COUNT(*) WARNINGS
- SHOW ERRORS,SHOW COUNT(*) ERRORS
- warning_count包含对或 error_count系统变量 的任何引用的语句 。

    通常，SQL 准备语句中不允许的语句在存储程序中也不允许。例外情况在
    第 25.8 节“存储程序的限制”中有所说明。

    检测到准备好的语句引用的表或视图的元数据更改，并在下次执行语句时自动重新准备语句。有关详细信息，请参阅
    第 8.10.3 节，“准备好的语句和存储程序的缓存”。

`LIMIT`使用准备好的语句时
    ，占位符可用于子句的参数
    。请参阅
    第 13.2.10 节，“SELECT 语句”。

    在与and
    `CALL`一起使用的准备好的语句中
    ，占位符支持
    和参数从 MySQL 8.0 开始可用。有关早期版本的示例和解决方法，请参见
    第 13.2.1 节，“CALL 语句” 。无论版本如何，占位符都可用于
    参数。
  `PREPARE``EXECUTE``OUT``INOUT``IN`

    准备好的语句的 SQL 语法不能以嵌套方式使用。也就是说，传递给的语句
    `PREPARE`本身不能是
    `PREPARE`、
    `EXECUTE`或
    `DEALLOCATE PREPARE`语句。

    准备语句的 SQL 语法不同于使用准备语句 API 调用。例如，您不能使用
    `mysql_stmt_prepare()`C API 函数来准备`PREPARE`、
    `EXECUTE`或
    `DEALLOCATE PREPARE`语句。

    准备语句的 SQL 语法可以在存储过程中使用，但不能在存储函数或触发器中使用。但是，游标不能用于使用`PREPARE`and
    准备和执行的动态语句`EXECUTE`。游标的语句在创建游标时进行检查，因此该语句不能是动态的。

    准备语句的 SQL 语法不支持多语句（即，单个字符串中的多个语句由
    `;`字符分隔）。

    要编写使用`CALL`
    SQL 语句执行包含准备语句的存储过程的 C 程序，`CLIENT_MULTI_RESULTS`必须启用该标志。这是因为`CALL`
    除了过程中执行的语句可能返回的任何结果集之外，每个函数都返回一个结果来指示调用状态。

    `CLIENT_MULTI_RESULTS`可以在调用时启用
    `mysql_real_connect()`，可以显式地传递`CLIENT_MULTI_RESULTS`
    标志本身，也可以隐式地传递
    `CLIENT_MULTI_STATEMENTS`（这也启用
    `CLIENT_MULTI_RESULTS`）。有关其他信息，请参阅第 13.2.1 节，“CALL 语句”。

---

[← 返回 第 13 章 SQL 语句 索引](00-index.md) · [← 返回总索引](../00-index.md)
