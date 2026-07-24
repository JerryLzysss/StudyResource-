# 第 4 章 MySQL 程序 · mysqldump

> 对应 SQL：[`sql/refman/ch04-programs/07-mysqldump.sql`](../../../sql/refman/ch04-programs/07-mysqldump.sql)

---

4.5.4 mysqldump——数据库备份程序_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 4 章 MySQL 程序 / 4.5 客户端程序 / 4.5.4 mysqldump——数据库备份程序 mysqldump客户端实用程序执行 逻辑备份，生成一组 SQL 语句，可以执行这些语句以重现原始数据库对象定义和表数据 。它转储一个或多个 MySQL 数据库以进行备份或传输到另一台 SQL 服务器。mysqldump 命令还可以生成 CSV、其他分隔文本或 XML 格式的输出 。 小费 考虑使用MySQL Shell 转储实用程序，它提供多线程并行转储、文件压缩和进度信息显示，以及 Oracle Cloud Infrastructure 对象存储流和 MySQL 数据库服务兼容性检查和修改等云功能。使用MySQL Shell 负载转储实用程序可以轻松地将转储导入 MySQL 服务器实例或 MySQL 数据库服务数据库系统。可以在此处找到 MySQL Shell 的安装说明。 性能和可扩展性注意事项
- 调用语法
- 选项语法 - 按字母顺序排列的摘要
- 连接选项
- 选项文件选项
- DDL 选项
- 调试选项
- 帮助选项
- 国际化选项
- 复制选项
- 格式选项
- 过滤选项
- 性能选项
- 交易选项
- 选项组
- 例子
- 限制

        **mysqldump**至少需要
        `SELECT`转储表、`SHOW VIEW`转储视图、`TRIGGER`转储触发器的权限，`LOCK TABLES`如果
        `--single-transaction`不使用该选项，以及（从 MySQL 8.0.21 开始）
        `PROCESS`如果
        `--no-tablespaces`不使用该选项。某些选项可能需要其他权限，如选项说明中所述。

        要重新加载转储文件，您必须具有执行它包含的语句所需的权限，例如对
        `CREATE`这些语句创建的对象的适当权限。

        **mysqldump**输出可以包含
        `ALTER DATABASE`更改数据库排序规则的语句。这些可以在转储存储的程序以保留其字符编码时使用。要重新加载包含此类语句的转储文件，
        `ALTER`需要受影响数据库的权限。

笔记

          在 Windows 上使用 PowerShell 进行输出重定向的转储创建了一个具有 UTF-16 编码的文件：

```text
mysqldump [options] > dump.sql
```

          但是，不允许将 UTF-16 作为连接字符集（请参阅
          不允许的客户端字符集），因此无法正确加载转储文件。要解决此问题，请使用`--result-file`以 ASCII 格式创建输出的选项：

```text
mysqldump [options] --result-file=dump.sql
```

`gtid_mode=ON`如果您的转储文件包含系统表，

        则不建议在服务器 ( ) 上启用 GTID 时加载转储文件。**mysqldump**为使用非事务性 MyISAM 存储引擎的系统表发出 DML 指令，并且在启用 GTID 时不允许这种组合。

#### 性能和可扩展性注意事项

        `mysqldump`优点包括在恢复之前查看甚至编辑输出的便利性和灵活性。您可以为开发和 DBA 工作克隆数据库，或者对现有数据库进行轻微改动以进行测试。它不是用于备份大量数据的快速或可扩展的解决方案。对于大数据量，即使备份步骤花费合理的时间，恢复数据也可能非常慢，因为重放 SQL 语句涉及用于插入、索引创建等的磁盘 I/O。

        对于大规模的备份和恢复，
        物理备份更为合适，将数据文件以原始格式复制，以便快速恢复。

        如果您的表主要是`InnoDB`
        表，或者混合使用`InnoDB`和
        `MyISAM`表，请考虑使用
        **mysqlbackup**，它作为 MySQL Enterprise 的一部分提供。该工具以最小的中断提供高性能的
        `InnoDB`备份；它还可以备份来自`MyISAM`其他存储引擎的表；它还提供了许多方便的选项以适应不同的备份方案。请参阅
        第 30.2 节，“MySQL 企业备份概述”。

        **mysqldump**可以逐行检索和转储表内容，或者它可以从表中检索整个内容并在转储之前将其缓冲在内存中。如果要转储大表，内存中的缓冲可能会成为一个问题。要逐行转储表，请使用
        `--quick`选项（或
        `--opt`，启用
        `--quick`）。该
        `--opt`选项（因此
        `--quick`）默认启用，因此要启用内存缓冲，请使用
        `--skip-quick`.

        如果您正在使用最新版本的
        **mysqldump**生成要重新加载到非常旧的 MySQL 服务器的转储，请使用该
        `--skip-opt`选项而不是`--opt`or
        `--extended-insert`选项。

        有关**mysqldump**的其他信息，请参阅第 7.4 节，“使用 mysqldump 进行备份”。

#### 调用语法

        通常有三种使用
        **mysqldump**的方法——为了转储一组一个或多个表、一组一个或多个完整的数据库或整个 MySQL 服务器——如下所示：

```text
mysqldump [options] db_name [tbl_name ...]
mysqldump [options] --databases db_name ...
mysqldump [options] --all-databases
```

        要转储整个数据库，请不要在 之后命名任何表
        *`db_name`*，或使用
        `--databases`或
        `--all-databases`选项。

        要查看您的
        **mysqldump**版本支持的选项列表，请发出命令
        **mysqldump**
        `--help`。

#### 选项语法 - 按字母顺序排列的摘要

        **mysqldump**支持以下选项，可以在命令行或

        选项文件的组中指定`[mysqldump]`。`[client]`有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。

**表 4.14 mysqldump 选项**

