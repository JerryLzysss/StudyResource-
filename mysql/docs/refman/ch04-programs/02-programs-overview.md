# 第 4 章 MySQL 程序 · 程序概述

> 对应 SQL：[`sql/refman/ch04-programs/02-programs-overview.sql`](../../../sql/refman/ch04-programs/02-programs-overview.sql)

---

## 4.1 MySQL程序概述

      MySQL 安装中有许多不同的程序。本节简要概述它们。除了 NDB Cluster 程序之外，后面的部分提供了对每个程序的更详细描述。每个程序的描述都指出了它的调用语法和它支持的选项。
      第 23.5 节，“NDB Cluster 程序”，描述了特定于 NDB Cluster 的程序。

      大多数 MySQL 发行版包括所有这些程序，除了那些特定于平台的程序。（例如，服务器启动脚本不在 Windows 上使用。）唯一的例外是 RPM 分发更加专业化。服务器有一个 RPM，客户端程序有另一个 RPM，等等。如果您似乎缺少一个或多个程序，请参阅
      第 2 章，*安装和升级 MySQL*，以获取有关分发类型及其包含内容的信息。可能是您的发行版不包含所有程序，您需要安装额外的软件包。

      每个 MySQL 程序都有许多不同的选项。大多数程序都提供一个`--help`选项，您可以使用该选项来获取程序不同选项的描述。例如，尝试
      **mysql --help**。

      您可以通过在命令行或选项文件中指定选项来覆盖 MySQL 程序的默认选项值。有关调用程序和指定程序选项的一般信息，
    请参阅
      第 4.2 节，“使用 MySQL 程序” 。

      MySQL 服务器**mysqld**是执行 MySQL 安装中大部分工作的主程序。服务器随附几个相关脚本，可帮助您启动和停止服务器：

- mysqld SQL 守护进程（即 MySQL 服务器）。要使用客户端程序，mysqld必须正在运行，因为客户端通过连接到服务器来访问数据库。请参阅第 4.3.1 节，“mysqld — MySQL 服务器”。
- mysqld_safe 服务器启动脚本。mysqld_safe 尝试启动mysqld。参见 第 4.3.2 节，“mysqld_safe — MySQL 服务器启动脚本”。
- mysql.server 服务器启动脚本。此脚本用于使用 System V 样式运行目录的系统，其中包含为特定运行级别启动系统服务的脚本。它调用 mysqld_safe来启动 MySQL 服务器。请参阅 第 4.3.3 节，“mysql.server — MySQL 服务器启动脚本”。
- mysqld_multi 服务器启动脚本，可以启动或停止系统上安装的多个服务器。参见 第 4.3.4 节，“mysqld_multi — 管理多个 MySQL 服务器”。

      有几个程序在MySQL安装或升级过程中执行设置操作：

- comp_err 该程序在 MySQL 构建/安装过程中使用。它从错误源文件编译错误消息文件。请参阅第 4.4.1 节，“comp_err — 编译 MySQL 错误消息文件”。
- mysql_secure_installation 该程序使您能够提高 MySQL 安装的安全性。请参阅第 4.4.2 节，“mysql_secure_installation — 提高 MySQL 安装安全性”。
- mysql_ssl_rsa_setup 该程序创建支持安全连接所需的 SSL 证书和密钥文件以及 RSA 密钥对文件（如果这些文件丢失）。mysql_ssl_rsa_setup创建的文件 可用于使用 SSL 或 RSA 的安全连接。参见 第 4.4.3 节，“mysql_ssl_rsa_setup — 创建 SSL/RSA 文件”。
- mysql_tzinfo_to_sql mysql该程序使用主机系统zoneinfo 数据库（描述时区的文件集）的内容 在数据库中加载时区表 。请参阅 第 4.4.4 节，“mysql_tzinfo_to_sql — 加载时区表”。
- mysql_升级 在 MySQL 8.0.16 之前，此程序在 MySQL 升级操作后使用。它使用更新版本的 MySQL 中所做的任何更改更新授权表，并检查表是否不兼容并在必要时修复它们。请参阅第 4.4.5 节，“mysql_upgrade — 检查和升级 MySQL 表”。 从 MySQL 8.0.16 开始，MySQL 服务器执行以前由mysql_upgrade处理的升级任务 （有关详细信息，请参阅 第 2.11.3 节，“MySQL 升级过程升级的内容”）。

      连接到 MySQL 服务器的 MySQL 客户端程序：

