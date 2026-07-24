# 第 23 章 MySQL NDB Cluster 8.0 · NDB Cluster 基础

> 对应 SQL：[`sql/refman/ch23-ndb-cluster/03-mysql-cluster-basics.sql`](../../../sql/refman/ch23-ndb-cluster/03-mysql-cluster-basics.sql)

---

23.2.1 NDB Cluster 核心概念_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 23 章 MySQL NDB Cluster 8.0 / 23.2 NDB Cluster 概述 / 23.2.1 NDB Cluster 核心概念 NDBCLUSTER （也称为NDB）是一种内存存储引擎，提供高可用性和数据持久性功能。 NDBCLUSTER存储引擎可以配置一系列故障转移和负载平衡选项，但从集群级别的存储引擎开始是最简单的 。NDB Cluster 的NDB存储引擎包含一组完整的数据，仅依赖于集群本身内的其他数据。 NDB Cluster的“ Cluster ”部分是独立于 MySQL 服务器配置的。在 NDB Cluster 中，集群的每个部分都被认为是一个 节点。 笔记 在许多情况下，术语“节点”用于表示一台计算机，但在讨论 NDB Cluster 时，它表示一个 进程。可以在一台计算机上运行多个节点；对于运行一个或多个集群节点的计算机，我们使用术语 集群主机。 有三种类型的集群节点，在最小的 NDB Cluster 配置中，至少有三个节点，每种类型之一： 管理节点：此类节点的作用是管理 NDB Cluster 中的其他节点，执行诸如提供配置数据、启动和停止节点以及运行备份等功能。由于此节点类型管理其他节点的配置，因此应首先启动此类型的节点，然后再启动任何其他节点。使用命令ndb_mgmd启动管理节点。
- 数据节点：这种类型的节点存储集群数据。数据节点的数量与片段副本的数量相同，乘以片段的数量（请参阅第 23.2.2 节，“NDB Cluster 节点、节点组、片段副本和分区”）。例如，对于两个片段副本，每个副本都有两个片段，您需要四个数据节点。一个分片副本足以存储数据，但不提供冗余；因此，建议有两个（或更多）片段副本以提供冗余，从而提供高可用性。使用命令ndbd启动数据节点 （请参阅第 23.5.1 节，“ndbd — NDB Cluster 数据节点守护进程”）或 ndbmtd（请参阅 第 23.5.3 节，“ndbmtd — NDB Cluster 数据节点守护进程（多线程）”）。 NDB Cluster 表通常完全存储在内存中而不是磁盘上（这就是为什么我们将 NDB Cluster 称为 内存数据库）。但是，一些 NDB Cluster 数据可以存储在磁盘上；有关更多信息，请参阅 第 23.6.10 节，“NDB Cluster 磁盘数据表”。
- SQL节点：这是一个访问集群数据的节点。对于 NDB Cluster，SQL 节点是使用 NDBCLUSTER存储引擎的传统 MySQL 服务器。SQL 节点是一个以和 选项启动的mysqld进程 ，这些在本章的其他地方进行了解释，可能还有其他 MySQL 服务器选项。 --ndbcluster--ndb-connectstring SQL 节点实际上只是一种特殊类型的 API 节点，它指定访问 NDB Cluster 数据的任何应用程序。API 节点的另一个示例 是用于恢复集群备份的ndb_restore实用程序。可以使用 NDB API 编写此类应用程序。有关 NDB API 的基本信息，请参阅 NDB API入门。

重要的

        期望在生产环境中采用三节点设置是不现实的。这样的配置不提供冗余；要从 NDB Cluster 的高可用性特性中受益，您必须使用多个数据和 SQL 节点。还强烈建议使用多个管理节点。

      有关 NDB Cluster 中节点、节点组、片段副本和分区之间关系的简要介绍，请参阅
      第 23.2.2 节，“NDB Cluster 节点、节点组、片段副本和分区”。

      集群的配置涉及配置集群中的每个单独节点以及在节点之间设置单独的通信链路。NDB Cluster 目前的设计意图是数据节点在处理器能力、内存空间和带宽方面是同构的。此外，为了提供单点配置，整个集群的所有配置数据都位于一个配置文件中。

      管理服务器管理集群配置文件和集群日志。集群中的每个节点都从管理服务器检索配置数据，因此需要一种方法来确定管理服务器所在的位置。当数据节点中发生有趣的事件时，节点将有关这些事件的信息传输到管理服务器，然后管理服务器将信息写入集群日志。

      此外，可以有任意数量的集群客户端进程或应用程序。这些包括标准的 MySQL 客户端、
      `NDB`特定的 API 程序和管理客户端。这些将在接下来的几段中进行描述。

