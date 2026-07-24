# 第 10 章 字符集、排序规则、Unicode · utf8mb4

> 对应 SQL：[`sql/refman/ch10-charset/07-charset-unicode-utf8mb4.sql`](../../../sql/refman/ch10-charset/07-charset-unicode-utf8mb4.sql)

---

10.9.1 utf8mb4 字符集（4 字节 UTF-8 Unicode 编码）_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 10 章字符集、排序规则、Unicode / 10.9 Unicode 支持 / 10.9.1 utf8mb4 字符集（4 字节 UTF-8 Unicode 编码） utfmb4字符集具有以下特点 ： 支持 BMP 和增补字符。
- 每个多字节字符最多需要四个字节。

        `utf8mb4`与
        `utf8mb3`仅支持 BMP 字符且每个字符最多使用三个字节的字符集形成对比：

- 对于一个BMP字符，utf8mb4具有 utf8mb3相同的存储特性：相同的码值、相同的编码、相同的长度。
- 对于增补字符，utf8mb4 需要四个字节来存储，而 utf8mb3根本不能存储字符。将utf8mb3列转换为 时 utf8mb4，您不必担心转换增补字符，因为没有增补字符。

        `utf8mb4`是 的超集
        `utf8mb3`，因此对于以下串联等操作，结果具有字符集
        `utf8mb4`和排序规则
        `utf8mb4_col`：

```sql
SELECT CONCAT(utf8mb3_col, utf8mb4_col);
```

        同样，子句中的以下比较
        `WHERE`根据 的排序规则工作`utf8mb4_col`：

```sql
SELECT * FROM utf8mb3_tbl, utf8mb4_tbl
WHERE utf8mb3_tbl.utf8mb3_col = utf8mb4_tbl.utf8mb4_col;
```

        有关与多字节字符集相关的数据类型存储的信息，请参阅
        字符串类型存储要求。

---

[← 返回 第 10 章 字符集、排序规则、Unicode 索引](00-index.md) · [← 返回总索引](../00-index.md)