| 选项名称 | 描述 | 介绍 | 弃用 |
| --- | --- | --- | --- |
| --添加删除数据库 | 在每个 CREATE DATABASE 语句之前添加 DROP DATABASE 语句 |  |  |
| --添加删除表 | 在每个 CREATE TABLE 语句之前添加 DROP TABLE 语句 |  |  |
| --add-drop-trigger | 在每个 CREATE TRIGGER 语句之前添加 DROP TRIGGER 语句 |  |  |
| --添加锁 | 用 LOCK TABLES 和 UNLOCK TABLES 语句围绕每个表转储 |  |  |
| --所有数据库 | 转储所有数据库中的所有表 |  |  |
| --allow-关键字 | 允许创建作为关键字的列名 |  |  |
| --apply-replica-statements | 在 CHANGE REPLICATION SOURCE TO 语句之前包括 STOP REPLICA 并在输出结束时包括 START REPLICA | 8.0.26 |  |
| --apply-slave-statements | 在 CHANGE MASTER 语句之前包括 STOP SLAVE 并在输出结束时包括 START SLAVE |  | 8.0.26 |
| --绑定地址 | 使用指定的网络接口连接到 MySQL 服务器 |  |  |
| --字符集目录 | 安装字符集的目录 |  |  |
| --列统计 | 编写 ANALYZE TABLE 语句以生成统计直方图 |  |  |
| - 注释 | 向转储文件添加注释 |  |  |
| - 袖珍的 | 产生更紧凑的输出 |  |  |
| - 兼容的 | 生成与其他数据库系统或旧版 MySQL 服务器更兼容的输出 |  |  |
| --complete-插入 | 使用包含列名的完整 INSERT 语句 |  |  |
| - 压缩 | 压缩客户端和服务器之间发送的所有信息 |  | 8.0.18 |
| --压缩算法 | 允许的服务器连接压缩算法 | 8.0.18 |  |
| --创建选项 | 在 CREATE TABLE 语句中包含所有 MySQL 特定的表选项 |  |  |
| --数据库 | 将所有名称参数解释为数据库名称 |  |  |
| --调试 | 写调试日志 |  |  |
| --调试检查 | 程序退出时打印调试信息 |  |  |
| - 调试信息 | 程序退出时打印调试信息、内存和 CPU 统计信息 |  |  |
| --default-auth | 要使用的身份验证插件 |  |  |
| --默认字符集 | 指定默认字符集 |  |  |
| --defaults-extra-file | 除了通常的选项文件外，还读取命名的选项文件 |  |  |
| --defaults-文件 | 只读命名选项文件 |  |  |
| --defaults-group-suffix | 选项组后缀值 |  |  |
| --delete-master-logs | 在复制源服务器上，执行转储操作后删除二进制日志 |  | 8.0.26 |
| --delete-source-logs | 在复制源服务器上，执行转储操作后删除二进制日志 | 8.0.26 |  |
| --disable-keys | 对于每个表，用语句包围 INSERT 语句以禁用和启用键 |  |  |
| --转储日期 | 如果给出了 --comments，则将转储日期包含为“转储完成于”注释 |  |  |
| --dump-副本 | 包括 CHANGE REPLICATION SOURCE TO 语句，列出副本源的二进制日志坐标 | 8.0.26 |  |
| --转储奴隶 | 包括列出副本源的二进制日志坐标的 CHANGE MASTER 语句 |  | 8.0.26 |
| --启用明文插件 | 启用明文身份验证插件 |  |  |
| --事件 | 从转储数据库中转储事件 |  |  |
| --扩展插入 | 使用多行 INSERT 语法 |  |  |
| --fields-enclosed-by | 此选项与 --tab 选项一起使用，与 LOAD DATA 的相应子句含义相同 |  |  |
| --fields-escaped-by | 此选项与 --tab 选项一起使用，与 LOAD DATA 的相应子句含义相同 |  |  |
| --fields-optionally-enclosed-by | 此选项与 --tab 选项一起使用，与 LOAD DATA 的相应子句含义相同 |  |  |
| --fields-terminated-by | 此选项与 --tab 选项一起使用，与 LOAD DATA 的相应子句含义相同 |  |  |
| --刷新日志 | 在开始转储之前刷新 MySQL 服务器日志文件 |  |  |
| --刷新权限 | 转储 mysql 数据库后发出 FLUSH PRIVILEGES 语句 |  |  |
| - 力量 | 即使在表转储过程中出现 SQL 错误也继续 |  |  |
| --get-server-public-key | 从服务器请求 RSA 公钥 |  |  |
| - 帮助 | 显示帮助信息并退出 |  |  |
| --hex-blob | 使用十六进制表示法转储二进制列 |  |  |
| - 主持人 | MySQL 服务器所在的主机 |  |  |
| --忽略错误 | 忽略指定的错误 |  |  |
| --忽略表 | 不要转储给定的表 |  |  |
| --include-master-host-port | 在使用 --dump-slave 生成​​的 CHANGE MASTER 语句中包含 MASTER_HOST/MASTER_PORT 选项 |  | 8.0.26 |
| --include-source-host-port | 在使用 --dump-replica 生成的 CHANGE REPLICATION SOURCE TO 语句中包含 SOURCE_HOST 和 SOURCE_PORT 选项 | 8.0.26 |  |
| --插入忽略 | 编写 INSERT IGNORE 而不是 INSERT 语句 |  |  |
| --lines-terminated-by | 此选项与 --tab 选项一起使用，与 LOAD DATA 的相应子句含义相同 |  |  |
| --lock-all-tables | 锁定所有数据库中的所有表 |  |  |
| --锁表 | 在转储之前锁定所有表 |  |  |
| --日志错误 | 将警告和错误附加到命名文件 |  |  |
| --登录路径 | 从 .mylogin.cnf 读取登录路径选项 |  |  |
| - 主要的数据 | 将二进制日志文件名和位置写入输出 |  | 8.0.26 |
| --最大允许数据包 | 发送到服务器或从服务器接收的最大数据包长度 |  |  |
| --mysqld-long-query-time | 慢速查询阈值的会话值 | 8.0.30 |  |
| --net-buffer-length | TCP/IP 和套接字通信的缓冲区大小 |  |  |
| --网络超时 | 增加网络超时以允许更大的表转储 |  |  |
| --no-autocommit | 在 SET autocommit = 0 和 COMMIT 语句中包含每个转储表的 INSERT 语句 |  |  |
| --no-create-db | 不要编写 CREATE DATABASE 语句 |  |  |
| --no-create-info | 不要编写重新创建每个转储表的 CREATE TABLE 语句 |  |  |
| - 没有数据 | 不要转储表内容 |  |  |
| --no-defaults | 不读取选项文件 |  |  |
| --no-set-names | 与 --skip-set-charset 相同 |  |  |
| --无表空间 | 不要在输出中写入任何 CREATE LOGFILE GROUP 或 CREATE TABLESPACE 语句 |  |  |
| - 选择 | --add-drop-table --add-locks --create-options --disable-keys --extended-insert --lock-tables --quick --set-charset 的简写 |  |  |
| --order-by-primary | 转储按主键或第一个唯一索引排序的每个表的行 |  |  |
| - 密码 | 连接到服务器时使用的密码 |  |  |
| --密码1 | 连接到服务器时使用的第一个多因素身份验证密码 | 8.0.27 |  |
| --密码2 | 连接到服务器时使用的第二个多因素身份验证密码 | 8.0.27 |  |
| --密码3 | 连接到服务器时使用的第三个多重身份验证密码 | 8.0.27 |  |
| - 管道 | 使用命名管道连接到服务器（仅限 Windows） |  |  |
| --插件目录 | 安装插件的目录 |  |  |
| - 港口 | 用于连接的 TCP/IP 端口号 |  |  |
| --print-defaults | 打印默认选项 |  |  |
| - 协议 | 使用的传输协议 |  |  |
| - 快的 | 一次从服务器中检索一个表的行 |  |  |
| --引用名称 | 反引号字符中的引号标识符 |  |  |
| - 代替 | 编写 REPLACE 语句而不是 INSERT 语句 |  |  |
| --结果文件 | 直接输出到给定文件 |  |  |
| --例程 | 从转储的数据库中转储存储的例程（过程和函数） |  |  |
| --server-public-key-path | 包含 RSA 公钥的文件的路径名 |  |  |
| --set-字符集 | 将 SET NAMES default_character_set 添加到输出 |  |  |
| --set-gtid-清除 | 是否在输出中添加 SET @@GLOBAL.GTID_PURGED |  |  |
| --shared-memory-base-name | 共享内存连接的共享内存名称（仅限 Windows） |  |  |
| --show-create-skip-secondary-engine | 从 CREATE TABLE 语句中排除 SECONDARY ENGINE 子句 | 8.0.18 |  |
| --单笔交易 | 在从服务器转储数据之前发出 BEGIN SQL 语句 |  |  |
| --skip-add-drop-table | 不要在每个 CREATE TABLE 语句之前添加 DROP TABLE 语句 |  |  |
| --skip-add-locks | 不加锁 |  |  |
| --跳过评论 | 不要在转储文件中添加注释 |  |  |
| --skip-compact | 不要产生更紧凑的输出 |  |  |
| --skip-disable-keys | 不要禁用键 |  |  |
| --skip-extended-insert | 关闭扩展插入 |  |  |
| --skip-generated-invisible-primary-key | 不要在转储文件中包含生成的不可见主键 | 8.0.30 |  |
| --skip-opt | 关闭 --opt 设置的选项 |  |  |
| --快速跳过 | 不要一次从服务器一行检索表的行 |  |  |
| --skip-quote-names | 不要引用标识符 |  |  |
| --skip-set-字符集 | 不要写 SET NAMES 语句 |  |  |
| --skip-触发器 | 不要转储触发器 |  |  |
| --skip-tz-utc | 关闭 tz-utc |  |  |
| - 插座 | 要使用的 Unix 套接字文件或 Windows 命名管道 |  |  |
| --源数据 | 将二进制日志文件名和位置写入输出 | 8.0.26 |  |
| --ssl-ca | 包含可信 SSL 证书颁发机构列表的文件 |  |  |
| --ssl-capath | 包含受信任的 SSL 证书颁发机构证书文件的目录 |  |  |
| --ssl证书 | 包含 X.509 证书的文件 |  |  |
| --ssl密码 | 连接加密的允许密码 |  |  |
| --ssl-crl | 包含证书吊销列表的文件 |  |  |
| --ssl-crlpath | 包含证书吊销列表文件的目录 |  |  |
| --ssl-fips-模式 | 客户端是否开启FIPS模式 |  |  |
| --ssl-密钥 | 包含 X.509 密钥的文件 |  |  |
| --ssl模式 | 连接到服务器的所需安全状态 |  |  |
| --ssl 会话数据 | 包含 SSL 会话数据的文件 | 8.0.29 |  |
| --ssl-session-data-continue-on-failed-reuse | session重用失败是否建立连接 | 8.0.29 |  |
| - 标签 | 生成制表符分隔的数据文件 |  |  |
| --表格 | 覆盖 --databases 或 -B 选项 |  |  |
| --tls-密码套件 | 用于加密连接的允许的 TLSv1.3 密码套件 | 8.0.16 |  |
| --tls-版本 | 加密连接允许的 TLS 协议 |  |  |
| --触发器 | 每个转储表的转储触发器 |  |  |
| --tz-utc | 将 SET TIME_ZONE='+00:00' 添加到转储文件 |  |  |
| - 用户 | 连接到服务器时使用的 MySQL 用户名 |  |  |
| --冗长 | 详细模式 |  |  |
| - 版本 | 显示版本信息并退出 |  |  |
| - 在哪里 | 仅转储给定 WHERE 条件选择的行 |  |  |
| --xml | 生成 XML 输出 |  |  |
| --zstd-压缩级别 | 使用 zstd 压缩的服务器连接的压缩级别 | 8.0.18 |  |

