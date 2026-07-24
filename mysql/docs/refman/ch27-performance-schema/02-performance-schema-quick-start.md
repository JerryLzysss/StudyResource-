# 第 27 章 MySQL 性能模式 · 快速入门

> 对应 SQL：[`sql/refman/ch27-performance-schema/02-performance-schema-quick-start.sql`](../../../sql/refman/ch27-performance-schema/02-performance-schema-quick-start.sql)

---

## 27.1 性能模式快速入门

      本节简要介绍 Performance Schema，并通过示例展示如何使用它。有关其他示例，请参阅
      第 27.19 节，“使用性能模式诊断问题”。

      默认情况下启用性能模式。要显式启用或禁用它，请将
      `performance_schema`变量设置为适当的值来启动服务器。例如，在服务器`my.cnf`文件中使用这些行：

```text
[mysqld]
performance_schema=ON
```

      当服务器启动时，它会看到
      `performance_schema`并尝试初始化性能模式。要验证初始化是否成功，请使用以下语句：

```sql
mysql> SHOW VARIABLES LIKE 'performance_schema';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| performance_schema | ON    |
+--------------------+-------+
```

      值`ON`表示 Performance Schema 已成功初始化并可以使用。值
      `OFF`表示发生了一些错误。检查服务器错误日志以获取有关出错原因的信息。

      Performance Schema 是作为存储引擎实现的，因此您可以在
      `INFORMATION_SCHEMA.ENGINES`表或`SHOW ENGINES`语句的输出中看到它：

```sql
mysql> SELECT * FROM INFORMATION_SCHEMA.ENGINES
       WHERE ENGINE='PERFORMANCE_SCHEMA'\G
*************************** 1. row ***************************
      ENGINE: PERFORMANCE_SCHEMA
     SUPPORT: YES
     COMMENT: Performance Schema
TRANSACTIONS: NO
          XA: NO
  SAVEPOINTS: NO

mysql> SHOW ENGINES\G
...
      Engine: PERFORMANCE_SCHEMA
     Support: YES
     Comment: Performance Schema
Transactions: NO
          XA: NO
  Savepoints: NO
...
```

`PERFORMANCE_SCHEMA`存储引擎对`performance_schema`
      数据库中
      的表进行操作。您可以创建`performance_schema`默认数据库，以便对其表的引用不需要使用数据库名称进行限定：

```sql
mysql> USE performance_schema;
```

      性能模式表存储在
      `performance_schema`数据库中。`INFORMATION_SCHEMA`与任何其他数据库一样，可以通过从数据库中选择或使用
      `SHOW`语句来获取有关此数据库及其表的结构的信息
      。例如，使用这些语句中的任何一个来查看存在哪些 Performance Schema 表：

```sql
mysql> SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA = 'performance_schema';
+------------------------------------------------------+
| TABLE_NAME                                           |
+------------------------------------------------------+
| accounts                                             |
| cond_instances                                       |
...
| events_stages_current                                |
| events_stages_history                                |
| events_stages_history_long                           |
| events_stages_summary_by_account_by_event_name       |
| events_stages_summary_by_host_by_event_name          |
| events_stages_summary_by_thread_by_event_name        |
| events_stages_summary_by_user_by_event_name          |
| events_stages_summary_global_by_event_name           |
| events_statements_current                            |
| events_statements_history                            |
| events_statements_history_long                       |
...
| file_instances                                       |
| file_summary_by_event_name                           |
| file_summary_by_instance                             |
| host_cache                                           |
| hosts                                                |
| memory_summary_by_account_by_event_name              |
| memory_summary_by_host_by_event_name                 |
| memory_summary_by_thread_by_event_name               |
| memory_summary_by_user_by_event_name                 |
| memory_summary_global_by_event_name                  |
| metadata_locks                                       |
| mutex_instances                                      |
| objects_summary_global_by_type                       |
| performance_timers                                   |
| replication_connection_configuration                 |
| replication_connection_status                        |
| replication_applier_configuration                    |
| replication_applier_status                           |
| replication_applier_status_by_coordinator            |
| replication_applier_status_by_worker                 |
| rwlock_instances                                     |
| session_account_connect_attrs                        |
| session_connect_attrs                                |
| setup_actors                                         |
| setup_consumers                                      |
| setup_instruments                                    |
| setup_objects                                        |
| socket_instances                                     |
| socket_summary_by_event_name                         |
| socket_summary_by_instance                           |
| table_handles                                        |
| table_io_waits_summary_by_index_usage                |
| table_io_waits_summary_by_table                      |
| table_lock_waits_summary_by_table                    |
| threads                                              |
| users                                                |
+------------------------------------------------------+

mysql> SHOW TABLES FROM performance_schema;
+------------------------------------------------------+
| Tables_in_performance_schema                         |
+------------------------------------------------------+
| accounts                                             |
| cond_instances                                       |
| events_stages_current                                |
| events_stages_history                                |
| events_stages_history_long                           |
...
```

      随着额外检测的实施，性能模式表的数量会随着时间的推移而增加。

      数据库的名称`performance_schema`是小写的，其中的表名也是如此。查询应以小写形式指定名称。

      要查看单个表的结构，请使用
      `SHOW CREATE TABLE`：

