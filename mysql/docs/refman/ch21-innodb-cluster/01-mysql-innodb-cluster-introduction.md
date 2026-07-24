# 第 21 章 InnoDB Cluster · InnoDB Cluster 简介

> 对应 SQL：[`sql/refman/ch21-innodb-cluster/01-mysql-innodb-cluster-introduction.sql`](../../../sql/refman/ch21-innodb-cluster/01-mysql-innodb-cluster-introduction.sql)

---

# 第21章InnoDB Cluster

    本章介绍 MySQL InnoDB Cluster，它结合了 MySQL 技术，使您能够为 MySQL 部署和管理完整的集成高可用性解决方案。此内容是 InnoDB Cluster 的高级概述，有关完整文档，请参阅
    MySQL InnoDB Cluster。

重要的

      InnoDB Cluster 不提供对 MySQL NDB Cluster 的支持。有关 MySQL NDB Cluster 的更多信息，请参阅
      第 23 章，*MySQL NDB Cluster 8.0*和
      第 23.2.6 节，“使用 InnoDB 的 MySQL 服务器与 NDB Cluster 相比”。

    InnoDB Cluster 由至少三个 MySQL Server 实例组成，它提供高可用性和扩展功能。InnoDB Cluster 使用以下 MySQL 技术：

- MySQL Shell，它是 MySQL 的高级客户端和代码编辑器。
- MySQL Server 和Group Replication，它使一组 MySQL 实例能够提供高可用性。InnoDB Cluster 提供了一种替代的、易于使用的编程方式来使用组复制。
- MySQL Router，一种轻量级中间件，可在您的应用程序和 InnoDB Cluster 之间提供透明路由。

    下图概述了这些技术如何协同工作：

**图 21.1 InnoDB Cluster 概览**

    基于 MySQL Group Replication构建，提供自动成员管理、容错、自动故障转移等功能。InnoDB Cluster 通常以单主模式运行，有一个主实例（读写）和多个从实例（只读）。高级用户还可以利用
    多主
    模式，其中所有实例都是主实例。您甚至可以在 InnoDB Cluster 在线时更改集群的拓扑结构，以确保尽可能高的可用性。

您使用作为 MySQL Shell 的一部分提供的AdminAPI
    来处理 InnoDB Cluster
     。AdminAPI 在 JavaScript 和 Python 中可用，非常适合 MySQL 部署的脚本和自动化，以实现高可用性和可扩展性。通过使用 MySQL Shell 的 AdminAPI，您可以避免手动配置许多实例。相反，AdminAPI 为一组 MySQL 实例提供了一个有效的现代接口，使您能够从一个中央工具配置、管理和监控您的部署。

    要开始使用 InnoDB Cluster，您需要
    下载
    并安装MySQL Shell。你需要一些安装了 MySQL Server 实例的主机
    ，你也可以
    安装MySQL Router。

    InnoDB Cluster 支持MySQL Clone，这使您能够简单地配置实例。过去，要在加入一组 MySQL 实例之前配置一个新实例，您需要以某种方式手动将事务传输到加入实例。这可能涉及制作文件副本、手动复制文件等。使用 InnoDB Cluster，您只需将一个实例添加到集群，它就会自动配置。

    同样，InnoDB Cluster 与
    MySQL Router紧密集成，您可以使用 AdminAPI与
    它们一起工作。MySQL Router 可以在一个名为bootstrapping的过程中基于 InnoDB Cluster 自动配置自己
    ，这样您就无需手动配置路由。然后，MySQL Router 透明地将客户端应用程序连接到 InnoDB 集群，为客户端连接提供路由和负载平衡。此集成还使您能够使用 AdminAPI 管理针对 InnoDB 集群引导的 MySQL 路由器的某些方面。InnoDB Cluster 状态信息包括有关针对集群引导的 MySQL 路由器的详细信息。操作使您能够在集群级别创建 MySQL Router 用户，以使用针对集群引导的 MySQL Routers，等等。

    有关这些技术的更多信息，请参阅说明中链接的用户文档。除了此用户文档之外，MySQL Shell JavaScript API 参考或 MySQL Shell Python API 参考中还有所有 AdminAPI 方法的开发人员文档，可从
    Connectors and APIs获得。

---

[← 返回 第 21 章 InnoDB Cluster 索引](00-index.md) · [← 返回总索引](../00-index.md)
