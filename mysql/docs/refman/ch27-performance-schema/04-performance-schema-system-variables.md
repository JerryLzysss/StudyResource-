# 第 27 章 MySQL 性能模式 · 系统变量

> 对应 SQL：[`sql/refman/ch27-performance-schema/04-performance-schema-system-variables.sql`](../../../sql/refman/ch27-performance-schema/04-performance-schema-system-variables.sql)

---

## 27.15 性能模式系统变量

      性能模式实现了几个提供配置信息的系统变量：

```sql
mysql> SHOW VARIABLES LIKE 'perf%';
+----------------------------------------------------------+-------+
| Variable_name                                            | Value |
+----------------------------------------------------------+-------+
| performance_schema                                       | ON    |
| performance_schema_accounts_size                         | -1    |
| performance_schema_digests_size                          | 10000 |
| performance_schema_events_stages_history_long_size       | 10000 |
| performance_schema_events_stages_history_size            | 10    |
| performance_schema_events_statements_history_long_size   | 10000 |
| performance_schema_events_statements_history_size        | 10    |
| performance_schema_events_transactions_history_long_size | 10000 |
| performance_schema_events_transactions_history_size      | 10    |
| performance_schema_events_waits_history_long_size        | 10000 |
| performance_schema_events_waits_history_size             | 10    |
| performance_schema_hosts_size                            | -1    |
| performance_schema_max_cond_classes                      | 80    |
| performance_schema_max_cond_instances                    | -1    |
| performance_schema_max_digest_length                     | 1024  |
| performance_schema_max_file_classes                      | 50    |
| performance_schema_max_file_handles                      | 32768 |
| performance_schema_max_file_instances                    | -1    |
| performance_schema_max_index_stat                        | -1    |
| performance_schema_max_memory_classes                    | 320   |
| performance_schema_max_metadata_locks                    | -1    |
| performance_schema_max_mutex_classes                     | 350   |
| performance_schema_max_mutex_instances                   | -1    |
| performance_schema_max_prepared_statements_instances     | -1    |
| performance_schema_max_program_instances                 | -1    |
| performance_schema_max_rwlock_classes                    | 40    |
| performance_schema_max_rwlock_instances                  | -1    |
| performance_schema_max_socket_classes                    | 10    |
| performance_schema_max_socket_instances                  | -1    |
| performance_schema_max_sql_text_length                   | 1024  |
| performance_schema_max_stage_classes                     | 150   |
| performance_schema_max_statement_classes                 | 192   |
| performance_schema_max_statement_stack                   | 10    |
| performance_schema_max_table_handles                     | -1    |
| performance_schema_max_table_instances                   | -1    |
| performance_schema_max_table_lock_stat                   | -1    |
| performance_schema_max_thread_classes                    | 50    |
| performance_schema_max_thread_instances                  | -1    |
| performance_schema_session_connect_attrs_size            | 512   |
| performance_schema_setup_actors_size                     | -1    |
| performance_schema_setup_objects_size                    | -1    |
| performance_schema_users_size                            | -1    |
+----------------------------------------------------------+-------+
```

      Performance Schema 系统变量可以在服务器启动时在命令行或选项文件中设置，许多可以在运行时设置。请参阅
      第 27.13 节，“性能模式选项和变量参考”。

      如果未明确设置，性能模式会在服务器启动时自动调整其几个参数的值。有关详细信息，请参阅
      第 27.3 节，“性能模式启动配置”。

      Performance Schema 系统变量具有以下含义：

