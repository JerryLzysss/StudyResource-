# 第 5 章 MySQL 服务器管理 · 状态变量

> 对应 SQL：[`sql/refman/ch05-server-administration/05-server-status-variables.sql`](../../../sql/refman/ch05-server-administration/05-server-status-variables.sql)

---

5.1.10 服务器状态变量_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 5 章 MySQL 服务器管理 / 5.1 MySQL 服务器 / 5.1.10 服务器状态变量 MySQL 服务器维护许多提供有关其操作信息的状态变量。SHOW [GLOBAL | SESSION] STATUS您可以使用语句查看这些变量及其值（请参阅第 13.7.7.37 节，“SHOW STATUS 语句”）。可选GLOBAL关键字聚合所有连接的值，并SESSION显示当前连接的值。 ```sql mysql> SHOW GLOBAL STATUS; +-----------------------------------+------------+ | Variable_name | Value | +-----------------------------------+------------+ | Aborted_clients | 0 | | Aborted_connects | 0 | | Bytes_received | 155372598 | | Bytes_sent | 1176560426 | ... | Connections | 30023 | | Created_tmp_disk_tables | 0 | | Created_tmp_files | 3 | | Created_tmp_tables | 2 | ... | Threads_created | 217 | | Threads_running | 88 | | Uptime | 1389872 | +-----------------------------------+------------+ ``` FLUSH STATUS该语句 将许多状态变量重置为 0 。 本节提供了每个状态变量的描述。有关状态变量摘要，请参阅 第 5.1.6 节，“服务器状态变量参考”。有关特定于 NDB Cluster 的状态变量的信息，请参阅 第 23.4.3.9.3 节，“NDB Cluster 状态变量”。 状态变量具有以下含义。 Aborted_clients 由于客户端未正确关闭连接而终止的连接数。请参阅 第 B.3.2.9 节，“通信错误和中止连接”。
- Aborted_connects 连接到 MySQL 服务器的失败尝试次数。请参阅第 B.3.2.9 节，“通信错误和中止连接”。 有关其他连接相关信息，请检查 状态变量和 表格。 Connection_errors_xxxhost_cache
- Authentication_ldap_sasl_supported_methods 实现 SASL LDAP 身份验证的authentication_ldap_sasl插件支持多种身份验证方法，但根据主机系统配置，它们可能并非全部可用。该 Authentication_ldap_sasl_supported_methods 变量为支持的方法提供可发现性。它的值是由空格分隔的受支持方法名称组成的字符串。例子："SCRAM-SHA 1 SCRAM-SHA-256 GSSAPI" 这个变量是在 MySQL 8.0.21 中添加的。
- Binlog_cache_disk_use 使用临时二进制日志缓存但超过值 binlog_cache_size并使用临时文件存储来自事务的语句的事务数。 Binlog_stmt_cache_disk_use 在状态变量 中单独跟踪导致二进制日志事务缓存写入磁盘的非事务语句的数量 。
- Acl_cache_items_count 缓存的特权对象的数量。每个对象都是用户及其活动角色的权限组合。
- Binlog_cache_use 使用二进制日志缓存的事务数。
- Binlog_stmt_cache_disk_use 使用二进制日志语句缓存但超过值 binlog_stmt_cache_size并使用临时文件存储这些语句的非事务语句数。
- Binlog_stmt_cache_use 使用二进制日志语句缓存的非事务语句数。
- Bytes_received 从所有客户端接收的字节数。
- Bytes_sent 发送给所有客户端的字节数。
- Caching_sha2_password_rsa_public_key caching_sha2_password身份验证插件用于基于 RSA 密钥对的密码交换的公钥 。 caching_sha2_password_private_key_path 仅当服务器成功初始化由和 caching_sha2_password_public_key_path 系统变量命名的文件中的私钥和公钥时，该值才为非空 。的值 Caching_sha2_password_rsa_public_key 来自后一个文件。
- Com_xxx 语句计数器变量指示每个 语句已执行 的次数。每种类型的语句都有一个状态变量。例如，and count 和 statements 分别。and 类似但适用于 使用多表语法 的and 语句。Com_xxxxxxCom_deleteCom_updateDELETEUPDATECom_delete_multiCom_update_multiDELETEUPDATE 即使准备好的语句参数未知或在执行期间发生错误， 所有变量都会增加。换句话说，它们的值对应于发出的请求数，而不是成功完成的请求数。例如，由于状态变量在每次服务器启动时都会初始化，并且不会在重新启动后持续存在， 因此跟踪和 语句的和 变量 的值通常为零，但如果或 语句已执行但失败 ，则可以为非零值 。Com_stmt_xxxCom_restartCom_shutdownRESTARTSHUTDOWNRESTARTSHUTDOWN 状态变量如下 ：Com_stmt_xxx Com_stmt_prepare
- Com_stmt_execute
- Com_stmt_fetch
- Com_stmt_send_long_data
- Com_stmt_reset
- Com_stmt_close

          这些变量代表准备好的语句命令。它们的名称指的
          是网络层中使用的命令集。换句话说，只要执行准备好的语句 API 调用（例如
          **mysql_stmt_prepare()**、
           **mysql_stmt_execute()**等），它们的值就会增加。但是，和
          也
          分别增加
          、
          或
          。此外，旧语句计数器变量、
          和
          的值随着
          、
          和
          `COM_xxx`********`Com_stmt_prepare``Com_stmt_execute``Com_stmt_close``PREPARE``EXECUTE``DEALLOCATE PREPARE``Com_prepare_sql``Com_execute_sql``Com_dealloc_sql``PREPARE``EXECUTE``DEALLOCATE PREPARE`声明。
          `Com_stmt_fetch`代表从游标中获取时发出的网络往返总数。

          `Com_stmt_reprepare`指示语句被服务器自动重新准备的次数，例如，在元数据更改语句引用的表或视图之后。重新准备操作递增
          `Com_stmt_reprepare`, 并且
          `Com_stmt_prepare`.

          `Com_explain_other`指示
          `EXPLAIN FOR CONNECTION`执行的语句数。请参阅
          第 8.8.4 节，“获取命名连接的执行计划信息”。

          `Com_change_repl_filter`指示`CHANGE REPLICATION FILTER`
          执行的语句数。

