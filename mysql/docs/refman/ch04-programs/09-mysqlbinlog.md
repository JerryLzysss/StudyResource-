# 第 4 章 MySQL 程序 · mysqlbinlog

> 对应 SQL：[`sql/refman/ch04-programs/09-mysqlbinlog.sql`](../../../sql/refman/ch04-programs/09-mysqlbinlog.sql)

---

4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 4 章 MySQL 程序 / 4.6 管理和实用程序 / 4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序 服务器的二进制日志由包含描述数据库内容修改的“事件” 的文件组成 。服务器以二进制格式写入这些文件。要以文本格式显示它们的内容，请使用 mysqlbinlog实用程序。您还可以使用 mysqlbinlog来显示复制设置中副本服务器写入的中继日志文件的内容，因为中继日志与二进制日志具有相同的格式。二进制日志和中继日志将在 第 5.4.4 节“二进制日志”和 第 17.2.4 节“中继日志和复制元数据存储库”中进一步讨论。 像这样调用mysqlbinlog： ```text mysqlbinlog [options] log_file ... ``` 例如，要显示名为 的二进制日志文件的内容binlog.000003，请使用以下命令： ```text mysqlbinlog binlog.000003 ``` 输出包括 中包含的事件 binlog.000003。对于基于语句的日志记录，事件信息包括 SQL 语句、执行它的服务器的 ID、语句执行时的时间戳、花费的时间等等。对于基于行的日志记录，事件指示行更改而不是 SQL 语句。有关日志记录模式的信息 ，请参阅第 17.2.1 节，“复制格式” 。 事件前面有提供附加信息的标题注释。例如： ```text # at 141 #100309 9:28:36 server id 123 end_log_pos 245 Query thread_id=3350 exec_time=11 error_code=0 ``` 在第一行中，后面的数字at 表示二进制日志文件中事件的文件偏移量或起始位置。 第二行以日期和时间开头，指示语句何时在事件发起的服务器上开始。对于复制，此时间戳会传播到副本服务器。 server id是 server_id事件发生的服务器的值。end_log_pos 表示下一个事件的开始位置（即当前事件的结束位置+1）。thread_id 指示哪个线程执行了事件。 exec_time是在复制源服务器上执行事件所花费的时间。在副本上，它是副本上的结束执行时间减去源上的开始执行时间的差值。差异用作复制落后于源多少的指标。 error_code指示执行事件的结果。零意味着没有错误发生。 笔记 使用事件组时，可以将事件的文件偏移量组合在一起，将事件的注释组合在一起。不要将这些分组事件误认为是空白文件偏移量。 可以重新执行 mysqlbinlog 的输出（例如，将其用作mysql的输入）以重做日志中的语句。这对于服务器意外退出后的恢复操作很有用。对于其他使用示例，请参阅本节后面的讨论和第 7.5 节“时间点（增量）恢复”。要执行 mysqlbinlogBINLOG使用的内部使用语句 ，用户需要 特权（或已弃用的特权），或特权加上执行每个日志事件的适当特权。 BINLOG_ADMINSUPERREPLICATION_APPLIER 您可以使用mysqlbinlog直接读取二进制日志文件并将其应用到本地 MySQL 服务器。您还可以使用该 --read-from-remote-server 选项从远程服务器读取二进制日志。要读取远程二进制日志，可以提供连接参数选项以指示如何连接到服务器。这些选项是--host、 --password、 --port、 --protocol、 --socket和 --user。 当二进制日志文件被加密时，可以从 MySQL 8.0.14 开始完成，mysqlbinlog不能直接读取它们，但可以使用 --read-from-remote-server 选项从服务器读取它们。binlog_encryption当服务器的系统变量设置为时，二进制日志文件被加密 ON。该 SHOW BINARY LOGS语句显示特定的二进制日志文件是加密的还是未加密的。加密和未加密的二进制日志文件也可以使用加密日志文件文件头开头的幻数 ( ) 来区分0xFD62696E，这不同于用于未加密日志文件 ( 0xFE62696E) 的幻数。请注意，从 MySQL 8.0.14 开始， mysqlbinlog如果您尝试直接读取加密的二进制日志文件，则返回一个合适的错误，但旧版本的mysqlbinlog根本不将该文件识别为二进制日志文件。有关二进制日志加密的更多信息，请参阅 第 17.3.2 节，“加密二进制日志文件和中继日志文件”。 当二进制日志事务有效载荷被压缩时，这可以从 MySQL 8.0.20 开始完成， 该版本的mysqlbinlog版本自动解压缩和解码事务有效载荷，并像未压缩的事件一样打印它们。旧版本的mysqlbinlog无法读取压缩的事务负载。当服务器的 binlog_transaction_compression 系统变量设置为 时ON，事务负载被压缩，然后作为单个事件 (a) 写入服务器的二进制日志文件 Transaction_payload_event。使用 --verbose选项， mysqlbinlog添加注释说明所使用的压缩算法、最初收到的压缩负载大小以及解压缩后生成的负载大小。 笔记 mysqlbinlog为作为压缩事务负载一部分的单个事件声明 的结束位置 ( end_log_pos) 与原始压缩负载的结束位置相同。因此，多个解压缩事件可以具有相同的结束位置。 如果事务有效负载已经压缩，则 mysqlbinlog自己的连接压缩会减少，但仍对未压缩的事务和标头进行操作。 有关二进制日志事务压缩的更多信息，请参阅 第 5.4.4.5 节，“二进制日志事务压缩”。 当针对大型二进制日志运行mysqlbinlog时，请注意文件系统有足够的空间用于生成的文件。要配置 mysqlbinlog用于临时文件的目录，请使用 TMPDIR环境变量。 mysqlbinlog在执行任何 SQL 语句之前pseudo_replica_modeor 的值设置 pseudo_slave_mode此系统变量影响 XA 事务的处理、 original_commit_timestamp复制延迟时间戳和 original_server_version系统变量，以及不支持的 SQL 模式。 mysqlbinlog支持以下选项，可以在命令行或 选项文件的组中指定[mysqlbinlog]。[client]有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。 表 4.22 mysqlbinlog 选项 选项名称 描述 介绍 弃用 --base64-输出 使用 base-64 编码打印二进制日志条目 --绑定地址 使用指定的网络接口连接到 MySQL 服务器 --binlog-row-event-max-size 二进制日志最大事件大小 --字符集目录 安装字符集的目录 - 压缩 压缩客户端和服务器之间发送的所有信息 8.0.17 8.0.18 --压缩算法 允许的服务器连接压缩算法 8.0.18 --connection-server-id 用于测试和调试。有关适用的默认值和其他详细信息，请参阅文本 - 数据库 仅列出该数据库的条目 --调试 写调试日志 --调试检查 程序退出时打印调试信息 - 调试信息 程序退出时打印调试信息、内存和 CPU 统计信息 --default-auth 要使用的身份验证插件 --defaults-extra-file 除了通常的选项文件外，还读取命名的选项文件 --defaults-文件 只读命名选项文件 --defaults-group-suffix 选项组后缀值 --disable-log-bin 禁用二进制日志记录 --exclude-gtids 不要显示提供的 GTID 集中的任何组 --force-if-open 读取二进制日志文件，即使打开或未正确关闭 --强制阅读 如果 mysqlbinlog 读取了一个它无法识别的二进制日志事件，它会打印一条警告 --get-server-public-key 从服务器请求 RSA 公钥 - 帮助 显示帮助信息并退出 --hexdump 在评论中显示日志的十六进制转储 - 主持人 MySQL 服务器所在的主机 --幂等 使服务器在仅处理来自该会话的二进制日志更新时使用幂等模式 --include-gtids 仅显示提供的 GTID 集中的组 --local-load 在指定目录下为LOAD DATA准备本地临时文件 --登录路径 从 .mylogin.cnf 读取登录路径选项 --no-defaults 不读取选项文件 - 抵消 跳过日志中的前 N ​​个条目 - 密码 连接到服务器时使用的密码 --插件目录 安装插件的目录 - 港口 用于连接的 TCP/IP 端口号 --print-defaults 打印默认选项 --打印表元数据 打印表元数据 - 协议 使用的传输协议 - 生的 以原始（二进制）格式将事件写入输出文件 --从远程主机读取 从 MySQL 复制源服务器读取二进制日志而不是读取本地日志文件 8.0.26 --从远程服务器读取 从 MySQL 服务器读取二进制日志而不是本地日志文件 --read-from-remote-source 从 MySQL 复制源服务器读取二进制日志而不是读取本地日志文件 8.0.26 --require-行格式 需要基于行的二进制日志记录格式 8.0.19 --结果文件 直接输出到命名文件 --rewrite-db 从以基于行的格式编写的日志回放时，为数据库创建重写规则。可以多次使用 --server-id 仅提取由具有给定服务器 ID 的服务器创建的那些事件 --server-id-bits 告诉 mysqlbinlog 当 log 由 server-id-bits 设置为小于最大值的 mysqld 写入时如何解释二进制日志中的服务器 ID；仅由 mysqlbinlog 的 MySQL Cluster 版本支持 --server-public-key-path 包含 RSA 公钥的文件的路径名 --set-字符集 将 SET NAMES charset_name 语句添加到输出 --shared-memory-base-name 共享内存连接的共享内存名称（仅限 Windows） - 简写 只显示日志中包含的语句 --skip-gtids 不要在输出转储文件中包含二进制日志文件中的 GTID - 插座 要使用的 Unix 套接字文件或 Windows 命名管道 --ssl-ca 包含可信 SSL 证书颁发机构列表的文件 --ssl-capath 包含受信任的 SSL 证书颁发机构证书文件的目录 --ssl证书 包含 X.509 证书的文件 --ssl密码 连接加密的允许密码 --ssl-crl 包含证书吊销列表的文件 --ssl-crlpath 包含证书吊销列表文件的目录 --ssl-fips-模式 客户端是否开启FIPS模式 --ssl-密钥 包含 X.509 密钥的文件 --ssl模式 连接到服务器的所需安全状态 --ssl 会话数据 包含 SSL 会话数据的文件 8.0.29 --ssl-session-data-continue-on-failed-reuse session重用失败是否建立连接 8.0.29 --开始日期时间 从时间戳等于或晚于 datetime 参数的第一个事件读取二进制日志 --起始位置 从位置等于或大于参数的第一个事件解码二进制日志 --停止日期时间 在时间戳等于或大于 datetime 参数的第一个事件停止读取二进制日志 --永不停止 读取最后一个二进制日志文件后保持与服务器的连接 --stop-never-slave-server-id 连接到服务器时要报告的从属服务器 ID --停止位置 在位置等于或大于参数的第一个事件处停止解码二进制日志 --tls-密码套件 用于加密连接的允许的 TLSv1.3 密码套件 8.0.16 --tls-版本 加密连接允许的 TLS 协议 --to-last-日志 不要在 MySQL 服务器请求的二进制日志末尾停止，而是继续打印到最后一个二进制日志的末尾 - 用户 连接到服务器时使用的 MySQL 用户名 --冗长 将行事件重构为 SQL 语句 --verify-binlog-校验和 验证二进制日志中的校验和 - 版本 显示版本信息并退出 --zstd-压缩级别 使用 zstd 压缩的服务器连接的压缩级别 8.0.18 --help, -? 显示帮助信息并退出。
- --base64-output=value 此选项确定何时应使用 BINLOG语句将事件编码为 base-64 字符串。该选项具有以下允许值（不区分大小写）： AUTO("automatic") 或 UNSPEC("unspecified") BINLOG在必要时自动显示语句（即，对于格式描述事件和行事件）。如果没有 --base64-output 给出选项，效果与 --base64-output=AUTO. 笔记 BINLOG 如果您打算使用mysqlbinlog的输出重新执行二进制日志文件内容， 自动显示是唯一安全的行为。其他选项值仅用于调试或测试目的，因为它们可能会产生不包含可执行形式的所有事件的输出。
- NEVER导致 BINLOG不显示语句。如果发现必须使用BINLOG.
- DECODE-ROWS通过同时指定选项，向 mysqlbinlog指定您打算将行事件解码并显示为带注释的 SQL 语句 --verbose。与 一样NEVER， DECODE-ROWS禁止显示 BINLOG语句，但与 不同NEVER的是，如果发现行事件，它不会退出并报错。

            有关显示
            行事件输出的影响的示例，请参阅`--base64-output`第
            4.6.9.2 节，“mysqlbinlog 行事件显示”。
          `--verbose`

