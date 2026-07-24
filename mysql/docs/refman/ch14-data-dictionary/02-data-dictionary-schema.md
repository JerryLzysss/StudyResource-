# 第 14 章 MySQL 数据字典 · 数据字典架构

> 对应 SQL：[`sql/refman/ch14-data-dictionary/02-data-dictionary-schema.sql`](../../../sql/refman/ch14-data-dictionary/02-data-dictionary-schema.sql)

---

## 14.1 数据字典模式

      数据字典表受到保护，只能在 MySQL 的调试版本中访问。`INFORMATION_SCHEMA`但是，MySQL支持通过表和
      `SHOW`语句来访问存储在数据字典表中的数据
      。有关构成数据字典的表的概述，请参阅
      数据字典表。

      MySQL 系统表在 MySQL 8.0 中仍然存在，可以通过在系统数据库上发出`SHOW TABLES`
      语句来查看。`mysql`一般来说，MySQL数据字典表和系统表的区别在于，数据字典表包含执行SQL查询所需的元数据，而系统表包含时区、帮助信息等辅助数据。MySQL系统表和数据字典表在升级方式上也有所不同。MySQL 服务器管理数据字典升级。SQL服务器。请参阅如何升级数据字典。升级 MySQL 系统表需要运行完整的 MySQL 升级过程。请参阅
      第 2.11.3 节，“MySQL 升级过程升级了什么”.

### 数据字典是如何升级的

        新版本的 MySQL 可能包含对数据字典表定义的更改。此类更改存在于新安装的 MySQL 版本中，但在执行 MySQL 二进制文件的就地升级时，当使用新二进制文件重新启动 MySQL 服务器时，更改将应用​​。在启动时，将服务器的数据字典版本与存储在数据字典中的版本信息进行比较，以确定是否应升级数据字典表。如果需要并支持升级，服务器会创建具有更新定义的数据字典表，将持久化的元数据复制到新表中，以原子方式用新表替换旧表，并重新初始化数据字典。如果不需要升级，

        数据字典表的升级是一个原子操作，即根据需要升级所有数据字典表，否则操作失败。如果升级操作失败，则服务器启动失败并出现错误。在这种情况下，旧的服务器二进制文件可以与旧的数据目录一起使用来启动服务器。当新的服务器二进制文件再次用于启动服务器时，将重新尝试数据字典升级。

        通常，数据字典表升级成功后，无法使用旧的服务器二进制文件重新启动服务器。因此，在升级数据字典表后，不支持将 MySQL 服务器二进制文件降级到以前的 MySQL 版本。

**mysqld**
        选项
        可`--no-dd-upgrade`用于防止在启动时自动升级数据字典表。指定时`--no-dd-upgrade`，服务器发现服务器的数据字典版本与数据字典中保存的版本不一致，启动失败，报错禁止数据字典升级。

### 使用 MySQL 的调试版本查看数据字典表

        数据字典表在默认情况下受到保护，但可以通过使用调试支持（使用
        `-DWITH_DEBUG=1`
        **CMake**选项）编译 MySQL 并指定
        `+d,skip_dd_table_access_check`
        `debug`选项和修饰符来访问。有关编译调试版本的信息，请参阅
        第 5.9.1.1 节，“为调试编译 MySQL”。

警告

          不建议直接修改或写入数据字典表，这可能会使您的 MySQL 实例无法运行。

        使用调试支持编译 MySQL 后，使用此
        `SET`语句使数据字典表对**mysql**客户端会话可见：

```sql
mysql> SET SESSION debug='+d,skip_dd_table_access_check';
```

        使用此查询检索数据字典表的列表：

```sql
mysql> SELECT name, schema_id, hidden, type FROM mysql.tables where schema_id=1 AND hidden='System';
```

        用于`SHOW CREATE TABLE`查看数据字典表定义。例如：

```sql
mysql> SHOW CREATE TABLE mysql.catalogs\G
```

---

[← 返回 第 14 章 MySQL 数据字典 索引](00-index.md) · [← 返回总索引](../00-index.md)