```sql
mysql> SHOW CREATE TABLE performance_schema.setup_consumers\G
*************************** 1. row ***************************
       Table: setup_consumers
Create Table: CREATE TABLE `setup_consumers` (
  `NAME` varchar(64) NOT NULL,
  `ENABLED` enum('YES','NO') NOT NULL,
  PRIMARY KEY (`NAME`)
) ENGINE=PERFORMANCE_SCHEMA DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

      表结构也可以通过从表中选择
      `INFORMATION_SCHEMA.COLUMNS`或使用诸如`SHOW COLUMNS`.

      数据库中的表`performance_schema`可以根据其中的信息类型进行分组：当前事件、事件历史和摘要、对象实例以及设置（配置）信息。以下示例说明了这些表的一些用途。有关每组中的表的详细信息，请参阅
      第 27.12 节，“性能模式表说明”。

      最初，并不是所有的工具和消费者都被启用，所以性能模式不会收集所有的事件。要打开所有这些并启用事件计时，请执行两个语句（行数可能因 MySQL 版本而异）：

```sql
mysql> UPDATE performance_schema.setup_instruments
       SET ENABLED = 'YES', TIMED = 'YES';
Query OK, 560 rows affected (0.04 sec)
mysql> UPDATE performance_schema.setup_consumers
       SET ENABLED = 'YES';
Query OK, 10 rows affected (0.00 sec)
```

      要查看服务器此时正在做什么，请检查该
      `events_waits_current`表。它包含每个线程一行，显示每个线程最近监视的事件：

```sql
mysql> SELECT *
       FROM performance_schema.events_waits_current\G
*************************** 1. row ***************************
            THREAD_ID: 0
             EVENT_ID: 5523
         END_EVENT_ID: 5523
           EVENT_NAME: wait/synch/mutex/mysys/THR_LOCK::mutex
               SOURCE: thr_lock.c:525
          TIMER_START: 201660494489586
            TIMER_END: 201660494576112
           TIMER_WAIT: 86526
                SPINS: NULL
        OBJECT_SCHEMA: NULL
          OBJECT_NAME: NULL
           INDEX_NAME: NULL
          OBJECT_TYPE: NULL
OBJECT_INSTANCE_BEGIN: 142270668
     NESTING_EVENT_ID: NULL
   NESTING_EVENT_TYPE: NULL
            OPERATION: lock
      NUMBER_OF_BYTES: NULL
                FLAGS: 0
...
```

      此事件表示线程 0 等待 86,526 皮秒以获取
      子系统`THR_LOCK::mutex`中的互斥
      锁 上的锁。`mysys`前几列提供以下信息：

- ID 列指示事件来自哪个线程和事件编号。
- EVENT_NAME指示检测的内容并SOURCE指示哪个源文件包含检测代码。
- 计时器列显示事件开始和停止的时间以及花费的时间。如果事件仍在进行中，则 TIMER_END和TIMER_WAIT 值为NULL。定时器值是近似值，以皮秒表示。有关计时器和事件时间收集的信息，请参阅 第 27.4.1 节，“性能模式事件计时”。

      历史表包含与当前事件表相同类型的行，但有更多行并显示服务器“最近”而不是
      “当前”在做什么。”和
      表分别包含每个线程最近的 10 个事件和最近的 10,000 个事件`events_waits_history`。
      `events_waits_history_long`例如，要查看线程 13 产生的最近事件的信息，请执行以下操作：

```sql
mysql> SELECT EVENT_ID, EVENT_NAME, TIMER_WAIT
       FROM performance_schema.events_waits_history
       WHERE THREAD_ID = 13
       ORDER BY EVENT_ID;