- --bind-address=ip_address 在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
- --binlog-row-event-max-size=N 命令行格式 --binlog-row-event-max-size=# 类型 数字 默认值 4294967040 最小值 256 最大值 18446744073709547520 指定基于行的二进制日志事件的最大大小（以字节为单位）。如果可能，行被分组为小于此大小的事件。该值应为 256 的倍数。默认值为 4GB。
- --character-sets-dir=dir_name 安装字符集的目录。请参阅 第 10.15 节，“字符集配置”。
- --compress 如果可能，压缩客户端和服务器之间发送的所有信息。请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.17 中添加的。从 MySQL 8.0.18 开始，它已被弃用。预计它会在 MySQL 的未来版本中被删除。请参阅 配置传统连接压缩。
- --compression-algorithms=value 允许的连接到服务器的压缩算法。可用算法与 protocol_compression_algorithms 系统变量相同。默认值为 uncompressed。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.18 中添加的。
- --connection-server-id=server_id --connection-server-id 指定mysqlbinlog 在连接到服务器时报告的服务器 ID。它可用于避免与副本服务器或另一个 mysqlbinlog进程的 ID 发生冲突。 如果 --read-from-remote-server 指定该选项，mysqlbinlog报告服务器 ID 为 0，这告诉服务器在发送最后一个日志文件后断开连接（非阻塞行为）。如果 --stop-never还指定了该选项以保持与服务器的连接，则 mysqlbinlog默认报告服务器 ID 为 1 而不是 0，并且 --connection-server-id 可以在需要时用于替换该服务器 ID。请参阅 第 4.6.9.4 节，“指定 mysqlbinlog 服务器 ID”。
- --database=db_name, -d db_name 此选项导致mysqlbinlog从二进制日志（仅限本地日志）输出条目，这些条目在db_name被选为默认数据库时发生USE。 mysqlbinlog 的--database选项类似于 mysqld的选项 ，但只能用于指定一个数据库。如果 多次给出，则仅使用最后一个实例。 --binlog-do-db--database 此选项的效果取决于使用的是基于语句的还是基于行的日志记录格式，就像 的效果 --binlog-do-db取决于使用的是基于语句还是基于行的日志记录一样。 基于语句的日志记录。 该--database选项的工作原理如下： 虽然db_name是默认数据库，但无论是修改数据库中的表db_name还是其他数据库中的表，都会输出语句。
- 除非db_name选择为默认数据库，否则不会输出语句，即使它们修改了 db_name.
- CREATE DATABASE、ALTER DATABASE和 除外DROP DATABASE。在确定是否输出语句时 ，正在 创建、更改或删除的数据库被认为是默认数据库。

            假设二进制日志是通过使用基于语句的日志记录执行这些语句创建的：