**#### 连接选项 mysqldump**命令登录到 MySQL 服务器以提取信息
        。以下选项指定如何连接到 MySQL 服务器，无论是在同一台机器上还是在远程系统上。

- --bind-address=ip_address 在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
- --compress, -C 如果可能，压缩客户端和服务器之间发送的所有信息。请参阅 第 4.2.8 节，“连接压缩控制”。 从 MySQL 8.0.18 开始，不推荐使用此选项。预计它会在 MySQL 的未来版本中被删除。请参阅 配置传统连接压缩。
- --compression-algorithms=value 允许的连接到服务器的压缩算法。可用算法与 protocol_compression_algorithms 系统变量相同。默认值为 uncompressed。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.18 中添加的。
- --default-auth=plugin 关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
- --enable-cleartext-plugin 启用mysql_clear_password明文身份验证插件。（请参阅 第 6.4.1.4 节，“客户端明文可插入身份验证”。）
- --get-server-public-key 从服务器请求基于 RSA 密钥对的密码交换所需的公钥。此选项适用于使用 caching_sha2_password身份验证插件进行身份验证的客户端。对于该插件，除非请求，否则服务器不会发送公钥。对于未使用该插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。 如果 给出并指定一个有效的公钥文件，它优先于 . --server-public-key-path=file_name--get-server-public-key 有关 caching_sha2_password插件的信息，请参阅 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
- --host=host_name, -h host_name 从给定主机上的 MySQL 服务器转储数据。默认主机是localhost.
- --login-path=name 从登录路径文件中指定的登录路径读取选项 .mylogin.cnf。“ 登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用 mysql_config_editor实用程序。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --password[=password], -p[password] 用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出， mysqldump会提示输入一个。如果给定，则后面 的密码之间 不能有空格。如果未指定密码选项，则默认为不发送密码。 --password=-p 在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅 第 6.1.2.1 节，“密码安全的最终用户指南”。 要明确指定没有密码并且 mysqldump不应提示输入密码，请使用该 --skip-password 选项。
- --password1[=pass_val] 用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出， mysqldump会提示输入一个。如果给定，则后面的密码和密码之间 不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。 在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅 第 6.1.2.1 节，“密码安全的最终用户指南”。 要明确指定没有密码并且 mysqldump不应提示输入密码，请使用该 --skip-password1 选项。 --password1and --password是同义词，就像 --skip-password1 and 一样--skip-password。
- --password2[=pass_val] 用于连接到服务器的 MySQL 帐户的多因素身份验证因子 2 的密码。此选项的语义类似于 ; 的语义 --password1。有关详细信息，请参阅该选项的说明。
- --password3[=pass_val] 用于连接服务器的 MySQL 帐户的多重身份验证因子 3 的密码。此选项的语义类似于 ; 的语义 --password1。有关详细信息，请参阅该选项的说明。
- --pipe, -W 在 Windows 上，使用命名管道连接到服务器。仅当服务器启动时 named_pipe启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是 named_pipe_full_access_group 系统变量指定的 Windows 组的成员。
- --plugin-dir=dir_name 在其中查找插件的目录。如果 --default-auth选项用于指定身份验证插件但 mysqldump找不到它，请指定此选项。请参阅 第 6.2.17 节，“可插入身份验证”。
- --port=port_num, -P port_num 对于 TCP/IP 连接，要使用的端口号。
- --protocol={TCP|SOCKET|PIPE|MEMORY} 用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅 第 4.2.7 节“连接传输协议”。
- --server-public-key-path=file_name PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。此选项适用于使用 sha256_password或 caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。 如果 给出并指定一个有效的公钥文件，它优先于 . --server-public-key-path=file_name--get-server-public-key 对于sha256_password，此选项仅适用于使用 OpenSSL 构建 MySQL 的情况。 有关sha256_password 和caching_sha2_password插件的信息，请参阅 第 6.4.1.3 节，“SHA-256 可插入身份验证”和 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
- --socket=path, -S path 对于与 的连接localhost，要使用的 Unix 套接字文件，或者在 Windows 上，要使用的命名管道的名称。 在 Windows 上，仅当服务器启动时named_pipe 启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是 named_pipe_full_access_group 系统变量指定的 Windows 组的成员。
- --ssl* 以 开头的选项--ssl指定是否使用加密连接到服务器并指示在哪里可以找到 SSL 密钥和证书。请参阅 加密连接的命令选项。
- --ssl-fips-mode={OFF|ON|STRICT} 控制是否在客户端启用 FIPS 模式。该 --ssl-fips-mode选项与其他 选项的不同之处在于它不用于建立加密连接，而是用于影响允许哪些加密操作。请参见第 6.8 节 “FIPS 支持”。 --ssl-xxx 这些--ssl-fips-mode 值是允许的： OFF: 禁用 FIPS 模式。
- ON：启用 FIPS 模式。
- STRICT：启用“严格” FIPS 模式。

笔记

              如果 OpenSSL FIPS 对象模块不可用，则唯一允许的
              `--ssl-fips-mode`值为
              `OFF`. 在这种情况下，设置
              `--ssl-fips-mode`为
              `ON`或`STRICT`会导致客户端在启动时发出警告并在非 FIPS 模式下运行。

