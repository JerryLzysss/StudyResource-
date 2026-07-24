# 第 5 章 MySQL 服务器管理 · 服务器配置

> 对应 SQL：[`sql/refman/ch05-server-administration/02-server-configuration.sql`](../../../sql/refman/ch05-server-administration/02-server-configuration.sql)

---

5.1.1 配置服务器_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 5 章 MySQL 服务器管理 / 5.1 MySQL 服务器 / 5.1.1 配置服务器 MySQL 服务器mysqld有许多命令选项和系统变量，可以在启动时设置它们以配置其操作。要确定服务器使用的默认命令选项和系统变量值，请执行以下命令： ```text $> mysqld --verbose --help ``` 该命令生成所有mysqld 选项和可配置系统变量的列表。它的输出包括默认选项和变量值，看起来像这样： ```text abort-slave-event-count 0 allow-suspicious-udfs FALSE archive ON auto-increment-increment 1 auto-increment-offset 1 autocommit TRUE automatic-sp-privileges TRUE avoid-temporal-upgrade FALSE back-log 80 basedir /home/jon/bin/mysql-8.0/ ... tmpdir /tmp transaction-alloc-block-size 8192 transaction-isolation REPEATABLE-READ transaction-prealloc-size 4096 transaction-read-only FALSE transaction-write-set-extraction XXHASH64 updatable-views-with-limit YES validate-user-plugins TRUE verbose TRUE wait-timeout 28800 ``` 要查看服务器在运行时实际使用的当前系统变量值，请连接到它并执行以下语句： ```sql mysql> SHOW VARIABLES; ``` 要查看正在运行的服务器的一些统计和状态指示器，请执行以下语句： ```sql mysql> SHOW STATUS; ``` 系统变量和状态信息也可以使用 mysqladmin命令获得： ```text $> mysqladmin variables $> mysqladmin extended-status ``` 有关所有命令选项、系统变量和状态变量的完整描述，请参阅以下部分： 第 5.1.7 节，“服务器命令选项”
- 第 5.1.8 节，“服务器系统变量”
- 第 5.1.10 节，“服务器状态变量”

      Performance Schema 提供了更详细的监控信息；参见第 27 章，*MySQL 性能模式*。此外，MySQL `sys`schema 是一组对象，可以方便地访问 Performance Schema 收集的数据；参见第 28 章，*MySQL 系统模式*。

      如果您在命令行上为
      **mysqld**或**mysqld_safe**指定一个选项，它仅对服务器的调用有效。要在每次服务器运行时使用该选项，请将其放入选项文件中。请参见第 4.2.2.2 节，“使用选项文件”。

---

[← 返回 第 5 章 MySQL 服务器管理 索引](00-index.md) · [← 返回总索引](../00-index.md)
