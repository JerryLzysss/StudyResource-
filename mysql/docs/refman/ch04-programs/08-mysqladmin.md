# 第 4 章 MySQL 程序 · mysqladmin

> 对应 SQL：[`sql/refman/ch04-programs/08-mysqladmin.sql`](../../../sql/refman/ch04-programs/08-mysqladmin.sql)

---

4.5.2 mysqladmin——一个 MySQL 服务器管理程序_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 4 章 MySQL 程序 / 4.5 客户端程序 / 4.5.2 mysqladmin——一个 MySQL 服务器管理程序 mysqladmin是执行管理操作的客户端。您可以使用它来检查服务器的配置和当前状态、创建和删除数据库等等。 像这样调用mysqladmin： ```text mysqladmin [options] command [command-arg] [command [command-arg]] ... ``` mysqladmin支持以下命令。一些命令在命令名称后带有一个参数。 create db_name 创建一个名为 db_name.
- debug 在 MySQL 8.0.20 之前，告诉服务器将调试信息写入错误日志。连接的用户必须具有SUPER权限。此信息的格式和内容可能会发生变化。 这包括有关事件调度​​程序的信息。请参阅 第 25.4.5 节，“事件调度程序状态”。
- drop db_name 删除名为的数据库db_name 及其所有表。
- extended-status 显示服务器状态变量及其值。
- flush-hosts 刷新主机缓存中的所有信息。请参阅 第 5.1.12.3 节，“DNS 查找和主机缓存”。
- flush-logs [log_type ...] 刷新所有日志。 mysqladmin flush-logs命令允许提供可选 的日志类型，以指定要刷新的日志。在命令之后， flush-logs您可以提供以下一种或多种日志类型的空格分隔 列表：binary、、、、、、、 。这些对应于可以为SQL 语句指定的日志类型。 engineerrorgeneralrelayslowFLUSH LOGS
- flush-privileges 重新加载授权表（与 相同reload）。
- flush-status 清除状态变量。
- flush-tables 刷新所有表。
- flush-threads 刷新线程缓存。
- kill id,id,... 杀死服务器线程。如果给出了多个线程 ID 值，则列表中不能有空格。 要终止属于其他用户的线程，连接的用户必须具有 CONNECTION_ADMIN特权（或已弃用的SUPER 特权）。
- password new_password 设置新密码。这会将密码更改 new_password为您使用mysqladmin连接到服务器的帐户。因此，下次您 使用同一帐户 调用mysqladmin （或任何其他客户端程序）时，您必须指定新密码。 警告 使用mysqladmin 设置密码 应该被认为是不安全的。在某些系统上，您的密码对系统状态程序（例如ps ）可见，其他用户可能会调用这些程序来显示命令行。MySQL 客户端通常在初始化序列期间用零覆盖命令行密码参数。但是，仍然有一个短暂的时间间隔，在此期间该值是可见的。此外，在某些系统上，这种覆盖策略是无效的，密码仍然对ps可见. （SystemV Unix 系统和其他系统可能会遇到这个问题。） 如果该new_password值包含空格或您的命令解释器特有的其他字符，您需要将其括在引号内。在 Windows 上，一定要使用双引号而不是单引号；单引号不会从密码中删除，而是被解释为密码的一部分。例如： ```text mysqladmin password "my new password" ``` 命令后可以省略新密码 password。在这种情况下， mysqladmin会提示输入密码值，这使您能够避免在命令行上指定密码。仅当mysqladmin命令行password上的最后一个命令时才应省略密码值。否则，将下一个参数作为密码。 警告 --skip-grant-tables如果服务器是使用该选项 启动的，请不要使用此命令 。不应用密码更改。即使您在同一命令行上的命令之前password重新 flush-privileges启用授权表也是如此，因为刷新操作发生在您连接之后。但是，您可以使用 mysqladmin flush-privileges重新启用授权表，然后使用单独的 mysqladmin password命令更改密码。
- ping 检查服务器是否可用。如果服务器正在运行，则mysqladmin的返回状态为 0，否则为 1。即使出现诸如 之类的错误，这也是 0 Access denied，因为这意味着服务器正在运行但拒绝连接，这与服务器未运行不同。
- processlist 显示活动服务器线程的列表。这就像SHOW PROCESSLIST语句的输出。如果 --verbose给出该选项，则输出类似于 SHOW FULL PROCESSLIST. （请参阅 第 13.7.7.29 节，“SHOW PROCESSLIST 语句”。）
- reload 重新加载授权表。
- refresh 刷新所有表并关闭和打开日志文件。
- shutdown 停止服务器。
- start-replica 在副本服务器上开始复制。从 MySQL 8.0.26 使用此命令。
- start-slave 在副本服务器上开始复制。在 MySQL 8.0.26 之前使用此命令。
- status 显示简短的服务器状态消息。
- stop-replica 停止副本服务器上的复制。从 MySQL 8.0.26 使用此命令。
- stop-slave 停止副本服务器上的复制。在 MySQL 8.0.26 之前使用此命令。
- variables 显示服务器系统变量及其值。
- version 显示来自服务器的版本信息。

        所有命令都可以缩短为任何唯一的前缀。例如：