- --tls-ciphersuites=ciphersuite_list 使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅 第 6.3.2 节，“加密连接 TLS 协议和密码”。 这个选项是在 MySQL 8.0.16 中添加的。
- --tls-version=protocol_list 加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅 第 6.3.2 节，“加密连接 TLS 协议和密码”。
- --user=user_name, -u user_name 用于连接到服务器的 MySQL 帐户的用户名。 如果您将Rewriter插件与 MySQL 8.0.31 或更高版本一起使用，则应授予此用户 SKIP_QUERY_REWRITE权限。
- --zstd-compression-level=level 用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认 zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.18 中添加的。

#### 选项文件选项

        这些选项用于控制要读取的选项文件。

- --defaults-extra-file=file_name 在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果 file_name不是绝对路径名，则将其解释为相对于当前目录。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --defaults-file=file_name 仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果 file_name不是绝对路径名，则将其解释为相对于当前目录。 例外：即使有 --defaults-file，客户端程序也会读取.mylogin.cnf. 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --defaults-group-suffix=str 不仅要阅读通常的选项组，还要阅读具有通常名称和后缀 str. 例如， mysqldump通常读取 [client]和 [mysqldump]组。如果此选项作为 给出 --defaults-group-suffix=_other， mysqldump还会读取 [client_other]和 [mysqldump_other]组。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --no-defaults 不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败， --no-defaults可用于防止它们被读取。 例外情况是.mylogin.cnf 文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在 --no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用 mysql_config_editor实用程序。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --print-defaults 打印程序名称和它从选项文件中获取的所有选项。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。

#### DDL 选项

**mysqldump**的
        使用场景包括建立一个全新的 MySQL 实例（包括数据库表），以及用现有数据库和表替换现有实例中的数据。以下选项允许您通过在转储文件中编码各种 DDL 语句来指定在恢复转储时要拆除和设置的内容。

- --add-drop-database DROP DATABASE 在每个陈述之前 写一个CREATE DATABASE陈述。此选项通常与 --all-databasesor --databases选项结合使用，因为CREATE DATABASE除非指定其中一个选项，否则不会写入任何语句。 笔记 在 MySQL 8.0 中，mysql 模式被认为是最终用户不能删除的系统模式。如果 --add-drop-database与 --all-databases或一起使用 --databaseswhere the list of schemas to be dumped includes mysql，则转储文件包含一条 DROP DATABASE `mysql`语句，该语句会在重新加载转储文件时导致错误。 相反，要使用 --add-drop-database， --databases请与要转储的模式列表一起使用，其中该列表不包括 mysql.
- --add-drop-table DROP TABLE在每个陈述之前 写一个CREATE TABLE 陈述。
- --add-drop-trigger DROP TRIGGER 在每个陈述之前 写一个CREATE TRIGGER陈述。
- --all-tablespaces, -Y 将创建表使用的任何表空间所需的所有 SQL 语句添加到表转储NDB 。此信息未包含在mysqldump的输出中。此选项当前仅与 NDB Cluster 表相关。
- --no-create-db, -n 如果给出了or 选项 ，则 抑制以CREATE DATABASE 其他方式包含在输出中的语句 。--databases--all-databases
- --no-create-info, -t 不要编写CREATE TABLE 创建每个转储表的语句。 笔记 此选项不排除从 mysqldump输出中创建日志文件组或表空间的语句；但是，您可以--no-tablespaces 为此目的使用该选项。
- --no-tablespaces, -y 该选项抑制mysqldumpCREATE LOGFILE GROUP输出中的所有和CREATE TABLESPACE语句 。
- --replace 写REPLACE陈述而不是INSERT 陈述。

#### 调试选项

        以下选项打印调试信息，在转储文件中对调试信息进行编码，或者让转储操作继续进行而不管潜在的问题。

- --allow-keywords 允许创建作为关键字的列名。这通过在每个列名前加上表名来实现。
- --comments, -i 在转储文件中写入附加信息，例如程序版本、服务器版本和主机。默认情况下启用此选项。要禁止显示此附加信息，请使用--skip-comments.
- --debug[=debug_options], -# [debug_options] 写调试日志。典型的 debug_options字符串是 . 默认值为 。 d:t:o,file_named:t:o,/tmp/mysqldump.trace 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --debug-check 程序退出时打印一些调试信息。 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --debug-info 程序退出时打印调试信息以及内存和 CPU 使用统计信息。 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --dump-date 如果--comments给出该选项，mysqldump会在以下形式的转储末尾生成注释： ```text -- Dump completed on DATE ``` 但是，日期会导致在不同时间获取的转储文件看起来不同，即使数据在其他方面是相同的。--dump-date并 --skip-dump-date 控制日期是否添加到评论中。默认为--dump-date （在注释中包含日期）。 --skip-dump-date 抑制日期打印。
- --force, -f 忽略所有错误；即使在表转储过程中发生 SQL 错误，也会继续。 此选项的一个用途是使 mysqldump继续执行，即使遇到因定义引用已删除的表而变得无效的视图。如果没有 --force，mysqldump将退出并显示一条错误消息。使用--force， mysqldump会打印错误消息，但它还会将包含视图定义的 SQL 注释写入转储输出并继续执行。 如果--ignore-error 还给出了忽略特定错误的选项， --force则优先。
- --log-error=file_name 通过将它们附加到命名文件来记录警告和错误。默认是不做日志记录。
- --skip-comments 请参阅 --comments选项的说明。
- --verbose, -v 详细模式。打印有关程序功能的更多信息。

#### 帮助选项

        以下选项显示有关
        **mysqldump**命令本身的信息。

- --help, -? 显示帮助信息并退出。
- --version, -V 显示版本信息并退出。

#### 国际化选项

        以下选项更改
        **mysqldump**命令如何表示具有本地语言设置的字符数据。

- --character-sets-dir=dir_name 安装字符集的目录。请参阅 第 10.15 节，“字符集配置”。
- --default-character-set=charset_name 用作charset_name默认字符集。请参阅第 10.15 节，“字符集配置”。如果没有指定字符集， mysqldump使用 utf8mb4.
- --no-set-names, -N 关闭 --set-charset设置，与指定 相同--skip-set-charset。
- --set-charset 写入 输出。默认情况下启用此选项。要禁止该 语句，请使用 . SET NAMES default_character_setSET NAMES--skip-set-charset

#### 复制选项

**mysqldump**命令经常用于
        在复制配置中的副本服务器上创建空实例或包含数据的实例。以下选项适用于在复制源服务器和副本上转储和恢复数据。