- performance_schema 命令行格式 --performance-schema[={OFF|ON}] 系统变量 performance_schema 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 布尔值 默认值 ON 该变量的值为ONor OFF，表示性能模式是否启用。默认情况下，该值为 ON。在服务器启动时，您可以指定此变量不带任何值或值为ON或 1 以启用它，或者指定此变量的值为OFF或 0 以禁用它。 即使禁用性能模式，它也会继续填充global_variables、 session_variables、 global_status和 session_status表。这在必要时发生，以允许 从这些表中提取SHOW VARIABLES和 语句的结果。SHOW STATUS性能模式在禁用时还会填充一些复制表。
- performance_schema_accounts_size 命令行格式 --performance-schema-accounts-size=# 系统变量 performance_schema_accounts_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数 accounts。如果该变量为 0，则 Performance Schema 不维护表中的连接统计accounts信息或表中的状态变量信息 status_by_account。
- performance_schema_digests_size 命令行格式 --performance-schema-digests-size=# 系统变量 performance_schema_digests_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的最大行数 events_statements_summary_by_digest 。如果超过此最大值以致无法检测摘要，则性能模式会增加 Performance_schema_digest_lost 状态变量。 有关语句摘要的更多信息，请参阅 第 27.10 节，“性能模式语句摘要和采样”。
- performance_schema_error_size 命令行格式 --performance-schema-error-size=# 系统变量 performance_schema_error_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 number of server error codes 最小值 0 最大值 1048576 检测服务器错误代码的数量。默认值为服务器错误代码的实际数量。尽管该值可以设置为 0 到最大值之间的任何值，但预期用途是将其设置为默认值（检测所有错误）或 0（检测无错误）。 错误信息汇总在汇总表中；请参阅 第 27.12.20.11 节，“错误汇总表”。如果发生未检测的错误，则将发生的信息聚合到NULL每个摘要表中的行；即，到带有 ERROR_NUMBER=0、 ERROR_NAME=NULL和 的行SQLSTATE=NULL。
- performance_schema_events_stages_history_long_size 命令行格式 --performance-schema-events-stages-history-long-size=# 系统变量 performance_schema_events_stages_history_long_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数 events_stages_history_long。
- performance_schema_events_stages_history_size 命令行格式 --performance-schema-events-stages-history-size=# 系统变量 performance_schema_events_stages_history_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1024 表中每个线程的行数 events_stages_history。
- performance_schema_events_statements_history_long_size 命令行格式 --performance-schema-events-statements-history-long-size=# 系统变量 performance_schema_events_statements_history_long_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数 events_statements_history_long 。
- performance_schema_events_statements_history_size 命令行格式 --performance-schema-events-statements-history-size=# 系统变量 performance_schema_events_statements_history_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1024 表中每个线程的行数 events_statements_history。
- performance_schema_events_transactions_history_long_size 命令行格式 --performance-schema-events-transactions-history-long-size=# 系统变量 performance_schema_events_transactions_history_long_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数 events_transactions_history_long 。
- performance_schema_events_transactions_history_size 命令行格式 --performance-schema-events-transactions-history-size=# 系统变量 performance_schema_events_transactions_history_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1024 表中每个线程的行数 events_transactions_history 。
- performance_schema_events_waits_history_long_size 命令行格式 --performance-schema-events-waits-history-long-size=# 系统变量 performance_schema_events_waits_history_long_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数 events_waits_history_long。
- performance_schema_events_waits_history_size 命令行格式 --performance-schema-events-waits-history-size=# 系统变量 performance_schema_events_waits_history_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1024 表中每个线程的行数 events_waits_history。
- performance_schema_hosts_size 命令行格式 --performance-schema-hosts-size=# 系统变量 performance_schema_hosts_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数hosts 。如果该变量为 0，则 Performance Schema 不维护表中的连接统计 hosts信息或表中的状态变量信息status_by_host 。
- performance_schema_max_cond_classes 命令行格式 --performance-schema-max-cond-classes=# 系统变量 performance_schema_max_cond_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值（≥ 8.0.27） 150 默认值（≥ 8.0.13，≤ 8.0.26） 100 默认值（≤ 8.0.12） 80 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 条件工具的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_cond_instances 命令行格式 --performance-schema-max-cond-instances=# 系统变量 performance_schema_max_cond_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 检测条件对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_digest_length 命令行格式 --performance-schema-max-digest-length=# 系统变量 performance_schema_max_digest_length 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 1024 最小值 0 最大值 1048576 单元 字节 每个语句保留的最大内存字节数，用于计算性能模式中的规范化语句摘要值。该变量与 max_digest_length; 请参阅第 5.1.8 节“服务器系统变量”中对该变量的描述 。 有关语句摘要的更多信息，包括有关内存使用的注意事项，请参阅 第 27.10 节，“性能模式语句摘要和采样”。
- performance_schema_max_digest_sample_age 命令行格式 --performance-schema-max-digest-sample-age=# 系统变量 performance_schema_max_digest_sample_age 范围 全球的 动态的 是的 SET_VAR提示适用 不 类型 整数 默认值 60 最小值 0 最大值 1048576 单元 秒 此变量影响表的语句抽样 events_statements_summary_by_digest 。插入新的表行时，生成行摘要值的语句将存储为与摘要关联的当前样本语句。此后，当服务器看到其他具有相同摘要值的语句时，它决定是否使用新语句来替换当前样本语句（即是否重新采样）。重采样策略基于当前示例语句和新语句的比较等待时间，以及可选的当前示例语句的年龄： 根据等待时间重采样：如果新语句等待时间的等待时间大于当前样本语句的等待时间，则成为当前样本语句。
- 基于年龄的重采样：如果 performance_schema_max_digest_sample_age 系统变量的值大于零，并且当前样本语句超过该秒数，则当前语句被认为“太旧”，新语句将替换它。即使新语句等待时间小于当前示例语句的等待时间，也会发生这种情况。

          有关语句采样的信息，请参阅
          第 27.10 节，“性能模式语句摘要和采样”。