```sql
INSERT INTO test.t1 (i) VALUES(100);
INSERT INTO db2.t2 (j)  VALUES(200);
USE test;
INSERT INTO test.t1 (i) VALUES(101);
INSERT INTO t1 (i)      VALUES(102);
INSERT INTO db2.t2 (j)  VALUES(201);
USE db2;
INSERT INTO test.t1 (i) VALUES(103);
INSERT INTO db2.t2 (j)  VALUES(202);
INSERT INTO t2 (j)      VALUES(203);
```

            **mysqlbinlog --database=test**没有输出前两条`INSERT`
            语句，因为没有默认的数据库。它输出`INSERT`后面的三个语句`USE test`，但不输出后面的三个
            `INSERT`语句
            `USE db2`。

            **mysqlbinlog --database=db2**没有输出前两条`INSERT`
            语句，因为没有默认数据库。它不输出后面的三个`INSERT`
            语句
            `USE test`，但是输出`INSERT`
            后面的三个语句
            `USE db2`。

**基于行的日志记录。**
              **mysqlbinlog**仅输出更改属于
              *`db_name`*. 默认数据库对此没有影响。假设刚刚描述的二进制日志是使用基于行的日志记录而不是基于语句的日志记录创建的。**mysqlbinlog --database=test**仅输出那些`t1`在测试数据库中修改的条目，无论是否`USE`
              发布或默认数据库是什么。

            如果服务器运行时
            `binlog_format`设置为
            `MIXED`并且您希望它可以使用带有该
            选项的**mysqlbinlog**`--database` ，则必须确保修改的表位于 . 选择的数据库中`USE`。（特别是，不应使用跨数据库更新。）

