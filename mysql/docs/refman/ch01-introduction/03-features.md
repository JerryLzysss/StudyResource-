# 第 1 章 一般信息 · 1.2.2 MySQL的主要特点

> 对应 SQL：[`sql/refman/ch01-introduction/03-features.sql`](../../../sql/refman/ch01-introduction/03-features.sql)

---

1.2.2 MySQL的主要特点_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第一章 一般信息 / 1.2 MySQL数据库管理系统概述 / 1.2.2 MySQL的主要特点 本节介绍 MySQL 数据库软件的一些重要特性。在大多数方面，该路线图适用于所有版本的 MySQL。有关在特定系列基础上引入 MySQL 的功能的信息，请参阅相应手册的 “简而言之”部分： MySQL 8.0：第 1.3 节，“MySQL 8.0 中的新功能”
- MySQL 5.7：MySQL 5.7 中的新功能
- MySQL 5.6：MySQL 5.6 中的新功能

#### 内部结构和便携性

- 用 C 和 C++ 编写。
- 使用各种不同的编译器进行测试。
- 适用于许多不同的平台。请参阅 https://www.mysql.com/support/supportedplatforms/database.html。
- 为了便携性，使用CMake配置。
- 使用 Purify（一种商业内存泄漏检测器）以及使用 GPL 工具 Valgrind 进行测试（http://developer.kde.org/~sewardj/）。
- 采用独立模块的多层服务器设计。
- 设计为使用内核线程实现完全多线程，以便在可用时轻松使用多个 CPU。
- 提供事务性和非事务性存储引擎。
- 使用非常快的 B 树磁盘表 ( MyISAM) 和索引压缩。
- 旨在使添加其他存储引擎变得相对容易。如果您想为内部数据库提供 SQL 接口，这将很有用。
- 使用非常快速的基于线程的内存分配系统。
- 使用优化的嵌套循环连接执行非常快速的连接。
- 实现内存中的哈希表，用作临时表。
- 使用应该尽可能快的高度优化的类库实现 SQL 函数。通常在查询初始化之后根本就没有内存分配。
- 将服务器作为单独的程序提供，以便在客户端/服务器网络环境中使用。

#### 数据类型

- 许多数据类型：有符号/无符号整数 1、2、3、4 和 8 字节长，FLOAT, DOUBLE, CHAR, VARCHAR, BINARY, VARBINARY, TEXT, BLOB, DATE, TIME, DATETIME, TIMESTAMP, YEAR, SET, ENUM, 和 OpenGIS 空间类型。请参阅第 11 章，数据类型。
- 定长和变长字符串类型。

#### 语句和函数

