# 第 7 章 备份与恢复 · 使用 mysqldump

> 对应 SQL：[`sql/refman/ch07-backup/04-using-mysqldump.sql`](../../../sql/refman/ch07-backup/04-using-mysqldump.sql)

---

## 7.4 使用 mysqldump 进行备份

小费

        考虑使用MySQL Shell 转储实用程序，它提供多线程并行转储、文件压缩和进度信息显示，以及 Oracle Cloud Infrastructure 对象存储流和 MySQL 数据库服务兼容性检查和修改等云功能。使用MySQL Shell 负载转储实用程序可以轻松地将转储导入 MySQL 服务器实例或 MySQL 数据库服务数据库系统。可以在此处找到 MySQL Shell 的安装说明。

      本节介绍如何使用**mysqldump**生成转储文件，以及如何重新加载转储文件。可以通过多种方式使用转储文件：

- 作为备份以在数据丢失时启用数据恢复。
- 作为设置副本的数据源。
- 作为实验数据来源： 在不更改原始数据的情况下制作可以使用的数据库副本。
- 测试潜在的升级不兼容性。

      **mysqldump**产生两种类型的输出，这取决于是否`--tab`
      给出选项：

- 如果没有--tab， mysqldump将 SQL 语句写入标准输出。此输出包含 CREATE创建转储对象（数据库、表、存储例程等）的 INSERT语句，以及将数据加载到表中的语句。输出可以保存在文件中，稍后使用 mysql重新加载以重新创建转储的对象。选项可用于修改 SQL 语句的格式，并控制转储哪些对象。
- 使用--tab， mysqldump为每个转储表生成两个输出文件。服务器将一个文件作为制表符分隔的文本写入，每个表行一行。tbl_name.txt 该文件在输出目录中命名 。服务器还将 CREATE TABLE表的语句发送到mysqldumptbl_name.sql ，后者将其写入 输出目录中 命名的文件 。

---

[← 返回 第 7 章 备份与恢复 索引](00-index.md) · [← 返回总索引](../00-index.md)