- Compression 客户端连接是否使用客户端/服务器协议中的压缩。 从 MySQL 8.0.18 开始，不推荐使用此状态变量；希望在未来的 MySQL 版本中将其删除。请参阅 配置传统连接压缩。
- Compression_algorithm 用于当前服务器连接的压缩算法的名称。该值可以是 protocol_compression_algorithms 系统变量值中允许的任何算法。例如，该值是 uncompressed连接是否使用压缩，或者zlib连接是否使用zlib算法。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个变量是在 MySQL 8.0.18 中添加的。
- Compression_level 用于当前服务器连接的压缩级别。连接数为 6 zlib（默认zlib算法压缩级别），连接数为 1 到 22，zstd连接数为 0 uncompressed。 有关更多信息，请参阅 第 4.2.8 节，“连接压缩控制”。 这个变量是在 MySQL 8.0.18 中添加的。
- Connection_errors_xxx 这些变量提供有关客户端连接过程中发生的错误的信息。它们仅是全局的，代表来自所有主机的跨连接聚合的错误计数。这些变量跟踪主机缓存未考虑的错误（请参阅第 5.1.12.3 节，“DNS 查找和主机缓存”），例如与 TCP 连接无关的错误，发生在连接过程的早期（甚至在连接之前） IP 地址是已知的），或者不特定于任何特定的 IP 地址（例如内存不足的情况）。 Connection_errors_accept accept()在侦听端口上 调用期间发生的错误数 。
- Connection_errors_internal 由于服务器内部错误（例如无法启动新线程或内存不足情况）而被拒绝的连接数。
- Connection_errors_max_connections 由于 max_connections达到服务器限制而拒绝的连接数。
- Connection_errors_peer_address 搜索连接客户端 IP 地址时发生的错误数。
- Connection_errors_select select()在调用侦听端口期间或poll() 在侦听端口上 发生的错误数 。（此操作失败并不一定意味着客户端连接被拒绝。）
- Connection_errors_tcpwrap 库拒绝的连接数 libwrap。