- performance_schema_max_file_classes 命令行格式 --performance-schema-max-file-classes=# 系统变量 performance_schema_max_file_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 80 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 文件工具的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_file_handles 命令行格式 --performance-schema-max-file-handles=# 系统变量 performance_schema_max_file_handles 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 32768 最小值 0 最大值 1048576 打开的文件对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。 的值 performance_schema_max_file_handles 应大于 的值 open_files_limit： open_files_limit影响服务器可以支持的最大打开文件句柄数，并 performance_schema_max_file_handles 影响可以检测这些文件句柄的数量。
- performance_schema_max_file_instances 命令行格式 --performance-schema-max-file-instances=# 系统变量 performance_schema_max_file_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 检测文件对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_index_stat 命令行格式 --performance-schema-max-index-stat=# 系统变量 performance_schema_max_index_stat 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 性能模式维护统计信息的最大索引数。如果超过此最大值以致索引统计信息丢失，则性能模式会增加 Performance_schema_index_stat_lost 状态变量。默认值是使用 的值自动调整大小的 performance_schema_max_table_instances。
- performance_schema_max_memory_classes 命令行格式 --performance-schema-max-memory-classes=# 系统变量 performance_schema_max_memory_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 450 最小值 0 最大值 1024 记忆仪器的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_metadata_locks 命令行格式 --performance-schema-max-metadata-locks=# 系统变量 performance_schema_max_metadata_locks 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 10485760 元数据锁定工具的最大数量。该值控制 metadata_locks表的大小。如果超过此最大值以致无法检测元数据锁，则性能模式会增加 Performance_schema_metadata_lock_lost 状态变量。
- performance_schema_max_mutex_classes 命令行格式 --performance-schema-max-mutex-classes=# 系统变量 performance_schema_max_mutex_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值（≥ 8.0.27） 350 默认值（≥ 8.0.12，≤ 8.0.26） 300 默认值 (8.0.11) 250 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 互斥仪器的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_mutex_instances 命令行格式 --performance-schema-max-mutex-instances=# 系统变量 performance_schema_max_mutex_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 104857600 检测互斥对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_prepared_statements_instances 命令行格式 --performance-schema-max-prepared-statements-instances=# 系统变量 performance_schema_max_prepared_statements_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 4194304 表中的最大行数 prepared_statements_instances 。如果超过此最大值以致无法检测准备好的语句，则性能模式会增加 Performance_schema_prepared_statements_lost 状态变量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。 该变量的默认值是根据 max_prepared_stmt_count 系统变量的值自动调整大小的。
- performance_schema_max_rwlock_classes 命令行格式 --performance-schema-max-rwlock-classes=# 系统变量 performance_schema_max_rwlock_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 60 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 rwlock 仪器的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_program_instances 命令行格式 --performance-schema-max-program-instances=# 系统变量 performance_schema_max_program_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 性能模式维护统计信息的最大存储程序数。如果超过这个最大值，性能模式会增加 Performance_schema_program_lost 状态变量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_rwlock_instances 命令行格式 --performance-schema-max-rwlock-instances=# 系统变量 performance_schema_max_rwlock_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动调整大小；不要分配此文字值） 最大值 104857600 检测的 rwlock 对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_socket_classes 命令行格式 --performance-schema-max-socket-classes=# 系统变量 performance_schema_max_socket_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 10 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 套接字工具的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_socket_instances 命令行格式 --performance-schema-max-socket-instances=# 系统变量 performance_schema_max_socket_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 检测套接字对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_sql_text_length 命令行格式 --performance-schema-max-sql-text-length=# 系统变量 performance_schema_max_sql_text_length 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 1024 最小值 0 最大值 1048576 单元 字节 用于存储 SQL 语句的最大字节数。该值适用于这些列所需的存储： 、 和 语句事件表 的SQL_TEXT列 。events_statements_currentevents_statements_historyevents_statements_history_long
- 汇总表 的QUERY_SAMPLE_TEXT列 。events_statements_summary_by_digest

          超出的任何字节
          `performance_schema_max_sql_text_length`
          都将被丢弃，并且不会出现在列中。只有在列中的许多初始字节无法区分之后，语句才会有所不同。

          减小该
          `performance_schema_max_sql_text_length`
          值会减少内存使用，但如果它们仅在末尾不同，则会导致更多语句变得无法区分。增加该值会增加内存使用，但允许区分更长的语句。

