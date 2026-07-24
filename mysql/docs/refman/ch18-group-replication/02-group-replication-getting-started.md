# 第 18 章 组复制 · 入门

> 对应 SQL：[`sql/refman/ch18-group-replication/02-group-replication-getting-started.sql`](../../../sql/refman/ch18-group-replication/02-group-replication-getting-started.sql)

---

## 18.2 开始

    MySQL Group Replication 作为 MySQL 服务器的插件提供，组中的每个服务器都需要配置和安装插件。本节提供详细教程，其中包含创建至少包含三个成员的复制组所需的步骤。

小费

      要部署多个 MySQL 实例，您可以使用InnoDB Cluster ，它使您可以轻松地在MySQL Shell中管理一组 MySQL 服务器实例。InnoDB Cluster 将 MySQL Group Replication 包装在一个编程环境中，使您能够轻松部署 MySQL 实例集群以实现高可用性。此外，InnoDB Cluster 与MySQL Router无缝连接，使您的应用程序无需编写自己的故障转移过程即可连接到集群。但是，对于不需要高可用性的类似用例，您可以使用InnoDB ReplicaSet。可以在此处找到 MySQL Shell 的安装说明。

---

[← 返回 第 18 章 组复制 索引](00-index.md) · [← 返回总索引](../00-index.md)
