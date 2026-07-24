# 第 1 章 一般信息 · 1.7 MySQL 标准合规性

> 对应 SQL：[`sql/refman/ch01-introduction/08-compatibility.sql`](../../../sql/refman/ch01-introduction/08-compatibility.sql)

---

## 1.7 MySQL 标准合规性

      本节描述 MySQL 如何与 ANSI/ISO SQL 标准相关。MySQL Server 对 SQL 标准有许多扩展，在这里您可以了解它们是什么以及如何使用它们。您还可以找到有关 MySQL 服务器缺少的功能以及如何解决某些差异的信息。

      SQL 标准自 1986 年以来一直在发展，并且存在多个版本。在本手册中，“ SQL-92 ”是指1992年发布的标准。“ SQL:1999 ”、
       “ SQL:2003 ”、“ SQL:2008 ”、
       “ SQL:2011 ”是指1992年发布的标准版本。相应的年份，最后一个是最新版本。我们使用短语“ SQL 标准”
      或“标准 SQL ”表示任何时候 SQL 标准的当前版本。

      我们对该产品的主要目标之一是继续努力符合 SQL 标准，但不牺牲速度或可靠性。如果这大大提高了我们大部分用户群的 MySQL 服务器的可用性，我们不怕添加 SQL 扩展或支持非 SQL 功能。`HANDLER`界面就是这种策略的一个例子。请参阅第 13.2.4 节，“HANDLER 语句”。

      我们继续支持事务性和非事务性数据库，以满足关键任务 24/7 使用和繁重的 Web 或日志记录使用。

      MySQL Server 最初设计用于小型计算机系统上的中型数据库（10-1 亿行，或每个表约 100MB）。今天 MySQL 服务器处理 TB 大小的数据库。

      我们的目标不是实时支持，尽管 MySQL 复制功能提供了重要的功能。

      MySQL 支持 ODBC 级别 0 到 3.51。

`NDBCLUSTER`MySQL 支持使用存储引擎
      的高可用性数据库集群
      。请参阅
      第 23 章，*MySQL NDB Cluster 8.0*。

      我们实现了支持大多数 W3C XPath 标准的 XML 功能。请参阅第 12.12 节，“XML 函数”。

      MySQL 支持由 RFC 7159 定义并基于 ECMAScript 标准 (ECMA-262) 的本机 JSON 数据类型。请参阅
      第 11.5 节，“JSON 数据类型”。MySQL 还实现了 SQL:2016 标准的预发布草案指定的 SQL/JSON 函数子集；有关更多信息，
请参阅第 12.18 节，“JSON 函数” 。

### 选择 SQL 模式

`sql_mode`MySQL 服务器可以在不同的 SQL 模式下运行，并且可以根据系统变量
      的值对不同的客户端应用这些模式。DBA 可以设置全局 SQL 模式以匹配站点服务器操作要求，每个应用程序可以根据自己的要求设置其会话 SQL 模式。

      模式会影响 MySQL 支持的 SQL 语法及其执行的数据验证检查。这使得在不同环境中使用 MySQL 以及与其他数据库服务器一起使用 MySQL 变得更加容易。

      有关设置 SQL 模式的更多信息，请参阅
      第 5.1.11 节，“服务器 SQL 模式”。

### 以 ANSI 模式运行 MySQL

      要以 ANSI 模式运行 MySQL 服务器，
      请使用该选项启动**mysqld 。**`--ansi`在 ANSI 模式下运行服务器与使用以下选项启动它相同：

```text
--transaction-isolation=SERIALIZABLE --sql-mode=ANSI
```

      要在运行时达到同样的效果，执行这两条语句：

```sql
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET GLOBAL sql_mode = 'ANSI';
```

      您可以看到设置
      `sql_mode`系统变量以
      `'ANSI'`启用与 ANSI 模式相关的所有 SQL 模式选项，如下所示：

```sql
mysql> SET GLOBAL sql_mode='ANSI';
mysql> SELECT @@GLOBAL.sql_mode;
        -> 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ANSI'
```

      在 ANSI 模式下运行服务器与
      `--ansi`将 SQL 模式设置为 不太一样，`'ANSI'`因为该
      `--ansi`选项还设置了事务隔离级别。

      请参阅第 5.1.7 节，“服务器命令选项”。

---

[← 返回 第 1 章 一般信息 索引](00-index.md) · [← 返回总索引](../00-index.md)