`--rewrite-db`与选项

            一起使用时
            ，`--rewrite-db`优先应用选项；然后`--database`应用该选项，使用重写的数据库名称。提供选项的顺序在这方面没有区别。

- --debug[=debug_options], -# [debug_options] 写调试日志。典型的 debug_options字符串是 . 默认值为 。 d:t:o,file_named:t:o,/tmp/mysqlbinlog.trace 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --debug-check 程序退出时打印一些调试信息。 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --debug-info 程序退出时打印调试信息以及内存和 CPU 使用统计信息。 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --default-auth=plugin 关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
- --defaults-extra-file=file_name 在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果 file_name不是绝对路径名，则将其解释为相对于当前目录。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --defaults-file=file_name 仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果 file_name不是绝对路径名，则将其解释为相对于当前目录。 例外：即使有 --defaults-file，客户端程序也会读取.mylogin.cnf. 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --defaults-group-suffix=str 不仅要阅读通常的选项组，还要阅读具有通常名称和后缀 str. 例如， mysqlbinlog通常会读取 [client]和 [mysqlbinlog]组。如果此选项作为 给出 --defaults-group-suffix=_other， 则mysqlbinlog还会读取 [client_other]和 [mysqlbinlog_other]组。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --disable-log-bin, -D 禁用二进制日志记录。--to-last-log如果您使用该选项并将输出发送到同一个 MySQL 服务器，这对于避免无限循环很有用 。在意外退出后恢复时，此选项也很有用，以避免重复您记录的语句。 此选项导致mysqlbinlog在其输出中包含一条SET sql_log_bin = 0语句以禁用剩余输出的二进制日志记录。操作系统变量的会话值 sql_log_bin是受限制的操作，因此此选项要求您具有足够的权限来设置受限制的会话变量。请参阅第 5.1.9.1 节，“系统变量权限”。
- --exclude-gtids=gtid_set 不要显示 中列出的任何组 gtid_set。
- --force-if-open, -F 读取二进制日志文件，即使它们已打开或未正确关闭。
- --force-read, -f 使用此选项，如果mysqlbinlog读取了一个它无法识别的二进制日志事件，它会打印一条警告，忽略该事件并继续。如果没有此选项，mysqlbinlog会在读取此类事件时停止。
- --get-server-public-key 从服务器请求基于 RSA 密钥对的密码交换所需的公钥。此选项适用于使用 caching_sha2_password身份验证插件进行身份验证的客户端。对于该插件，除非请求，否则服务器不会发送公钥。对于未使用该插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。 如果 给出并指定一个有效的公钥文件，它优先于 . --server-public-key-path=file_name--get-server-public-key 有关 caching_sha2_password插件的信息，请参阅 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
- --hexdump, -H 在注释中显示日志的十六进制转储，如 第 4.6.9.1 节“mysqlbinlog 十六进制转储格式”中所述。十六进制输出有助于复制调试。
- --host=host_name, -h host_name 从给定主机上的 MySQL 服务器获取二进制日志。
- --idempotent 告诉 MySQL 服务器在处理更新时使用幂等模式；这会抑制服务器在处理更新时在当前会话中遇到的任何重复键或键未找到错误。每当需要或有必要将一个或多个二进制日志重播到 MySQL 服务器时，此选项可能会证明是有用的，而该服务器可能不包含日志所引用的所有数据。 此选项的影响范围仅包括当前的 mysqlbinlog客户端和会话。
- --include-gtids=gtid_set 仅显示 中列出的组 gtid_set。
- --local-load=dir_name, -l dir_name 对于 LOAD DATA语句对应的数据加载操作， mysqlbinlog从二进制日志事件中提取文件，将其作为临时文件写入本地文件系统，并写入 LOAD DATA LOCAL语句使文件加载。默认情况下，mysqlbinlog将这些临时文件写入特定于操作系统的目录。该--local-load选项可用于明确指定 mysqlbinlog应该准备本地临时文件的目录。 因为其他进程可以将文件写入默认的系统特定目录，所以建议为 mysqlbinlog--local-load指定选项以 指定数据文件的不同目录，然后 在处理 mysqlbinlog的输出时通过为mysql指定选项指定同一目录. 例如： --load-data-local-dir ```text mysqlbinlog --local-load=/my/local/data ... | mysql --load-data-local-dir=/my/local/data ... ``` 重要的 这些临时文件不会被 mysqlbinlog或任何其他 MySQL 程序自动删除。
- --login-path=name 从登录路径文件中指定的登录路径读取选项 .mylogin.cnf。“ 登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用 mysql_config_editor实用程序。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --no-defaults 不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败， --no-defaults可用于防止它们被读取。 例外情况是.mylogin.cnf 文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在 --no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用 mysql_config_editor实用程序。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --offset=N, -o N 跳过N日志中的第一个条目。
- --open-files-limit=N 指定要保留的打开文件描述符的数量。
- --password[=password], -p[password] 用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出， mysqlbinlog会提示输入一个。如果给定，则后面 的密码之间 不能有空格。如果未指定密码选项，则默认为不发送密码。 --password=-p 在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅 第 6.1.2.1 节，“密码安全的最终用户指南”。 要明确指定没有密码并且 mysqlbinlog不应提示输入密码，请使用该 --skip-password 选项。
- --plugin-dir=dir_name 在其中查找插件的目录。如果该 --default-auth选项用于指定身份验证插件但 mysqlbinlog未找到它，请指定此选项。请参阅 第 6.2.17 节，“可插入身份验证”。
- --port=port_num, -P port_num 用于连接到远程服务器的 TCP/IP 端口号。
- --print-defaults 打印程序名称和它从选项文件中获取的所有选项。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --print-table-metadata 从二进制日志中打印与表相关的元数据。配置使用记录的表相关元数据二进制文件的数量 binlog-row-metadata。
- --protocol={TCP|SOCKET|PIPE|MEMORY} 用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅 第 4.2.7 节“连接传输协议”。
- --raw 默认情况下，mysqlbinlog读取二进制日志文件并以文本格式写入事件。该 --raw选项告诉 mysqlbinlog以其原始二进制格式写入它们。它的使用要求 --read-from-remote-server 也被使用，因为文件是从服务器请求的。 mysqlbinlog为从服务器读取的每个文件写入一个输出文件。该 --raw选项可用于备份服务器的二进制日志。使用该 --stop-never选项，备份是“实时”的，因为 mysqlbinlog保持与服务器的连接。默认情况下，输出文件以与原始日志文件相同的名称写入当前目录。可以使用该 --result-file选项修改输出文件名。有关详细信息，请参阅 第 4.6.9.3 节，“使用 mysqlbinlog 备份二进制日志文件”。
- --read-from-remote-source=type 从 MySQL 8.0.26 开始，使用 --read-from-remote-source，在 MySQL 8.0.26 之前，使用 --read-from-remote-master. 这两个选项具有相同的效果。通过将选项值分别设置为或 ，这些选项使用COM_BINLOG_DUMP或 COM_BINLOG_DUMP_GTID命令 从 MySQL 服务器读取二进制日志 。如果 or 与 结合使用 ，则可以在源上过滤掉事务，避免不必要的网络流量。 BINLOG-DUMP-NON-GTIDSBINLOG-DUMP-GTIDS--read-from-remote-source=BINLOG-DUMP-GTIDS--read-from-remote-master=BINLOG-DUMP-GTIDS--exclude-gtids 连接参数选项与这些选项或 --read-from-remote-server 选项一起使用。这些选项是 --host、 --password、 --port、 --protocol、 --socket和 --user。如果未指定任何远程选项，则忽略连接参数选项。 使用这些REPLICATION SLAVE 选项需要权限。
- --read-from-remote-master=type 在 MySQL 8.0.26 之前使用此选项而不是 --read-from-remote-source. 这两个选项具有相同的效果。
- --read-from-remote-server, -R 从 MySQL 服务器读取二进制日志，而不是读取本地日志文件。此选项要求远程服务器正在运行。它仅适用于远程服务器上的二进制日志文件，不适用于中继日志文件。 连接参数选项与此选项或 --read-from-remote-master 选项一起使用。这些选项是 --host、 --password、 --port、 --protocol、 --socket和 --user。如果未指定任何远程选项，则忽略连接参数选项。 使用REPLICATION SLAVE 此选项需要权限。 这个选项就像 --read-from-remote-master=BINLOG-DUMP-NON-GTIDS.
- --result-file=name, -r name 如果没有该--raw 选项，该选项指示 mysqlbinlog将文本输出写入到的文件。使用 --raw， mysqlbinlog为从服务器传输的每个日志文件写入一个二进制输出文件，默认情况下将它们写入当前目录，使用与原始日志文件相同的名称。在这种情况下， --result-file选项值被视为修改输出文件名的前缀。
- --require-row-format 要求事件的基于行的二进制日志记录格式。此选项为mysqlbinlog输出强制执行基于行的复制事件 。使用此选项生成的事件流将被复制通道接受，该复制通道使用 语句（来自 MySQL 8.0.23）或语句（MySQL 8.0.23 之前）的REQUIRE_ROW_FORMAT选项进行 保护。 必须在写入二进制日志的服务器上设置。当您指定此选项时，如果mysqlbinlog遇到任何在 限制下不允许的事件，包括错误消息，它会停止并显示一条错误消息，包括CHANGE REPLICATION SOURCE TOCHANGE MASTER TObinlog_format=ROWREQUIRE_ROW_FORMATLOAD DATA INFILE 指令、创建或删除临时表、 INTVAR、RAND或 USER_VAR事件，以及 DML 事务中的非基于行的事件。mysqlbinlog 还在其输出的开头打印一条SET @@session.require_row_format语句以在执行输出时应用限制，并且不打印该SET @@session.pseudo_thread_id语句。 这个选项是在 MySQL 8.0.19 中添加的。
- --rewrite-db='from_name->to_name' 从基于行或基于语句的日志中读取时，重写所有出现的 from_nameto to_name。对于基于行的日志，重写是在行上完成的，对于基于 USE语句的日志，重写是在子句上完成的。 警告 使用此选项时，不会重写表名使用数据库名限定的语句以使用新名称。 用作此选项值的重写规则是一个具有形式的字符串 ，如前所示，因此必须用引号括起来。 'from_name->to_name' 要使用多个重写规则，请多次指定该选项，如下所示： ```text mysqlbinlog --rewrite-db='dbcurrent->dbold' --rewrite-db='dbtest->dbcurrent' \ binlog.00001 > /tmp/statements.sql ``` --database与选项 一起使用时 ，--rewrite-db优先应用选项；然后 --database应用选项，使用重写的数据库名称。提供选项的顺序在这方面没有区别。 这意味着，例如，如果 mysqlbinlog以 开头 ，则对数据库中 --rewrite-db='mydb->yourdb' --database=yourdb任何表的所有更新都包含在输出中。另一方面，如果它以 开始 ，则 mysqlbinlog根本不输出任何语句：因为在应用该选项之前，首先将对的所有更新重写为对的更新，因此没有匹配 的更新。 mydbyourdb--rewrite-db='mydb->yourdb' --database=mydbmydbyourdb--database--database=mydb
- --server-id=id 仅显示由具有给定服务器 ID 的服务器创建的那些事件。
- --server-id-bits=N 仅使用 的前N几位 server_id来标识服务器。如果二进制日志是由 mysqld写入的，其server-id-bits 设置为小于 32，并且用户数据存储在最高有效位中，则运行设置 为 32 的mysqlbinlog--server-id-bits可以看到此数据。 此选项仅受 NDB Cluster 发行版提供或使用 NDB Cluster 支持构建 的mysqlbinlog版本支持。
- --server-public-key-path=file_name PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。此选项适用于使用 sha256_password或 caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。 如果 给出并指定一个有效的公钥文件，它优先于 . --server-public-key-path=file_name--get-server-public-key 对于sha256_password，此选项仅适用于使用 OpenSSL 构建 MySQL 的情况。 有关sha256_password 和caching_sha2_password插件的信息，请参阅 第 6.4.1.3 节，“SHA-256 可插入身份验证”和 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
- --set-charset=charset_name 在输出中添加一条语句以指定用于处理日志文件的字符集。 SET NAMES charset_name
- --shared-memory-base-name=name 在 Windows 上，用于使用共享内存与本地服务器建立连接的共享内存名称。默认值为MYSQL。共享内存名称区分大小写。 仅当服务器启动时 shared_memory启用了支持共享内存连接的系统变量时，此选项才适用。
- --short-form, -s 仅显示日志中包含的语句，没有任何额外信息或基于行的事件。这仅用于测试，不应在生产系统中使用。它已被弃用，您应该期望它会在未来的版本中被删除。
- --skip-gtids[=(true|false)] 不要在输出转储文件中包含二进制日志文件中的 GTID。例如： ```text mysqlbinlog --skip-gtids binlog.000001 > /tmp/dump.sql mysql -u root -p -e "source /tmp/dump.sql" ``` 您通常不应在生产或恢复中使用此选项，除非在特定且罕见的情况下 GTID 主动不需要。例如，管理员可能希望将选定的事务（例如表定义）从一个部署复制到另一个不相关的部署，该部署不会复制到原始部署或从原始部署复制。在这种情况下， --skip-gtids 可用于使管理员能够像处理新事务一样应用事务，并确保部署保持无关。但是，只有在包含 GTID 导致您的用例出现已知问题时，您才应使用此选项。
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

