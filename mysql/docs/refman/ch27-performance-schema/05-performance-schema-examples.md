# 第 27 章 MySQL 性能模式 · 示例

> 对应 SQL：[`sql/refman/ch27-performance-schema/05-performance-schema-examples.sql`](../../../sql/refman/ch27-performance-schema/05-performance-schema-examples.sql)

---

## 27.19 使用性能模式诊断问题

Performance Schema 是一种工具，可帮助 DBA 通过进行实际测量而不是“胡乱猜测”
      来进行性能调优。”本节演示为此目的使用性能模式的一些方法。这里的讨论依赖于事件过滤的使用，这在
      第 27.4.2 节，“性能模式事件过滤”中有描述。

      以下示例提供了一种可用于分析可重复问题的方法，例如调查性能瓶颈。首先，您应该有一个可重复的用例，其中性能被认为“太慢”并且需要优化，并且您应该启用所有检测（根本没有预过滤）。

- 运行用例。
- 使用性能模式表，分析性能问题的根本原因。此分析在很大程度上依赖于后过滤。
- 对于排除的问题区域，禁用相应的工具。例如，如果分析表明问题与特定存储引擎中的文件 I/O 无关，则禁用该引擎的文件 I/O 工具。然后截断历史和摘要表以删除以前收集的事件。
- 重复步骤 1 中的过程。 在每次迭代中，Performance Schema 输出，尤其是 events_waits_history_long表格，包含越来越少的由无关紧要的仪器引起的“噪音”，并且鉴于该表格具有固定大小，包含越来越多与手头问题分析相关的数据。 在每次迭代中，随着“信噪比”的提高 ，调查应该越来越接近问题的根本原因 ，从而使分析更加容易。
- 一旦确定了性能瓶颈的根本原因，就采取适当的纠正措施，例如： 调整服务器参数（缓存大小、内存等）。
- 通过不同的方式编写查询来调整查询，
- 调整数据库架构（表、索引等）。
- 调整代码（这仅适用于存储引擎或服务器开发人员）。

- 从第 1 步重新开始，查看更改对性能的影响。

      和
      列对于调查性能瓶颈或死锁极为重要`mutex_instances.LOCKED_BY_THREAD_ID`。
      `rwlock_instances.WRITE_LOCKED_BY_THREAD_ID`这是通过 Performance Schema 检测实现的，如下所示：

- 假设线程 1 在等待互斥锁时卡住了。
- 您可以确定线程正在等待什么： ```sql SELECT * FROM performance_schema.events_waits_current WHERE THREAD_ID = thread_1; ``` 假设查询结果标识线程正在等待在 中找到的互斥量 events_waits_current.OBJECT_INSTANCE_BEGINA。
- 您可以确定哪个线程持有互斥量 A： ```sql SELECT * FROM performance_schema.mutex_instances WHERE OBJECT_INSTANCE_BEGIN = mutex_A; ``` 假设查询结果标识它是持有互斥量 A 的线程 2，如中所见 mutex_instances.LOCKED_BY_THREAD_ID。
- 你可以看到线程 2 在做什么： ```sql SELECT * FROM performance_schema.events_waits_current WHERE THREAD_ID = thread_2; ```

---

[← 返回 第 27 章 MySQL 性能模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
