# 第 5 章 MySQL 服务器管理 · SQL 模式

> 对应 SQL：[`sql/refman/ch05-server-administration/06-sql-mode.sql`](../../../sql/refman/ch05-server-administration/06-sql-mode.sql)

---

5.1.11 服务器 SQL 模式_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 5 章 MySQL 服务器管理 / 5.1 MySQL 服务器 / 5.1.11 服务器 SQL 模式 sql_modeMySQL 服务器可以在不同的 SQL 模式下运行，并且可以根据系统变量 的值对不同的客户端应用这些模式。DBA 可以设置全局 SQL 模式以匹配站点服务器操作要求，每个应用程序可以根据自己的要求设置其会话 SQL 模式。 模式会影响 MySQL 支持的 SQL 语法及其执行的数据验证检查。这使得在不同环境中使用 MySQL 以及与其他数据库服务器一起使用 MySQL 变得更加容易。 设置 SQL 模式
- 最重要的 SQL 模式
- SQL 模式的完整列表
- 组合 SQL 模式
- 严格 SQL 模式
- IGNORE 关键字和严格 SQL 模式的比较

      有关 MySQL 中服务器 SQL 模式的常见问题解答，请参阅第 A.3 节，“MySQL 8.0 FAQ：服务器 SQL 模式”。

      使用`InnoDB`表时，还要考虑`innodb_strict_mode`系统变量。`InnoDB`它为表
启用额外的错误检查
      。

#### 设置 SQL 模式

        MySQL 8.0 中默认的 SQL 模式包括这些模式：`ONLY_FULL_GROUP_BY`、
         `STRICT_TRANS_TABLES`、
         `NO_ZERO_IN_DATE`、
         `NO_ZERO_DATE`、
        `ERROR_FOR_DIVISION_BY_ZERO`和`NO_ENGINE_SUBSTITUTION`。

        要在服务器启动时设置 SQL 模式，请

        在命令行或

        选项文件（例如（Unix 操作系统）或（Windows））中使用该选项。
        是以逗号分隔的不同模式的列表。要明确清除 SQL 模式，请
        在命令行或选项文件中将其设置为空字符串。
