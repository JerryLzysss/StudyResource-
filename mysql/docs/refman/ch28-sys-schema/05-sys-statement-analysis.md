# 第 28 章 MySQL 系统模式 · 语句分析相关

> 对应 SQL：[`sql/refman/ch28-sys-schema/05-sys-statement-analysis.sql`](../../../sql/refman/ch28-sys-schema/05-sys-statement-analysis.sql)

---

28.4.3.35 statement_analysis 和 x$statement_analysis 视图_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 28 章 MySQL 系统模式 / 28.4 sys 模式对象参考 / 28.4.3 sys 架构视图 / 28.4.3.35 statement_analysis 和 x$statement_analysis 视图 这些视图列出了带有聚合统计信息的规范化语句。内容模仿 MySQL Enterprise Monitor 查询分析视图。默认情况下，行按总延迟降序排列。 statement_analysis和 x$statement_analysis视图有以下列 ： query 规范化语句字符串。
- db 语句的默认数据库，或者 NULL如果没有。
- full_scan 语句的出现执行的全表扫描总数。
- exec_count 语句执行的总次数。
- err_count 语句出现所产生的错误总数。
- warn_count 语句的出现产生的警告总数。
- total_latency 语句定时出现的总等待时间。
- max_latency 语句定时出现的最大单次等待时间。
- avg_latency 语句每次定时出现的平均等待时间。
- lock_latency 语句的定时出现等待锁定的总时间。
- cpu_latency 当前线程在 CPU 上花费的时间。
- rows_sent 语句的出现返回的总行数。
- rows_sent_avg 语句每次出现返回的平均行数。
- rows_examined 通过语句的出现从存储引擎读取的总行数。
- rows_examined_avg 语句每次出现时从存储引擎读取的平均行数。
- rows_affected 受语句出现影响的总行数。
- rows_affected_avg 语句每次出现时受影响的平均行数。
- tmp_tables 由语句的出现创建的内部内存临时表的总数。
- tmp_disk_tables 由语句的出现创建的内部磁盘临时表的总数。
- rows_sorted 按语句出现次数排序的总行数。
- sort_merge_passes 排序合并的总数通过语句的出现次数。
- max_controlled_memory 语句使用的最大受控内存量（字节）。 该列是 MySQL 8.0.31 新增的
- max_total_memory 语句使用的最大内存量（字节）。 该列是 MySQL 8.0.31 新增的
- digest 声明摘要。
- first_seen 首次看到声明的时间。
- last_seen 最近一次看到声明的时间。

---

[← 返回 第 28 章 MySQL 系统模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
