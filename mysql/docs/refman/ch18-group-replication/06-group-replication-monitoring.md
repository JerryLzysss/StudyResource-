# 第 18 章 组复制 · 监控

> 对应 SQL：[`sql/refman/ch18-group-replication/06-group-replication-monitoring.sql`](../../../sql/refman/ch18-group-replication/06-group-replication-monitoring.sql)

---

## 18.4 监控组复制

    假设
    启用了性能模式，请使用性能模式表来监视组复制。下表显示特定于组复制的信息：

- performance_schema.replication_group_member_stats
- performance_schema.replication_group_members

    请参阅第 18.4.3 节，“replication_group_members 表”和
    第 18.4.4 节，“replication_group_member_stats 表”，它们讨论了解释这些表中可用的信息。

    这些 Performance Schema 复制表还显示了与 Group Replication 相关的信息：

- performance_schema.replication_connection_status 显示有关组复制的信息，例如已从组接收并在应用程序队列（中继日志）中排队的事务。
- performance_schema.replication_applier_status 显示组复制相关通道和线程的状态。如果有许多不同的工作线程在应用事务，那么工作表也可以用来监视每个工作线程在做什么。

    此处列出了由 Group Replication 插件创建的复制通道：

- group_replication_recovery- 此通道用于与分布式恢复阶段相关的复制更改。
- group_replication_applier- 此通道用于来自组的传入更改。这是用于应用直接来自集团的交易的渠道。

    从 MySQL 8.0.21 开始，非错误情况的组复制生命周期事件被归类为系统消息，并且始终记录到复制组成员上的服务器错误日志中。您可以使用此信息来查看服务器在复制组中的成员身份的历史记录。在以前的版本中，非错误情况的 Group Replication 生命周期事件被归类为信息消息，可以通过
    `log_error_verbosity`为服务器指定级别 3 将其添加到错误日志中。

    一些影响整个组的生命周期事件记录在每个组成员上，例如新成员进入
    `ONLINE`组状态或初选。其他事件仅记录在发生它们的成员上，例如在成员上启用或禁用超级只读模式，或者成员离开组。许多生命周期事件如果频繁发生则可以指示问题，这些事件将记录为警告消息，包括成员变得不可访问和再次可访问，以及成员通过二进制日志的状态传输或远程克隆操作开始分布式恢复。

笔记

      如果您正在使用
      **mysqladmin**监视一个或多个辅助实例，您应该知道
      `FLUSH STATUS`此实用程序执行的语句会在本地实例上创建一个 GTID 事件，这可能会影响未来的组操作。

---

[← 返回 第 18 章 组复制 索引](00-index.md) · [← 返回总索引](../00-index.md)
