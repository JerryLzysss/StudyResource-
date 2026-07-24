# 第 12 章 函数和运算符 · 聚合函数

> 对应 SQL：[`sql/refman/ch12-functions/10-aggregate-functions.sql`](../../../sql/refman/ch12-functions/10-aggregate-functions.sql)

---

12.20.1 聚合函数说明_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 12 章函数和运算符 / 12.20聚合函数 / 12.20.1 聚合函数说明 本节介绍对值集进行操作的聚合函数。它们通常与GROUP BY子句一起使用以将值分组到子集中。 表 12.25 聚合函数 姓名 描述 AVG() 返回参数的平均值 BIT_AND() 返回按位与 BIT_OR() 返回按位或 BIT_XOR() 返回按位异或 COUNT() 返回返回行数的计数 COUNT(DISTINCT) 返回多个不同值的计数 GROUP_CONCAT() 返回一个连接的字符串 JSON_ARRAYAGG() 将结果集作为单个 JSON 数组返回 JSON_OBJECTAGG() 将结果集作为单个 JSON 对象返回 MAX() 返回最大值 MIN() 返回最小值 STD() 返回总体标准差 STDDEV() 返回总体标准差 STDDEV_POP() 返回总体标准差 STDDEV_SAMP() 返回样本标准差 SUM() 返回总和 VAR_POP() 返回总体标准方差 VAR_SAMP() 返回样本方差 VARIANCE() 返回总体标准方差 除非另有说明，聚合函数忽略 NULL值。 如果在不包含 GROUP BY子句的语句中使用聚合函数，则相当于对所有行进行分组。有关详细信息，请参阅 第 12.20.3 节，“MySQL 对 GROUP BY 的处理”。 大多数聚合函数都可以用作窗口函数。可以这种方式使用的那些在它们的语法描述中用 表示，代表一个可选的子句。 在 第 12.21.2 节“窗口函数概念和语法”中进行了描述，其中还包括有关窗口函数用法的其他信息。 [over_clause]OVERover_clause 对于数字参数，方差和标准差函数返回一个DOUBLE值。和函数 为精确值参数（整数或）返回一个值SUM()， 为近似值参数（或 ）返回一个值。 AVG()DECIMALDECIMALDOUBLEFLOATDOUBLE 和聚合函数SUM()不适 AVG()用于时间值。（他们将值转换为数字，在第一个非数字字符之后丢失所有内容。）要解决此问题，请转换为数字单位，执行聚合操作，然后转换回时间值。例子： ```sql SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(time_col))) FROM tbl_name; SELECT FROM_DAYS(SUM(TO_DAYS(date_col))) FROM tbl_name; ``` 如有必要SUM()， AVG()期望数字参数的函数将参数转换为数字。对于 SETor ENUM值，转换操作会导致使用基础数值。 、BIT_AND()和 聚合函数执行位运算BIT_OR()。 BIT_XOR()在 MySQL 8.0 之前，位函数和运算符需要BIGINT（64 位整数）参数和返回 BIGINT值，因此它们的最大范围为 64 位。非参数在执行操作之前 BIGINT被转换为并且可能发生截断。BIGINT 在 MySQL 8.0 中，位函数和运算符允许二进制字符串类型参数（BINARY、 VARBINARY和 BLOB类型）并返回类似类型的值，这使它们能够接受参数并产生大于 64 位的返回值。有关位操作的参数评估和结果类型的讨论，请参阅第 12.13 节，“位函数和运算符”中的介绍性讨论。 AVG([DISTINCT] expr) [over_clause] 返回 的平均值 expr。该 DISTINCT选项可用于返回 的不同值的平均值 expr。 如果没有匹配的行，则 AVG()返回 NULL。该函数还返回 NULLif expr is NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述；它不能与 一起使用DISTINCT。 ```sql mysql> SELECT student_name, AVG(test_score) FROM student GROUP BY student_name; ```
- BIT_AND(expr) [over_clause] 返回AND中所有位 的按位expr。 结果类型取决于函数参数值是被评估为二进制字符串还是数字： 当参数值具有二进制字符串类型并且参数不是十六进制文字、位文字或 NULL文字时，会发生二进制字符串评估。否则会进行数字评估，必要时将参数值转换为无符号 64 位整数。
- 二进制字符串评估生成与参数值长度相同的二进制字符串。如果参数值的长度不相等， ER_INVALID_BITWISE_OPERANDS_SIZE 则会发生错误。如果参数大小超过 511 字节， ER_INVALID_BITWISE_AGGREGATE_OPERANDS_SIZE 则会发生错误。数值计算产生一个无符号的 64 位整数。

            如果没有匹配的行，则
            `BIT_AND()`返回一个与参数值长度相同的中性值（所有位设置为 1）。

            `NULL`除非所有值都是 ，否则值不会影响结果`NULL`。在这种情况下，结果是一个与参数值长度相同的中性值。

            有关参数评估和结果类型的更多信息讨论，请参阅
            第 12.13 节“位函数和运算符”中的介绍性讨论。

            如果`BIT_AND()`从**mysql**客户端中调用，则二进制字符串结果使用十六进制表示法显示，具体取决于`--binary-as-hex`. 有关该选项的更多信息，请参阅
            第 4.5.1 节，“mysql — MySQL 命令行客户端”。