- --apply-replica-statements 从 MySQL 8.0.26 开始，使用 --apply-replica-statements，在 MySQL 8.0.26 之前，使用 --apply-slave-statements. 这两个选项具有相同的效果。对于使用 --dump-replicaor --dump-slave选项生成的副本转储，该选项 在带有二进制日志坐标的语句之前 添加一个STOP REPLICA（或在 MySQL 8.0.22 之前）语句，并在输出末尾添加一个语句。 STOP SLAVESTART REPLICA
- --apply-slave-statements 在 MySQL 8.0.26 之前使用此选项而不是 --apply-replica-statements. 这两个选项具有相同的效果。
- --delete-source-logs 从 MySQL 8.0.26 开始，使用 --delete-source-logs，在 MySQL 8.0.26 之前，使用 --delete-master-logs. 这两个选项具有相同的效果。PURGE BINARY LOGS在复制源服务器上，选项通过在执行转储操作后向服务器发送语句来删除二进制日志 。这些选项需要RELOAD 特权以及足以执行该语句的特权。选项自动启用 --source-data或 --master-data。
- --delete-master-logs 在 MySQL 8.0.26 之前使用此选项而不是 --delete-source-logs. 这两个选项具有相同的效果。
- --dump-replica[=value] 从 MySQL 8.0.26 开始，使用--dump-replica，在 MySQL 8.0.26 之前，使用 --dump-slave. 这两个选项具有相同的效果。这些选项类似于 --source-data，不同之处在于它们用于转储副本服务器以生成转储文件，该转储文件可用于将另一台服务器设置为与转储服务器具有相同源的副本。这些选项导致转储输出包含一条 CHANGE REPLICATION SOURCE TO 语句（来自 MySQL 8.0.23）或一条语句CHANGE MASTER TO（在 MySQL 8.0.23 之前），指示转储副本源的二进制日志坐标（文件名和位置）。该 CHANGE REPLICATION SOURCE TO 语句读取和的 Relay_Master_Log_File值 Exec_Master_Log_Pos从 SHOW REPLICA STATUS输出并分别将它们用于 SOURCE_LOG_FILE和 SOURCE_LOG_POS。这些是副本开始复制的复制源服务器坐标。 笔记 已执行的中继日志中事务顺序的不一致可能导致使用错误的位置。有关更多信息，请参阅 第 17.5.1.34 节，“复制和事务不一致” 。 --dump-replica或 --dump-slave导致使用来自源的坐标而不是转储服务器的坐标，如 --source-data或 --master-data选项所做的那样。此外，指定此选项会导致 --source-data或 --master-data选项被覆盖（如果使用）并被有效地忽略。 警告 --dump-replica如果要应用转储的服务器使用and 或 ， --dump-slave则不应使用 . gtid_mode=ONSOURCE_AUTO_POSITION=1MASTER_AUTO_POSITION=1 选项值的处理方式与 for 相同 --source-data。不设置值或设置 1 会导致将CHANGE REPLICATION SOURCE TO语句（来自 MySQL 8.0.23）或 CHANGE MASTER TO语句（MySQL 8.0.23 之前）写入转储。设置 2 导致语句被写入但包含在 SQL 注释中。--source-data它与启用或禁用其他选项以及如何处理锁定 具有相同的效果 。 --dump-replica并 --dump-slave导致 mysqldump在转储之前停止复制 SQL 线程并在转储之后再次重新启动它。 --dump-replica并向 服务器--dump-slave发送 SHOW REPLICA STATUS语句以获取信息，因此他们需要足够的权限来执行该语句。 --apply-replica-statements and --include-source-host-port 选项可以与 --dump-replicaand 结合使用--dump-slave。
- --dump-slave[=value] 在 MySQL 8.0.26 之前使用此选项而不是 --dump-replica. 这两个选项具有相同的效果。
- --include-source-host-port 从 MySQL 8.0.26 开始，使用 --include-source-host-port，在 MySQL 8.0.26 之前，使用 --include-master-host-port. 这两个选项具有相同的效果。选项添加 SOURCE_HOST| MASTER_HOST和 SOURCE_PORT| MASTER_PORT副本源的主机名和 TCP/IP 端口号的 选项，到使用或 选项 生成的副本转储中 的CHANGE REPLICATION SOURCE TO 语句（来自 MySQL 8.0.23）或语句（MySQL 8.0.23 之前）。CHANGE MASTER TO--dump-replica--dump-slave
- --include-master-host-port 在 MySQL 8.0.26 之前使用此选项而不是 --include-source-host-port. 这两个选项具有相同的效果。
- --source-data[=value] 从 MySQL 8.0.26 开始，使用--source-data，在 MySQL 8.0.26 之前，使用 --master-data. 这两个选项具有相同的效果。这些选项用于转储复制源服务器以生成可用于将另一台服务器设置为源副本的转储文件。这些选项导致转储输出包含一条 CHANGE REPLICATION SOURCE TO 语句（来自 MySQL 8.0.23）或一条语句（MySQL 8.0.23CHANGE MASTER TO之前），指示转储服务器的二进制日志坐标（文件名和位置）。这些是复制源服务器坐标，在将转储文件加载到副本后，副本应从该坐标开始复制。 如果选项值为 2，则CHANGE REPLICATION SOURCE TO| CHANGE MASTER TO语句以 SQL 注释的形式编写，因此仅供参考；重新加载转储文件时它不起作用。如果选项值为 1，则该语句不作为注释写入，并在重新加载转储文件时生效。如果未指定选项值，则默认值为 1。 --source-data并向 服务器--master-data发送 SHOW MASTER STATUS语句以获取信息，因此他们需要足够的权限来执行该语句。此选项还需要RELOAD 权限并且必须启用二进制日志。 --source-data并 --master-data自动关闭 --lock-tables。它们也会打开--lock-all-tables，除非 --single-transaction还指定，在这种情况下，全局读锁只会在转储开始时短时间内获取（请参阅说明 --single-transaction）。在所有情况下，对日志的任何操作都发生在转储的确切时刻。 也可以通过使用 --dump-replicaor --dump-slave选项转储源的现有副本来设置副本，该选项会覆盖--source-dataand --master-data并导致它们被忽略。
- --master-data[=value] 在 MySQL 8.0.26 之前使用此选项而不是 --source-data. 这两个选项具有相同的效果。
- --set-gtid-purged=value 此选项适用于使用基于 GTID 的复制 ( gtid_mode=ON) 的服务器。它控制SET @@GLOBAL.gtid_purged在转储输出中包含一条语句，该语句更新 gtid_purged重新加载转储文件的服务器上的值，以添加从源服务器的 gtid_executed系统变量设置的 GTID。gtid_purged保存已在服务器上应用但不存在于服务器上的任何二进制日志文件中的所有事务的 GTID。mysql转储因此，为在源服务器上执行的事务添加 GTID，以便目标服务器在应用时记录这些事务，尽管它的二进制日志中没有它们。--set-gtid-purged还控制语句的包含，该SET @@SESSION.sql_log_bin=0语句在重新加载转储文件时禁用二进制日志记录。此语句可防止在执行转储文件时生成新的 GTID 并将其分配给转储文件中的事务，以便使用事务的原始 GTID。 如果您不设置该--set-gtid-purged 选项，则默认情况下，SET @@GLOBAL.gtid_purged如果您正在备份的服务器上启用了 GTID，并且 gtid_executed系统变量的全局值中的 GTID 集不为空，则转储输出中将包含一条语句。SET @@SESSION.sql_log_bin=0如果在服务器上启用了 GTID，也会包含 一条语句。 您可以将 的值替换为 gtid_purged指定的 GTID 集，或者在语句中添加加号 (+) 以将指定的 GTID 集附加到已由 持有的 GTID 集gtid_purged。mysqldump记录的 SET @@GLOBAL.gtid_purged语句在特定于版本的注释中包含一个加号 ( )，这样 MySQL 8.0（及更高版本）将从转储文件中设置的 GTID 添加到现有 值中。 +gtid_purged 重要的是要注意， mysqldump为该SET @@GLOBAL.gtid_purged语句包含的值包括服务器上集合中所有事务的 GTID gtid_executed，甚至是那些更改了数据库的抑制部分的 GTID，或者服务器上未包含在部分转储。这可能意味着在 gtid_purged值已在重放转储文件的服务器上更新，存在与目标服务器上的任何数据无关的 GTID。如果您不在目标服务器上重播任何进一步的转储文件，则无关的 GTID 不会对服务器的未来操作造成任何问题，但它们会使比较或协调复制拓扑中不同服务器上的 GTID 集变得更加困难。如果您确实在目标服务器上重播包含相同 GTID 的进一步转储文件（例如，来自同一源服务器的另一个部分转储），则任何SET @@GLOBAL.gtid_purged第二个转储文件中的语句失败。在这种情况下，要么在重放转储文件之前手动删除该语句，要么输出不带该语句的转储文件。 将此选项与选项一起使用 --single-transaction 会导致输出不一致。如果 --set-gtid-purged=ON需要，它可以与 一起使用 --lock-all-tables，但这可以防止 在运行mysqldump时进行并行查询。 如果该SET @@GLOBAL.gtid_purged语句在您的目标服务器上没有预期的结果，您可以从输出中排除该语句，或者（从 MySQL 8.0.17 开始）包含它但将其注释掉，这样它就不会自动执行。您还可以包含该语句，但在转储文件中手动编辑它以获得所需的结果。 该 --set-gtid-purged选项的可能值如下： AUTO 默认值。如果在您正在备份的服务器上启用了 GTID 并且 gtid_executed不为空，SET @@GLOBAL.gtid_purged则添加到输出中，其中包含来自的 GTID 集 gtid_executed。如果启用了 GTID，SET @@SESSION.sql_log_bin=0则会添加到输出中。如果服务器上未启用 GTID，则不会将语句添加到输出中。 OFF SET @@GLOBAL.gtid_purged未添加到输出中，并且SET @@SESSION.sql_log_bin=0未添加到输出中。对于未使用 GTID 的服务器，请使用此选项或AUTO. 如果您确定所需的 GTID 集已经存在于 gtid_purged目标服务器上并且不应更改，或者如果您计划手动识别和添加任何缺失的 GTID，则仅对正在使用 GTID 的服务器使用此选项。 ON 如果在要备份的服务器上启用了 GTID， SET @@GLOBAL.gtid_purged则添加到输出（除非 gtid_executed为空），并SET @@SESSION.sql_log_bin=0添加到输出。如果设置此选项但服务器上未启用 GTID，则会发生错误。对于正在使用 GTID 的服务器，请使用此选项或 AUTO，除非您确定 gtid_executed目标服务器不需要 GTID。 COMMENTED 从 MySQL 8.0.17 开始可用。如果在您正在备份的服务器上启用了 GTID，SET @@GLOBAL.gtid_purged则会添加到输出中（除非gtid_executed 为空），但会被注释掉。这意味着 的值 gtid_executed在输出中可用，但在重新加载转储文件时不会自动执行任何操作。 SET @@SESSION.sql_log_bin=0被添加到输出中，并且没有被注释掉。使用 COMMENTED，您可以控制gtid_executed 手动或通过自动化设置。例如，如果您正在将数据迁移到另一台已经具有不同活动数据库的服务器，您可能更愿意这样做。

