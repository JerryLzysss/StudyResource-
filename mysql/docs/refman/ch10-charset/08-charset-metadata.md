# 第 10 章 字符集、排序规则、Unicode · 元数据字符集

> 对应 SQL：[`sql/refman/ch10-charset/08-charset-metadata.sql`](../../../sql/refman/ch10-charset/08-charset-metadata.sql)

---

10.2.2 元数据的 UTF-8_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 10 章字符集、排序规则、Unicode / 10.2 MySQL 中的字符集和排序规则 / 10.2.2 元数据的 UTF-8 元数据是“关于数据的数据。”任何 描述数据库的东西——而不是数据库的内容——都是元数据。因此，列名、数据库名、用户名、版本名和大部分字符串结果 SHOW都是元数据。表的内容也是如此， INFORMATION_SCHEMA因为根据定义，这些表包含有关数据库对象的信息。 元数据的表示必须满足以下要求： 所有元数据必须采用相同的字符集。否则，语句和表 in的SHOW语句都不会正常工作，因为这些操作结果的同一列中的不同行将采用不同的字符集。 SELECTINFORMATION_SCHEMA
- 元数据必须包括所有语言的所有字符。否则，用户将无法使用自己的语言来命名列和表。

        为了满足这两个要求，MySQL 将元数据存储在 Unicode 字符集中，即 UTF-8。如果您从不使用重音字符或非拉丁字符，这不会造成任何中断。但如果这样做，您应该知道元数据是 UTF-8 格式的。

        元数据要求意味着 、 、 、 、 和 函数的返回值
        `USER()`默认
        `CURRENT_USER()`具有
        `SESSION_USER()`UTF
         `SYSTEM_USER()`-
         `DATABASE()`8
        `VERSION()`字符集。

        服务器将
        `character_set_system`系统变量设置为元数据字符集的名称：

```sql
mysql> SHOW VARIABLES LIKE 'character_set_system';
+----------------------+---------+
| Variable_name        | Value   |
+----------------------+---------+
| character_set_system | utf8mb3 |
+----------------------+---------+
```

        使用 Unicode 存储元数据*并不*
        意味着服务器默认以字符集返回列的标题和`DESCRIBE`函数
        的结果。`character_set_system`当您使用`SELECT column1 FROM t`时，名称`column1`本身以系统变量的值确定的字符集从服务器返回到客户端，
        `character_set_results`系统变量的默认值为
        `utf8mb4`. 如果您希望服务器以不同的字符集传回元数据结果，请使用该
        `SET NAMES`语句强制服务器执行字符集转换。
        `SET NAMES`设置
        `character_set_results`和其他相关的系统变量。（看
        第 10.4 节，“连接字符集和排序规则”。）或者，客户端程序可以在从服务器接收到结果后执行转换。客户端执行转换效率更高，但并非所有客户端都可以使用此选项。

        如果`character_set_results`设置为`NULL`，则不执行任何转换，服务器使用其原始字符集（由 指示的集
        `character_set_system`）返回元数据。

        与元数据一样，从服务器返回到客户端的错误消息会自动转换为客户端字符集。

        如果您在单个语句中使用（例如）
        `USER()`比较或赋值函数，请不要担心。MySQL 为您执行一些自动转换。

```sql
SELECT * FROM t1 WHERE USER() = latin1_column;
```

        这是有效的，因为 的内容
        `latin1_column`在比较之前自动转换为 UTF-8。

```sql
INSERT INTO t1 (latin1_column) SELECT USER();
```

        这是可行的，因为 的内容
        `USER()`会自动转换为`latin1`赋值之前的内容。

        尽管自动转换不在 SQL 标准中，但该标准确实表示每个字符集（就支持的字符而言）都是 Unicode 的“子集”。因为“适用于超集的也适用于子集”是众所周知的原则，所以我们认为 Unicode 的排序规则可以适用于与非 Unicode 字符串的比较。有关字符串强制的更多信息，请参阅
        第 10.8.4 节，“表达式中的排序规则强制”。

---

[← 返回 第 10 章 字符集、排序规则、Unicode 索引](00-index.md) · [← 返回总索引](../00-index.md)