**标准 MySQL 客户端。**
        NDB Cluster 可以与用 PHP、Perl、C、C++、Java、Python 等编写的现有 MySQL 应用程序一起使用。此类客户端应用程序向充当 NDB Cluster SQL 节点的 MySQL 服务器发送 SQL 语句并从中接收响应，其方式与它们与独立 MySQL 服务器交互的方式大致相同。

      可以修改使用 NDB Cluster 作为数据源的 MySQL 客户端，以利用与多个 MySQL 服务器连接的能力来实现负载平衡和故障转移。例如，使用 Connector/J 5.0.6 及更高版本的 Java 客户端可以使用
      `jdbc:mysql:loadbalance://`URL（在 Connector/J 5.1.7 中得到改进）透明地实现负载平衡；有关将 Connector/J 与 NDB Cluster 一起使用的更多信息，请参阅
      将 Connector/J 与 NDB Cluster 一起使用。

**NDB 客户端程序。**
        可以编写客户端程序直接从`NDBCLUSTER`存储引擎访问 NDB Cluster 数据，绕过任何可能连接到集群的 MySQL 服务器，使用NDB API，一个高级 C++ API。此类应用程序可用于不需要数据的 SQL 接口的特殊用途。有关详细信息，请参阅
        NDB API。

      `NDB`特定的 Java 应用程序也可以使用NDB Cluster Connector for Java为 NDB Cluster 编写。这个 NDB Cluster 连接器包括ClusterJ，一个高级数据库 API，类似于直接连接到 的对象关系映射持久性框架，例如 Hibernate 和 JPA，`NDBCLUSTER`因此不需要访问 MySQL 服务器。有关更多信息，请参阅
      Java 和 NDB Cluster以及
      ClusterJ API 和数据对象模型。

      NDB Cluster 还支持使用 Node.js 以 JavaScript 编写的应用程序。用于 JavaScript 的 MySQL 连接器包括用于直接访问`NDB`存储引擎和 MySQL 服务器的适配器。使用此连接器的应用程序通常是事件驱动的，并使用在许多方面类似于 ClusterJ 使用的域对象模型。有关详细信息，请参阅适用于 JavaScript 的 MySQL NoSQL 连接器。

**管理客户。**
        这些客户端连接到管理服务器并提供用于正常启动和停止节点、启动和停止消息跟踪（仅限调试版本）、显示节点版本和状态、启动和停止备份等的命令。此类程序的一个示例是
        NDB Cluster 提供的**ndb_mgm**管理客户端（请参阅第 23.5.5 节，“ndb_mgm — NDB Cluster 管理客户端”）。此类应用程序可以使用
        MGM API编写，这是一种 C 语言 API，可直接与一个或多个 NDB Cluster 管理服务器通信。有关详细信息，请参阅
        MGM API。

      Oracle 还提供了 MySQL Cluster Manager，它提供了一个高级命令行界面，简化了许多复杂的 NDB Cluster 管理任务，例如重新启动具有大量节点的 NDB Cluster。MySQL Cluster Manager 客户端还支持用于获取和设置大多数节点配置参数值的命令，以及与 NDB Cluster 相关的**mysqld服务器选项和变量。**MySQL Cluster Manager 1.4.8 为 NDB 8.0 提供实验性支持。有关详细信息，请参阅MySQL Cluster Manager 1.4.8 用户手册。

**事件日志。**
        NDB Cluster 按类别（启动、关闭、错误、检查点等）、优先级和严重性记录事件。所有可报告事件的完整列表可以在
        第 23.6.3 节，“NDB Cluster 中生成的事件报告”中找到。事件日志是此处列出的两种类型：

- 集群日志：记录整个集群的所有需要​​的可报告事件。
- 节点日志：一个单独的日志，也为每个单独的节点保留。

笔记

        一般情况下，只保存和检查集群日志就足够了。仅出于应用程序开发和调试目的才需要查阅节点日志。

**检查站。**
        一般来说，当数据保存到磁盘时，就说到达了一个检查点。更具体地说，对于 NDB Cluster，检查点是一个时间点，所有提交的事务都存储在磁盘上。关于`NDB`存储引擎，有两种类型的检查点协同工作以确保维护集群数据的一致视图。这些显示在以下列表中：

- 本地检查点（LCP）：这是特定于单个节点的检查点；然而，LCP 或多或少同时发生在集群中的所有节点上。LCP 通常每隔几分钟发生一次；精确的时间间隔会有所不同，并且取决于节点存储的数据量、集群活动级别和其他因素。 NDB 8.0 支持部分 LCP，在某些情况下可以显着提高性能。请参阅 启用部分 LCP 并控制它们使用的存储量 的EnablePartialLcp和 配置参数的说明。RecoveryWork
- 全局检查点 (GCP)：当所有节点的事务同步并且重做日志刷新到磁盘时，GCP 每隔几秒发生一次。

      有关本地检查点和全局检查点创建的文件和目录的更多信息，请参阅
      NDB Cluster 数据节点文件系统目录。

---

[← 返回 第 23 章 MySQL NDB Cluster 8.0 索引](00-index.md) · [← 返回总索引](../00-index.md)
