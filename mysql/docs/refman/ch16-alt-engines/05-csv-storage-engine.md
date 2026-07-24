# 第 16 章 替代存储引擎 · CSV

> 对应 SQL：[`sql/refman/ch16-alt-engines/05-csv-storage-engine.sql`](../../../sql/refman/ch16-alt-engines/05-csv-storage-engine.sql)

---

## 16.4 CSV存储引擎

`CSV`存储引擎使用逗号分隔值格式将数据存储在文本文件中

    。

`CSV`存储引擎总是被编译到 MySQL 服务器中

    。

    要检查`CSV`引擎的源代码，请查看`storage/csv`MySQL 源代码分发目录。

    创建`CSV`表时，服务器会创建一个纯文本数据文件，其名称以表名开头并带有`.CSV`扩展名。当您将数据存储到表中时，存储引擎会将其以逗号分隔值格式保存到数据文件中。

```sql
mysql> CREATE TABLE test (i INT NOT NULL, c CHAR(10) NOT NULL)
       ENGINE = CSV;
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO test VALUES(1,'record one'),(2,'record two');
Query OK, 2 rows affected (0.05 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM test;
+---+------------+
| i | c          |
+---+------------+
| 1 | record one |
| 2 | record two |
+---+------------+
2 rows in set (0.00 sec)
```

    创建`CSV`表还会创建一个相应的图元文件，用于存储表的状态和表中存在的行数。该文件的名称与表的名称相同，扩展名为`CSM`.

    如果检查`test.CSV`执行上述语句创建的数据库目录中的文件，其内容应如下所示：

```text
"1","record one"
"2","record two"
```

    这种格式可以被 Microsoft Excel 等电子表格应用程序读取，甚至写入。

---

[← 返回 第 16 章 替代存储引擎 索引](00-index.md) · [← 返回总索引](../00-index.md)