`--sql-mode="modes`"`sql-mode="modes`"`my.cnf``my.ini`*`modes`*`--sql-mode=""``sql-mode=""`

笔记

          MySQL 安装程序可能会在安装过程中配置 SQL 模式。

          如果 SQL 模式不同于默认模式或您期望的模式，请检查服务器在启动时读取的选项文件中的设置。

        要在运行时更改 SQL 模式，请
        `sql_mode`使用`SET`
        语句设置全局或会话系统变量：

```sql
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';
```

        设置`GLOBAL`变量需要
        `SYSTEM_VARIABLES_ADMIN`特权（或已弃用的`SUPER`
        特权）并影响从那时起连接的所有客户端的操作。设置`SESSION`
        变量仅影响当前客户端。每个客户端都可以随时更改其会话`sql_mode`值。

        要确定当前的全局或会话
        `sql_mode`设置，请选择其值：

```sql
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
```

重要的

**SQL 模式和用户定义的分区。**
            在创建分区表并将数据插入分区表后更改服务器 SQL 模式可能会导致此类表的行为发生重大变化，并可能导致数据丢失或损坏。强烈建议您在使用用户定义的分区创建表后永远不要更改 SQL 模式。

          复制分区表时，源和副本上的不同 SQL 模式也会导致问题。为获得最佳结果，您应该始终在源和副本上使用相同的服务器 SQL 模式。

          有关详细信息，请参阅
          第 24.6 节，“分区的限制和限制”。

#### 最重要的 SQL 模式

        最重要的`sql_mode`
        价值观可能是这些：

- ANSI 此模式更改语法和行为以更符合标准 SQL。它是 本节末尾列出 的特殊组合模式之一。
- STRICT_TRANS_TABLES 如果无法将给定的值插入到事务表中，则中止该语句。对于非事务表，如果值出现在单行语句或多行语句的第一行中，则中止语句。本节稍后将提供更多详细信息。
- TRADITIONAL 使 MySQL 表现得像一个“传统的” SQL 数据库系统。这种模式的简单描述是 在向列中插入不正确的值时“给出错误而不是警告” 。它是本节末尾列出 的特殊组合模式之一。 笔记 TRADITIONAL启用模式后，一旦发生错误 ，INSERTor 就会中止。UPDATE如果您正在使用非事务性存储引擎，这可能不是您想要的，因为在错误之前所做的数据更改可能无法回滚，从而导致“部分完成”更新。

        当本手册提到“严格模式”时，它表示一种模式，其中一个或两个
        `STRICT_TRANS_TABLES`或
        `STRICT_ALL_TABLES`启用。

#### SQL 模式的完整列表

        以下列表描述了所有支持的 SQL 模式：

- ALLOW_INVALID_DATES 不要执行完整的日期检查。只检查月份在 1 到 12 的范围内，日期在 1 到 31 的范围内。这可能对 Web 应用程序有用，这些应用程序在三个不同的字段中获取年月日并准确存储用户的内容已插入，没有日期验证。此模式适用于 DATE和 DATETIME列。它不适用于TIMESTAMP始终需要有效日期的列。 ALLOW_INVALID_DATES 如果禁用，服务器要求月份和日期值是合法的，而不仅仅是分别在 1 到 12 和 1 到 31 的范围内 。'2004-04-31'禁用严格模式后，将转换为 无效日期'0000-00-00'并生成警告。启用严格模式后，无效日期会产生错误。要允许此类日期，请启用 ALLOW_INVALID_DATES.
- ANSI_QUOTES 将其视为"标识符引号字符（如`引号字符）而不是字符串引号字符。启用此模式后，您仍然可以使用 `引用标识符。启用后，您不能使用ANSI_QUOTES 双引号来引用文字字符串，因为它们被解释为标识符。
- ERROR_FOR_DIVISION_BY_ZERO 该 ERROR_FOR_DIVISION_BY_ZERO 模式影响除以零的处理，其中包括 . 对于数据更改操作（, ），其效果还取决于是否启用了严格的 SQL 模式。 MOD(N,0)INSERTUPDATE 如果未启用此模式，则除以零会插入 NULL并且不会产生警告。
- 如果启用此模式，则除以零会插入 NULL并产生警告。
- 如果启用此模式和严格模式，除以零会产生错误，除非IGNORE 也给出。对于INSERT IGNORE 和UPDATE IGNORE，除以零插入NULL并产生警告。

            对于`SELECT`，除以零返回`NULL`。启用
            `ERROR_FOR_DIVISION_BY_ZERO`
            也会导致产生警告，无论是否启用严格模式。

            `ERROR_FOR_DIVISION_BY_ZERO`
            已弃用。
            `ERROR_FOR_DIVISION_BY_ZERO`
            不是严格模式的一部分，但应与严格模式结合使用，默认情况下启用。如果在未启用严格模式的情况下启用，则会出现警告，
            `ERROR_FOR_DIVISION_BY_ZERO`
            反之亦然。

            由于
            `ERROR_FOR_DIVISION_BY_ZERO`
            已弃用，您应该期望在未来的 MySQL 版本中将其作为单独的模式名称删除，其效果包括在严格 SQL 模式的效果中。

- HIGH_NOT_PRECEDENCE 运算符的优先级NOT 是这样的表达式，如NOT a BETWEEN b AND c被解析为NOT (a BETWEEN b AND c)。在一些旧版本的 MySQL 中，表达式被解析为(NOT a) BETWEEN b AND c. 可以通过启用 HIGH_NOT_PRECEDENCESQL 模式获得旧的更高优先级的行为。 ```sql mysql> SET sql_mode = ''; mysql> SELECT NOT 1 BETWEEN -5 AND 5; -> 0 mysql> SET sql_mode = 'HIGH_NOT_PRECEDENCE'; mysql> SELECT NOT 1 BETWEEN -5 AND 5; -> 1 ```
- IGNORE_SPACE (函数名称和字符 之间允许有空格 。这会导致内置函数名称被视为保留字。因此，与函数名称相同的标识符必须按照第 9.2 节“模式对象名称”中的描述进行引用。例如，因为有一个 COUNT()函数， count在下面的语句中使用作为表名会导致错误： ```sql mysql> CREATE TABLE count (i INT); ERROR 1064 (42000): You have an error in your SQL syntax ``` 表名应该被引用： ```sql mysql> CREATE TABLE `count` (i INT); Query OK, 0 rows affected (0.00 sec) ``` SQL 模式适用于IGNORE_SPACE内置函数，不适用于可加载函数或存储函数。IGNORE_SPACE无论是否启用 ，始终允许在可加载函数或存储函数名称后有空格 。 有关 的进一步讨论 IGNORE_SPACE，请参阅 第 9.2.5 节，“函数名称解析和解析”。
- NO_AUTO_VALUE_ON_ZERO NO_AUTO_VALUE_ON_ZERO 影响AUTO_INCREMENT 列的处理。NULL通常，您通过插入或 来为该列生成下一个序列号0。 NO_AUTO_VALUE_ON_ZERO 抑制此行为，0以便仅NULL生成下一个序列号。 0如果已存储在表的AUTO_INCREMENT 列中， 则此模式会很有用。（0顺便说一句，不推荐存储。）例如，如果您使用mysqldump转储表然后重新加载它，MySQL 通常会在遇到0值时生成新的序列号，从而导致表的内容与原来的不同那被丢弃了。NO_AUTO_VALUE_ON_ZERO 在重新加载转储文件之前启用 可解决此问题。为此，mysqldump自动在其输出中包含一条启用 NO_AUTO_VALUE_ON_ZERO.
- NO_BACKSLASH_ESCAPES 启用此模式将禁止使用反斜杠字符 ( \) 作为字符串和标识符中的转义字符。启用此模式后，反斜杠像其他任何字符一样变成普通字符，并且 LIKE表达式的默认转义序列已更改，因此不使用转义字符。
- NO_DIR_IN_CREATE 创建表时，忽略所有INDEX DIRECTORY和DATA DIRECTORY 指令。此选项在副本服务器上很有用。
- NO_ENGINE_SUBSTITUTION 当诸如CREATE TABLEor之类的语句ALTER TABLE指定禁用或未编译的存储引擎时，控制默认存储引擎的自动替换。 默认情况下， NO_ENGINE_SUBSTITUTION启用。 因为存储引擎可以在运行时插入，所以不可用的引擎以相同的方式处理： NO_ENGINE_SUBSTITUTION 如果禁用，则 使用 CREATE TABLE 默认引擎，如果所需引擎不可用，则会出现警告。对于 ALTER TABLE，出现警告并且表未更改。 启用后，如果所需的引擎不可用 NO_ENGINE_SUBSTITUTION ，则会发生错误并且不会创建或更改表。
- NO_UNSIGNED_SUBTRACTION 默认情况下，整数值之间的减法，其中一个是类型 UNSIGNED，会产生一个无符号的结果。如果结果为负，则会产生错误： ```sql mysql> SET sql_mode = ''; Query OK, 0 rows affected (0.00 sec) mysql> SELECT CAST(0 AS UNSIGNED) - 1; ERROR 1690 (22003): BIGINT UNSIGNED value is out of range in '(cast(0 as unsigned) - 1)' ``` 如果 NO_UNSIGNED_SUBTRACTION 启用 SQL 模式，则结果是否定的： ```sql mysql> SET sql_mode = 'NO_UNSIGNED_SUBTRACTION'; mysql> SELECT CAST(0 AS UNSIGNED) - 1; +-------------------------+ | CAST(0 AS UNSIGNED) - 1 | +-------------------------+ | -1 | +-------------------------+ ``` 如果此类操作的结果用于更新 UNSIGNED整数列，则结果将被裁剪为列类型的最大值，或者如果 NO_UNSIGNED_SUBTRACTION启用则裁剪为 0。在启用严格 SQL 模式的情况下，发生错误并且该列保持不变。 启用时 NO_UNSIGNED_SUBTRACTION，减法结果是有符号的，即使任何操作数是无符号的。例如，将 table 中列的类型与c2table t1中 列c2的类型进行比较t2： ```sql mysql> SET sql_mode=''; mysql> CREATE TABLE test (c1 BIGINT UNSIGNED NOT NULL); mysql> CREATE TABLE t1 SELECT c1 - 1 AS c2 FROM test; mysql> DESCRIBE t1; +-------+---------------------+------+-----+---------+-------+ | Field | Type | Null | Key | Default | Extra | +-------+---------------------+------+-----+---------+-------+ | c2 | bigint(21) unsigned | NO | | 0 | | +-------+---------------------+------+-----+---------+-------+ mysql> SET sql_mode='NO_UNSIGNED_SUBTRACTION'; mysql> CREATE TABLE t2 SELECT c1 - 1 AS c2 FROM test; mysql> DESCRIBE t2; +-------+------------+------+-----+---------+-------+ | Field | Type | Null | Key | Default | Extra | +-------+------------+------+-----+---------+-------+ | c2 | bigint(21) | NO | | 0 | | +-------+------------+------+-----+---------+-------+ ``` 这意味着它BIGINT UNSIGNED并非在所有情况下都 100% 可用。请参阅 第 12.11 节，“Cast 函数和运算符”。
- NO_ZERO_DATE NO_ZERO_DATE模式影响服务器是否允许 作为'0000-00-00'有效日期。其效果还取决于是否启用了严格 SQL 模式。 如果未启用此模式， '0000-00-00'则允许插入并且不会产生警告。
- 如果启用此模式，'0000-00-00' 则允许插入并产生警告。
- 如果启用此模式和严格模式， '0000-00-00'则不允许插入并产生错误，除非 IGNORE也给出。对于 INSERT IGNOREand UPDATE IGNORE，'0000-00-00'是允许的，插入会产生警告。

            `NO_ZERO_DATE`已弃用。`NO_ZERO_DATE`
            不是严格模式的一部分，但应与严格模式结合使用，默认情况下启用。如果在未启用严格模式的情况下启用，则会出现警告，
            `NO_ZERO_DATE`反之亦然。

            由于`NO_ZERO_DATE`已弃用，您应该期望在未来的 MySQL 版本中将其作为单独的模式名称删除，其效果包括在严格 SQL 模式的效果中。

- NO_ZERO_IN_DATE 模式会影响服务器是否允许年份部分不为零但月份或日期部分为 0的日期。 NO_ZERO_IN_DATE（此模式会影响诸如'2010-00-01'或 之类的日期'2010-01-00'，但不会 影响'0000-00-00'。要控制服务器是否允许'0000-00-00'，请使用该 NO_ZERO_DATE模式。）效果ofNO_ZERO_IN_DATE 还取决于是否启用了严格的 SQL 模式。 如果未启用此模式，则允许包含零部分的日期并且插入不会产生警告。
- 如果启用此模式，则零部分的日期将被插入'0000-00-00'并产生警告。
- 如果启用此模式和严格模式，则不允许包含零部分的日期并且插入会产生错误，除非IGNORE也给出。对于INSERT IGNORE和 UPDATE IGNORE，零部分的日期被插入为'0000-00-00'并产生警告。

            `NO_ZERO_IN_DATE`已弃用。
            `NO_ZERO_IN_DATE`不是严格模式的一部分，但应与严格模式结合使用，默认情况下启用。如果在未启用严格模式的情况下启用，则会出现警告，
            `NO_ZERO_IN_DATE`反之亦然。

            由于`NO_ZERO_IN_DATE`已弃用，您应该期望在未来的 MySQL 版本中将其作为单独的模式名称删除，其效果包括在严格 SQL 模式的效果中。

- ONLY_FULL_GROUP_BY 拒绝选择列表、 HAVING条件或ORDER BY列表引用非聚合列的查询，这些列既没有在GROUP BY子句中命名，也没有在功能上依赖于（唯一确定的） GROUP BY列。 MySQL 对标准 SQL 的扩展允许在 HAVING子句中引用选择列表中的别名表达式。HAVING无论是否 ONLY_FULL_GROUP_BY启用 ，子句都可以引用别名。 有关其他讨论和示例，请参阅 第 12.20.3 节，“GROUP BY 的 MySQL 处理”。
- PAD_CHAR_TO_FULL_LENGTH 默认情况下，尾随空格会 CHAR在检索时从列值中删除。如果 PAD_CHAR_TO_FULL_LENGTH启用，则不会进行修剪，并且检索 CHAR到的值将填充到它们的全长。此模式不适 VARCHAR用于在检索时保留尾随空格的列。 笔记 从 MySQL 8.0.13 开始， PAD_CHAR_TO_FULL_LENGTH 已弃用。预计它会在 MySQL 的未来版本中被删除。 ```sql mysql> CREATE TABLE t1 (c1 CHAR(10)); Query OK, 0 rows affected (0.37 sec) mysql> INSERT INTO t1 (c1) VALUES('xy'); Query OK, 1 row affected (0.01 sec) mysql> SET sql_mode = ''; Query OK, 0 rows affected (0.00 sec) mysql> SELECT c1, CHAR_LENGTH(c1) FROM t1; +------+-----------------+ | c1 | CHAR_LENGTH(c1) | +------+-----------------+ | xy | 2 | +------+-----------------+ 1 row in set (0.00 sec) mysql> SET sql_mode = 'PAD_CHAR_TO_FULL_LENGTH'; Query OK, 0 rows affected (0.00 sec) mysql> SELECT c1, CHAR_LENGTH(c1) FROM t1; +------------+-----------------+ | c1 | CHAR_LENGTH(c1) | +------------+-----------------+ | xy | 10 | +------------+-----------------+ 1 row in set (0.00 sec) ```
- PIPES_AS_CONCAT 将其视为||字符串连接运算符（与 相同 CONCAT()）而不是 的同义词OR。
- REAL_AS_FLOAT 视为REAL的同义词 FLOAT。默认情况下，MySQLREAL将 DOUBLE.
- STRICT_ALL_TABLES 为所有存储引擎启用严格的 SQL 模式。拒绝无效的数据值。有关详细信息，请参阅 严格 SQL 模式。
- STRICT_TRANS_TABLES 为事务存储引擎启用严格的 SQL 模式，并在可能的情况下为非事务存储引擎启用严格的 SQL 模式。有关详细信息，请参阅严格 SQL 模式。
- TIME_TRUNCATE_FRACTIONAL TIME控制在将具有小数秒部分的、 DATE或 TIMESTAMP值插入具有相同类型但小数位数较少的列 时是否发生舍入或截断。默认行为是使用舍入。如果启用此模式，则会发生截断。以下语句序列说明了差异： ```sql CREATE TABLE t (id INT, tval TIME(1)); SET sql_mode=''; INSERT INTO t (id, tval) VALUES(1, 1.55); SET sql_mode='TIME_TRUNCATE_FRACTIONAL'; INSERT INTO t (id, tval) VALUES(2, 1.55); ``` 生成的表格内容如下所示，其中第一个值进行了舍入，第二个进行了截断： ```sql mysql> SELECT id, tval FROM t ORDER BY id; +------+------------+ | id | tval | +------+------------+ | 1 | 00:00:01.6 | | 2 | 00:00:01.5 | +------+------------+ ``` 另见第 11.2.6 节，“时间值中的小数秒”。

#### 组合 SQL 模式

        以下特殊模式作为前面列表中模式值组合的简写形式提供。

- ANSI 等价于 REAL_AS_FLOAT、 PIPES_AS_CONCAT、 ANSI_QUOTES、 IGNORE_SPACE和 ONLY_FULL_GROUP_BY。 ANSImode 还会导致服务器为查询返回错误，其中 无法在已解析外部引用的外部查询中聚合S具有外部引用 的集合函数。这是这样一个查询： S(outer_ref) ```sql SELECT * FROM t1 WHERE t1.a IN (SELECT MAX(t1.b) FROM t2 WHERE ...); ``` 在这里，MAX(t1.b)不能在外部查询中聚合，因为它出现在该 WHERE查询的子句中。在这种情况下，标准 SQL 需要一个错误。如果 ANSI未启用模式，服务器 将以与解释相同的方式处理此类查询 。 S(outer_ref)S(const) 请参阅第 1.7 节，“MySQL 标准合规性”。
- TRADITIONAL TRADITIONAL等同于STRICT_TRANS_TABLES、 STRICT_ALL_TABLES、 NO_ZERO_IN_DATE、 NO_ZERO_DATE、 ERROR_FOR_DIVISION_BY_ZERO和 NO_ENGINE_SUBSTITUTION。

#### 严格 SQL 模式

        严格模式控制 MySQL 如何处理数据更改语句中的无效或缺失值，例如
        `INSERT`or
         `UPDATE`。一个值可能由于多种原因而无效。例如，列的数据类型可能有误，或者可能超出范围。当要插入的新行不包含在其定义`NULL`中没有显式
        `DEFAULT`子句的非列的值时，将缺少一个值。（对于
        `NULL`列，`NULL`如果值缺失则插入。）严格模式还会影响 DDL 语句，例如`CREATE TABLE`.

        如果严格模式未生效，MySQL 会为无效或缺失值插入调整后的值并产生警告（请参阅
        第 13.7.7.42 节，“SHOW WARNINGS 语句”）。在严格模式下，您可以使用
        `INSERT IGNORE`
        or产生这种行为`UPDATE IGNORE`。

        对于诸如`SELECT`
        不更改数据之类的语句，无效值会在严格模式下生成警告，而不是错误。

        严格模式会在尝试创建超过最大密钥长度的密钥时产生错误。当未启用严格模式时，这会导致警告并将密钥截断为最大密钥长度。

        严格模式不影响是否检查外键约束。`foreign_key_checks`可以用于那个。（请参阅
        第 5.1.8 节，“服务器系统变量”。）

`STRICT_ALL_TABLES`如果启用或
        ，
        严格 SQL 模式将生效
        `STRICT_TRANS_TABLES`，尽管这些模式的效果有所不同：

- 对于事务表，当启用STRICT_ALL_TABLES或 时，数据更改语句中的无效值或缺失值会发生错误 。STRICT_TRANS_TABLES该语句被中止并回滚。
- 对于非事务表，如果错误值出现在要插入或更新的第一行中，两种模式的行为都是相同的：语句被中止，表保持不变。如果语句插入或修改多行并且错误值出现在第二行或后面的行中，则结果取决于启用的严格模式： 对于STRICT_ALL_TABLES，MySQL 返回错误并忽略其余行。但是，因为前面的行已被插入或更新，所以结果是部分更新。为避免这种情况，请使用单行语句，它可以在不更改表的情况下中止。
- 对于 STRICT_TRANS_TABLES，MySQL 将无效值转换为最接近列的有效值并插入调整后的值。如果缺少值，MySQL 将插入列数据类型的隐式默认值。在任何一种情况下，MySQL 都会生成警告而不是错误并继续处理该语句。隐式默认值在第 11.6 节，“数据类型默认值”中描述。

        严格模式影响除以零、零日期和日期中的零的处理，如下所示：

- 严格模式影响除以零的处理，其中包括 ： MOD(N,0) 对于数据更改操作 ( INSERT, UPDATE)： 如果未启用严格模式，则除以零会插入 NULL并且不会产生警告。
- 如果启用严格模式，除以零会产生错误，除非IGNORE也给出。对于INSERT IGNORE和 UPDATE IGNORE，除以零插入NULL并产生警告。

            对于`SELECT`，除以零返回`NULL`。启用严格模式也会导致产生警告。

- 严格模式影响服务器是否允许 '0000-00-00'作为有效日期： 如果未启用严格模式， '0000-00-00'则允许插入并且不会产生警告。
- 如果启用了严格模式， '0000-00-00'则不允许并且插入会产生错误，除非 IGNORE也给出。对于 INSERT IGNOREand UPDATE IGNORE，'0000-00-00'是允许的，插入会产生警告。

- 严格模式会影响服务器是否允许年部分为非零但月或日部分为 0 的日期（如'2010-00-01'或 的日期'2010-01-00'）： 如果未启用严格模式，则允许包含零部分的日期并且插入不会产生警告。
- 如果启用了严格模式，则不允许包含零部分的日期并且插入会产生错误，除非 IGNORE也给出。对于 INSERT IGNORE和UPDATE IGNORE，零部分的日期被插入为 '0000-00-00'（被认为对 有效IGNORE）并产生警告。

        有关严格模式的更多信息
        `IGNORE`，请参阅
        IGNORE 关键字和严格 SQL 模式的比较。

        严格模式会影响除以零、零日期和日期中的零以及
        `ERROR_FOR_DIVISION_BY_ZERO`、
        `NO_ZERO_DATE`和
        `NO_ZERO_IN_DATE`模式的处理。

#### IGNORE 关键字和严格 SQL 模式的比较

        本节比较
        `IGNORE`关键字（将错误降级为警告）和严格 SQL 模式（将警告升级为错误）对语句执行的影响。它描述了它们影响哪些语句，以及它们适用于哪些错误。

        下表提供了默认情况下产生错误与警告时语句行为的总结比较。默认情况下会产生错误的示例是将 a 插入`NULL`到`NOT NULL`列中。默认情况下会产生警告的一个示例是将错误数据类型的值插入到列中（例如将字符串
        `'abc'`插入到整数列中）。

| 运作模式 | 当 Statement Default 出错时 | 当声明默认为警告时 |
| --- | --- | --- |
| 无IGNORE或严格 SQL 模式 | 错误 | 警告 |
| 和IGNORE | 警告 | 警告（与没有IGNORE或严格 SQL 模式相同） |
| 使用严格的 SQL 模式 | 错误（与没有IGNORE或严格 SQL 模式相同） | 错误 |
| 使用IGNORE和严格的 SQL 模式 | 警告 | 警告 |

        从表中得出的一个结论是，当
        `IGNORE`关键字和严格 SQL 模式都有效时，`IGNORE`优先。这意味着，虽然`IGNORE`和严格 SQL 模式可以被认为对错误处理有相反的效果，但它们在一起使用时不会取消。

- IGNORE 对语句执行的影响
- 严格SQL模式对语句执行的影响

IGNORE 对语句执行的影响

        MySQL 中的几个语句支持可选
        `IGNORE`关键字。此关键字导致服务器降级某些类型的错误并生成警告。对于多行语句，将错误降级为警告可能会启用要处理的行。否则，
        `IGNORE`导致语句跳到下一行而不是中止。（对于不可忽略的错误，无论`IGNORE`关键字如何都会发生错误。）

        示例：如果表`t`的主键列`i`包含唯一值，尝试将相同的值`i`插入多行通常会产生重复键错误：

```sql
mysql> CREATE TABLE t (i INT NOT NULL PRIMARY KEY);
mysql> INSERT INTO t (i) VALUES(1),(1);
ERROR 1062 (23000): Duplicate entry '1' for key 't.PRIMARY'
```

        使用`IGNORE`，仍然没有插入包含重复键的行，但会出现警告而不是错误：

```sql
mysql> INSERT IGNORE INTO t (i) VALUES(1),(1);
Query OK, 1 row affected, 1 warning (0.01 sec)
Records: 2  Duplicates: 1  Warnings: 1