- performance_schema_max_stage_classes 命令行格式 --performance-schema-max-stage-classes=# 系统变量 performance_schema_max_stage_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值（≥ 8.0.13） 175 默认值（≤ 8.0.12） 150 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 舞台乐器的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_statement_classes 命令行格式 --performance-schema-max-statement-classes=# 系统变量 performance_schema_max_statement_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 最小值 0 最大值 256 语句工具的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。 默认值是在服务器构建时根据客户端/服务器协议中的命令数和服务器支持的 SQL 语句类型数计算的。 不应更改此变量，除非将其设置为 0 以禁用所有语句检测并保存与其关联的所有内存。将变量设置为默认值以外的非零值没有任何好处；特别是，大于默认值的值会导致分配比需要更多的内存。
- performance_schema_max_statement_stack 命令行格式 --performance-schema-max-statement-stack=# 系统变量 performance_schema_max_statement_stack 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 10 最小值 1 最大值 256 性能模式维护统计信息的嵌套存储程序调用的最大深度。当超过这个最大值时，性能模式会 Performance_schema_nested_statement_lost 为每个执行的存储程序语句增加状态变量。
- performance_schema_max_table_handles 命令行格式 --performance-schema-max-table-handles=# 系统变量 performance_schema_max_table_handles 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 打开的表对象的最大数量。该值控制 table_handles表的大小。如果超过此最大值以致无法检测表句柄，则性能模式会增加 Performance_schema_table_handles_lost 状态变量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_table_instances 命令行格式 --performance-schema-max-table-instances=# 系统变量 performance_schema_max_table_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 检测表对象的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_table_lock_stat 命令行格式 --performance-schema-max-table-lock-stat=# 系统变量 performance_schema_max_table_lock_stat 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 Performance Schema 维护锁统计信息的最大表数。如果超过此最大值以致表锁统计信息丢失，则性能模式会增加 Performance_schema_table_lock_stat_lost 状态变量。
- performance_schema_max_thread_classes 命令行格式 --performance-schema-max-thread-classes=# 系统变量 performance_schema_max_thread_classes 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 100 最小值 0 最大值 (≥ 8.0.12) 1024 最大值 (8.0.11) 256 线程工具的最大数量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。
- performance_schema_max_thread_instances 命令行格式 --performance-schema-max-thread-instances=# 系统变量 performance_schema_max_thread_instances 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 检测线程对象的最大数量。该值控制threads 表的大小。如果超过此最大值以致无法检测线程，则性能模式会增加 Performance_schema_thread_instances_lost 状态变量。有关如何设置和使用此变量的信息，请参阅 第 27.7 节，“性能模式状态监控”。 max_connections系统变量会影响服务器中可以运行的线程数 。performance_schema_max_thread_instances 影响这些正在运行的线程中有多少可以被检测。 variables_by_thread和 表仅包含有关前台线程 的status_by_thread系统和状态变量信息。如果不是所有线程都由性能模式检测，则此表会丢失一些行。在这种情况下， Performance_schema_thread_instances_lost 状态变量大于零。
- performance_schema_session_connect_attrs_size 命令行格式 --performance-schema-session-connect-attrs-size=# 系统变量 performance_schema_session_connect_attrs_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动调整大小；不要分配此文字值） 最小值 -1（表示自动调整大小；不要分配此文字值） 最大值 1048576 单元 字节 为保存连接属性键值对而保留的每个线程的预分配内存量。如果客户端发送的连接属性数据的总大小大于此数量，则性能模式会截断属性数据，增加 Performance_schema_session_connect_attrs_lost 状态变量，并向错误日志写入一条消息，指示如果 log_error_verbosity系统变量大于则发生截断1.一个_truncated 如果属性缓冲区有足够的空间，属性也被添加到会话属性中，其值指示丢失了多少字节。这使性能模式能够在连接属性表中公开每个连接的截断信息。无需检查错误日志即可检查此信息。 的默认值 performance_schema_session_connect_attrs_size 在服务器启动时自动调整。该值可能很小，因此如果发生截断（Performance_schema_session_connect_attrs_lost 变为非零），您可能希望 performance_schema_session_connect_attrs_size 明确设置为更大的值。 尽管最大允许 performance_schema_session_connect_attrs_size 值为 1MB，但有效最大值为 64KB，因为服务器对其接受的连接属性数据的总大小施加了 64KB 的限制。如果客户端尝试发送超过 64KB 的属性数据，服务器将拒绝连接。有关详细信息，请参阅 第 27.12.9 节，“性能模式连接属性表”。
- performance_schema_setup_actors_size 命令行格式 --performance-schema-setup-actors-size=# 系统变量 performance_schema_setup_actors_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动调整大小；不要分配此文字值） 最大值 1048576 表中的行数 setup_actors。
- performance_schema_setup_objects_size 命令行格式 --performance-schema-setup-objects-size=# 系统变量 performance_schema_setup_objects_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数 setup_objects。
- performance_schema_show_processlist 命令行格式 --performance-schema-show-processlist[={OFF|ON}] 介绍 8.0.22 系统变量 performance_schema_show_processlist 范围 全球的 动态的 是的 SET_VAR提示适用 不 类型 布尔值 默认值 OFF 该SHOW PROCESSLIST语句通过从所有活动线程收集线程数据来提供进程信息。该 performance_schema_show_processlist 变量决定SHOW PROCESSLIST 使用哪个实现： 默认实现在线程管理器中遍历活动线程，同时持有全局互斥锁。这会对性能产生负面影响，尤其是在繁忙的系统上。
- 替代SHOW PROCESSLIST实现基于 Performance Schema processlist表。此实现从性能模式而不是线程管理器查询活动线程数据，并且不需要互斥体。

          要启用替代实现，请启用
          `performance_schema_show_processlist`
          系统变量。为确保默认和替代实现产生相同的信息，必须满足某些配置要求；参见
          第 27.12.21.6 节，“进程列表”。

- performance_schema_users_size 命令行格式 --performance-schema-users-size=# 系统变量 performance_schema_users_size 范围 全球的 动态的 不 SET_VAR提示适用 不 类型 整数 默认值 -1（表示自动缩放；不要分配此文字值） 最小值 -1（表示自动缩放；不要分配此文字值） 最大值 1048576 表中的行数users 。如果该变量为 0，则 Performance Schema 不维护表中的连接统计 users信息或表中的状态变量信息status_by_user 。

---

[← 返回 第 27 章 MySQL 性能模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
