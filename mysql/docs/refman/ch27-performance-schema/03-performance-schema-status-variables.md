# 第 27 章 MySQL 性能模式 · 状态变量

> 对应 SQL：[`sql/refman/ch27-performance-schema/03-performance-schema-status-variables.sql`](../../../sql/refman/ch27-performance-schema/03-performance-schema-status-variables.sql)

---

## 27.16 性能模式状态变量

      Performance Schema 实现了几个状态变量，这些变量提供有关由于内存限制而无法加载或创建的仪器的信息：

```sql
mysql> SHOW STATUS LIKE 'perf%';
+-------------------------------------------+-------+
| Variable_name                             | Value |
+-------------------------------------------+-------+
| Performance_schema_accounts_lost          | 0     |
| Performance_schema_cond_classes_lost      | 0     |
| Performance_schema_cond_instances_lost    | 0     |
| Performance_schema_file_classes_lost      | 0     |
| Performance_schema_file_handles_lost      | 0     |
| Performance_schema_file_instances_lost    | 0     |
| Performance_schema_hosts_lost             | 0     |
| Performance_schema_locker_lost            | 0     |
| Performance_schema_mutex_classes_lost     | 0     |
| Performance_schema_mutex_instances_lost   | 0     |
| Performance_schema_rwlock_classes_lost    | 0     |
| Performance_schema_rwlock_instances_lost  | 0     |
| Performance_schema_socket_classes_lost    | 0     |
| Performance_schema_socket_instances_lost  | 0     |
| Performance_schema_stage_classes_lost     | 0     |
| Performance_schema_statement_classes_lost | 0     |
| Performance_schema_table_handles_lost     | 0     |
| Performance_schema_table_instances_lost   | 0     |
| Performance_schema_thread_classes_lost    | 0     |
| Performance_schema_thread_instances_lost  | 0     |
| Performance_schema_users_lost             | 0     |
+-------------------------------------------+-------+
```

      有关使用这些变量检查性能模式状态的信息，请参阅
      第 27.7 节，“性能模式状态监控”。

      性能模式状态变量具有以下含义：

- Performance_schema_accounts_lost 由于表已满而无法将行添加到 accounts表中的次数。
- Performance_schema_cond_classes_lost 无法加载多少条件仪器。
- Performance_schema_cond_instances_lost 无法创建多少个条件工具实例。
- Performance_schema_digest_lost 无法在 events_statements_summary_by_digest 表中检测的摘要实例数。performance_schema_digests_size 如果 的值太小 ，这可以是非零的 。
- Performance_schema_file_classes_lost 无法加载多少文件工具。
- Performance_schema_file_handles_lost 无法打开多少文件工具实例。
- Performance_schema_file_instances_lost 无法创建多少文件工具实例。
- Performance_schema_hosts_lost 由于表已满而无法将行添加到 hosts表中的次数。
- Performance_schema_index_stat_lost 丢失统计信息的索引数。performance_schema_max_index_stat 如果 的值太小 ，这可以是非零的 。
- Performance_schema_locker_lost 由于以下情况，有多少事件“丢失”或未记录： 事件是递归的（例如，等待 A 导致等待 B，这导致等待 C）。
- 嵌套事件堆栈的深度大于实施强加的限制。

          Performance Schema 记录的事件不是递归的，所以这个变量应该始终为 0。

- Performance_schema_memory_classes_lost 无法加载记忆仪器的次数。
- Performance_schema_metadata_lock_lost 无法在metadata_locks表中检测的元数据锁的数量。performance_schema_max_metadata_locks 如果 的值太小 ，这可以是非零的 。
- Performance_schema_mutex_classes_lost 无法加载多少互斥仪器。
- Performance_schema_mutex_instances_lost 无法创建多少个互斥工具实例。
- Performance_schema_nested_statement_lost 丢失统计信息的存储程序语句数。performance_schema_max_statement_stack 如果 的值太小 ，这可以是非零的 。
- Performance_schema_prepared_statements_lost 无法在 prepared_statements_instances 表中检测的准备好的语句数。performance_schema_max_prepared_statements_instances 如果 的值太小 ，这可以是非零的 。
- Performance_schema_program_lost 丢失统计信息的存储程序数。performance_schema_max_program_instances 如果 的值太小 ，这可以是非零的 。
- Performance_schema_rwlock_classes_lost 无法加载多少 rwlock 工具。
- Performance_schema_rwlock_instances_lost 无法创建多少个 rwlock 仪器实例。
- Performance_schema_session_connect_attrs_longest_seen 除了性能模式针对 performance_schema_session_connect_attrs_size 系统变量值执行的连接属性大小限制检查外，服务器还执行初步检查，对其接受的连接属性数据的总大小施加 64KB 的限制。如果客户端尝试发送超过 64KB 的属性数据，服务器将拒绝连接。否则，服务器认为属性缓冲区有效并在 Performance_schema_session_connect_attrs_longest_seen 状态变量中跟踪最长此类缓冲区的大小。如果这个值大于 performance_schema_session_connect_attrs_size，DBA 可能希望增加后一个值，或者调查哪些客户端正在发送大量属性数据。 有关连接属性的更多信息，请参阅 第 27.12.9 节，“性能模式连接属性表”。
- Performance_schema_session_connect_attrs_lost 发生连接属性截断的连接数。对于给定的连接，如果客户端发送的连接属性键值对的聚合大小大于 performance_schema_session_connect_attrs_size 系统变量值允许的保留存储，则性能模式会截断属性数据并递增 Performance_schema_session_connect_attrs_lost。如果此值不为零，您可能希望设置 performance_schema_session_connect_attrs_size 为更大的值。 有关连接属性的更多信息，请参阅 第 27.12.9 节，“性能模式连接属性表”。
- Performance_schema_socket_classes_lost 无法加载多少插座工具。
- Performance_schema_socket_instances_lost 无法创建多少套接字工具实例。
- Performance_schema_stage_classes_lost 有多少舞台乐器无法加载。
- Performance_schema_statement_classes_lost 无法加载多少语句工具。
- Performance_schema_table_handles_lost 无法打开多少表工具实例。performance_schema_max_table_handles 如果 的值太小 ，这可以是非零的 。
- Performance_schema_table_instances_lost 无法创建多少表工具实例。
- Performance_schema_table_lock_stat_lost 丢失锁统计信息的表的数量。performance_schema_max_table_lock_stat 如果 的值太小 ，这可以是非零的 。
- Performance_schema_thread_classes_lost 无法加载多少线程仪器。
- Performance_schema_thread_instances_lost 无法在threads表中检测的线程实例数。performance_schema_max_thread_instances 如果 的值太小 ，这可以是非零的 。
- Performance_schema_users_lost 由于表已满而无法将行添加到 users表中的次数。

---

[← 返回 第 27 章 MySQL 性能模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