- Connections 尝试连接到 MySQL 服务器的次数（成功与否）。
- Created_tmp_disk_tables 服务器在执行语句时创建的内部磁盘临时表的数量。 Created_tmp_disk_tables您可以通过比较和 Created_tmp_tables值 来比较创建的内部磁盘临时表的数量与创建的内部临时表的总数 。 笔记 由于已知限制， Created_tmp_disk_tables 不计算在内存映射文件中创建的磁盘临时表。默认情况下，TempTable 存储引擎溢出机制会在内存映射文件中创建内部临时表。此行为 temptable_use_mmap 由默认启用的变量控制。 另见第 8.4.4 节，“MySQL 中的内部临时表使用”。
- Created_tmp_files mysqld创建了 多少个临时文件。
- Created_tmp_tables 服务器在执行语句时创建的内部临时表的数量。 Created_tmp_disk_tables您可以通过比较和 Created_tmp_tables值 来比较创建的内部磁盘临时表的数量与创建的内部临时表的总数 。 另见第 8.4.4 节，“MySQL 中的内部临时表使用”。 语句的每次调用都SHOW STATUS使用内部临时表并递增全局 Created_tmp_tables值。
- Current_tls_ca ssl_ca服务器用于新连接的 SSL 上下文中 的活动值。ssl_ca如果系统变量已更改但 ALTER INSTANCE RELOAD TLS随后尚未执行以从上下文相关的系统变量值重新配置 SSL 上下文并更新相应的状态变量，则此上下文值可能与当前 系统变量值不同。（这种潜在的值差异适用于每对对应的上下文相关系统和状态变量。请参阅 服务器端运行时配置和加密连接监控。） 这个变量是在 MySQL 8.0.16 中添加的。 从 MySQL 8.0.21 开始， 状态变量值也可以通过 Performance Schema 表获得。请参阅 第 27.12.21.8 节，“tls_channel_status 表”。 Current_tls_xxxtls_channel_status
- Current_tls_capath ssl_capath服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Current_tls_cert ssl_cert服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Current_tls_cipher ssl_cipher服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Current_tls_ciphersuites tls_ciphersuites 服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Current_tls_crl ssl_crl服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。 笔记 当您重新加载 TLS 上下文时，OpenSSL 会重新加载包含 CRL（证书撤销列表）的文件作为该过程的一部分。如果 CRL 文件很大，服务器会分配一大块内存（文件大小的十倍），在加载新实例而旧实例尚未释放时内存会加倍。释放大量分配后，进程驻留内存不会立即减少，因此如果您ALTER INSTANCE RELOAD TLS使用大型 CRL 文件重复发出该语句，进程驻留内存使用量可能会因此增加。
- Current_tls_crlpath ssl_crlpath服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Current_tls_key ssl_key服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Current_tls_version tls_version服务器用于新连接的 TSL 上下文中 的活动值。该状态变量与其对应的系统变量的关系说明见 的说明 Current_tls_ca。 这个变量是在 MySQL 8.0.16 中添加的。
- Delayed_errors 此状态变量已弃用（因为 DELAYED不支持插入）；希望在未来的版本中将其删除。
- Delayed_insert_threads 此状态变量已弃用（因为 DELAYED不支持插入）；希望在未来的版本中将其删除。
- Delayed_writes 此状态变量已弃用（因为 DELAYED不支持插入）；希望在未来的版本中将其删除。
- dragnet.Status 最近一次分配给 dragnet.log_error_filter_rules 系统变量的结果，如果没有发生这样的分配则为空。 这个变量是在 MySQL 8.0.12 中添加的。
- Error_log_buffered_bytes error_logPerformance Schema表 中当前使用的字节数 。值可能会减小，例如，如果新事件在丢弃旧事件之前无法容纳，但新事件小于旧事件。 此变量是在 MySQL 8.0.22 中添加的。
- Error_log_buffered_events error_logPerformance Schema表 中当前存在的事件数。与 一样 Error_log_buffered_bytes，该值可能会降低。 此变量是在 MySQL 8.0.22 中添加的。
- Error_log_expired_events 从 Performance Schema 表中丢弃的事件数， error_log以便为新事件腾出空间。 此变量是在 MySQL 8.0.22 中添加的。
- Error_log_latest_write 最后一次写入 Performance Schema error_log表的时间。 此变量是在 MySQL 8.0.22 中添加的。
- Flush_commands 服务器刷新表的次数，无论是因为用户执行FLUSH TABLES 语句还是由于内部服务器操作。它也随着COM_REFRESH 数据包的接收而增加。这与 相反 ，后者表示已执行Com_flush了多少条语句，是否、等等。 FLUSHFLUSH TABLESFLUSH LOGS
- Global_connection_memory 所有用户连接到服务器所使用的内存。系统线程或MySQL root账户使用的内存包含在总数中，但此类线程或用户不会因内存使用而断开连接。global_connection_memory_tracking 除非启用（默认情况下禁用），否则不会计算此内存 。还必须启用性能模式。 您可以通过设置 来（间接地）控制更新此变量的频率 connection_memory_chunk_size。 Global_connection_memory状态变量是在 MySQL 8.0.28 中引入的 。
- group_replication_primary_member 当组在单主模式下运行时显示主要成员的 UUID。如果组在多主模式下运行，则显示空字符串。 status 变量已弃用，group_replication_primary_member并计划在未来版本中删除。
- Handler_commit 内部COMMIT 语句的数量。
- Handler_delete 从表中删除行的次数。
- Handler_external_lock 服务器会在每次调用其 external_lock()函数时递增此变量，这通常发生在访问表实例的开始和结束时。存储引擎之间可能存在差异。例如，此变量可用于发现访问分区表的语句在发生锁定之前修剪了多少分区：检查计数器为该语句增加了多少，减去 2（对表本身调用 2），然后除以 2 以获得锁定的分区数。
- Handler_mrr_init 服务器使用存储引擎自己的多范围读取实现来访问表的次数。
- Handler_prepare 两阶段提交操作的准备阶段的计数器。
- Handler_read_first 索引中第一个条目被读取的次数。如果此值很高，则表明服务器正在执行大量完整索引扫描（例如SELECT col1 FROM foo，假设col1已建立索引）。
- Handler_read_key 基于键读取行的请求数。如果此值很高，则很好地表明您的表已针对您的查询正确建立索引。
- Handler_read_last 读取索引中最后一个键的请求数。使用 ORDER BY时，服务器发出第一个键请求，然后发出几个下一个键请求，而使用 ORDER BY DESC，服务器发出最后一个键请求，然后发出几个上一个键请求。
- Handler_read_next 按键顺序读取下一行的请求数。如果您正在查询具有范围约束的索引列或者您正在执行索引扫描，则此值会递增。
- Handler_read_prev 按键顺序读取上一行的请求数。这种读方法主要是用来优化ORDER BY ... DESC的。
- Handler_read_rnd 基于固定位置读取一行的请求数。如果您正在执行大量需要对结果进行排序的查询，则此值很高。您可能有很多查询需要 MySQL 扫描整个表，或者您有没有正确使用键的连接。
- Handler_read_rnd_next 读取数据文件中下一行的请求数。如果您正在进行大量表扫描，则此值会很高。通常，这表明您的表未正确编制索引，或者您的查询未编写为利用您拥有的索引。
- Handler_rollback 存储引擎执行回滚操作的请求数。
- Handler_savepoint 存储引擎放置保存点的请求数。
- Handler_savepoint_rollback 存储引擎回滚到保存点的请求数。
- Handler_update 更新表中一行的请求数。
- Handler_write 在表中插入行的请求数。
- Innodb_buffer_pool_dump_status 记录缓冲池中页面的 操作的进度， 由or 的设置触发 。 InnoDB innodb_buffer_pool_dump_at_shutdowninnodb_buffer_pool_dump_now 有关相关信息和示例，请参阅 第 15.8.3.6 节，“保存和恢复缓冲池状态”。
- Innodb_buffer_pool_load_status 通过读取一组 对应于较早时间点 的页面来预热InnoDB 缓冲池的 操作的进度， 由 或 的设置触发。如果该操作引入过多开销，您可以通过设置取消它 。 innodb_buffer_pool_load_at_startupinnodb_buffer_pool_load_nowinnodb_buffer_pool_load_abort 有关相关信息和示例，请参阅 第 15.8.3.6 节，“保存和恢复缓冲池状态”。
- Innodb_buffer_pool_bytes_data 包含数据的InnoDB 缓冲池中 的总字节数。该数字包括 脏页和干净页。为了比使用更准确的内存使用计算 Innodb_buffer_pool_pages_data，当压缩表导致缓冲池保存不同大小的页面时。
- Innodb_buffer_pool_pages_data 缓冲池中包含数据 的页数。 该数字包括 脏页和干净页。使用压缩表时，报告的 值可能大于 （错误#59550）。 InnoDB Innodb_buffer_pool_pages_dataInnodb_buffer_pool_pages_total
- Innodb_buffer_pool_bytes_dirty 缓冲池中脏页中 保存的当前总字节数 。为了比使用更准确的内存使用计算 ，当压缩表导致缓冲池保存不同大小的页面时。 InnoDB Innodb_buffer_pool_pages_dirty
- Innodb_buffer_pool_pages_dirty 缓冲池中的 当前脏页数。 InnoDB
- Innodb_buffer_pool_pages_flushed 从 缓冲池刷新 页面 的请求数 。 InnoDB
- Innodb_buffer_pool_pages_free 缓冲池中的 空闲页数。 InnoDB
- Innodb_buffer_pool_pages_latched 缓冲池中 锁定的页数 。这些是当前正在读取或写入的页面，或者由于某些其他原因无法 刷新或删除的页面。这个变量的计算是昂贵的，所以它只有在 系统在服务器构建时定义时才可用。 InnoDB UNIV_DEBUG
- Innodb_buffer_pool_pages_misc 缓冲池中因管理开销（例如行锁或 自适应散列索引）而被分配而忙碌 的页数。 该值也可以计算为 - - 。使用压缩表时， 可能会报告越界值（错误 #59550）。 InnoDB Innodb_buffer_pool_pages_totalInnodb_buffer_pool_pages_freeInnodb_buffer_pool_pages_dataInnodb_buffer_pool_pages_misc
- Innodb_buffer_pool_pages_total InnoDB 缓冲池 的总大小，以 页为单位。使用 压缩表时，报告的 Innodb_buffer_pool_pages_data 值可能大于 Innodb_buffer_pool_pages_total （错误＃59550）
- Innodb_buffer_pool_read_ahead 预读后台线程 读 入缓冲池 的页数。InnoDB
- Innodb_buffer_pool_read_ahead_evicted 由 预读后台线程 读入缓冲池 的页数，这些页随后在未被查询访问的情况下被 逐出。InnoDB
- Innodb_buffer_pool_read_ahead_rnd 发起 的“随机”预读 的数量InnoDB。当查询以随机顺序扫描表的大部分时，就会发生这种情况。
- Innodb_buffer_pool_read_requests 逻辑读请求的数量。
- Innodb_buffer_pool_reads 从缓冲池中InnoDB 无法满足 的逻辑读取数，不得不直接从磁盘读取。
- Innodb_buffer_pool_resize_status 动态调整 InnoDB 缓冲池innodb_buffer_pool_size大小的操作的状态，通过动态设置 参数 触发 。该 innodb_buffer_pool_size 参数是动态的，它允许您在不重新启动服务器的情况下调整缓冲池的大小。有关相关信息， 请参阅 在线配置 InnoDB 缓冲池大小。
- Innodb_buffer_pool_resize_status_code 报告用于跟踪在线缓冲池大小调整操作的状态代码。每个状态代码代表调整大小操作中的一个阶段。状态码包括： 0：没有正在进行的调整大小操作
- 1：开始调整大小
- 2：禁用AHI（自适应哈希索引）
- 3：提取区块
- 4：获取全局锁
- 5：调整池大小
- 6：调整哈希大小
- 7：调整大小失败

          您可以结合使用此状态变量
          `Innodb_buffer_pool_resize_status_progress`
          来跟踪调整大小操作的每个阶段的进度。该
          `Innodb_buffer_pool_resize_status_progress`
          变量报告一个百分比值，指示当前阶段的进度。

          有关详细信息，请参阅
          监控在线缓冲池大小调整进度。

