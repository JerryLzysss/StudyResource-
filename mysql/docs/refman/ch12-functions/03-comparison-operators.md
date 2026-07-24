# 第 12 章 函数和运算符 · 比较函数和运算符

> 对应 SQL：[`sql/refman/ch12-functions/03-comparison-operators.sql`](../../../sql/refman/ch12-functions/03-comparison-operators.sql)

---

12.4.2 比较函数和运算符_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 12 章函数和运算符 / 12.4 运营商 / 12.4.2 比较函数和运算符 表 12.4 比较运算符 姓名 描述 > 大于运算符 >= 大于或等于运算符 ,!= 不等于运算符  NULL 安全等于运算符 = 等于运算符 BETWEEN ... AND ... 一个值是否在一个值范围内 COALESCE() 返回第一个非 NULL 参数 GREATEST() 返回最大的参数 IN() 一个值是否在一组值内 INTERVAL() 返回小于第一个参数的参数的索引 IS 针对布尔值测试值 IS NOT 针对布尔值测试值 IS NOT NULL NOT NULL 值测试 IS NULL NULL 值测试 ISNULL() 测试参数是否为 NULL LEAST() 返回最小的参数 LIKE 简单模式匹配 NOT BETWEEN ... AND ... 值是否不在值范围内 NOT IN() 一个值是否不在一组值中 NOT LIKE 简单模式匹配的否定 STRCMP() 比较两个字符串 比较运算的结果为1 ( TRUE)、0 ( FALSE) 或NULL。这些操作适用于数字和字符串。根据需要，字符串会自动转换为数字，数字也会自动转换为字符串。 以下关系比较运算符不仅可用于比较标量操作数，还可用于比较行操作数： ```text = > = != ``` 本节后面对这些运算符的描述详细说明了它们如何使用行操作数。有关行子查询上下文中行比较的其他示例，请参阅 第 13.2.11.5 节，“行子查询”。 本节中的某些函数返回 1( TRUE)、 0( FALSE) 或 以外的值NULL。LEAST() 并且GREATEST()是此类功能的示例；第 12.3 节，“表达式计算中的类型转换”，描述了由这些函数和类似函数执行的用于确定其返回值的比较操作的规则。 笔记 在以前的 MySQL 版本中，当评估包含LEAST()or 的表达式时GREATEST()，服务器会尝试猜测使用函数的上下文，并将函数的参数强制转换为整个表达式的数据类型。例如， 的参数LEAST("11", "45", "2")被评估并排序为字符串，因此该表达式返回"11"。在 MySQL 8.0.3 及更早版本中，在计算表达式时 LEAST("11", "45", "2") + 0，服务器在对它们进行排序之前将参数转换为整数（预期将整数 0 添加到结果中），从而返回 2。 从 MySQL 8.0.4 开始，服务器不再尝试以这种方式推断上下文。相反，该函数是使用提供的参数执行的，当且仅当它们不都是同一类型时，才对一个或多个参数执行数据类型转换。使用返回值的表达式强制执行的任何类型强制现在都在函数执行后执行。这意味着，在 MySQL 8.0.4 及更高版本中，LEAST("11", "45", "2") + 0计算"11" + 0结果为整数 11。（Bug #83895，Bug #25123839） 要将值转换为特定类型以进行比较，您可以使用该CAST()函数。可以使用 将字符串值转换为不同的字符集CONVERT()。请参阅 第 12.11 节，“Cast 函数和运算符”。 默认情况下，字符串比较不区分大小写并使用当前字符集。默认值为 utf8mb4。 = 平等的： ```sql mysql> SELECT 1 = 0; -> 0 mysql> SELECT '0' = 0; -> 1 mysql> SELECT '0.0' = 0; -> 1 mysql> SELECT '0.01' = 0; -> 0 mysql> SELECT '.01' = 0.01; -> 1 ``` 对于行比较，(a, b) = (x, y)相当于： ```text (a = x) AND (b = y) ```
-  NULL-安全平等。此运算符执行与运算符类似的相等比较 ，但如果两个操作数都是 ，则=返回1而不是 返回，而不是一个操作数是 。 NULLNULL0NULLNULL 该  运算符等同于标准 SQLIS NOT DISTINCT FROM运算符。 ```sql mysql> SELECT 1 1, NULL NULL, 1 NULL; -> 1, 1, 0 mysql> SELECT 1 = 1, NULL = NULL, 1 = NULL; -> 1, NULL, NULL ``` 对于行比较，(a, b)  (x, y)相当于： ```text (a x) AND (b y) ```
- <>, != 不等于： ```sql mysql> SELECT '.01' <> '0.01'; -> 1 mysql> SELECT .01 <> '0.01'; -> 0 mysql> SELECT 'zapp' <> 'zappp'; -> 1 ``` 对于行比较，(a, b) <> (x, y)和(a, b) != (x, y)等同于： ```text (a <> x) OR (b <> y) ```
-  SELECT 0.1 1 ``` 对于行比较，(a, b)  SELECT 2 0 ``` 对于行比较，(a, b) = 大于或等于： ```sql mysql> SELECT 2 >= 2; -> 1 ``` 对于行比较，(a, b) >= (x, y) 相当于： ```text (a > x) OR ((a = x) AND (b >= y)) ```
- > 比...更棒： ```sql mysql> SELECT 2 > 2; -> 0 ``` 对于行比较，(a, b) > (x, y) 相当于： ```text (a > x) OR ((a = x) AND (b > y)) ```
- expr BETWEEN min AND max 如果expr大于或等于min且 expr小于或等于 max， 则BETWEEN返回 1，否则返回 0。如果所有参数都属于同一类型，则这等效于表达式 。否则类型转换将根据 第 12.3 节“表达式计算中的类型转换”中描述的规则进行，但适用于所有三个参数。 (min  SELECT 2 BETWEEN 1 AND 3, 2 BETWEEN 3 and 1; -> 1, 0 mysql> SELECT 1 BETWEEN 2 AND 3; -> 0 mysql> SELECT 'b' BETWEEN 'a' AND 'c'; -> 1 mysql> SELECT 2 BETWEEN 2 AND '3'; -> 1 mysql> SELECT 2 BETWEEN 2 AND 'x-3'; -> 0 ``` BETWEEN为了在与日期或时间值一起使用 时获得最佳结果 ，请使用CAST()将值显式转换为所需的数据类型。示例：如果将 a DATETIME与两个 DATE值进行比较，则将值转换 DATE为 DATETIME值。如果您'2001-1-1'在与 a 的比较中使用字符串常量DATE，则将字符串转换为 a DATE。
- expr NOT BETWEEN min AND max 这与. NOT (expr BETWEEN min AND max)
- COALESCE(value,...) 返回NULL列表中的第一个非值，或者NULL如果没有非NULL值。 的返回类型COALESCE() 是参数类型的聚合类型。 ```sql mysql> SELECT COALESCE(NULL,1); -> 1 mysql> SELECT COALESCE(NULL,NULL,NULL); -> NULL ```
- GREATEST(value1,value2,...) 使用两个或多个参数，返回最大（最大值）的参数。使用与 for 相同的规则比较参数 LEAST()。 ```sql mysql> SELECT GREATEST(2,0); -> 2 mysql> SELECT GREATEST(34.0,3.0,5.0,767.0); -> 767.0 mysql> SELECT GREATEST('B','A','C'); -> 'C' ``` GREATEST()NULL如果任何参数是 ，则返回 NULL。
- expr IN (value,...) 1如果 expr等于列表中的任何值，则 返回(true) IN()，否则返回 0(false)。 类型转换根据第 12.3 节“表达式求值中的类型转换”中描述的规则进行，适用于所有参数。如果列表中的值不需要类型转换IN()，它们都是JSON同一类型的非常量，并且 expr可以作为同一类型的值与它们中的每一个进行比较（可能在类型转换之后），则进行优化. 对列表中的值进行排序，并 expr使用二进制搜索完成搜索，这使得IN()操作非常快速。 ```sql mysql> SELECT 2 IN (0,3,5,7); -> 0 mysql> SELECT 'wefwf' IN ('wee','wefwf','weg'); -> 1 ``` IN()可用于比较行构造函数： ```sql mysql> SELECT (3,4) IN ((1,2), (3,4)); -> 1 mysql> SELECT (3,4) IN ((1,2), (3,5)); -> 0 ``` 永远不要在 IN()列表中混合引用和未引用的值，因为引用值（例如字符串）和未引用值（例如数字）的比较规则不同。因此，混合类型可能会导致不一致的结果。例如，不要写这样的 IN()表达式： ```sql SELECT val1 FROM tbl1 WHERE val1 IN (1,2,'a'); ``` 相反，这样写： ```sql SELECT val1 FROM tbl1 WHERE val1 IN ('1','2','a'); ``` 隐式类型转换可能会产生不直观的结果： ```sql mysql> SELECT 'a' IN (0), 0 IN ('b'); -> 1, 1 ``` 在这两种情况下，比较值都被转换为浮点值，在每种情况下产生 0.0，比较结果为 1（真）。 列表中值的数量IN()仅受 max_allowed_packet值限制。 为了符合 SQL 标准，不仅在左侧的表达式为 时IN() 返回，而且在列表中未找到匹配且列表中的表达式之一为 时也返回。 NULLNULLNULL IN()语法也可以用来编写某些类型的子查询。请参阅 第 13.2.11.3 节，“带有 ANY、IN 或 SOME 的子查询”。
- expr NOT IN (value,...) 这与. NOT (expr IN (value,...))
- INTERVAL(N,N1,N2,N3,...) 返回0if N  SELECT INTERVAL(23, 1, 15, 17, 30, 44, 200); -> 3 mysql> SELECT INTERVAL(10, 1, 10, 100, 1000); -> 2 mysql> SELECT INTERVAL(22, 23, 30, 44, 200); -> 0 ```
- IS boolean_value 根据布尔值测试值，其中 boolean_value可以是 TRUE、FALSE或 UNKNOWN。 ```sql mysql> SELECT 1 IS TRUE, 0 IS FALSE, NULL IS UNKNOWN; -> 1, 1, 1 ```
- IS NOT boolean_value 根据布尔值测试值，其中 boolean_value可以是 TRUE、FALSE或 UNKNOWN。 ```sql mysql> SELECT 1 IS NOT UNKNOWN, 0 IS NOT UNKNOWN, NULL IS NOT UNKNOWN; -> 1, 1, 0 ```
- IS NULL 测试一个值是否为NULL. ```sql mysql> SELECT 1 IS NULL, 0 IS NULL, NULL IS NULL; -> 0, 0, 1 ``` 为了更好地与 ODBC 程序配合使用，MySQL 在使用时支持以下额外功能IS NULL： 如果sql_auto_is_null 变量设置为 1，则在成功插入自动生成的 AUTO_INCREMENT值的语句之后，您可以通过发出以下形式的语句来找到该值： ```sql SELECT * FROM tbl_name WHERE auto_col IS NULL ``` 如果该语句返回一行，则返回的值与您调用该 LAST_INSERT_ID() 函数时的值相同。有关详细信息，包括多行插入后的返回值，请参阅 第 12.16 节，“信息函数”。如果未 AUTO_INCREMENT成功插入任何值，则该SELECT 语句不返回任何行。 可以通过设置禁用 AUTO_INCREMENT使用 比较 检索值的行为 。请参阅第 5.1.8 节，“服务器系统变量”。 IS NULLsql_auto_is_null = 0 的默认值为 sql_auto_is_null0。
- 对于声明为DATE和 的列，您可以使用如下语句 找到特殊日期：DATETIMENOT NULL'0000-00-00' ```sql SELECT * FROM tbl_name WHERE date_column IS NULL ``` 这是使某些 ODBC 应用程序工作所必需的，因为 ODBC 不支持 '0000-00-00'日期值。 请参阅 获取自动增量值和 连接器/ODBC 连接参数FLAG_AUTO_IS_NULL中的选项 说明。

- IS NOT NULL 测试一个值是否不是NULL. ```sql mysql> SELECT 1 IS NOT NULL, 0 IS NOT NULL, NULL IS NOT NULL; -> 1, 1, 0 ```
- ISNULL(expr) 如果expr是 NULL， 则ISNULL()返回 1，否则返回 0。 ```sql mysql> SELECT ISNULL(1+1); -> 0 mysql> SELECT ISNULL(1/0); -> 1 ``` ISNULL()可以用来代替=to 来测试一个值是否为NULL. （将值与NULL使用 =always 进行比较会产生NULL。） 该函数与 比较运算符ISNULL()共享一些特殊行为 。IS NULL见说明 IS NULL。
- LEAST(value1,value2,...) 对于两个或多个参数，返回最小（最小值）参数。使用以下规则比较参数： 如果任何参数是NULL，则结果是NULL。不需要比较。
- 如果所有参数都是整数值，则将它们作为整数进行比较。
- 如果至少一个参数是双精度，则将它们作为双精度值进行比较。否则，如果至少一个参数是一个 DECIMAL值，则将它们作为DECIMAL 值进行比较。
- 如果参数包含数字和字符串的混合，则将它们作为字符串进行比较。
- 如果任何参数是非二进制（字符）字符串，则将参数作为非二进制字符串进行比较。
- 在所有其他情况下，参数将作为二进制字符串进行比较。

            的返回类型`LEAST()`是比较参数类型的聚合类型。

```sql
mysql> SELECT LEAST(2,0);
        -> 0
mysql> SELECT LEAST(34.0,3.0,5.0,767.0);
        -> 3.0
mysql> SELECT LEAST('B','A','C');
        -> 'A'
```

---

[← 返回 第 12 章 函数和运算符 索引](00-index.md) · [← 返回总索引](../00-index.md)
