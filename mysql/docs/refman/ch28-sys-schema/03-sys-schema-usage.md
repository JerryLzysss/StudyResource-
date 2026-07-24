# 第 28 章 MySQL 系统模式 · 使用说明

> 对应 SQL：[`sql/refman/ch28-sys-schema/03-sys-schema-usage.sql`](../../../sql/refman/ch28-sys-schema/03-sys-schema-usage.sql)

---

## 28.2 使用系统模式

      您可以将`sys`模式设为默认模式，这样对其对象的引用就不需要使用模式名称进行限定：

```sql
mysql> USE sys;
Database changed
mysql> SELECT * FROM version;
+-------------+---------------+
| sys_version | mysql_version |
+-------------+---------------+
| 2.1.1       | 8.0.26-debug  |
+-------------+---------------+
```

      （该`version`视图显示
      `sys`模式和 MySQL 服务器版本。）

      要访问`sys`模式对象，而不同的模式是默认的（或简单地明确），请使用模式名称限定对象引用：

```sql
mysql> SELECT * FROM sys.version;
+-------------+---------------+
| sys_version | mysql_version |
+-------------+---------------+
| 2.1.1       | 8.0.26-debug  |
+-------------+---------------+
```

      该`sys`模式包含许多以各种方式总结性能模式表的视图。大多数这些视图都是成对出现的，这样一对中的一个成员与另一个成员具有相同的名称，加上一个`x$`前缀。例如，该`host_summary_by_file_io`
      视图汇总了按主机分组的文件 I/O，并显示从皮秒转换为更易读的值（带单位）的延迟；

```sql
mysql> SELECT * FROM sys.host_summary_by_file_io;
+------------+-------+------------+
| host       | ios   | io_latency |
+------------+-------+------------+
| localhost  | 67570 | 5.38 s     |
| background |  3468 | 4.18 s     |
+------------+-------+------------+
```

      该`x$host_summary_by_file_io`视图汇总了相同的数据，但显示了未格式化的皮秒延迟：

```sql
mysql> SELECT * FROM sys.x$host_summary_by_file_io;
+------------+-------+---------------+
| host       | ios   | io_latency    |
+------------+-------+---------------+
| localhost  | 67574 | 5380678125144 |
| background |  3474 | 4758696829416 |
+------------+-------+---------------+
```

      没有`x$`前缀的视图旨在提供对用户更友好且更易于人们阅读的输出。带有以原始形式显示相同值的前缀的视图`x$`更多地用于与对数据执行自己的处理的其他工具一起使用。`x$`有关非视图和视图之间差异的其他信息`x$`，请参阅
      第 28.4.3 节，“sys 模式视图”。

      要检查`sys`架构对象定义，请使用适当的
      `SHOW`语句或
      `INFORMATION_SCHEMA`查询。例如，要检查
      `session`视图和
      `format_bytes()`函数的定义，请使用以下语句：

```sql
mysql> SHOW CREATE VIEW sys.session;
mysql> SHOW CREATE FUNCTION sys.format_bytes;
```

      但是，这些语句以相对未格式化的形式显示定义。要查看具有更易读格式的对象定义，请访问在 MySQL 源代码分发中找到的各个`.sql`文件。在 MySQL 8.0.18 之前，源代码在模式开发网站
      [https://github.com/mysql/mysql-sys](https://github.com/mysql/mysql-sys)`scripts/sys_schema`的单独分发中维护
      。
    `sys`

**默认情况下， mysqldump**和
      **mysqlpump**
      都不会转储
      `sys`模式。要生成转储文件，请`sys`使用以下任一命令在命令行上显式命名架构：

```text
mysqldump --databases --routines sys > sys_dump.sql
mysqlpump sys > sys_dump.sql
```

      要从转储文件重新安装架构，请使用以下命令：

```text
mysql

---

[← 返回 第 28 章 MySQL 系统模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