+----------+-----------------------------------------+------------+
| EVENT_ID | EVENT_NAME                              | TIMER_WAIT |
+----------+-----------------------------------------+------------+
|       86 | wait/synch/mutex/mysys/THR_LOCK::mutex  |     686322 |
|       87 | wait/synch/mutex/mysys/THR_LOCK_malloc  |     320535 |
|       88 | wait/synch/mutex/mysys/THR_LOCK_malloc  |     339390 |
|       89 | wait/synch/mutex/mysys/THR_LOCK_malloc  |     377100 |
|       90 | wait/synch/mutex/sql/LOCK_plugin        |     614673 |
|       91 | wait/synch/mutex/sql/LOCK_open          |     659925 |
|       92 | wait/synch/mutex/sql/THD::LOCK_thd_data |     494001 |
|       93 | wait/synch/mutex/mysys/THR_LOCK_malloc  |     222489 |
|       94 | wait/synch/mutex/mysys/THR_LOCK_malloc  |     214947 |
|       95 | wait/synch/mutex/mysys/LOCK_alarm       |     312993 |
+----------+-----------------------------------------+------------+
```

      当新事件被添加到历史表中时，如果表已满，旧事件将被丢弃。

      汇总表提供了所有事件随时间变化的汇总信息。该组中的表以不同方式总结事件数据。要查看哪些工具执行次数最多或等待时间最长，请
      在or
      列`events_waits_summary_global_by_event_name`
      上对表格进行排序，它们分别对应于针对所有事件计算的
      or
      值：
    `COUNT_STAR``SUM_TIMER_WAIT``COUNT(*)``SUM(TIMER_WAIT)`

```sql
mysql> SELECT EVENT_NAME, COUNT_STAR
       FROM performance_schema.events_waits_summary_global_by_event_name
       ORDER BY COUNT_STAR DESC LIMIT 10;
+---------------------------------------------------+------------+
| EVENT_NAME                                        | COUNT_STAR |
+---------------------------------------------------+------------+
| wait/synch/mutex/mysys/THR_LOCK_malloc            |       6419 |
| wait/io/file/sql/FRM                              |        452 |
| wait/synch/mutex/sql/LOCK_plugin                  |        337 |
| wait/synch/mutex/mysys/THR_LOCK_open              |        187 |
| wait/synch/mutex/mysys/LOCK_alarm                 |        147 |
| wait/synch/mutex/sql/THD::LOCK_thd_data           |        115 |
| wait/io/file/myisam/kfile                         |        102 |
| wait/synch/mutex/sql/LOCK_global_system_variables |         89 |
| wait/synch/mutex/mysys/THR_LOCK::mutex            |         89 |
| wait/synch/mutex/sql/LOCK_open                    |         88 |
+---------------------------------------------------+------------+

mysql> SELECT EVENT_NAME, SUM_TIMER_WAIT
       FROM performance_schema.events_waits_summary_global_by_event_name
       ORDER BY SUM_TIMER_WAIT DESC LIMIT 10;
+----------------------------------------+----------------+
| EVENT_NAME                             | SUM_TIMER_WAIT |
+----------------------------------------+----------------+
| wait/io/file/sql/MYSQL_LOG             |     1599816582 |
| wait/synch/mutex/mysys/THR_LOCK_malloc |     1530083250 |
| wait/io/file/sql/binlog_index          |     1385291934 |
| wait/io/file/sql/FRM                   |     1292823243 |
| wait/io/file/myisam/kfile              |      411193611 |
| wait/io/file/myisam/dfile              |      322401645 |
| wait/synch/mutex/mysys/LOCK_alarm      |      145126935 |
| wait/io/file/sql/casetest              |      104324715 |
| wait/synch/mutex/sql/LOCK_plugin       |       86027823 |
| wait/io/file/sql/pid                   |       72591750 |
+----------------------------------------+----------------+
```

      这些结果表明`THR_LOCK_malloc`
      互斥锁是“热的”，无论是使用频率还是线程等待获取它的时间。

笔记

`THR_LOCK_malloc`互斥量仅用于调试构建
        。在生产构建中它并不热，因为它不存在。

      实例表记录了哪些类型的对象被检测。被检测对象在被服务器使用时会产生一个事件。这些表提供了事件名称和解释性说明或状态信息。例如，下
      `file_instances`表列出了用于文件 I/O 操作及其关联文件的工具实例：

```sql
mysql> SELECT *
       FROM performance_schema.file_instances\G