#### 格式选项

        以下选项指定如何表示整个转储文件或转储文件中的某些类型的数据。它们还控制是否将某些可选信息写入转储文件。

- --compact 产生更紧凑的输出。此选项启用 --skip-add-drop-table、 --skip-add-locks、 --skip-comments、 --skip-disable-keys和 --skip-set-charset 选项。
- --compatible=name 生成与其他数据库系统或较旧的 MySQL 服务器更兼容的输出。该选项唯一允许的值为ansi，其含义与设置服务器 SQL 模式的相应选项相同。请参阅第 5.1.11 节，“服务器 SQL 模式”。
- --complete-insert, -c INSERT 使用包含列名的 完整语句。
- --create-options 在语句中包括所有特定于 MySQL 的表选项 CREATE TABLE。
- --fields-terminated-by=..., --fields-enclosed-by=..., --fields-optionally-enclosed-by=..., --fields-escaped-by=... 这些选项与 option 一起使用，与 的相应 子句--tab具有相同的含义。请参阅 第 13.2.7 节，“加载数据语句”。 FIELDSLOAD DATA
- --hex-blob 使用十六进制表示法转储二进制列（例如， 'abc'变成 0x616263）。受影响的数据类型是 BINARY, VARBINARY, BLOBtypes, , 所有空间数据类型，以及与 字符集BIT一起使用时的其他非二进制数据类型 。 binary
- --lines-terminated-by=... 该选项与选项一起使用，与 对应的 子句--tab意义相同。请参阅 第 13.2.7 节，“加载数据语句”。 LINESLOAD DATA
- --quote-names, -Q 在字符中引用标识符（例如数据库、表和列名称）`。如果 ANSI_QUOTES启用 SQL 模式，则标识符在" 字符内被引用。默认情况下启用此选项。它可以被禁用--skip-quote-names，但是这个选项应该在任何 --compatible可能启用的选项之后给出--quote-names。
- --result-file=file_name, -r file_name 直接输出到命名文件。即使在生成转储时发生错误，也会创建结果文件并覆盖其先前的内容。 此选项应该在 Windows 上使用，以防止换行符 \n被转换为 \r\n回车/换行符序列。
- --show-create-skip-secondary-engine=value 从语句中 排除SECONDARY ENGINE子句 。CREATE TABLE它通过 show_create_table_skip_secondary_engine 在转储操作期间启用系统变量来实现。或者，您可以 在使用mysqldumpshow_create_table_skip_secondary_engine 之前启用系统变量。 这个选项是在 MySQL 8.0.18 中添加的。 在不支持该变量的 MySQL 8.0.18 之前的版本上 尝试 使用选项进行mysqldump操作 会导致错误。 --show-create-skip-secondary-engineshow_create_table_skip_secondary_engine
- --tab=dir_name, -T dir_name 生成制表符分隔的文本格式数据文件。对于每个转储的表，mysqldump创建一个 tbl_name.sql 包含CREATE TABLE创建表的语句的文件，并且服务器写入一个 tbl_name.txt 包含其数据的文件。选项值是写入文件的目录。 笔记 仅当mysqldump与mysqld服务器在同一台机器上运行 时才应使用此选项 。因为服务器*.txt在您指定的目录中创建文件，所以该目录必须是服务器可写的，并且您使用的 MySQL 帐户必须具有 FILE权限。因为 mysqldump在同一目录中创建 *.sql，所以它必须对您的系统登录帐户是可写的。 默认情况下，.txt数据文件的格式是使用列值之间的制表符和每行末尾的换行符。可以使用 和 选项明确指定格式。 --fields-xxx--lines-terminated-by 列值转换为 --default-character-set 选项指定的字符集。
- --tz-utc 此选项允许TIMESTAMP 在不同时区的服务器之间转储和重新加载列。mysqldump将其连接时区设置为 UTC 并添加SET TIME_ZONE='+00:00'到转储文件中。如果没有此选项，TIMESTAMP列将在源服务器和目标服务器的本地时区转储和重新加载，如果服务器位于不同的时区，这可能会导致值发生变化。 --tz-utc还可以防止由于夏令时而发生的变化。--tz-utc默认情况下启用。要禁用它，请使用 --skip-tz-utc.
- --xml,-X 将转储输出写入格式正确的 XML。 NULL、 'NULL'和空值：对于名为 的列column_name， NULL值、空字符串和字符串值'NULL'在此选项生成的输出中相互区分，如下所示。 价值： XML 表示： NULL（未知值）  ''（空字符串）  'NULL'（字符串值） NULL 使用该选项运行时mysql客户端 的输出--xml也遵循上述规则。（参见 第 4.5.1.1 节，“mysql 客户端选项”。） mysqldump的 XML 输出包括 XML 命名空间，如下所示： ```sql $> mysqldump --xml -u root world City 1 Kabul AFG Kabol 1780000 ... 4079 Rafah PSE Rafah 92020 ```

#### 过滤选项

        以下选项控制将哪种模式对象写入转储文件：按类别，例如触发器或事件；按名称，例如，选择要转储的数据库和表；甚至使用`WHERE`子句从表数据中过滤行。

- --all-databases, -A 转储所有数据库中的所有表。这与--databases在命令行上使用选项和命名所有数据库相同。 笔记 --add-drop-database 有关该选项与 不兼容的信息， 请参阅 说明--all-databases。 在 MySQL 8.0 之前， mysqldump和 mysqlpump--routines的和 --events选项 在使用选项时不需要包括存储的例程和事件 ：转储包括系统数据库，因此也 包括包含存储例程和事件定义的和 表。从 MySQL 8.0 开始，和 --all-databasesmysqlmysql.procmysql.eventmysql.eventmysql.proc不使用表格。相应对象的定义存储在数据字典表中，但不会转储这些表。要在使用 生成的转储中包含存储的例程和事件， 请明确--all-databases使用 --routines和 --events选项。
- --databases, -B 转储几个数据库。通常， mysqldump将命令行上的第一个名称参数视为数据库名称，将后面的名称视为表名。使用此选项，它将所有名称参数视为数据库名称。CREATE DATABASE和USE 语句包含在每个新数据库之前的输出中。 此选项可用于转储 performance_schema数据库，通常即使使用该 --all-databases选项也不会转储。（也使用该 --skip-lock-tables 选项。） 笔记 --add-drop-database 有关该选项与 不兼容的信息， 请参阅 说明--databases。
- --events, -E 在输出中包括转储数据库的事件计划程序事件。此选项需要 EVENT这些数据库的权限。 通过使用--events containsCREATE EVENT 语句创建事件而生成的输出。
- --ignore-error=error[,error]... 忽略指定的错误。选项值是一个逗号分隔的错误号列表，指定在mysqldump执行期间要忽略的错误。如果 --force还给出了忽略所有错误的选项， --force则优先。
- --ignore-table=db_name.tbl_name 不要转储给定的表，该表必须使用数据库名和表名指定。要忽略多个表，请多次使用此选项。此选项也可用于忽略视图。
- --no-data, -d 不要写入任何表行信息（即不要转储表内容）。如果您只想转储 CREATE TABLE表的语句（例如，通过加载转储文件来创建表的空副本），这将很有用。
- --routines, -R 在输出中包括转储数据库的存储例程（过程和函数）。此选项需要全局SELECT权限。 通过使用--routines containsCREATE PROCEDURE和 CREATE FUNCTION语句创建例程生成的输出。
- --skip-generated-invisible-primary-key 此选项从 MySQL 8.0.30 开始可用，并导致生成的不可见主键从输出中排除。有关详细信息，请参阅 第 13.1.20.11 节，“生成的不可见主键”。
- --tables 覆盖--databases or-B选项。mysqldump 将选项后面的所有名称参数视为表名。
- --triggers 在输出中包含每个转储表的触发器。默认情况下启用此选项；禁用它 --skip-triggers。 为了能够转储表的触发器，您必须拥有该 TRIGGER表的权限。 允许多个触发器。 mysqldump以激活顺序转储触发器，以便在重新加载转储文件时，以相同的激活顺序创建触发器。但是，如果 mysqldump转储文件包含具有相同触发事件和操作时间的表的多个触发器，则尝试将转储文件加载到不支持多个触发器的旧服务器时会发生错误。（有关解决方法，请参阅 降级说明；您可以转换触发器以与旧服务器兼容。）
- --where='where_condition', -w 'where_condition' 仅转储给定 WHERE条件选择的行。如果条件包含空格或其他对您的命令解释器来说特殊的字符，则必须在条件周围加上引号。 例子： ```text --where="user='jimf'" -w"userid>1" -w"userid