mysql> SHOW WARNINGS;
+---------+------+-----------------------------------------+
| Level   | Code | Message                                 |
+---------+------+-----------------------------------------+
| Warning | 1062 | Duplicate entry '1' for key 't.PRIMARY' |
+---------+------+-----------------------------------------+
1 row in set (0.00 sec)
```

        示例：如果表`t2`有`NOT NULL`列`id`，尝试插入`NULL`会在严格 SQL 模式下产生错误：

```sql
mysql> CREATE TABLE t2 (id INT NOT NULL);
mysql> INSERT INTO t2 (id) VALUES(1),(NULL),(3);
ERROR 1048 (23000): Column 'id' cannot be null
mysql> SELECT * FROM t2;
Empty set (0.00 sec)
```

        如果 SQL 模式不严格，则`IGNORE`导致`NULL`作为列隐式默认值（在本例中为 0）插入，这使得可以在不跳过行的情况下处理该行：

```sql
mysql> INSERT INTO t2 (id) VALUES(1),(NULL),(3);
mysql> SELECT * FROM t2;
+----+
| id |
+----+
|  1 |
|  0 |
|  3 |
+----+
```

        这些语句支持`IGNORE`关键字：

- CREATE TABLE ... SELECT:IGNORE不适用于语句的CREATE TABLE或 SELECT部分，但适用于插入到由 生成的行的表中 SELECT。与唯一键值上的现有行重复的行将被丢弃。
- DELETE： IGNORE导致MySQL在删除行的过程中忽略错误。
- INSERT：对于 IGNORE，在唯一键值上重复现有行的行将被丢弃。设置为会导致数据转换错误的值的行将改为设置为最接近的有效值。 对于未找到与给定值匹配的分区的分区表，IGNORE对于包含不匹配值的行，导致插入操作静默失败。
- LOAD DATA, LOAD XML: 对于 IGNORE, 在唯一键值上重复现有行的行将被丢弃。
- UPDATE：对于 IGNORE，在唯一键值上发生重复键冲突的行不会更新。更新为会导致数据转换错误的值的行将更新为最接近的有效值。

        该`IGNORE`关键字适用于以下可忽略的错误：

```text
ER_BAD_NULL_ERROR
ER_DUP_ENTRY
ER_DUP_ENTRY_WITH_KEY_NAME
ER_DUP_KEY
ER_NO_PARTITION_FOR_GIVEN_VALUE
ER_NO_PARTITION_FOR_GIVEN_VALUE_SILENT
ER_NO_REFERENCED_ROW_2
ER_ROW_DOES_NOT_MATCH_GIVEN_PARTITION_SET
ER_ROW_IS_REFERENCED_2
ER_SUBQUERY_NO_1_ROW
ER_VIEW_CHECK_FAILED
```

严格SQL模式对语句执行的影响
`sql_mode`
        MySQL 服务器可以在不同的 SQL 模式下运行，并且可以根据系统变量
        的值对不同的客户端应用这些模式。在“严格” SQL 模式下，服务器将某些警告升级为错误。

        例如，在非严格 SQL 模式下，将字符串
        `'abc'`插入整数列会导致值转换为 0 并出现警告：

```sql
mysql> SET sql_mode = '';
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO t (i) VALUES('abc');
Query OK, 1 row affected, 1 warning (0.01 sec)