```text
$> mysqladmin proc stat
+----+-------+-----------+----+---------+------+-------+------------------+
| Id | User  | Host      | db | Command | Time | State | Info             |
+----+-------+-----------+----+---------+------+-------+------------------+
| 51 | jones | localhost |    | Query   | 0    |       | show processlist |
+----+-------+-----------+----+---------+------+-------+------------------+
Uptime: 1473624  Threads: 1  Questions: 39487
Slow queries: 0  Opens: 541  Flush tables: 1
Open tables: 19  Queries per second avg: 0.0268
```

**mysqladmin status**命令结果显示以下值

        ：

- Uptime MySQL 服务器已运行的秒数。
- Threads 活动线程（客户端）的数量。
- Questions 自服务器启动以来来自客户端的问题（查询）数。
- Slow queries 花费超过 long_query_time秒数的查询数。请参阅第 5.4.5 节，“慢速查询日志”。
- Opens 服务器已打开的表数。
- Flush tables flush-*服务器已执行的、 refresh和reload 命令的 数量。
- Open tables 当前打开的表数。

        如果在使用 Unix 套接字文件连接到本地服务器时
        执行**mysqladmin shutdown ，****mysqladmin**会等待服务器的进程 ID 文件被删除，以确保服务器已正确停止。

        **mysqladmin**支持以下选项，可以在命令行或

        选项文件的组中指定`[mysqladmin]`。`[client]`有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。

**表 4.12 mysqladmin 选项**

| 选项名称 | 描述 | 介绍 | 弃用 |
| --- | --- | --- | --- |
| --绑定地址 | 使用指定的网络接口连接到 MySQL 服务器 |  |  |
| - 压缩 | 压缩客户端和服务器之间发送的所有信息 |  | 8.0.18 |
| --压缩算法 | 允许的服务器连接压缩算法 | 8.0.18 |  |
| --连接超时 | 连接超时前的秒数 |  |  |
| - 数数 | 重复命令执行的迭代次数 |  |  |
| --调试 | 写调试日志 |  |  |
| --调试检查 | 程序退出时打印调试信息 |  |  |
| - 调试信息 | 程序退出时打印调试信息、内存和 CPU 统计信息 |  |  |
| --default-auth | 要使用的身份验证插件 |  |  |
| --默认字符集 | 指定默认字符集 |  |  |
| --defaults-extra-file | 除了通常的选项文件外，还读取命名的选项文件 |  |  |
| --defaults-文件 | 只读命名选项文件 |  |  |
| --defaults-group-suffix | 选项组后缀值 |  |  |
| --启用明文插件 | 启用明文身份验证插件 |  |  |
| - 力量 | 即使出现 SQL 错误也继续 |  |  |
| --get-server-public-key | 从服务器请求 RSA 公钥 |  |  |
| - 帮助 | 显示帮助信息并退出 |  |  |
| - 主持人 | MySQL 服务器所在的主机 |  |  |
| --登录路径 | 从 .mylogin.cnf 读取登录路径选项 |  |  |
| --无哔声 | 发生错误时不发出蜂鸣声 |  |  |
| --no-defaults | 不读取选项文件 |  |  |
| - 密码 | 连接到服务器时使用的密码 |  |  |
| --密码1 | 连接到服务器时使用的第一个多因素身份验证密码 | 8.0.27 |  |
| --密码2 | 连接到服务器时使用的第二个多因素身份验证密码 | 8.0.27 |  |
| --密码3 | 连接到服务器时使用的第三个多重身份验证密码 | 8.0.27 |  |
| - 管道 | 使用命名管道连接到服务器（仅限 Windows） |  |  |
| --插件目录 | 安装插件的目录 |  |  |
| - 港口 | 用于连接的 TCP/IP 端口号 |  |  |
| --print-defaults | 打印默认选项 |  |  |
| - 协议 | 使用的传输协议 |  |  |
| - 相对的 | 与 --sleep 选项一起使用时显示当前值和先前值之间的差异 |  |  |
| --server-public-key-path | 包含 RSA 公钥的文件的路径名 |  |  |
| --shared-memory-base-name | 共享内存连接的共享内存名称（仅限 Windows） |  |  |
| --显示警告 | 语句执行后显示警告 |  |  |
| --关机超时 | 等待服务器关闭的最大秒数 |  |  |
| - 沉默的 | 静音模式 |  |  |
| - 睡觉 | 重复执行命令，中间休眠 delay 秒 |  |  |
| - 插座 | 要使用的 Unix 套接字文件或 Windows 命名管道 |  |  |
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
| --tls-密码套件 | 用于加密连接的允许的 TLSv1.3 密码套件 | 8.0.16 |  |
| --tls-版本 | 加密连接允许的 TLS 协议 |  |  |
| - 用户 | 连接到服务器时使用的 MySQL 用户名 |  |  |
| --冗长 | 详细模式 |  |  |
| - 版本 | 显示版本信息并退出 |  |  |
| - 垂直的 | 垂直打印查询输出行（每列值一行） |  |  |
| - 等待 | 如果无法建立连接，请等待并重试而不是中止 |  |  |
| --zstd-压缩级别 | 使用 zstd 压缩的服务器连接的压缩级别 | 8.0.18 |  |