*`over_clause`*从 MySQL 8.0.12 开始，如果存在
            ，此函数将作为窗口函数执行。*`over_clause`*如第 12.21.2 节，“窗口函数概念和语法”中所述。

- BIT_OR(expr) [over_clause] 返回OR中所有位 的按位expr。 结果类型取决于函数参数值是被评估为二进制字符串还是数字： 当参数值具有二进制字符串类型并且参数不是十六进制文字、位文字或 NULL文字时，会发生二进制字符串评估。否则会进行数字评估，必要时将参数值转换为无符号 64 位整数。
- 二进制字符串评估生成与参数值长度相同的二进制字符串。如果参数值的长度不相等， ER_INVALID_BITWISE_OPERANDS_SIZE 则会发生错误。如果参数大小超过 511 字节， ER_INVALID_BITWISE_AGGREGATE_OPERANDS_SIZE 则会发生错误。数值计算产生一个无符号的 64 位整数。

            如果没有匹配的行，则
            `BIT_OR()`返回一个与参数值长度相同的中性值（所有位设置为 0）。

            `NULL`除非所有值都是 ，否则值不会影响结果`NULL`。在这种情况下，结果是一个与参数值长度相同的中性值。

            有关参数评估和结果类型的更多信息讨论，请参阅
            第 12.13 节“位函数和运算符”中的介绍性讨论。

            如果`BIT_OR()`从**mysql**客户端中调用，则二进制字符串结果使用十六进制表示法显示，具体取决于`--binary-as-hex`. 有关该选项的更多信息，请参阅
            第 4.5.1 节，“mysql — MySQL 命令行客户端”。

*`over_clause`*从 MySQL 8.0.12 开始，如果存在
            ，此函数将作为窗口函数执行。*`over_clause`*如第 12.21.2 节，“窗口函数概念和语法”中所述。

- BIT_XOR(expr) [over_clause] 返回XOR中所有位的按位expr。 结果类型取决于函数参数值是被评估为二进制字符串还是数字： 当参数值具有二进制字符串类型并且参数不是十六进制文字、位文字或 NULL文字时，会发生二进制字符串评估。否则会进行数字评估，必要时将参数值转换为无符号 64 位整数。
- 二进制字符串评估生成与参数值长度相同的二进制字符串。如果参数值的长度不相等， ER_INVALID_BITWISE_OPERANDS_SIZE 则会发生错误。如果参数大小超过 511 字节， ER_INVALID_BITWISE_AGGREGATE_OPERANDS_SIZE 则会发生错误。数值计算产生一个无符号的 64 位整数。

            如果没有匹配的行，则
            `BIT_XOR()`返回一个与参数值长度相同的中性值（所有位设置为 0）。

            `NULL`除非所有值都是 ，否则值不会影响结果`NULL`。在这种情况下，结果是一个与参数值长度相同的中性值。

            有关参数评估和结果类型的更多信息讨论，请参阅
            第 12.13 节“位函数和运算符”中的介绍性讨论。

            如果`BIT_XOR()`从**mysql**客户端中调用，则二进制字符串结果使用十六进制表示法显示，具体取决于`--binary-as-hex`. 有关该选项的更多信息，请参阅
            第 4.5.1 节，“mysql — MySQL 命令行客户端”。