- --start-datetime=datetime 在时间戳等于或晚于 datetime参数的第一个事件开始读取二进制日志。该 datetime值相对于您运行 mysqlbinlog的机器上的本地时区。该值应采用 DATETIME或 TIMESTAMP数据类型可接受的格式。例如： ```text mysqlbinlog --start-datetime="2005-12-25 11:25:56" binlog.000003 ``` 此选项对于时间点恢复很有用。请参阅 第 7.5 节，“时间点（增量）恢复”。
- --start-position=N, -j N 在日志 position 开始解码二进制日志 N，包括在输出中开始于 positionN 或之后的任何事件。该位置是日志文件中的一个字节点，而不是事件计数器；它需要指向事件的起始位置以生成有用的输出。此选项适用于在命令行上命名的第一个日志文件。 此选项对于时间点恢复很有用。请参阅 第 7.5 节，“时间点（增量）恢复”。
- --stop-datetime=datetime 在时间戳等于或晚于 datetime参数的第一个事件处停止读取二进制日志。--start-datetime有关该值的信息， 请参阅选项的描述 datetime。 此选项对于时间点恢复很有用。请参阅 第 7.5 节，“时间点（增量）恢复”。
- --stop-never 此选项与 一起使用 --read-from-remote-server。它告诉mysqlbinlog保持与服务器的连接。否则 ，当最后一个日志文件从服务器传输时，mysqlbinlog退出。--stop-never 暗示--to-last-log，因此只需要在命令行上命名要传输的第一个日志文件。 --stop-never通常用于--raw制作实时二进制日志备份，但也可用于 --raw在服务器生成日志事件时不维护日志事件的连续文本显示。 使用--stop-never，默认情况下，mysqlbinlog在连接到服务器时报告服务器 ID 为 1。用于 --connection-server-id 明确指定要报告的替代 ID。它可用于避免与副本服务器或另一个mysqlbinlog进程的 ID 发生冲突。请参阅 第 4.6.9.4 节，“指定 mysqlbinlog 服务器 ID”。
- --stop-never-slave-server-id=id 此选项已弃用；希望在未来的版本中将其删除。使用该 --connection-server-id 选项来指定 mysqlbinlog报告的服务器 ID。
- --stop-position=N 在日志 position 停止解码二进制日志 ，从输出中排除在 position 或之后N开始的任何事件。N该位置是日志文件中的一个字节点，而不是事件计数器；它需要指向要包含在输出中的最后一个事件的起始位置之后的位置。在该位置之前开始 N并在该位置或之后结束的事件是要处理的最后一个事件。此选项适用于在命令行中命名的最后一个日志文件。 此选项对于时间点恢复很有用。请参阅 第 7.5 节，“时间点（增量）恢复”。
- --tls-ciphersuites=ciphersuite_list 使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅 第 6.3.2 节，“加密连接 TLS 协议和密码”。 这个选项是在 MySQL 8.0.16 中添加的。
- --tls-version=protocol_list 加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅 第 6.3.2 节，“加密连接 TLS 协议和密码”。
- --to-last-log, -t 不要在 MySQL 服务器请求的二进制日志结束时停止，而是继续打印直到最后一个二进制日志结束。如果将输出发送到同一个 MySQL 服务器，这可能会导致死循环。此选项需要 --read-from-remote-server.
- --user=user_name, -u user_name 连接到远程服务器时要使用的 MySQL 帐户的用户名。 如果您将Rewriter插件与 MySQL 8.0.31 或更高版本一起使用，则应授予此用户 SKIP_QUERY_REWRITE权限。
- --verbose, -v 重建行事件并将它们显示为带注释的 SQL 语句，并在适用时包含表分区信息。如果此选项给出两次（通过传入“-vv”或“--verbose --verbose”），则输出包括指示列数据类型和一些元数据的注释，以及信息日志事件，例如行查询日志事件，如果binlog_rows_query_log_events 系统变量设置为 TRUE。 有关显示 行事件输出的影响的示例，请参阅--base64-output第 4.6.9.2 节，“mysqlbinlog 行事件显示”。 --verbose
- --verify-binlog-checksum, -c 验证二进制日志文件中的校验和。
- --version, -V 显示版本信息并退出。 使用此选项时显示的mysqlbinlog版本号为 3.4。
- --zstd-compression-level=level 用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认 zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.18 中添加的。

