# 第 16 章 替代存储引擎 · 设置存储引擎

> 对应 SQL：[`sql/refman/ch16-alt-engines/02-storage-engine-setting.sql`](../../../sql/refman/ch16-alt-engines/02-storage-engine-setting.sql)

---

## 16.1 设置存储引擎

      创建新表时，可以通过在语句
    中添加`ENGINE`表选项来
      指定使用哪个存储引擎：`CREATE TABLE`

```sql
-- ENGINE=INNODB not needed unless you have set a different
-- default storage engine.
CREATE TABLE t1 (i INT) ENGINE = INNODB;
-- Simple table definitions can be switched from one to another.
CREATE TABLE t2 (i INT) ENGINE = CSV;
CREATE TABLE t3 (i INT) ENGINE = MEMORY;
```

      当您省略该`ENGINE`选项时，将使用默认存储引擎。默认引擎
      `InnoDB`在 MySQL 8.0 中。您可以使用
      `--default-storage-engine`服务器启动选项或通过
      在配置文件
    中设置该`default-storage-engine`选项来指定默认引擎。`my.cnf`

      您可以通过设置
      `default_storage_engine`变量为当前会话设置默认存储引擎：

```sql
SET default_storage_engine=NDBCLUSTER;
```

通过在启动时或运行时设置 ，
    可以将`TEMPORARY`创建
      的表的存储引擎与`CREATE TEMPORARY TABLE`永久表的引擎分开设置
      。`default_tmp_storage_engine`

      要将表从一个存储引擎转换为另一个存储引擎，请使用
      `ALTER TABLE`指示新引擎的语句：

```sql
ALTER TABLE t ENGINE = InnoDB;
```

      请参阅第 13.1.20 节，“CREATE TABLE 语句”和
      第 13.1.9 节，“ALTER TABLE 语句”。

      如果您尝试使用未编译或已编译但停用的存储引擎，则 MySQL 会使用默认存储引擎创建一个表。例如，在复制设置中，也许您的源服务器使用`InnoDB`
      表来获得最大的安全性，但副本服务器使用其他存储引擎来提高速度，但会牺牲持久性或并发性。

      默认情况下，每当
      `CREATE TABLE`或
      `ALTER TABLE`不能使用默认存储引擎时都会生成警告。为防止在所需引擎不可用时发生混乱的意外行为，请启用
      `NO_ENGINE_SUBSTITUTION`SQL 模式。如果所需的引擎不可用，此设置会产生错误而不是警告，并且不会创建或更改表。请参阅第 5.1.11 节，“服务器 SQL 模式”。

      MySQL 可以将表的索引和数据存储在一个或多个其他文件中，具体取决于存储引擎。表和列定义存储在 MySQL 数据字典中。各个存储引擎创建它们管理的表所需的任何附加文件。如果表名包含特殊字符，则表文件的名称包含这些字符的编码版本，如
      第 9.2.4 节，“标识符到文件名的映射”中所述。

---

[← 返回 第 16 章 替代存储引擎 索引](00-index.md) · [← 返回总索引](../00-index.md)
