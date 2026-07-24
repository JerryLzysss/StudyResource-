# 第 4 章 MySQL 程序 · mysql 客户端

> 对应 SQL：[`sql/refman/ch04-programs/06-mysql.sql`](../../../sql/refman/ch04-programs/06-mysql.sql)

---

4.5.1 mysql——MySQL 命令行客户端_MySQL 8.0 参考手册

**Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 4 章 MySQL 程序 / 4.5 客户端程序 / 4.5.1 mysql——MySQL 命令行客户端 mysql**是一个简单的 SQL shell，具有输入行编辑功能。它支持交互式和非交互式使用。当以交互方式使用时，查询结果以 ASCII 表格式显示。当以非交互方式使用时（例如，作为过滤器），结果以制表符分隔的格式显示。可以使用命令选项更改输出格式。

        如果您因大型结果集的内存不足而遇到问题，请使用该`--quick`选项。这会强制**mysql**一次从服务器检索一行结果，而不是检索整个结果集并在显示之前将其缓冲在内存中。这是通过使用
        `mysql_use_result()`客户端/服务器库中的 C API 函数而不是
        `mysql_store_result()`.

笔记

          或者，MySQL Shell 提供对 X DevAPI 的访问。详情请参见MySQL Shell 8.0。

        使用**mysql**非常简单。从命令解释器的提示中调用它，如下所示：

```text
mysql db_name
```

        或者：

```text
mysql --user=user_name --password db_name
```

        在这种情况下，您需要输入密码以响应**mysql**显示的提示：

```text
Enter password: your_password
```

        然后键入一条 SQL 语句，以 、 或 结束`;`，
        `\g`然后`\G`按 Enter 键。

        如果有当前语句，则键入**Control+C**会中断当前语句，否则会取消任何部分输入行。

        您可以像这样在脚本文件（批处理文件）中执行 SQL 语句：

```text
mysql db_name  output.tab
```

        在 Unix 上，**mysql**客户端将交互执行的语句记录到历史文件中。请参阅
        第 4.5.1.3 节，“mysql 客户端日志记录”。

---

[← 返回 第 4 章 MySQL 程序 索引](00-index.md) · [← 返回总索引](../00-index.md)
