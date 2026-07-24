# 第 23 章 MySQL NDB Cluster 8.0 · 配置

> 对应 SQL：[`sql/refman/ch23-ndb-cluster/05-mysql-cluster-configuration.sql`](../../../sql/refman/ch23-ndb-cluster/05-mysql-cluster-configuration.sql)

---

## 23.4 NDB Cluster的配置

    作为 NDB Cluster 一部分的 MySQL 服务器在一个主要方面与普通（非集群）MySQL 服务器不同，因为它使用`NDB`存储引擎。该引擎有时也称为
    `NDBCLUSTER`，尽管
    `NDB`是首选。

    为了避免不必要的资源分配，服务器默认配置为`NDB`
    禁用存储引擎。要启用`NDB`，您必须修改服务器的`my.cnf`
    配置文件，或者使用该
    `--ndbcluster`选项启动服务器。

    这个MySQL服务器是集群的一部分，所以它也必须知道如何访问管理节点来获取集群配置数据。默认行为是在 上查找管理节点
    `localhost`。但是，如果您需要指定它的位置在别处，这可以在 中
    `my.cnf`或使用**mysql**
    客户端完成。在`NDB`可以使用存储引擎之前，至少有一个管理节点以及任何所需的数据节点必须处于运行状态。

有关特定于 NDB Cluster 的
    `--ndbcluster`其他
    **mysqld**选项
    的更多信息
    ，请参阅第 23.4.3.9.1 节，“NDB Cluster 的 MySQL 服务器选项”。

    有关安装 NDB Cluster 的一般信息，请参阅
    第 23.3 节，“NDB Cluster 安装”。

---

[← 返回 第 23 章 MySQL NDB Cluster 8.0 索引](00-index.md) · [← 返回总索引](../00-index.md)