- --help, -? 显示帮助信息并退出。
- --bind-address=ip_address 在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
- --character-sets-dir=dir_name 安装字符集的目录。请参阅 第 10.15 节，“字符集配置”。
- --compress, -C 如果可能，压缩客户端和服务器之间发送的所有信息。请参阅 第 4.2.8 节，“连接压缩控制”。 从 MySQL 8.0.18 开始，不推荐使用此选项。预计它会在 MySQL 的未来版本中被删除。请参阅 配置传统连接压缩。
- --compression-algorithms=value 允许的连接到服务器的压缩算法。可用算法与 protocol_compression_algorithms 系统变量相同。默认值为 uncompressed。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.18 中添加的。
- --connect-timeout=value 连接超时前的最大秒数。默认值为 43200（12 小时）。
- --count=N, -c N --sleep 如果给出选项，则 重复命令执行的迭代次数。
- --debug[=debug_options], -# [debug_options] 写调试日志。典型的 debug_options字符串是 . 默认值为 。 d:t:o,file_named:t:o,/tmp/mysqladmin.trace 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --debug-check 程序退出时打印一些调试信息。 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --debug-info 程序退出时打印调试信息以及内存和 CPU 使用统计信息。 仅当 MySQL 是使用 WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是 使用此选项构建的。
- --default-auth=plugin 关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
- --default-character-set=charset_name 用作charset_name默认字符集。请参阅第 10.15 节，“字符集配置”。
- --defaults-extra-file=file_name 在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果 file_name不是绝对路径名，则将其解释为相对于当前目录。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --defaults-file=file_name 仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果 file_name不是绝对路径名，则将其解释为相对于当前目录。 例外：即使有 --defaults-file，客户端程序也会读取.mylogin.cnf. 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --defaults-group-suffix=str 不仅要阅读通常的选项组，还要阅读具有通常名称和后缀 str. 例如， mysqladmin通常会读取 [client]和 [mysqladmin]组。如果此选项作为 给出 --defaults-group-suffix=_other， 则mysqladmin还会读取 [client_other]和 [mysqladmin_other]组。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --enable-cleartext-plugin 启用mysql_clear_password明文身份验证插件。（请参阅 第 6.4.1.4 节，“客户端明文可插入身份验证”。）
- --force, -f 不要要求确认命令。对于多个命令，即使发生错误也要继续。 drop db_name
- --get-server-public-key 从服务器请求基于 RSA 密钥对的密码交换所需的公钥。此选项适用于使用 caching_sha2_password身份验证插件进行身份验证的客户端。对于该插件，除非请求，否则服务器不会发送公钥。对于未使用该插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。 如果 给出并指定一个有效的公钥文件，它优先于 . --server-public-key-path=file_name--get-server-public-key 有关 caching_sha2_password插件的信息，请参阅 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
- --host=host_name, -h host_name 连接到给定主机上的 MySQL 服务器。
- --login-path=name 从登录路径文件中指定的登录路径读取选项 .mylogin.cnf。“ 登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用 mysql_config_editor实用程序。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --no-beep, -b 抑制默认情况下针对连接服务器失败等错误发出的警告蜂鸣声。
- --no-defaults 不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败， --no-defaults可用于防止它们被读取。 例外情况是.mylogin.cnf 文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在 --no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用 mysql_config_editor实用程序。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --password[=password], -p[password] 用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出， mysqladmin会提示输入一个。如果给定，则后面 的密码之间 不能有空格。如果未指定密码选项，则默认为不发送密码。 --password=-p 在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅 第 6.1.2.1 节，“密码安全的最终用户指南”。 要明确指定没有密码并且 mysqladmin不应提示输入密码，请使用该 --skip-password 选项。
- --password1[=pass_val] 用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出， mysql会提示输入一个。如果给定，则后面的密码和密码之间 不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。 在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅 第 6.1.2.1 节，“密码安全的最终用户指南”。 要明确指定没有密码并且 mysqladmin不应提示输入密码，请使用该 --skip-password1 选项。 --password1and --password是同义词，就像 --skip-password1 and 一样--skip-password。
- --password2[=pass_val] 用于连接到服务器的 MySQL 帐户的多因素身份验证因子 2 的密码。此选项的语义类似于 ; 的语义 --password1。有关详细信息，请参阅该选项的说明。
- --password3[=pass_val] 用于连接服务器的 MySQL 帐户的多重身份验证因子 3 的密码。此选项的语义类似于 ; 的语义 --password1。有关详细信息，请参阅该选项的说明。
- --pipe, -W 在 Windows 上，使用命名管道连接到服务器。仅当服务器启动时 named_pipe启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是 named_pipe_full_access_group 系统变量指定的 Windows 组的成员。
- --plugin-dir=dir_name 在其中查找插件的目录。如果该 --default-auth选项用于指定身份验证插件但 mysqladmin未找到它，请指定此选项。请参阅 第 6.2.17 节，“可插入身份验证”。
- --port=port_num, -P port_num 对于 TCP/IP 连接，要使用的端口号。
- --print-defaults 打印程序名称和它从选项文件中获取的所有选项。 有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
- --protocol={TCP|SOCKET|PIPE|MEMORY} 用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅 第 4.2.7 节“连接传输协议”。
- --relative, -r --sleep与选项 一起使用时显示当前值和先前值之间的差异 。此选项仅适用于 extended-status命令。
- --server-public-key-path=file_name PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。此选项适用于使用 sha256_password或 caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。 如果 给出并指定一个有效的公钥文件，它优先于 . --server-public-key-path=file_name--get-server-public-key 对于sha256_password，此选项仅适用于使用 OpenSSL 构建 MySQL 的情况。 有关sha256_password 和caching_sha2_password插件的信息，请参阅 第 6.4.1.3 节，“SHA-256 可插入身份验证”和 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
- --shared-memory-base-name=name 在 Windows 上，用于使用共享内存与本地服务器建立连接的共享内存名称。默认值为MYSQL。共享内存名称区分大小写。 仅当服务器启动时 shared_memory启用了支持共享内存连接的系统变量时，此选项才适用。
- --show-warnings 显示因执行发送到服务器的语句而产生的警告。
- --shutdown-timeout=value 等待服务器关闭的最大秒数。默认值为 3600（1 小时）。
- --silent, -s 如果无法建立与服务器的连接，则静默退出。
- --sleep=delay, -i delay 重复执行命令， delay中间休眠几秒钟。该 --count选项确定迭代次数。如果 --count没有给出， mysqladmin会无限期地执行命令直到被中断。
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
- --verbose, -v 详细模式。打印有关程序功能的更多信息。
- --version, -V 显示版本信息并退出。
- --vertical, -E 垂直打印输出。这类似于 --relative，但垂直打印输出。
- --wait[=count], -w[count] 如果无法建立连接，请等待并重试，而不是中止。如果count 给定一个值，它表示重试的次数。默认为一次。
- --zstd-compression-level=level 用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认 zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个选项是在 MySQL 8.0.18 中添加的。

---

[← 返回 第 4 章 MySQL 程序 索引](00-index.md) · [← 返回总索引](../00-index.md)