**您可以将mysqlbinlog**
        的输出通过管道传输到**mysql**客户端，以执行二进制日志中包含的事件。当您有旧备份时，此技术用于从意外退出中恢复（请参阅
        第 7.5 节，“时间点（增量）恢复”）。例如：

```text
mysqlbinlog binlog.000001 | mysql -u root -p
```

        或者：

```text
mysqlbinlog binlog.[0-9]* | mysql -u root -p
```

**如果mysqlbinlog**
        产生的语句可能包含`BLOB`值，这些可能会导致**mysql**处理它们时出现问题。在这种情况下，使用
        选项
      调用**mysql 。**`--binary-mode`

如果您需要先修改语句日志（例如，删除出于某种原因不想执行的语句），您也可以将**mysqlbinlog**
        的输出重定向
        到文本文件。**编辑文件后，通过将其用作mysql**程序
      的输入来执行其中包含的语句：

```text
mysqlbinlog binlog.000001 > tmpfile
... edit tmpfile ...
mysql -u root -p “将我的数据库前滚到今天上午 10:30 的状态”）。

**处理多个文件。**
          如果要在 MySQL 服务器上执行多个二进制日志，安全的方法是使用到服务器的单个连接来处理它们。这是一个演示可能*不安全*的示例：

```text
mysqlbinlog binlog.000001 | mysql -u root -p # DANGER!!
mysqlbinlog binlog.000002 | mysql -u root -p # DANGER!!
```

`CREATE TEMPORARY TABLE`如果第一个日志文件包含一个语句而第二个日志包含一个使用临时表的语句，那么使用与
        服务器的多个连接以这种方式处理二进制日志会导致问题
        。当第一个
        **mysql**进程终止时，服务器会删除临时表。当第二个**mysql**
        进程尝试使用该表时，服务器报告
        “未知表。”

        为避免此类问题，请使用*单个*
        **mysql**进程执行所有要处理的二进制日志的内容。这是一种方法：

```text
mysqlbinlog binlog.000001 binlog.000002 | mysql -u root -p
```

        另一种方法是将所有日志写入单个文件，然后处理该文件：

```text
mysqlbinlog binlog.000001 >  /tmp/statements.sql
mysqlbinlog binlog.000002 >> /tmp/statements.sql
mysql -u root -p -e "source /tmp/statements.sql"
```

        从 MySQL 8.0.12 开始，您还可以使用 shell 管道将多个二进制日志文件作为流式输入提供给**mysqlbinlog 。**压缩二进制日志文件的存档可以解压缩并直接提供给
        **mysqlbinlog**。在本例中，
        `binlog-files_1.gz`包含多个二进制日志文件进行处理。管道提取 的内容
        `binlog-files_1.gz`，将二进制日志文件通过管道传输到**mysqlbinlog**作为标准输入，并将**mysqlbinlog**的输出通过管道传输到
        **mysql**客户端执行：

```text
gzip -cd binlog-files_1.gz | ./mysqlbinlog - | ./mysql -uroot  -p
```

        您可以指定多个归档文件，例如：

```text
gzip -cd binlog-files_1.gz binlog-files_2.gz | ./mysqlbinlog - | ./mysql -uroot  -p
```

        对于流式输入，不要使用
        `--stop-position`，因为
        **mysqlbinlog**无法识别应用此选项的最后一个日志文件。

**加载数据操作。**
          **mysqlbinlog**可以产生在`LOAD DATA`
          没有原始数据文件的情况下重现操作的输出。
          **mysqlbinlog**将数据复制到临时文件并写入
          `LOAD DATA LOCAL`引用该文件的语句。写入这些文件的目录的默认位置是系统特定的。要明确指定目录，请使用该
          `--local-load`选项。

        由于**mysqlbinlog**将
        `LOAD DATA`语句转换为
        `LOAD DATA LOCAL`语句（即添加
        `LOCAL`），因此您用于处理语句的客户端和服务器都必须配置为启用该
        `LOCAL`功能。请参阅
        第 6.1.6 节，“LOAD DATA LOCAL 的安全注意事项”。

警告

`LOAD DATA LOCAL`为语句
          创建的临时文件
          *不会*
          自动删除，因为在您实际执行这些语句之前需要它们。不再需要语句日志后，您应该自行删除临时文件。这些文件可以在临时文件目录中找到，名称类似于
          *`original_file_name-#-#`*.

---

[← 返回 第 4 章 MySQL 程序 索引](00-index.md) · [← 返回总索引](../00-index.md)
