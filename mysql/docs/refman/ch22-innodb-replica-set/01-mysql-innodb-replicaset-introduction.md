# 第 22 章 InnoDB 副本集 · ReplicaSet 简介

> 对应 SQL：[`sql/refman/ch22-innodb-replica-set/01-mysql-innodb-replicaset-introduction.sql`](../../../sql/refman/ch22-innodb-replica-set/01-mysql-innodb-replicaset-introduction.sql)

---

# 第 22 章 InnoDB 副本集

    本章介绍 MySQL InnoDB ReplicaSet，它结合了 MySQL 技术，使您能够部署和管理
    第 17 章，*复制*。此内容是 InnoDB ReplicaSet 的高级概述，有关完整文档，请参阅
    MySQL InnoDB ReplicaSet。

    InnoDB ReplicaSet 由至少两个 MySQL Server 实例组成，它提供了您熟悉的所有 MySQL Replication 功能，例如读取横向扩展和数据安全性。InnoDB ReplicaSet 使用以下 MySQL 技术：

- MySQL Shell，它是 MySQL 的高级客户端和代码编辑器。
- MySQL 服务器和第 17 章，复制，它使一组 MySQL 实例能够提供可用性和异步读取横向扩展。InnoDB ReplicaSet 提供了一种替代的、易于使用的编程方式来处理复制。
- MySQL Router，一种轻量级中间件，可在您的应用程序和 InnoDB ReplicaSet 之间提供透明路由。

    InnoDB ReplicaSet 的接口类似于
    MySQL InnoDB Cluster，您使用 MySQL Shell 将 MySQL Server 实例作为 ReplicaSet 工作，并且 MySQL Router 也以与 InnoDB Cluster 相同的方式紧密集成。

    基于 MySQL 复制，InnoDB ReplicaSet 有一个主实例，它复制到一个或多个辅助实例。InnoDB ReplicaSet 不提供 InnoDB Cluster 提供的所有功能，例如自动故障转移或多主模式。但是，它确实支持以类似方式配置、添加和删除实例等功能。您可以手动切换或故障转移到辅助实例，例如在发生故障时。您甚至可以采用现有的 Replication 部署，然后将其作为 InnoDB ReplicaSet 进行管理。

    您使用
    作为 MySQL Shell 的一部分提供的AdminAPI来处理 InnoDB ReplicaSet。AdminAPI 在 JavaScript 和 Python 中可用，非常适合 MySQL 部署的脚本和自动化，以实现高可用性和可扩展性。通过使用 MySQL Shell 的 AdminAPI，您可以避免手动配置许多实例。相反，AdminAPI 为一组 MySQL 实例提供了一个有效的现代接口，使您能够从一个中央工具配置、管理和监控您的部署。

    要开始使用 InnoDB ReplicaSet，您需要
    下载
    并安装MySQL Shell。你需要一些安装了 MySQL Server 实例的主机
    ，你也可以
    安装MySQL Router。

    InnoDB ReplicaSet 支持MySQL Clone，这使您能够简单地提供实例。过去，要在加入 MySQL 复制部署之前配置新实例，您需要以某种方式手动将事务传输到加入实例。这可能涉及制作文件副本、手动复制文件等。您只需
    将一个实例添加到副本集，它就会自动配置。

    同样，InnoDB ReplicaSet 与
    MySQL Router紧密集成，您可以使用 AdminAPI与
    它们一起工作。MySQL Router 可以在称为引导的过程中基于 InnoDB ReplicaSet 自动配置自身
    ，这样您就无需手动配置路由。MySQL Router 然后透明地将客户端应用程序连接到 InnoDB ReplicaSet，为客户端连接提供路由和负载平衡。此集成还使您能够使用 AdminAPI 管理针对 InnoDB ReplicaSet 引导的 MySQL 路由器的某些方面。InnoDB ReplicaSet 状态信息包括有关针对 ReplicaSet 引导的 MySQL 路由器的详细信息。操作使您能够
    在 ReplicaSet 级别创建 MySQL Router 用户
    ，以使用针对 ReplicaSet 引导的 MySQL Routers，等等。

    有关这些技术的更多信息，请参阅说明中链接的用户文档。除了此用户文档之外，MySQL Shell JavaScript API 参考或 MySQL Shell Python API 参考中还有所有 AdminAPI 方法的开发人员文档，可从
    Connectors and APIs获得。

---

[← 返回 第 22 章 InnoDB 副本集 索引](00-index.md) · [← 返回总索引](../00-index.md)