#### 性能选项

        以下选项与性能最相关，尤其是还原操作的性能。对于大数据集，恢复操作（处理`INSERT`
        转储文件中的语句）是最耗时的部分。当急需快速恢复数据时，提前规划和测试该阶段的性能。对于以小时为单位的恢复时间，您可能更喜欢备用备份和恢复解决方案，例如MySQL Enterprise Backup for `InnoDB`-only 和 mixed-use 数据库。

        性能也受
        事务选项的影响，主要是针对转储操作。

- --column-statistics 将ANALYZE TABLE语句添加到输出以在重新加载转储文件时为转储表生成直方图统计信息。默认情况下禁用此选项，因为大型表的直方图生成可能需要很长时间。
- --disable-keys, -K INSERT对于每个表，用 和语句 包围 语句。这使得加载转储文件更快，因为索引是在插入所有行之后创建的。此选项仅对表的非唯一索引有效。 /*!40000 ALTER TABLE tbl_name DISABLE KEYS */;/*!40000 ALTER TABLE tbl_name ENABLE KEYS */;MyISAM
- --extended-insert, -e INSERT使用包含多个 VALUES列表的多行语法 编写语句。这会导致转储文件更小，并在重新加载文件时加快插入速度。
- --insert-ignore 写INSERT IGNORE陈述而不是 INSERT陈述。
- --max-allowed-packet=value 客户端/服务器通信缓冲区的最大大小。默认为 24​​MB，最大为 1GB。
- --mysqld-long-query-time=value long_query_time设置系统变量 的会话值 。如果您想增加 mysqldump的查询在记录到慢速查询日志文件之前允许的时间，请使用此选项，它可从 MySQL 8.0.30 获得。 mysqldump执行全表扫描，这意味着它的查询通常可以超过 long_query_time 对常规查询有用的全局设置。默认全局设置为 10 秒。 您可以使用 --mysqld-long-query-time 指定从 0（意味着来自mysqldump的每个查询都记录到慢查询日志）到 31536000（以秒为单位的 365 天）之间的会话值。对于 mysqldump的选项，您只能指定整秒。当您不指定此选项时，服务器的全局设置适用于 mysqldump的查询。
- --net-buffer-length=value 客户端/服务器通信缓冲区的初始大小。当创建多行 INSERT语句时（与--extended-insertor --opt选项一样）， mysqldump创建最多 --net-buffer-length字节长的行。如果增加此变量，请确保 MySQL 服务器net_buffer_length 系统变量的值至少有这么大。
- --network-timeout, -M --max-allowed-packet通过将其设置为最大值和网络读写超时设置为较大的值来 启用大型表的转储 。默认情况下启用此选项。要禁用它，请使用 --skip-network-timeout.
- --opt 此选项默认启用，是 . 组合的简写 。它提供快速转储操作并生成可以快速重新加载到 MySQL 服务器的转储文件。 --add-drop-table --add-locks --create-options --disable-keys --extended-insert --lock-tables --quick --set-charset 因为该--opt选项在默认情况下处于启用状态，所以您只需指定其相反的选项 --skip-opt即可关闭多个默认设置。有关有选择地启用或禁用受 影响的选项子集的信息， 请参阅mysqldump 选项组的讨论 --opt。
- --quick, -q 此选项对于转储大型表很有用。它强制 mysqldump一次一行地从服务器检索表的行，而不是检索整个行集并在写出之前将其缓冲在内存中。
- --skip-opt 请参阅 --opt选项的说明。

#### 交易选项

        以下选项权衡了转储操作的性能，以及导出数据的可靠性和一致性。

