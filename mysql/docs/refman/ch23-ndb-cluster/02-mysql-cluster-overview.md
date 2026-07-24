# 第 23 章 MySQL NDB Cluster 8.0 · 概述

> 对应 SQL：[`sql/refman/ch23-ndb-cluster/02-mysql-cluster-overview.sql`](../../../sql/refman/ch23-ndb-cluster/02-mysql-cluster-overview.sql)

---

## 23.2 NDB Cluster 概述

    NDB Cluster是一种在无共享系统中启用内存数据库集群的技术。无共享架构使系统能够与非常便宜的硬件一起工作，并且对硬件或软件的特定要求最少。

    NDB Cluster 被设计为没有任何单点故障。在无共享系统中，每个组件都应该有自己的内存和磁盘，并且不推荐或不支持使用共享存储机制，例如网络共享、网络文件系统和 SAN。

*NDB**Cluster将**标准*MySQL
    服务器与称为`NDB`
    （代表“网络数据库
    ”******）的内存中集群存储引擎集成在一起。在我们的文档中，该术语`NDB`指的是特定于存储引擎的设置部分，而“ MySQL NDB Cluster ”指的是一个或多个 MySQL 服务器与
    `NDB`存储引擎的组合。

    NDB Cluster 由一组称为
    主机的计算机组成，每个计算机运行一个或多个进程。这些进程称为
    节点，可能包括 MySQL 服务器（用于访问 NDB 数据）、数据节点（用于存储数据）、一个或多个管理服务器，以及可能的其他专用数据访问程序。NDB Cluster 中这些组件的关系如下所示：

**图 23.1 NDB Cluster 组件**

**所有这些程序一起工作以形成一个 NDB Cluster（请参阅 第 23.5 节，“NDB Cluster 程序”）。当 `NDB`存储引擎存储数据时，表（和表数据）存储在数据节点中。这些表可以直接访问集群中的所有其他 MySQL 服务器（SQL 节点）。因此，在集群中存储数据的薪资应用程序中，如果一个应用程序更新了员工的薪水，所有查询此数据的其他 MySQL 服务器都可以立即看到此更改。 尽管 NDB Cluster SQL 节点使用mysqld**
    服务器守护进程，但它在许多关键方面与 MySQL 8.0 发行版提供的
    **mysqld**二进制文件不同，并且这两个版本的
    **mysqld**不可互换。

    此外，未连接到 NDB Cluster 的 MySQL 服务器无法使用`NDB`存储引擎，也无法访问任何 NDB Cluster 数据。

    可以镜像存储在 NDB Cluster 的数据节点中的数据；集群可以处理单个数据节点的故障，除了少量事务因丢失事务状态而中止外，没有其他影响。因为事务应用程序应该处理事务失败，所以这不应该是问题的根源。

    可以停止和重新启动单个节点，然后可以重新加入系统（集群）。滚动重启（所有节点依次重启）用于进行配置更改和软件升级（请参阅
    第 23.6.5 节，“执行 NDB Cluster 的滚动重启”）。滚动重启也用作在线添加新数据节点过程的一部分（请参阅第 23.6.7 节，“在线添加 NDB Cluster 数据节点”）。有关数据节点、它们在 NDB Cluster 中的组织方式以及它们如何处理和存储 NDB Cluster 数据的更多信息，请参阅
    第 23.2.2 节，“NDB Cluster 节点、节点组、片段副本和分区”。

`NDB`可以使用NDB Cluster 管理客户端中的 -native 功能和 NDB Cluster 发行版中包含的**ndb_restore**程序
    来备份和恢复 NDB Cluster 数据库
    。有关更多信息，请参阅
    第 23.6.8 节，“NDB Cluster 的在线备份”和
    第 23.5.23 节，“ndb_restore - 恢复 NDB Cluster 备份”。**您还可以在mysqldump**和 MySQL 服务器中使用为此目的提供的标准 MySQL 功能
    。有关详细信息，请参阅
    第 4.5.4 节，“mysqldump — 数据库备份程序”。

    NDB Cluster 节点可以采用不同的传输机制进行节点间通信；在大多数实际部署中使用基于标准 100 Mbps 或更快以太网硬件的 TCP/IP。

---

[← 返回 第 23 章 MySQL NDB Cluster 8.0 索引](00-index.md) · [← 返回总索引](../00-index.md)