mysql> SHOW WARNINGS;
+---------+------+--------------------------------------------------------+
| Level   | Code | Message                                                |
+---------+------+--------------------------------------------------------+
| Warning | 1366 | Incorrect integer value: 'abc' for column 'i' at row 1 |
+---------+------+--------------------------------------------------------+
1 row in set (0.00 sec)
```

        在严格 SQL 模式下，无效值会被错误拒绝：

```sql
mysql> SET sql_mode = 'STRICT_ALL_TABLES';
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO t (i) VALUES('abc');
ERROR 1366 (HY000): Incorrect integer value: 'abc' for column 'i' at row 1
```

        有关
        `sql_mode`系统变量的可能设置的更多信息，请参阅
        第 5.1.11 节，“服务器 SQL 模式”。

        严格 SQL 模式适用于以下语句，在某些值可能超出范围或向表中插入或删除无效行的情况下：

- ALTER TABLE
- CREATE TABLE
- CREATE TABLE ... SELECT
- DELETE（单表和多表）
- INSERT
- LOAD DATA
- LOAD XML
- SELECT SLEEP()
- UPDATE（单表和多表）

        在存储程序中，如果程序是在严格模式生效时定义的，那么刚刚列出的类型的单个语句将以严格 SQL 模式执行。

        严格 SQL 模式适用于以下错误，这些错误表示输入值无效或缺失的一类错误。如果列的数据类型错误或可能超出范围，则值无效。如果要插入的新行不包含其定义`NOT NULL`中没有显式
        `DEFAULT`子句的列的值，则值丢失。

```text
ER_BAD_NULL_ERROR
ER_CUT_VALUE_GROUP_CONCAT
ER_DATA_TOO_LONG
ER_DATETIME_FUNCTION_OVERFLOW
ER_DIVISION_BY_ZERO
ER_INVALID_ARGUMENT_FOR_LOGARITHM
ER_NO_DEFAULT_FOR_FIELD
ER_NO_DEFAULT_FOR_VIEW_FIELD
ER_TOO_LONG_KEY
ER_TRUNCATED_WRONG_VALUE
ER_TRUNCATED_WRONG_VALUE_FOR_FIELD
ER_WARN_DATA_OUT_OF_RANGE
ER_WARN_NULL_TO_NOTNULL
ER_WARN_TOO_FEW_RECORDS
ER_WRONG_ARGUMENTS
ER_WRONG_VALUE_FOR_TYPE
WARN_DATA_TRUNCATED
```

笔记

          因为继续的 MySQL 开发定义了新的错误，所以可能存在不在前面列表中的错误，这些错误适用于严格的 SQL 模式。

---

[← 返回 第 5 章 MySQL 服务器管理 索引](00-index.md) · [← 返回总索引](../00-index.md)
