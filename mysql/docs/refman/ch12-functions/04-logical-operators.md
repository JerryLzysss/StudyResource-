# 第 12 章 函数和运算符 · 逻辑运算符

> 对应 SQL：[`sql/refman/ch12-functions/04-logical-operators.sql`](../../../sql/refman/ch12-functions/04-logical-operators.sql)

---

12.4.3 逻辑运算符_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 12 章函数和运算符 / 12.4 运营商 / 12.4.3 逻辑运算符 表 12.5 逻辑运算符 姓名 描述 AND,&& 逻辑与 NOT,! 否定价值 OR,|| 逻辑或 XOR 逻辑异或 在 SQL 中，所有逻辑运算符的计算结果都是 TRUE、FALSE或 NULL( UNKNOWN)。在 MySQL 中，这些实现为 1 ( TRUE)、0 ( FALSE) 和NULL。其中大部分对于不同的 SQL 数据库服务器是通用的，尽管某些服务器可能会为 返回任何非零值 TRUE。 MySQL 将任何非零、非NULL值计算为TRUE。例如，以下语句均评估为TRUE： ```sql mysql> SELECT 10 IS TRUE; -> 1 mysql> SELECT -10 IS TRUE; -> 1 mysql> SELECT 'string' IS NOT NULL; -> 1 ``` NOT, ! 逻辑非。计算1操作数是否为0，0操作数是否为非零，并NOT NULL 返回NULL。 ```sql mysql> SELECT NOT 10; -> 0 mysql> SELECT NOT 0; -> 1 mysql> SELECT NOT NULL; -> NULL mysql> SELECT ! (1+1); -> 0 mysql> SELECT ! 1+1; -> 1 ``` 生成最后一个示例1是因为表达式的计算方式与 相同 (!1)+1。 ,!运算符是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此运算符已弃用；希望在未来的 MySQL 版本中将其删除。应调整应用程序以使用标准 SQLNOT运算符。
- AND, && 逻辑与。评估1是否所有操作数都是非零且不是NULL， 0如果一个或多个操作数是 0，否则NULL返回。 ```sql mysql> SELECT 1 AND 1; -> 1 mysql> SELECT 1 AND 0; -> 0 mysql> SELECT 1 AND NULL; -> NULL mysql> SELECT 0 AND NULL; -> 0 mysql> SELECT NULL AND 0; -> 0 ``` ,&&运算符是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此运算符已弃用；希望在未来版本的 MySQL 中删除对它的支持。应调整应用程序以使用标准 SQL AND运算符。
- OR, || 逻辑或。当两个操作数都为非NULL- 时，结果为 1如果任何操作数为非零， 0否则为。对于一个 NULL操作数，结果是 1另一个操作数是否为非零， NULL否则。如果两个操作数都是 NULL，则结果是 NULL。 ```sql mysql> SELECT 1 OR 1; -> 1 mysql> SELECT 1 OR 0; -> 1 mysql> SELECT 0 OR 0; -> 0 mysql> SELECT 0 OR NULL; -> NULL mysql> SELECT 1 OR NULL; -> 1 ``` 笔记 如果PIPES_AS_CONCAT 启用了 SQL 模式，则 ||表示 SQL 标准字符串连接运算符（如 CONCAT()）。 ,||运算符是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此运算符已弃用；希望在未来版本的 MySQL 中删除对它的支持。应调整应用程序以使用标准 SQL OR运算符。PIPES_AS_CONCAT例外：如果启用， 则弃用不适用， 因为在这种情况下，||表示字符串连接。
- XOR 逻辑异或。NULL如果任一操作数是 ，则返回NULL。对于非NULL操作数， 1如果奇数个操作数不为零，则求值，否则0返回。 ```sql mysql> SELECT 1 XOR 1; -> 0 mysql> SELECT 1 XOR 0; -> 1 mysql> SELECT 1 XOR NULL; -> NULL mysql> SELECT 1 XOR 1 XOR 1; -> 1 ``` a XOR b在数学上等于 (a AND (NOT b)) OR ((NOT a) and b)。

---

[← 返回 第 12 章 函数和运算符 索引](00-index.md) · [← 返回总索引](../00-index.md)