*`over_clause`*从 MySQL 8.0.12 开始，如果存在
            ，此函数将作为窗口函数执行。*`over_clause`*如第 12.21.2 节，“窗口函数概念和语法”中所述。

- COUNT(expr) [over_clause] 返回语句检索的行中非NULL 值 的数量的计数。结果是一个 值。 exprSELECTBIGINT 如果没有匹配的行，则 COUNT()返回 0。COUNT(NULL)返回 0。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。 ```sql mysql> SELECT student.student_name,COUNT(*) FROM student,course WHERE student.student_id=course.student_id GROUP BY student_name; ``` COUNT(*)有点不同，因为它返回检索到的行数，无论它们是否包含 NULL值。 对于诸如 之类的事务性存储引擎 InnoDB，存储准确的行数是有问题的。多个事务可能同时发生，每个事务都可能影响计数。 InnoDB不保留表中行的内部计数，因为并发事务可能同时 “看到”不同数量的行。因此，SELECT COUNT(*) 语句只对当前事务可见的行进行计数。 从 MySQL 8.0.13 开始，如果没有额外的子句（例如or ），表的查询性能针对单线程工作负载进行了优化。 SELECT COUNT(*) FROM tbl_nameInnoDBWHEREGROUP BY InnoDB通过遍历最小的可用二级索引来处理SELECT COUNT(*)语句，除非索引或优化器提示指示优化器使用不同的索引。如果二级索引不存在，则通过扫描聚簇索引来 InnoDB 处理语句。SELECT COUNT(*)SELECT COUNT(*)如果索引记录不完​​全在缓冲池中，则 处理语句需要一些时间。为了更快地计数，创建一个计数器表并让您的应用程序根据它所做的插入和删除更新它。但是，在数千个并发事务正在启动对同一个计数器表的更新的情况下，此方法可能无法很好地扩展。如果近似行数足够，请使用 SHOW TABLE STATUS. InnoDB以相同的方式处理SELECT COUNT(*)和SELECT COUNT(1) 操作。没有性能差异。 对于MyISAM表， 如果从一个表中检索，没有检索到其他列，并且没有 子句，COUNT(*)则优化为非常快速地返回 。例如： SELECTWHERE ```sql mysql> SELECT COUNT(*) FROM student; ``` 此优化仅适用于MyISAM 表，因为为该存储引擎存储了精确的行数并且可以非常快速地访问。 COUNT(1)如果第一列定义为 ，则仅进行相同的优化NOT NULL。
- COUNT(DISTINCT expr,[expr...]) 返回具有不同非NULL expr 值的行数的计数。 如果没有匹配的行，则 COUNT(DISTINCT)返回 0。 ```sql mysql> SELECT COUNT(DISTINCT results) FROM student; ``` NULL在 MySQL 中，您可以通过给出一个表达式列表 来获取不包含的不同表达式组合的数量。在标准 SQL 中，您必须将 COUNT(DISTINCT ...).
- GROUP_CONCAT(expr) 此函数返回一个字符串结果，其中包含NULL来自组的连接的非值。NULL如果没有非NULL值，它会返回 。完整语法如下： ```text GROUP_CONCAT([DISTINCT] expr [,expr ...] [ORDER BY {unsigned_integer | col_name | expr} [ASC | DESC] [,col_name ...]] [SEPARATOR str_val]) ``` ```sql mysql> SELECT student_name, GROUP_CONCAT(test_score) FROM student GROUP BY student_name; ``` 或者： ```sql mysql> SELECT student_name, GROUP_CONCAT(DISTINCT test_score ORDER BY test_score DESC SEPARATOR ' ') FROM student GROUP BY student_name; ``` 在 MySQL 中，您可以获得表达式组合的连接值。要消除重复值，请使用 DISTINCT子句。要对结果中的值进行排序，请使用ORDER BY子句。要以相反的顺序排序，请将（降序）关键字添加到子句DESC 中作为排序依据的列的名称。ORDER BY默认为升序；这可以使用ASC关键字明确指定。组中值之间的默认分隔符是逗号 ( ,)。要明确指定分隔符，请使用SEPARATOR后跟应插入组值之间的字符串文字值。要完全消除分隔符，请指定 SEPARATOR ''. 结果被截断为系统变量给定的最大长度，group_concat_max_len 系统变量的默认值为 1024。该值可以设置得更高，但返回值的有效最大长度受 的值限制 max_allowed_packet。在运行时更改值的语法 group_concat_max_len如下，其中val 是一个无符号整数： ```sql SET [GLOBAL | SESSION] group_concat_max_len = val; ``` 返回值是非二进制或二进制字符串，具体取决于参数是非二进制字符串还是二进制字符串。结果类型为TEXTor BLOB除非 group_concat_max_len小于或等于 512，在这种情况下结果类型为 VARCHARor VARBINARY。 如果GROUP_CONCAT()从mysql客户端中调用，则二进制字符串结果使用十六进制表示法显示，具体取决于 --binary-as-hex. 有关该选项的更多信息，请参阅第 4.5.1 节，“mysql — MySQL 命令行客户端”。 另请参阅CONCAT()和 CONCAT_WS()： 第 12.8 节，“字符串函数和运算符”。
- JSON_ARRAYAGG(col_or_expr) [over_clause] 将结果集聚合为单个 JSON数组，其元素由行组成。此数组中元素的顺序未定义。该函数作用于计算结果为单个值的列或表达式。NULL如果结果不包含任何行，或者出现错误，则返回 。如果 col_or_expr是 ，该函数返回一个 JSON元素 NULL数组。[null]over_clause从 MySQL 8.0.14 开始，如果存在 ，此函数将作为窗口函数执行。over_clause如第 12.21.2 节，“窗口函数概念和语法”中所述。 ```sql mysql> SELECT o_id, attribute, value FROM t3; +------+-----------+-------+ | o_id | attribute | value | +------+-----------+-------+ | 2 | color | red | | 2 | fabric | silk | | 3 | color | green | | 3 | shape | square| +------+-----------+-------+ 4 rows in set (0.00 sec) mysql> SELECT o_id, JSON_ARRAYAGG(attribute) AS attributes -> FROM t3 GROUP BY o_id; +------+---------------------+ | o_id | attributes | +------+---------------------+ | 2 | ["color", "fabric"] | | 3 | ["color", "shape"] | +------+---------------------+ 2 rows in set (0.00 sec) ```
- JSON_OBJECTAGG(key, value) [over_clause] 将两个列名或表达式作为参数，其中第一个用作键，第二个用作值，并返回包含键值对的 JSON 对象。NULL如果结果不包含任何行，或者出现错误，则返回。NULL如果任何键名是或参数的数量不等于 2， 则会发生错误。over_clause从 MySQL 8.0.14 开始，如果存在 ，此函数将作为窗口函数执行。over_clause如第 12.21.2 节，“窗口函数概念和语法”中所述。 ```sql mysql> SELECT o_id, attribute, value FROM t3; +------+-----------+-------+ | o_id | attribute | value | +------+-----------+-------+ | 2 | color | red | | 2 | fabric | silk | | 3 | color | green | | 3 | shape | square| +------+-----------+-------+ 4 rows in set (0.00 sec) mysql> SELECT o_id, JSON_OBJECTAGG(attribute, value) -> FROM t3 GROUP BY o_id; +------+---------------------------------------+ | o_id | JSON_OBJECTAGG(attribute, value) | +------+---------------------------------------+ | 2 | {"color": "red", "fabric": "silk"} | | 3 | {"color": "green", "shape": "square"} | +------+---------------------------------------+ 2 rows in set (0.00 sec) ``` 重复的密钥处理。 当此函数的结果被规范化时，具有重复键的值将被丢弃。为了与JSON不允许重复键的 MySQL 数据类型规范保持一致，只有最后遇到的值与返回对象中的该键一起使用（“最后一个重复键获胜”）。这意味着在SELECTcan 中的列上使用此函数的结果取决于返回行的顺序，这是无法保证的。 当用作窗口函数时，如果帧中有重复的键，则结果中只会出现键的最后一个值。ORDER BY如果规范保证值具有特定顺序，则帧中最后一行的键值是确定性的。如果不是，则密钥的结果值是不确定的。 考虑以下： ```sql mysql> CREATE TABLE t(c VARCHAR(10), i INT); Query OK, 0 rows affected (0.33 sec) mysql> INSERT INTO t VALUES ('key', 3), ('key', 4), ('key', 5); Query OK, 3 rows affected (0.10 sec) Records: 3 Duplicates: 0 Warnings: 0 mysql> SELECT c, i FROM t; +------+------+ | c | i | +------+------+ | key | 3 | | key | 4 | | key | 5 | +------+------+ 3 rows in set (0.00 sec) mysql> SELECT JSON_OBJECTAGG(c, i) FROM t; +----------------------+ | JSON_OBJECTAGG(c, i) | +----------------------+ | {"key": 5} | +----------------------+ 1 row in set (0.00 sec) mysql> DELETE FROM t; Query OK, 3 rows affected (0.08 sec) mysql> INSERT INTO t VALUES ('key', 3), ('key', 5), ('key', 4); Query OK, 3 rows affected (0.06 sec) Records: 3 Duplicates: 0 Warnings: 0 mysql> SELECT c, i FROM t; +------+------+ | c | i | +------+------+ | key | 3 | | key | 5 | | key | 4 | +------+------+ 3 rows in set (0.00 sec) mysql> SELECT JSON_OBJECTAGG(c, i) FROM t; +----------------------+ | JSON_OBJECTAGG(c, i) | +----------------------+ | {"key": 4} | +----------------------+ 1 row in set (0.00 sec) ``` 从上次查询中选择的键是不确定的。如果查询不使用GROUP BY（通常无论如何都会强制执行自己的排序）并且您更喜欢特定的键排序，则可以 通过包含一个带有规范的子句 来调用JSON_OBJECTAGG()作为窗口函数，以在框架行上强制执行特定的顺序。以下示例显示了使用和不 使用一些不同的帧规范时会发生什么。 OVERORDER BYORDER BY 没有ORDER BY，框架是整个分区： ```sql mysql> SELECT JSON_OBJECTAGG(c, i) OVER () AS json_object FROM t; +-------------+ | json_object | +-------------+ | {"key": 4} | | {"key": 4} | | {"key": 4} | +-------------+ ``` 使用ORDER BY，其中框架默认为RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW（升序和降序）： ```sql mysql> SELECT JSON_OBJECTAGG(c, i) OVER (ORDER BY i) AS json_object FROM t; +-------------+ | json_object | +-------------+ | {"key": 3} | | {"key": 4} | | {"key": 5} | +-------------+ mysql> SELECT JSON_OBJECTAGG(c, i) OVER (ORDER BY i DESC) AS json_object FROM t; +-------------+ | json_object | +-------------+ | {"key": 5} | | {"key": 4} | | {"key": 3} | +-------------+ ``` 带有ORDER BY整个分区的显式框架： ```sql mysql> SELECT JSON_OBJECTAGG(c, i) OVER (ORDER BY i ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS json_object FROM t; +-------------+ | json_object | +-------------+ | {"key": 5} | | {"key": 5} | | {"key": 5} | +-------------+ ``` 要返回特定键值（例如最小或最大），LIMIT请在适当的查询中包含一个子句。例如： ```sql mysql> SELECT JSON_OBJECTAGG(c, i) OVER (ORDER BY i) AS json_object FROM t LIMIT 1; +-------------+ | json_object | +-------------+ | {"key": 3} | +-------------+ mysql> SELECT JSON_OBJECTAGG(c, i) OVER (ORDER BY i DESC) AS json_object FROM t LIMIT 1; +-------------+ | json_object | +-------------+ | {"key": 5} | +-------------+ ``` 有关其他信息和示例， 请参阅JSON 值的规范化、合并和自动包装。
- MAX([DISTINCT] expr) [over_clause] 返回 的最大值 expr。 MAX()可能需要一个字符串参数；在这种情况下，它返回最大的字符串值。参见第 8.3.1 节，“MySQL 如何使用索引”。DISTINCT关键字可用于查找 的不同值的最大值 ， expr但是，这会产生与省略 相同的结果DISTINCT。 如果没有匹配的行，或者如果 expr是NULL， 则MAX()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述；它不能与 一起使用DISTINCT。 ```sql mysql> SELECT student_name, MIN(test_score), MAX(test_score) FROM student GROUP BY student_name; ``` 对于MAX()，MySQL 当前通过字符串值而不是字符串在集合中的相对位置来比较ENUM和 列。SET这与ORDER BY 比较它们的方式不同。
- MIN([DISTINCT] expr) [over_clause] 返回 的最小值 expr。 MIN()可能需要一个字符串参数；在这种情况下，它返回最小字符串值。参见第 8.3.1 节，“MySQL 如何使用索引”。DISTINCT关键字可用于查找 的不同值中的最小值 ， expr但是，这会产生与省略 相同的结果DISTINCT。 如果没有匹配的行，或者如果 expr是NULL， 则MIN()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述；它不能与 一起使用DISTINCT。 ```sql mysql> SELECT student_name, MIN(test_score), MAX(test_score) FROM student GROUP BY student_name; ``` 对于MIN()，MySQL 当前通过字符串值而不是字符串在集合中的相对位置来比较ENUM和 列。SET这与ORDER BY 比较它们的方式不同。
- STD(expr) [over_clause] 返回 的总体标准差 expr。 STD()是标准 SQL 函数的同义词 STDDEV_POP()，作为 MySQL 扩展提供。 如果没有匹配的行，或者如果 expr是NULL， 则STD()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。
- STDDEV(expr) [over_clause] 返回 的总体标准差 expr。 STDDEV()是标准 SQL 函数的同义词 STDDEV_POP()，提供它是为了与 Oracle 兼容。 如果没有匹配的行，或者如果 expr是NULL， 则STDDEV()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。
- STDDEV_POP(expr) [over_clause] expr返回（的平方根 ） 的总体标准差 VAR_POP()。您还可以使用 STD()or STDDEV()，它们等效但不是标准 SQL。 如果没有匹配的行，或者如果 expr是NULL， 则STDDEV_POP()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。
- STDDEV_SAMP(expr) [over_clause] 返回样本标准偏差 expr（的平方根 VAR_SAMP()。 如果没有匹配的行，或者如果 expr是NULL， 则STDDEV_SAMP()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。
- SUM([DISTINCT] expr) [over_clause] 返回 的总和expr。如果返回集没有行，则SUM() 返回NULL。DISTINCT关键字可用于仅对 的不同值求和 expr。 如果没有匹配的行，或者如果 expr是NULL， 则SUM()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述；它不能与 一起使用DISTINCT。
- VAR_POP(expr) [over_clause] 返回 的总体标准方差 expr。它将行视为整个总体，而不是样本，因此它以行数作为分母。您也可以使用 VARIANCE()，它等效但不是标准 SQL。 如果没有匹配的行，或者如果 expr是NULL， 则VAR_POP()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。
- VAR_SAMP(expr) [over_clause] 返回 的样本方差 expr。也就是说，分母是行数减一。 如果没有匹配的行，或者如果 expr是NULL， 则VAR_SAMP()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。
- VARIANCE(expr) [over_clause] 返回 的总体标准方差 expr。 VARIANCE()是标准 SQL 函数的同义词 VAR_POP()，作为 MySQL 扩展提供。 如果没有匹配的行，或者如果 expr是NULL， 则VARIANCE()返回 NULL。 over_clause如果存在， 此函数将作为窗口函数执行 。over_clause如 第 12.21.2 节，“窗口函数概念和语法”中所述。

---

[← 返回 第 12 章 函数和运算符 索引](00-index.md) · [← 返回总索引](../00-index.md)