- SELECT查询列表和 WHERE子句中 的完整运算符和函数支持 。例如： ```sql mysql> SELECT CONCAT(first_name, ' ', last_name) -> FROM citizen -> WHERE income/dependents > 10000 AND age > 30; ```
- 完全支持 SQLGROUP BY和 ORDER BY子句。支持群组功能（COUNT()、 AVG()、 STD()、 SUM()、 MAX()、 MIN()和 GROUP_CONCAT()）。
- 支持LEFT OUTER JOIN并 RIGHT OUTER JOIN使用标准 SQL 和 ODBC 语法。
- 支持标准 SQL 要求的表和列的别名。
- 支持DELETE、 INSERT、 REPLACE和 UPDATE返回已更改（受影响）的行数，或者通过在连接到服务器时设置标志来返回匹配的行数。
- 支持SHOW 检索有关数据库、存储引擎、表和索引的信息的 MySQL 特定语句。支持 INFORMATION_SCHEMA数据库，按照标准SQL实现。
- 显示优化器如何解析查询的EXPLAIN语句。
- 函数名称与表或列名称的独立性。例如，ABS是一个有效的列名。唯一的限制是对于函数调用，函数名和后面的“ (”之间不允许有空格 。请参阅 第 9.3 节，“关键字和保留字”。
- 您可以在同一语句中引用来自不同数据库的表。

#### 安全

- 一个非常灵活和安全的权限和密码系统，并且支持基于主机的验证。
- 当您连接到服务器时，通过加密所有密码流量来确保密码安全。

#### 可扩展性和限制

- 支持大型数据库。我们将 MySQL Server 与包含 5000 万条记录的数据库一起使用。我们还知道使用 MySQL Server 的用户有 200,000 个表和大约 5,000,000,000 行。
- 每个表最多支持 64 个索引。每个索引可能由 1 到 16 列或部分列组成。表的最大索引宽度为InnoDB767 字节或 3072 字节。请参阅第 15.22 节，“InnoDB 限制”。表的最大索引宽度为 MyISAM1000 字节。参见 第 16.2 节，“MyISAM 存储引擎”。索引可以使用CHAR、 VARCHAR、 BLOB或 TEXT列类型的列前缀。

#### 连通性

- 客户端可以使用多种协议连接到 MySQL 服务器： 客户端可以在任何平台上使用 TCP/IP 套接字进行连接。
- named_pipe在 Windows 系统上，如果服务器在启用系统变量 的情况下启动，则客户端可以使用命名管道进行连接 。shared_memory如果在启用系统变量的情况下启动，Windows 服务器也支持共享内存连接 。--protocol=memory客户端可以使用该选项 通过共享内存进行连接 。
- 在 Unix 系统上，客户端可以使用 Unix 域套接字文件进行连接。

- MySQL 客户端程序可以用多种语言编写。用 C 编写的客户端库适用于用 C 或 C++ 编写的客户端，或任何提供 C 绑定的语言。
- C、C++、Eiffel、Java、Perl、PHP、Python、Ruby 和 Tcl 的 API 可用，使 MySQL 客户端可以用多种语言编写。请参阅第 29 章，连接器和 API。
- 连接器/ODBC (MyODBC) 接口为使用 ODBC（开放式数据库连接）连接的客户端程序提供 MySQL 支持。例如，您可以使用 MS Access 连接到您的 MySQL 服务器。客户端可以在 Windows 或 Unix 上运行。连接器/ODBC 源可用。所有 ODBC 2.5 函数都受支持，许多其他函数也是如此。请参阅 MySQL 连接器/ODBC 开发人员指南。
- Connector/J 接口为使用 JDBC 连接的 Java 客户端程序提供 MySQL 支持。客户端可以在 Windows 或 Unix 上运行。连接器/J 源可用。请参阅 MySQL Connector/J 8.0 开发人员指南。
- MySQL Connector/NET 使开发人员能够轻松创建需要与 MySQL 进行安全、高性能数据连接的 .NET 应用程序。它实现所需的 ADO.NET 接口并集成到 ADO.NET 感知工具中。开发人员可以使用他们选择的 .NET 语言构建应用程序。MySQL Connector/NET 是一个完全托管的 ADO.NET 驱动程序，用 100% 纯 C# 编写。请参阅 MySQL 连接器/NET 开发人员指南。

#### 本土化

- 服务器可以用多种语言向客户端提供错误消息。请参阅第 10.12 节，“设置错误消息语言”。
- 完全支持多种不同的字符集，包括 ( latin1cp1252)、、、、german多种 Unicode 字符集等。例如，表名和列名中允许 使用斯堪的纳维亚字符“ ”、 “ ”和 “ ” 。big5ujisåäö
- 所有数据都保存在所选字符集中。
- 根据默认的字符集和排序规则进行排序和比较。可以在 MySQL 服务器启动时更改它（请参阅 第 10.3.2 节，“服务器字符集和排序规则”）。要查看非常高级的排序示例，请查看捷克语排序代码。MySQL Server 支持许多不同的字符集，可以在编译时和运行时指定。
- 服务器时区可以动态更改，各个客户端可以指定自己的时区。请参阅 第 5.1.15 节，“MySQL 服务器时区支持”。

#### 客户端和工具

- MySQL 包括几个客户端和实用程序。这些包括命令行程序（如 mysqldump和 mysqladmin）和图形程序（如 MySQL Workbench）。
- MySQL Server 内置支持 SQL 语句来检查、优化和修复表。这些语句可通过 mysqlcheck客户端从命令行获得。MySQL 还包括 myisamchk，这是一个非常快速的命令行实用程序，用于对MyISAM 表执行这些操作。请参阅第 4 章，MySQL 程序。
- 可以使用--help 或-?选项调用 MySQL 程序以获得在线帮助。

---

[← 返回 第 1 章 一般信息 索引](00-index.md) · [← 返回总索引](../00-index.md)