- Innodb_buffer_pool_resize_status_progress 报告一个百分比值，指示在线缓冲池大小调整操作的当前阶段的进度。此变量与 一起使用 Innodb_buffer_pool_resize_status_code，它报告指示在线缓冲池大小调整操作的当前阶段的状态代码。 在处理每个缓冲池实例后更新百分比值。随着状态代码（由 报告 Innodb_buffer_pool_resize_status_code）从一种状态变为另一种状态，百分比值将重置为 0。 有关相关信息，请参阅 监控在线缓冲池大小调整进度。
- Innodb_buffer_pool_wait_free 通常，写入InnoDB 缓冲池发生在后台。当InnoDB需要读取或创建页面而没有可用的干净页面时，先InnoDB刷新一些 脏页面并等待该操作完成。该计数器计算这些等待的实例。如果 innodb_buffer_pool_size设置得当，这个值应该很小。
- Innodb_buffer_pool_write_requests 写入InnoDB 缓冲池的次数。
- Innodb_data_fsyncs fsync()到目前为止 的操作数。调用频率fsync()受 innodb_flush_method 配置选项设置的影响。 fdatasync()如果innodb_use_fdatasync启用 ，计算操作数。
- Innodb_data_pending_fsyncs 当前挂起的fsync() 操作数。调用频率fsync()受 innodb_flush_method 配置选项设置的影响。
- Innodb_data_pending_reads 当前挂起的读取数。
- Innodb_data_pending_writes 当前挂起的写入数。
- Innodb_data_read 自服务器启动以来读取的数据量（以字节为单位）。
- Innodb_data_reads 数据读取总数（操作系统文件读取）。
- Innodb_data_writes 数据写入总数。
- Innodb_data_written 到目前为止写入的数据量，以字节为单位。
- Innodb_dblwr_pages_written 已写入 双写缓冲区 的页数。请参阅第 15.11.1 节，“InnoDB 磁盘 I/O”。
- Innodb_dblwr_writes 已执行的双写操作数。请参阅第 15.11.1 节，“InnoDB 磁盘 I/O”。
- Innodb_have_atomic_builtins 指示服务器是否使用 原子指令构建。
- Innodb_log_waits 日志缓冲区太小而需要等待刷新才能继续的 次数 。
- Innodb_log_write_requests InnoDB 重做日志 的写请求数。
- Innodb_log_writes 物理写入InnoDB 重做日志文件的次数。
- Innodb_num_open_files InnoDB当前打开 的文件数。
- Innodb_os_log_fsyncs fsync()写入 InnoDB 重做日志文件 的次数。
- Innodb_os_log_pending_fsyncs 重做日志文件 的未决fsync()操作数。InnoDB
- Innodb_os_log_pending_writes InnoDB 对重做日志文件 的未决写入数。
- Innodb_os_log_written 写入InnoDB 重做日志文件的字节数。
- Innodb_page_size InnoDB页面大小（默认 16KB）。许多值以页数计算；页面大小使它们可以轻松转换为字节。
- Innodb_pages_created InnoDB对表 的操作创建的页数 。
- Innodb_pages_read 通过对表 InnoDB 的操作从缓冲池中 读取的页数。InnoDB
- Innodb_pages_written 表操作写入的页数 InnoDB。
- Innodb_redo_log_enabled 重做日志记录是启用还是禁用。请参阅 禁用重做日志记录。 这个变量是在 MySQL 8.0.21 中添加的。
- Innodb_redo_log_capacity_resized 在上次完成容量调整大小操作后，所有重做日志文件的总重做日志容量（以字节为单位）。该值包括普通和备用重做日志文件。 如果没有挂起的调整大小缩小操作， Innodb_redo_log_capacity_resized 应该等于 innodb_redo_log_capacity 设置。调整大小操作是即时的。 有关相关信息，请参阅 第 15.6.5 节，“重做日志”。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_checkpoint_lsn 重做日志检查点 LSN。有关相关信息，请参阅 第 15.6.5 节，“重做日志”。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_current_lsn 当前 LSN 表示重做日志缓冲区中最后写入的位置。InnoDB在请求操作系统将数据写入当前重做日志文件之前，将数据写入 MySQL 进程内部的重做日志缓冲区。有关相关信息，请参阅 第 15.6.5 节，“重做日志”。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_flushed_to_disk_lsn 刷新到磁盘的 LSN。InnoDB首先将数据写入重做日志，然后请求操作系统将数据刷新到磁盘。刷新到磁盘的 LSN 表示重做日志中 InnoDB知道已刷新到磁盘的最后一个位置。有关相关信息，请参阅第 15.6.5 节，“重做日志”。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_logical_size 一个数据大小值，以字节为单位，表示包含正在使用的重做日志数据的 LSN 范围，从重做日志消费者所需的最旧块到最新写入的块。有关相关信息，请参阅 第 15.6.5 节，“重做日志”。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_physical_size 磁盘上所有重做日志文件当前占用的磁盘空间量（以字节为单位，不包括备用重做日志文件）。有关相关信息，请参阅第 15.6.5 节，“重做日志”。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_read_only 重做日志是否只读。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_redo_log_resize_status 重做日志调整大小状态指示重做日志容量调整机制的当前状态。可能的值包括： OK：没有问题，也没有挂起的重做日志容量调整操作。
- Resizing down：正在进行缩小操作。

          调整大小操作是即时的，因此没有挂起状态。

          这个变量是在 MySQL 8.0.30 中添加的。

