# 第 24 章 分区 · 章首

> 对应 SQL：[`sql/refman/ch24-partitioning/01-partitioning.sql`](../../../sql/refman/ch24-partitioning/01-partitioning.sql)

---

# 第24章分区

    本章讨论用户定义的分区。

笔记

      表分区不同于窗口函数使用的分区。有关窗口函数的信息，请参阅
      第 12.21 节，“窗口函数”。

`InnoDB`在 MySQL 8.0 中，

    分区支持由
    `NDB`存储引擎提供。

    MySQL 8.0 目前不支持使用除`InnoDB`
    或之外的任何存储引擎对表进行分区`NDB`，例如
    `MyISAM`. 尝试使用不提供本机分区支持的存储引擎创建分区表失败并显示
    `ER_CHECK_NOT_IMPLEMENTED`。

    Oracle 提供的 MySQL 8.0 社区二进制文件包括存储引擎提供`InnoDB`的
    分区支持。`NDB`有关 MySQL Enterprise Edition 二进制文件中提供的分区支持的信息，请参阅
    第 30 章，*MySQL Enterprise Edition*。

    如果您从源代码编译 MySQL 8.0，配置构建`InnoDB`支持足以生成具有
    `InnoDB`表分区支持的二进制文件。有关详细信息，请参阅
    第 2.9 节，“从源代码安装 MySQL”。

    不需要做任何进一步的事情来启用分区支持
    `InnoDB`（例如，文件中不需要特殊条目`my.cnf`）。

`InnoDB`存储引擎

    无法禁用分区支持
    。

有关分区和分区概念的介绍，

    请参阅第 24.1 节，“MySQL 分区概述” 。

    支持多种类型的分区，以及子分区；参见第 24.2 节，“分区类型”和
    第 24.2.6 节，“子分区”。

    第 24.3 节，“分区管理”，涵盖了在现有分区表中添加、删除和更改分区的方法。

    第 24.3.4 节，“分区的维护”，讨论了用于分区表的表维护命令。

    数据库中的`PARTITIONS`表
    `INFORMATION_SCHEMA`提供有关分区和分区表的信息。有关更多信息，请参见
    第 26.3.21 节，“INFORMATION_SCHEMA PARTITIONS 表”；有关针对此表的查询的一些示例，请参阅
    第 24.2.7 节，“MySQL 分区如何处理 NULL”。

    有关 MySQL 8.0 中分区的已知问题，请参阅
    第 24.6 节，“分区的限制和限制”。

    在使用分区表时，您可能还会发现以下资源很有用。

**其他资源。**
      有关 MySQL 中用户定义分区的其他信息来源包括：

- MySQL分区论坛 这是为那些对 MySQL 分区技术感兴趣或尝试使用 MySQL 分区技术的人提供的官方论坛。它包含来自 MySQL 开发人员和其他人的公告和更新。它由分区开发和文档团队的成员监控。
- Mikael Ronström 的博客 MySQL 分区架构师和首席开发人员 Mikael Ronström 经常在这里发布有关他在 MySQL 分区和 NDB 集群方面的工作的文章。
- 星球MySQL 一个 MySQL 新闻站点，提供与 MySQL 相关的博客，任何使用我的 MySQL 的人都应该感兴趣。我们鼓励您在此处查看由使用 MySQL 分区的人员保存的博客链接，或者将您自己的博客添加到所涵盖的内容中。

---

[← 返回 第 24 章 分区 索引](00-index.md) · [← 返回总索引](../00-index.md)