*************************** 1. row ***************************
 FILE_NAME: /opt/mysql-log/60500/binlog.000007
EVENT_NAME: wait/io/file/sql/binlog
OPEN_COUNT: 0
*************************** 2. row ***************************
 FILE_NAME: /opt/mysql/60500/data/mysql/tables_priv.MYI
EVENT_NAME: wait/io/file/myisam/kfile
OPEN_COUNT: 1
*************************** 3. row ***************************
 FILE_NAME: /opt/mysql/60500/data/mysql/columns_priv.MYI
EVENT_NAME: wait/io/file/myisam/kfile
OPEN_COUNT: 1
...
```

      设置表用于配置和显示监控特性。例如，
      `setup_instruments`列出可以为其收集事件的一组工具并显示其中哪些已启用：

```sql
mysql> SELECT NAME, ENABLED, TIMED
       FROM performance_schema.setup_instruments;
+---------------------------------------------------+---------+-------+
| NAME                                              | ENABLED | TIMED |
+---------------------------------------------------+---------+-------+
...
| stage/sql/end                                     | NO      | NO    |
| stage/sql/executing                               | NO      | NO    |
| stage/sql/init                                    | NO      | NO    |
| stage/sql/insert                                  | NO      | NO    |
...
| statement/sql/load                                | YES     | YES   |
| statement/sql/grant                               | YES     | YES   |
| statement/sql/check                               | YES     | YES   |
| statement/sql/flush                               | YES     | YES   |
...
| wait/synch/mutex/sql/LOCK_global_read_lock        | YES     | YES   |
| wait/synch/mutex/sql/LOCK_global_system_variables | YES     | YES   |
| wait/synch/mutex/sql/LOCK_lock_db                 | YES     | YES   |
| wait/synch/mutex/sql/LOCK_manager                 | YES     | YES   |
...
| wait/synch/rwlock/sql/LOCK_grant                  | YES     | YES   |
| wait/synch/rwlock/sql/LOGGER::LOCK_logger         | YES     | YES   |
| wait/synch/rwlock/sql/LOCK_sys_init_connect       | YES     | YES   |
| wait/synch/rwlock/sql/LOCK_sys_init_slave         | YES     | YES   |
...
| wait/io/file/sql/binlog                           | YES     | YES   |
| wait/io/file/sql/binlog_index                     | YES     | YES   |
| wait/io/file/sql/casetest                         | YES     | YES   |
| wait/io/file/sql/dbopt                            | YES     | YES   |
...
```

      要了解如何解释仪器名称，请参阅
      第 27.6 节，“性能模式仪器命名约定”。

      要控制是否为仪器收集事件，请将其
      `ENABLED`值设置为`YES`或
      `NO`。例如：

```sql
mysql> UPDATE performance_schema.setup_instruments
       SET ENABLED = 'NO'
       WHERE NAME = 'wait/synch/mutex/sql/LOCK_mysql_create_db';
```

      Performance Schema 使用收集的事件来更新`performance_schema`数据库中的表，这些表充当
      事件信息的“消费者”。该
      `setup_consumers`表列出了可用的消费者以及已启用的消费者：

```sql
mysql> SELECT * FROM performance_schema.setup_consumers;
+----------------------------------+---------+
| NAME                             | ENABLED |
+----------------------------------+---------+
| events_stages_current            | NO      |
| events_stages_history            | NO      |
| events_stages_history_long       | NO      |
| events_statements_cpu            | NO      |
| events_statements_current        | YES     |
| events_statements_history        | YES     |
| events_statements_history_long   | NO      |
| events_transactions_current      | YES     |
| events_transactions_history      | YES     |
| events_transactions_history_long | NO      |
| events_waits_current             | NO      |
| events_waits_history             | NO      |
| events_waits_history_long        | NO      |
| global_instrumentation           | YES     |
| thread_instrumentation           | YES     |
| statements_digest                | YES     |
+----------------------------------+---------+
```

      要控制 Performance Schema 是否将消费者维护为事件信息的目的地，请设置其
      `ENABLED`值。

      有关设置表以及如何使用它们来控制事件收集的更多信息，请参阅
      第 27.4.2 节，“性能模式事件过滤”。

      有一些杂项表不属于任何前面的组。例如，
      `performance_timers`列出可用的事件计时器及其特性。有关计时器的信息，请参阅第 27.4.1 节，“性能模式事件计时”。

---

[← 返回 第 27 章 MySQL 性能模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