- Innodb_redo_log_uuid 重做日志 UUID。 这个变量是在 MySQL 8.0.30 中添加的。
- Innodb_row_lock_current_waits 表上的操作当前等待 的行锁 数InnoDB。
- Innodb_row_lock_time 为 表获取行锁 所花费的总时间 InnoDB，以毫秒为单位。
- Innodb_row_lock_time_avg 获取 表行锁 的平均时间 InnoDB，以毫秒为单位。
- Innodb_row_lock_time_max 获取 表行锁 的最长时间 InnoDB，以毫秒为单位。
- Innodb_row_lock_waits 表上的操作InnoDB 必须等待行锁的次数。
- Innodb_rows_deleted InnoDB 从表 中删除的行数。
- Innodb_rows_inserted 插入InnoDB 表中的行数。
- Innodb_rows_read InnoDB从表 中读取的行数。
- Innodb_rows_updated 表中更新的行数InnoDB 。
- Innodb_system_rows_deleted InnoDB 从属于系统创建的模式的表 中删除的行数。
- Innodb_system_rows_inserted 插入到InnoDB 属于系统创建的模式的表中的行数。
- Innodb_system_rows_read InnoDB从属于系统创建的模式的表 中读取的行数。
- Innodb_truncated_status_writes 语句输出的次数SHOW ENGINE INNODB STATUS被截断。
- Innodb_undo_tablespaces_active 活动撤消表空间的数量。包括隐式（InnoDB创建的）和显式（用户创建的）撤消表空间。有关撤消表空间的信息，请参阅第 15.6.3.4 节，“撤消表空间”。
- Innodb_undo_tablespaces_explicit 用户创建的撤消表空间的数量。有关撤消表空间的信息，请参阅 第 15.6.3.4 节，“撤消表空间”。
- Innodb_undo_tablespaces_implicit 所创建的撤消表空间的数量 InnoDB。两个默认的撤销表空间是在InnoDBMySQL 实例初始化时创建的。有关撤消表空间的信息，请参阅 第 15.6.3.4 节，“撤消表空间”。
- Innodb_undo_tablespaces_total 撤消表空间的总数。包括隐式（InnoDB创建的）和显式（用户创建的）撤消表空间，活动的和非活动的。有关撤消表空间的信息，请参阅 第 15.6.3.4 节，“撤消表空间”。
- Key_blocks_not_flushed MyISAM键缓存中已更改但尚未刷新到磁盘 的键块数。
- Key_blocks_unused MyISAM 键缓存 中未使用的块数。您可以使用此值来确定使用了多少密钥缓存；请参阅 第 5.1.8 节“服务器系统变量”key_buffer_size中 的讨论。
- Key_blocks_used MyISAM键缓存 中使用的块数。该值是一个高水位线，表示一次使用过的块的最大数量。
- Key_read_requests MyISAM从密钥缓存 中读取密钥块的请求数 。
- Key_reads 将密钥块从磁盘物理读取到 MyISAM密钥缓存中的次数。如果 Key_reads很大，那么您的key_buffer_size值可能太小了。缓存未命中率可以计算为 Key_reads/ Key_read_requests。
- Key_write_requests 将密钥块写入 MyISAM密钥缓存的请求数。
- Key_writes 将密钥块从 MyISAM密钥缓存物理写入磁盘的次数。
- Last_query_cost 查询优化器计算的最后编译查询的总成本。这对于比较同一查询的不同查询计划的成本很有用。默认值 0 表示尚未编译任何查询。默认值为 0。Last_query_cost具有会话范围。 在 MySQL 8.0.16 及更高版本中，此变量显示具有多个查询块的查询的成本，将每个查询块的成本估计相加，估计执行了多少次不可缓存的子查询，并将这些查询块的成本乘以子查询执行的次数。（Bug #92766，Bug #28786951）在 MySQL 8.0.16 之前， Last_query_cost仅针对简单的“扁平”查询进行准确计算，但对于包含子查询或 UNION. （对于后者，该值设置为 0。）
- Last_query_partial_plans 查询优化器在前一个查询的执行计划构造中进行的迭代次数。 Last_query_cost有会话范围。
- Locked_connects 尝试连接到锁定的用户帐户的次数。有关帐户锁定和解锁的信息，请参阅 第 6.2.20 节，“帐户锁定”。
- Max_execution_time_exceeded SELECT超过执行超时 的语句数。
- Max_execution_time_set SELECT设置了非零执行超时 的语句数。这包括包含非零 MAX_EXECUTION_TIME优化器提示的语句，以及不包含此类提示但在 max_execution_time系统变量指示的超时为非零时执行的语句。
- Max_execution_time_set_failed SELECT尝试设置执行超时失败 的语句数。
- Max_used_connections 自服务器启动以来同时使用的最大连接数。
- Max_used_connections_time Max_used_connections达到其当前值 的时间 。
- Not_flushed_delayed_rows 此状态变量已弃用（因为 DELAYED不支持插入）；希望在未来的版本中将其删除。
- mecab_charset MeCab 全文解析器插件当前使用的字符集。有关相关信息，请参阅 第 12.10.9 节，“MeCab 全文解析器插件”。
- Ongoing_anonymous_transaction_count 显示已标记为匿名的正在进行的交易数量。这可用于确保没有其他交易在等待处理。
- Ongoing_anonymous_gtid_violating_transaction_count 此状态变量仅在调试版本中可用。显示使用 gtid_next=ANONYMOUS和违反 GTID 一致性的正在进行的事务数。
- Ongoing_automatic_gtid_violating_transaction_count 此状态变量仅在调试版本中可用。显示使用 gtid_next=AUTOMATIC和违反 GTID 一致性的正在进行的事务数。
- Open_files 打开的文件数。此计数包括服务器打开的常规文件。它不包括其他类型的文件，例如套接字或管道。此外，该计数不包括存储引擎使用自己的内部功能而不是要求服务器级别打开的文件。
- Open_streams 打开的流数（主要用于日志记录）。
- Open_table_definitions 缓存表定义的数量。
- Open_tables 打开的表数。
- Opened_files my_open()使用（mysys 库函数） 打开的文件数 。不使用此功能打开文件的服务器部分不会增加计数。
- Opened_table_definitions 已缓存的表定义数。
- Opened_tables 已打开的表数。如果 Opened_tables很大，则您的 table_open_cache值可能太小。
- Performance_schema_xxx 性能模式状态变量在第 27.16 节，“性能模式状态变量” 中列出 。这些变量提供有关由于内存限制而无法加载或创建的检测的信息。
- Prepared_stmt_count 当前准备好的语句数。（最大语句数由 max_prepared_stmt_count 系统变量给出。）
- Queries 服务器执行的语句数。与变量不同，此变量包括在存储程序中执行的语句Questions。它不计算COM_PING或 COM_STATISTICS命令。 本节开头的讨论指出了如何将此语句计数状态变量与其他此类变量相关联。
- Questions 服务器执行的语句数。Queries与变量不同，这仅包括客户端发送到服务器的语句，而不包括在存储程序中执行的语句 。此变量不计算COM_PING、 COM_STATISTICS、 COM_STMT_PREPARE、 COM_STMT_CLOSE或 COM_STMT_RESET命令。 本节开头的讨论指出了如何将此语句计数状态变量与其他此类变量相关联。
- Replica_open_temp_tables 从 MySQL 8.0.26 开始，使用 Replica_open_temp_tables代替 Slave_open_temp_tables，该版本已弃用。在 MySQL 8.0.26 之前的版本中，使用 Slave_open_temp_tables. Replica_open_temp_tables 显示复制 SQL 线程当前打开的临时表的数量。如果该值大于零，关闭副本是不安全的；参见 第 17.5.1.31 节，“复制和临时表”。此变量报告所有复制通道 的打开临时表的总数 。
- Replica_rows_last_search_algorithm_used 从 MySQL 8.0.26 开始，使用 Replica_rows_last_search_algorithm_used 代替 Slave_rows_last_search_algorithm_used，该版本已弃用。在 MySQL 8.0.26 之前的版本中，使用 Slave_rows_last_search_algorithm_used. Replica_rows_last_search_algorithm_used 显示了该副本最近使用的搜索算法来定位基于行的复制的行。结果显示副本是否使用索引、表扫描或散列作为在任何通道上执行的最后一个事务的搜索算法。 使用的方法取决于 slave_rows_search_algorithms 系统变量的设置（现已弃用）以及相关表上可用的键。 此变量仅适用于 MySQL 的调试版本。
- Resource_group_supported 是否支持资源组特性。 在某些平台或 MySQL 服务器配置上，资源组不可用或有限制。特别是，对于某些安装方法，Linux 系统可能需要手动步骤。有关详细信息，请参阅 资源组限制。
- Rpl_semi_sync_master_clients 半同步副本的数量。 Rpl_semi_sync_master_clientsrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_clients 则可用。
- Rpl_semi_sync_master_net_avg_wait_time 源等待副本回复的平均时间（以微秒为单位）。此变量始终为0, 并且已弃用；希望它在未来的版本中被删除。 Rpl_semi_sync_master_net_avg_wait_timerpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_net_avg_wait_time 则可用。
- Rpl_semi_sync_master_net_wait_time 源等待副本回复的总时间（以微秒为单位）。此变量始终为0, 并且已弃用；希望它在未来的版本中被删除。 Rpl_semi_sync_master_net_wait_timerpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_net_wait_time 则可用。
- Rpl_semi_sync_master_net_waits 源等待副本回复的总次数。 Rpl_semi_sync_master_net_waitsrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_net_waits 则可用。
- Rpl_semi_sync_master_no_times 源关闭半同步复制的次数。 Rpl_semi_sync_master_no_timesrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_no_times 则可用。
- Rpl_semi_sync_master_no_tx 副本未成功确认的提交数。 Rpl_semi_sync_master_no_txrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_no_tx 则可用。
- Rpl_semi_sync_master_status 半同步复制当前是否在源上运行。该值是ON插件是否已启用并且已发生提交确认。如果OFF插件未启用或源由于提交确认超时而退回到异步复制。 Rpl_semi_sync_master_statusrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_status 则可用。
- Rpl_semi_sync_master_timefunc_failures 源在调用时间函数时失败的次数，例如gettimeofday(). Rpl_semi_sync_master_timefunc_failuresrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_timefunc_failures 则可用。
- Rpl_semi_sync_master_tx_avg_wait_time 源等待每个事务的平均时间（以微秒为单位）。 Rpl_semi_sync_master_tx_avg_wait_timerpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_tx_avg_wait_time 则可用。
- Rpl_semi_sync_master_tx_wait_time 源等待事务的总时间（以微秒为单位）。 Rpl_semi_sync_master_tx_wait_timerpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_tx_wait_time 则可用。
- Rpl_semi_sync_master_tx_waits 源等待事务的总次数。 Rpl_semi_sync_master_tx_waitsrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_tx_waits 则可用。
- Rpl_semi_sync_master_wait_pos_backtraverse 源等待二进制坐标低于先前等待事件的事件的总次数。当事务开始等待回复的顺序与其二进制日志事件的写入顺序不同时，就会发生这种情况。 Rpl_semi_sync_master_wait_pos_backtraverserpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_wait_pos_backtraverse 则可用。
- Rpl_semi_sync_master_wait_sessions 当前等待副本回复的会话数。 Rpl_semi_sync_master_wait_sessionsrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_wait_sessions 则可用。
- Rpl_semi_sync_master_yes_tx 副本成功确认的提交数。 Rpl_semi_sync_master_yes_txrpl_semi_sync_master 在副本上安装了( semisync_master.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_source 插件（semisync_source.so库）， Rpl_semi_sync_source_yes_tx 则可用。
- Rpl_semi_sync_source_clients 半同步副本的数量。 Rpl_semi_sync_source_clientsrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_clients 则可用。
- Rpl_semi_sync_source_net_avg_wait_time 源等待副本回复的平均时间（以微秒为单位）。此变量始终为0, 并且已弃用；希望它在未来的版本中被删除。 Rpl_semi_sync_source_net_avg_wait_timerpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_net_avg_wait_time 则可用。
- Rpl_semi_sync_source_net_wait_time 源等待副本回复的总时间（以微秒为单位）。此变量始终为0, 并且已弃用；希望它在未来的版本中被删除。 Rpl_semi_sync_source_net_wait_timerpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_net_wait_time 则可用。
- Rpl_semi_sync_source_net_waits 源等待副本回复的总次数。 Rpl_semi_sync_source_net_waitsrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_net_waits 则可用。
- Rpl_semi_sync_source_no_times 源关闭半同步复制的次数。 Rpl_semi_sync_source_no_timesrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_no_times 则可用。
- Rpl_semi_sync_source_no_tx 副本未成功确认的提交数。 Rpl_semi_sync_source_no_txrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_no_tx 则可用。
- Rpl_semi_sync_source_status 半同步复制当前是否在源上运行。该值是ON插件是否已启用并且已发生提交确认。如果OFF插件未启用或源由于提交确认超时而退回到异步复制。 Rpl_semi_sync_source_statusrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_status 则可用。
- Rpl_semi_sync_source_timefunc_failures 源在调用时间函数时失败的次数，例如gettimeofday(). Rpl_semi_sync_source_timefunc_failuresrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_timefunc_failures 则可用。
- Rpl_semi_sync_source_tx_avg_wait_time 源等待每个事务的平均时间（以微秒为单位）。 Rpl_semi_sync_source_tx_avg_wait_timerpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_tx_avg_wait_time 则可用。
- Rpl_semi_sync_source_tx_wait_time 源等待事务的总时间（以微秒为单位）。 Rpl_semi_sync_source_tx_wait_timerpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_tx_wait_time 则可用。
- Rpl_semi_sync_source_tx_waits 源等待事务的总次数。 Rpl_semi_sync_source_tx_waitsrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_tx_waits 则可用。
- Rpl_semi_sync_source_wait_pos_backtraverse 源等待二进制坐标低于先前等待事件的事件的总次数。当事务开始等待回复的顺序与其二进制日志事件的写入顺序不同时，就会发生这种情况。 Rpl_semi_sync_source_wait_pos_backtraverserpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_wait_pos_backtraverse 则可用。
- Rpl_semi_sync_source_wait_sessions 当前等待副本回复的会话数。 Rpl_semi_sync_source_wait_sessionsrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_wait_sessions 则可用。
- Rpl_semi_sync_source_yes_tx 副本成功确认的提交数。 Rpl_semi_sync_source_yes_txrpl_semi_sync_source 在源上安装( semisync_source.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_master插件（semisync_master.so库）， Rpl_semi_sync_master_yes_tx 则可用。
- Rpl_semi_sync_replica_status 显示半同步复制当前是否在副本上运行。这是ON如果插件已启用并且复制 I/O（接收方）线程正在运行，OFF否则。 Rpl_semi_sync_replica_statusrpl_semi_sync_replica 在副本上安装了( semisync_replica.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_slave 插件（semisync_slave.so库）， Rpl_semi_sync_slave_status 则可用。
- Rpl_semi_sync_slave_status 显示半同步复制当前是否在副本上运行。这是ON如果插件已启用并且复制 I/O（接收方）线程正在运行，OFF否则。 Rpl_semi_sync_slave_statusrpl_semi_sync_slave 在副本上安装了( semisync_slave.solibrary ) 插件以设置半同步复制 时可用。如果安装了rpl_semi_sync_replica 插件（semisync_replica.so库）， Rpl_semi_sync_replica_status 则可用。
- Rsa_public_key 此变量的值是 sha256_password身份验证插件用于基于 RSA 密钥对的密码交换的公钥。sha256_password_private_key_path 仅当服务器成功初始化由和 sha256_password_public_key_path 系统变量命名的文件中的私钥和公钥时，该值才为非空 。的值 Rsa_public_key来自后一个文件。 有关 的信息sha256_password，请参阅 第 6.4.1.3 节，“SHA-256 可插入身份验证”。
- Secondary_engine_execution_count 卸载到辅助引擎的查询数。这个变量是在 MySQL 8.0.13 中添加的。 与 HeatWave 一起使用。请参阅MySQL HeatWave 用户指南。
- Select_full_join 由于不使用索引而执行表扫描的连接数。如果此值不为 0，则应仔细检查表的索引。
- Select_full_range_join 在引用表上使用范围搜索的联接数。
- Select_range 使用第一个表上的范围的联接数。即使值非常大，这通常也不是关键问题。
- Select_range_check 在每行之后检查密钥使用情况的没有密钥的连接数。如果这不是 0，您应该仔细检查表的索引。
- Select_scan 对第一个表进行全面扫描的联接数。
- Slave_open_temp_tables 从 MySQL 8.0.26 开始， 已弃用， 应改用Slave_open_temp_tables别名 。Replica_open_temp_tables在 MySQL 8.0.26 之前的版本中，使用 Slave_open_temp_tables. Slave_open_temp_tables显示复制 SQL 线程当前打开的临时表的数量。如果该值大于零，关闭副本是不安全的；参见 第 17.5.1.31 节，“复制和临时表”。此变量报告所有复制通道 的打开临时表的总数 。
- Slave_rows_last_search_algorithm_used 从 MySQL 8.0.26 开始， 已弃用， 应改用Slave_rows_last_search_algorithm_used 别名 。Replica_rows_last_search_algorithm_used在 MySQL 8.0.26 之前的版本中，使用 Slave_rows_last_search_algorithm_used. Slave_rows_last_search_algorithm_used 显示了该副本最近使用的搜索算法来定位基于行的复制的行。结果显示副本是否使用索引、表扫描或散列作为在任何通道上执行的最后一个事务的搜索算法。 使用的方法取决于 slave_rows_search_algorithms 系统变量的设置，以及相关表上可用的键。 此变量仅适用于 MySQL 的调试版本。
- Slow_launch_threads 创建时间超过 slow_launch_time秒数的线程数。
- Slow_queries 花费超过 long_query_time秒数的查询数。无论是否启用慢速查询日志，此计数器都会递增。有关该日志的信息，请参阅 第 5.4.5 节，“慢速查询日志”。
- Sort_merge_passes 排序算法必须执行的合并遍数。如果这个值很大，你应该考虑增加sort_buffer_size 系统变量的值。
- Sort_range 使用范围完成的排序数。
- Sort_rows 排序的行数。
- Sort_scan 通过扫描表完成的排序数。
- Ssl_accept_renegotiates 建立连接所需的协商次数。
- Ssl_accepts 接受的 SSL 连接数。
- Ssl_callback_cache_hits 回调缓存命中数。
- Ssl_cipher 当前的加密密码（对于未加密的连接为空）。
- Ssl_cipher_list 可能的 SSL 密码列表（对于非 SSL 连接为空）。如果 MySQL 支持 TLSv1.3，则该值包括可能的 TLSv1.3 密码套件。请参阅 第 6.3.2 节，“加密连接 TLS 协议和密码”。
- Ssl_client_connects 到启用 SSL 的复制源服务器的 SSL 连接尝试次数。
- Ssl_connect_renegotiates 与启用 SSL 的复制源服务器建立连接所需的协商次数。
- Ssl_ctx_verify_depth SSL 上下文验证深度（测试链中的证书数量）。
- Ssl_ctx_verify_mode SSL 上下文验证模式。
- Ssl_default_timeout 默认 SSL 超时。
- Ssl_finished_accepts 与服务器的成功 SSL 连接数。
- Ssl_finished_connects 与启用 SSL 的复制源服务器的成功副本连接数。
- Ssl_server_not_after SSL 证书有效的最后日期。要检查 SSL 证书过期信息，请使用以下语句： ```sql mysql> SHOW STATUS LIKE 'Ssl_server_not%'; +-----------------------+--------------------------+ | Variable_name | Value | +-----------------------+--------------------------+ | Ssl_server_not_after | Apr 28 14:16:39 2025 GMT | | Ssl_server_not_before | May 1 14:16:39 2015 GMT | +-----------------------+--------------------------+ ```
- Ssl_server_not_before SSL 证书的第一个有效日期。
- Ssl_session_cache_hits SSL 会话缓存命中数。
- Ssl_session_cache_misses SSL 会话缓存未命中数。
- Ssl_session_cache_mode SSL 会话缓存模式。当 ssl_session_cache_mode服务器变量ON的值为 时， Ssl_session_cache_mode 状态变量的值为SERVER。
- Ssl_session_cache_overflows SSL 会话缓存溢出的数量。
- Ssl_session_cache_size SSL 会话缓存大小。
- Ssl_session_cache_timeout 缓存中 SSL 会话的超时值（以秒为单位）。
- Ssl_session_cache_timeouts SSL 会话缓存超时次数。
- Ssl_sessions_reused 从缓存中重用了多少 SSL 连接。
- Ssl_used_session_cache_entries 使用了多少 SSL 会话缓存条目。
- Ssl_verify_depth 复制 SSL 连接的验证深度。
- Ssl_verify_mode 服务器用于使用 SSL 的连接的验证模式。该值是一个位掩码；位在 openssl/ssl.h头文件中定义： ```text # define SSL_VERIFY_NONE 0x00 # define SSL_VERIFY_PEER 0x01 # define SSL_VERIFY_FAIL_IF_NO_PEER_CERT 0x02 # define SSL_VERIFY_CLIENT_ONCE 0x04 ``` SSL_VERIFY_PEER表示服务器要求客户端证书。如果客户端提供一个，则服务器执行验证并且仅当验证成功时才继续。SSL_VERIFY_CLIENT_ONCE 表示仅在初始握手中执行对客户端证书的请求。
- Ssl_version 连接的 SSL 协议版本（例如，TL​​Sv1）。如果连接未加密，则值为空。
- Table_locks_immediate 可以立即授予表锁请求的次数。
- Table_locks_waited 无法立即授予表锁请求并需要等待的次数。如果这个值很高并且你有性能问题，你应该首先优化你的查询，然后拆分你的一个或多个表或使用复制。
- Table_open_cache_hits 打开表缓存查找的命中数。
- Table_open_cache_misses 打开表缓存查找的未命中数。
- Table_open_cache_overflows 打开表缓存的溢出数。这是次数，在打开或关闭表后，缓存实例有一个未使用的条目并且实例的大小大于table_open_cache / table_open_cache_instances。
- Tc_log_max_pages_used 对于mysqld在充当内部 XA 事务恢复的事务协调器时使用的日志的内存映射实现，此变量指示自服务器启动以来用于日志的最大页数。Tc_log_max_pages_used如果和 的乘积 Tc_log_page_size总是明显小于日志大小，则该大小比需要的大，可以减小。（尺寸由 --log-tc-size选项。此变量未使用：基于二进制日志的恢复不需要它，并且不使用内存映射恢复日志方法，除非能够进行两阶段提交并支持 XA 事务的存储引擎数量大于一个。（InnoDB是唯一适用的引擎。）
- Tc_log_page_size 用于 XA 恢复日志的内存映射实现的页面大小。默认值使用 确定 getpagesize()。该变量未使用的原因与 中所述的相同 Tc_log_max_pages_used。
- Tc_log_page_waits 对于恢复日志的内存映射实现，每次服务器无法提交事务并且必须等待日志中的空闲页面时，此变量都会递增。如果此值很大，您可能希望增加日志大小（使用 --log-tc-size选项）。对于基于二进制日志的恢复，每次由于正在进行两阶段提交而无法关闭二进制日志时，此变量都会递增。（关闭操作会等到所有此类事务完成。）
- Threads_cached 线程缓存中的线程数。
- Threads_connected 当前打开的连接数。
- Threads_created 为处理连接而创建的线程数。如果 Threads_created很大，您可能想要增加该 thread_cache_size值。缓存未命中率可以计算为 Threads_created/ Connections。
- Threads_running 未休眠的线程数。
- Tls_library_version 用于此 MySQL 实例的 OpenSSL 库的运行时版本。 这个变量是在 MySQL 8.0.30 中添加的。
- Uptime 服务器已启动的秒数。
- Uptime_since_flush_status 自最近FLUSH STATUS语句以来的秒数。

---

[← 返回 第 5 章 MySQL 服务器管理 索引](00-index.md) · [← 返回总索引](../00-index.md)