- --add-locks LOCK TABLES用and UNLOCK TABLES语句 包围每个表转储。重新加载转储文件时，这会导致更快的插入。请参阅 第 8.2.5.1 节，“优化 INSERT 语句”。
- --flush-logs, -F 在开始转储之前刷新 MySQL 服务器日志文件。此选项需要 RELOAD特权。如果将此选项与 选项结合使用 ，则会为每个转储的数据库--all-databases刷新日志。使用 , 或 , 或 时除外。在这些情况下，日志只会刷新一次，对应于所有表都被 锁定的时刻 。如果你想让你的转储和日​​志刷新在同一时刻发生，你应该 一起使用 with ， --lock-all-tables--source-data--master-data--single-transactionFLUSH TABLES WITH READ LOCK--flush-logs--lock-all-tables--source-data或者 --master-data，或者 --single-transaction。
- --flush-privileges FLUSH PRIVILEGES 转储数据库后向转储输出 添加一条语句mysql。mysql 只要转储包含数据库和任何其他依赖于数据库中的数据以mysql进行正确恢复 的数据库，就应该使用此选项。 因为转储文件包含一条FLUSH PRIVILEGES语句，重新加载文件需要足够的权限来执行该语句。 笔记 对于从旧版本升级到 MySQL 5.7 或更高版本，请勿使用--flush-privileges. 有关这种情况下的升级说明，请参阅 第 2.11.4 节，“MySQL 8.0 中的更改”。
- --lock-all-tables, -x 锁定所有数据库中的所有表。这是通过在整个转储期间获取全局读锁来实现的。此选项会自动关闭 --single-transaction和 --lock-tables。
- --lock-tables, -l 对于每个转储的数据库，在转储之前锁定所有要转储的表。表被锁定 READ LOCAL以允许在MyISAM表的情况下并发插入。对于诸如 之类的事务表InnoDB， 这--single-transaction是一个更好的选择，--lock-tables 因为它根本不需要锁定表。 因为--lock-tables分别为每个数据库锁定表，所以此选项不保证转储文件中的表在数据库之间在逻辑上是一致的。不同数据库中的表可能会以完全不同的状态转储。 某些选项（例如 --opt）会自动启用--lock-tables。如果您想覆盖它，--skip-lock-tables请在选项列表的末尾使用。
- --no-autocommit 将INSERT每个转储表的语句包含在SET autocommit = 0和COMMIT 语句中。
- --order-by-primary 转储按其主键或第一个唯一索引（如果存在这样的索引）排序的每个表的行。MyISAM这在转储要加载到表中的表时很有用InnoDB，但会使转储操作花费相当长的时间。
- --shared-memory-base-name=name 在 Windows 上，用于使用共享内存与本地服务器建立连接的共享内存名称。默认值为MYSQL。共享内存名称区分大小写。 仅当服务器启动时 shared_memory启用了支持共享内存连接的系统变量时，此选项才适用。
- --single-transaction 此选项将事务隔离模式设置为 REPEATABLE READ并在转储数据之前向服务器发送START TRANSACTIONSQL 语句。它仅对诸如 之类的事务表有用InnoDB，因为它会在发布时转储数据库的一致状态， START TRANSACTION而不会阻止任何应用程序。 使用此选项时，您应该记住，只有 InnoDB表会以一致的状态转储。例如，使用此选项时转储 的任何MyISAM或 表可能仍会更改状态。MEMORY 在 --single-transaction转储过程中，为确保转储文件有效（正确的表内容和二进制日志坐标），其他任何连接都不应使用以下语句： ALTER TABLE, CREATE TABLE, DROP TABLE, RENAME TABLE, TRUNCATE TABLE。一致性读取并不与这些语句隔离，因此在要转储的表上使用它们可能会导致 mysqldumpSELECT执行的 检索表内容的操作获取不正确的内容或失败。 --single-transactionoption 和 --lock-tablesoption 是互斥的，因为 会LOCK TABLES导致任何未决事务被隐式提交。 不建议--single-transaction与该选项一起使用 ；--set-gtid-purged这样做会导致 mysqldump的输出不一致。 要转储大表，请将 --single-transaction选项与 --quick选项结合使用。

#### 选项组

- 该--opt选项会启用多个协同工作以执行快速转储操作的设置。默认情况下，所有这些设置都处于启用状态，因为默认情况下处于启用 --opt状态。因此，您很少指定--opt. 相反，您可以通过指定 将这些设置作为一个组关闭 --skip-opt，然后通过稍后在命令行上指定相关选项来选择性地重新启用某些设置。
- 该--compact选项关闭了几个控制可选语句和注释是否出现在输出中的设置。同样，您可以在该选项之后使用其他选项重新启用某些设置，或者使用 --skip-compact表单打开所有设置。

        当您有选择地启用或禁用组选项的效果时，顺序很重要，因为选项是从前到后处理的。例如，
        不会有预期的效果；它
        本身就是一样的。
`--disable-keys`
        `--lock-tables`
        `--skip-opt``--skip-opt`

#### 例子

        要备份整个数据库：

```text
mysqldump db_name > backup-file.sql
```

        将转储文件加载回服务器：

```text
mysql db_name  my_databases.sql
```

        要转储所有数据库，请使用以下
        `--all-databases`选项：

```text
mysqldump --all-databases > all_databases.sql
```

        对于`InnoDB`表，
         **mysqldump**提供了一种进行在线备份的方法：

```text
mysqldump --all-databases --master-data --single-transaction > all_databases.sql

or from MySQL 8.0.26:
mysqldump --all-databases --source-data --single-transaction > all_databases.sql
```

`FLUSH TABLES WITH READ LOCK`此备份在转储开始时
        获取所有表（使用 ）的全局读锁
        。一旦获得此锁，就会读取二进制日志坐标并释放锁。如果在
        `FLUSH`发出语句时正在运行长更新语句，则 MySQL 服务器可能会停止运行，直到这些语句完成。在那之后，转储变得无锁并且不会干扰表上的读写。如果 MySQL 服务器收到的更新语句很短（就执行时间而言），初始锁定期应该不会很明显，即使有很多更新。

        对于时间点恢复（也称为
        “前滚” ，当您需要恢复旧备份并重播自该备份以来发生的更改时），旋转二进制日志通常很有用（请参阅
        第 5.4 节）。 4，“二进制日志”）或者至少知道转储对应的二进制日志坐标：

```text
mysqldump --all-databases --master-data=2 > all_databases.sql

or from MySQL 8.0.26:
mysqldump --all-databases --source-data=2 > all_databases.sql
```

        或者：

```text
mysqldump --all-databases --flush-logs --master-data=2 > all_databases.sql

or from MySQL 8.0.26:
mysqldump --all-databases --flush-logs --source-data=2 > all_databases.sql
```

`--source-data`or
        `--master-data`选项可以与 option 同时使用

        ，如果表是使用存储引擎
      `--single-transaction`存储的，它提供了一种方便的方法来使在线备份适合在时间点恢复之前使用。`InnoDB`

        有关制作备份的更多信息，请参阅
        第 7.2 节，“数据库备份方法”和
        第 7.3 节，“示例备份和恢复策略”。

- 要选择 --opt除某些功能之外的效果，请使用--skip每个功能的选项。要禁用扩展插入和内存缓冲，请使用. （实际上， 就足够了，因为 默认情况下处于打开状态。） --opt --skip-extended-insert --skip-quick--skip-extended-insert --skip-quick--opt
- 要反转--opt除禁用索引和表锁定之外的所有功能，请使用 . --skip-opt --disable-keys --lock-tables

#### 限制

        **默认情况下， mysqldump**不会转储
        `performance_schema`或`sys`
        模式。要转储其中任何一个，请在命令行上明确命名它们。您也可以使用
        `--databases`选项命名它们。对于
        `performance_schema`，也使用
        `--skip-lock-tables`
        选项。

        **mysqldump**不转储
        `INFORMATION_SCHEMA`模式。

        **mysqldump**不转储
        `InnoDB` `CREATE TABLESPACE`语句。

        **mysqldump**不会转储 NDB Cluster
        `ndbinfo`信息数据库。

        **mysqldump**包括为数据库转储
        重新创建
        `general_log`和
        。不转储日志表内容。
      `slow_query_log``mysql`

        如果您由于权限不足而在备份视图时遇到问题，请参阅第 25.9 节 “视图限制”以获得解决方法。

---

[← 返回 第 4 章 MySQL 程序 索引](00-index.md) · [← 返回总索引](../00-index.md)