- 数据库 用于交互式输入 SQL 语句或以批处理模式从文件执行它们的命令行工具。请参阅 第 4.5.1 节，“mysql — MySQL 命令行客户端”。
- mysql管理员 执行管理操作的客户端，例如创建或删除数据库、重新加载授权表、将表刷新到磁盘以及重新打开日志文件。 mysqladmin还可用于从服务器检索版本、进程和状态信息。请参阅 第 4.5.2 节，“mysqladmin — 一个 MySQL 服务器管理程序”。
- mysql检查 检查、修复、分析和优化表的表维护客户端。请参阅第 4.5.3 节，“mysqlcheck — 表维护程序”。
- mysql转储 将 MySQL 数据库作为 SQL、文本或 XML 转储到文件中的客户端。请参阅第 4.5.4 节，“mysqldump — 数据库备份程序”。
- mysql导入 使用LOAD DATA. 请参阅 第 4.5.5 节，“mysqlimport — 数据导入程序”。
- mysql泵 将 MySQL 数据库作为 SQL 转储到文件中的客户端。请参阅 第 4.5.6 节，“mysqlpump — 数据库备份程序”。
- mysqlsh MySQL Shell 是 MySQL Server 的高级客户端和代码编辑器。请参阅MySQL Shell 8.0。除了提供的 SQL 功能外，类似于 mysql，MySQL Shell 还为 JavaScript 和 Python 提供脚本功能，并包括用于与 MySQL 一起工作的 API。X DevAPI 使您能够处理关系数据和文档数据，请参阅 第 20 章，使用 MySQL 作为文档存储。AdminAPI 使您能够使用 InnoDB Cluster，请参阅 MySQL AdminAPI。
- mysqlshow 显示有关数据库、表、列和索引的信息的客户端。请参阅第 4.5.7 节，“mysqlshow — 显示数据库、表和列信息”。
- mysqlslap 旨在模拟 MySQL 服务器的客户端负载并报告每个阶段的时间的客户端。它的工作方式就好像多个客户端正在访问服务器一样。请参阅 第 4.5.8 节，“mysqlslap — 负载仿真客户端”。

      MySQL 管理和实用程序：

- 创新校验和 离线InnoDB离线文件校验和实用程序。请参阅第 4.6.2 节，“innochecksum - 离线 InnoDB 文件校验和实用程序”。
- myisam_ftdump 显示有关表中全文索引的信息的实用程序 MyISAM。请参阅 第 4.6.3 节，“myisam_ftdump — 显示全文索引信息”。
- myisamchk 用于描述、检查、优化和修复 MyISAM表的实用程序。请参阅 第 4.6.4 节，“myisamchk — MyISAM 表维护实用程序”。
- myisamlog MyISAM处理日志文件 内容的实用程序 。请参阅 第 4.6.5 节，“myisamlog — 显示 MyISAM 日志文件内容”。
- myisampack 压缩MyISAM表以生成更小的只读表的实用程序。请参阅 第 4.6.6 节，“myisampack — 生成压缩的只读 MyISAM 表”。
- mysql_config_editor 一种实用程序，使您能够将身份验证凭据存储在名为 .mylogin.cnf. 请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
- mysql_migrate_keyring 一种用于在一个密钥环组件和另一个密钥环组件之间迁移密钥的实用程序。请参阅第 4.6.8 节，“mysql_migrate_keyring — 密钥环密钥迁移实用程序”。
- mysql二进制日志 用于从二进制日志中读取语句的实用程序。二进制日志文件中包含的已执行语句的日志可用于帮助从崩溃中恢复。请参阅 第 4.6.9 节，“mysqlbinlog — 处理二进制日志文件的实用程序”。
- mysql转储慢 用于读取和汇总慢速查询日志内容的实用程序。请参阅第 4.6.10 节，“mysqldumpslow — 总结慢速查询日志文件”。

      MySQL 程序开发实用程序：

- mysql_config 生成编译 MySQL 程序时所需的选项值的 shell 脚本。请参阅第 4.7.1 节，“mysql_config — 编译客户端的显示选项”。
- 我的打印默认值 显示选项文件的选项组中存在哪些选项的实用程序。请参阅 第 4.7.2 节，“my_print_defaults — 显示选项文件中的选项”。

      杂项实用程序：

- lz4_解压缩 解压缩使用 LZ4 压缩创建的mysqlpump输出 的实用程序。请参阅 第 4.8.1 节，“lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出”。
- 错误 显示系统或 MySQL 错误代码含义的实用程序。请参阅第 4.8.2 节，“perror — 显示 MySQL 错误消息信息”。
- zlib_解压缩 解压缩使用 ZLIB 压缩创建的mysqlpump输出 的实用程序。请参阅 第 4.8.3 节，“zlib_decompress — 解压缩 mysqlpump ZLIB 压缩输出”。

      Oracle Corporation 还提供
      MySQL Workbench GUI 工具，用于管理 MySQL 服务器和数据库，创建、执行和评估查询，以及从其他关系数据库管理系统迁移模式和数据以用于 MySQL。

      使用 MySQL 客户端/服务器库与服务器通信的 MySQL 客户端程序使用以下环境变量。

| 环境变量 | 意义 |
| --- | --- |
| MYSQL_UNIX_PORT | 默认的 Unix 套接字文件；用于连接到 localhost |
| MYSQL_TCP_PORT | 默认端口号；用于 TCP/IP 连接 |
| MYSQL_DEBUG | 调试时调试跟踪选项 |
| TMPDIR | 创建临时表和文件的目录 |

      有关 MySQL 程序使用的环境变量的完整列表，请参阅第 4.9 节，“环境变量”。

---

[← 返回 第 4 章 MySQL 程序 索引](00-index.md) · [← 返回总索引](../00-index.md)
