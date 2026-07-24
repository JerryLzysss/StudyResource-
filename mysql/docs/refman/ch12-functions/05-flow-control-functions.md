# 第 12 章 函数和运算符 · 流量控制函数

> 对应 SQL：[`sql/refman/ch12-functions/05-flow-control-functions.sql`](../../../sql/refman/ch12-functions/05-flow-control-functions.sql)

---

## 12.5 流量控制函数

**表 12.7 流量控制运算符**

| 姓名 | 描述 |
| --- | --- |
| CASE | 案例操作员 |
| IF() | 如果/否则构造 |
| IFNULL() | Null if/else 构造 |
| NULLIF() | 如果 expr1 = expr2 则返回 NULL |

- CASE value WHEN compare_value THEN result [WHEN compare_value THEN result ...] [ELSE result] END CASE WHEN condition THEN result [WHEN condition THEN result ...] [ELSE result] END 第一个CASE语法返回 result第一个 为真的比较。第二种语法返回第一个条件为真的结果。如果没有比较或条件为真，则返回之后的结果，或者如果没有 部分。 value=compare_valueELSENULLELSE 笔记 此处描述的运算符 语法与第 13.6.5.1 节“CASE 语句”中描述的 用于存储程序的 SQL语句略有不同 。该 语句不能有 子句，它以而不是 终止。 CASE CASE CASEELSE NULLEND CASEEND 表达式结果的返回类型CASE 是所有结果值的聚合类型： 如果所有类型都是数字，则聚合类型也是数字： 如果至少一个参数是双精度，则结果是双精度。
- 否则，如果至少有一个参数是 DECIMAL，则结果是 DECIMAL。
- 否则，结果是整数类型（有一个例外）： 如果所有整数类型都是有符号的或都是无符号的，则结果是相同的符号并且精度是所有指定整数类型（即 、 、 TINYINT、 或 ） 中最高的。 SMALLINTMEDIUMINTINTBIGINT
- 如果有符号和无符号整数类型的组合，结果是有符号的，精度可能更高。例如，如果类型为 signedINT和 unsigned INT，则结果为 signed BIGINT。
- 异常是无符号 BIGINT的，与任何有符号的整数类型相结合。结果 DECIMAL具有足够的精度和小数位数 0。

- 如果所有类型都是BIT，则结果是BIT。否则， BIT参数的处理方式类似于BIGINT。
- 如果所有类型都是YEAR，则结果是YEAR。否则， YEAR参数的处理方式类似于 INT。
- 如果所有类型都是字符串（CHAR或 VARCHAR），则结果的 VARCHAR最大长度由操作数的最长字符长度决定。
- 如果所有类型都是字符或二进制字符串，则结果为 VARBINARY.
- SET并被 ENUM视为类似 VARCHAR; 结果是 VARCHAR。
- 如果所有类型都是JSON，则结果是JSON。
- 如果所有类型都是时间的，则结果是时间的： 如果所有时间类型均为 DATE、 TIME或 TIMESTAMP，则结果分别为DATE、 TIME或 TIMESTAMP。
- 否则，对于时间类型的混合，结果是 DATETIME.

- 如果所有类型都是GEOMETRY，则结果是GEOMETRY。
- 如果任何类型是BLOB，则结果是BLOB。
- 对于所有其他类型组合，结果为 VARCHAR。
- NULL类型聚合忽略 文字操作数。

```sql
mysql> SELECT CASE 1 WHEN 1 THEN 'one'
    ->     WHEN 2 THEN 'two' ELSE 'more' END;
        -> 'one'
mysql> SELECT CASE WHEN 1>0 THEN 'true' ELSE 'false' END;
        -> 'true'
mysql> SELECT CASE BINARY 'B'
    ->     WHEN 'a' THEN 1 WHEN 'b' THEN 2 END;
        -> NULL
```

- IF(expr1,expr2,expr3) 如果expr1是TRUE (expr1 <> 0和expr1 IS NOT NULL)，则IF() 返回expr2。否则，它返回expr3。 笔记 还有一个statement，它与这里描述的 功能不同。请参阅 第 13.6.5.2 节，“IF 语句”。 IF IF() 如果expr2or 中只有一个expr3是显式 NULL的，则函数的结果类型 IF()是非NULL表达式的类型。 的默认返回类型IF() （当它存储到临时表中时可能很重要）计算如下： 如果expr2or expr3产生一个字符串，则结果是一个字符串。 如果expr2和 expr3都是字符串，则如果任一字符串区分大小写，则结果区分大小写。
- 如果expr2or expr3产生一个浮点值，则结果是一个浮点值。
- 如果expr2or expr3产生一个整数，则结果是一个整数。

```sql
mysql> SELECT IF(1>2,2,3);
        -> 3
mysql> SELECT IF(1 'yes'
mysql> SELECT IF(STRCMP('test','test1'),'no','yes');
        -> 'no'
```

- IFNULL(expr1,expr2) 如果expr1不是 NULL， 则IFNULL()返回 expr1；否则返回 expr2。 ```sql mysql> SELECT IFNULL(1,0); -> 1 mysql> SELECT IFNULL(NULL,10); -> 10 mysql> SELECT IFNULL(1/0,10); -> 10 mysql> SELECT IFNULL(1/0,'yes'); -> 'yes' ``` 的默认返回类型 是两个表达式中更“通用”的一个，顺序为、或。考虑基于表达式的表的情况，或者 MySQL 必须在临时表中内部存储返回值的情况： IFNULL(expr1,expr2)STRINGREALINTEGERIFNULL() ```sql mysql> CREATE TABLE tmp SELECT IFNULL(1,'test') AS test; mysql> DESCRIBE tmp; +-------+--------------+------+-----+---------+-------+ | Field | Type | Null | Key | Default | Extra | +-------+--------------+------+-----+---------+-------+ | test | varbinary(4) | NO | | | | +-------+--------------+------+-----+---------+-------+ ``` 在这个例子中，test 列的类型是VARBINARY(4)（字符串类型）。
- NULLIF(expr1,expr2) NULL如果 为真则返回，否则 返回。这与 . expr1 = expr2expr1CASE WHEN expr1 = expr2 THEN NULL ELSE expr1 END 返回值与第一个参数具有相同的类型。 ```sql mysql> SELECT NULLIF(1,1); -> NULL mysql> SELECT NULLIF(1,2); -> 1 ``` 笔记 expr1如果参数不相等， MySQL 计算两次。

      这些函数对系统变量值的处理在 MySQL 8.0.22 中发生了变化。对于这些函数中的每一个，如果第一个参数仅包含第二个参数使用的字符集和排序规则中存在的字符（并且它是常量），则使用后一个字符集和排序规则进行比较。在 MySQL 8.0.22 及更高版本中，系统变量值被处理为具有相同字符和排序规则的列值。一些将这些函数与先前成功的系统变量一起使用的查询随后可能会被Illegal mix of collat​​ions拒绝。在这种情况下，您应该将系统变量转换为正确的字符集和排序规则。

---

[← 返回 第 12 章 函数和运算符 索引](00-index.md) · [← 返回总索引](../00-index.md)
