# 第 19 章 MySQL Shell · 用户指南

> 对应 SQL：[`sql/refman/ch19-mysql-shell/01-mysql-shell-userguide.sql`](../../../sql/refman/ch19-mysql-shell/01-mysql-shell-userguide.sql)

---

# 第十九章MySQL Shell

    MySQL Shell 是 MySQL Server 的高级客户端和代码编辑器。除了提供的 SQL 功能外，类似于
    **mysql**，MySQL Shell 还为 JavaScript 和 Python 提供脚本功能，并包括用于与 MySQL 一起工作的 API。MySQL Shell 是一个可以单独安装的组件。

    下面的讨论简要描述了 MySQL Shell 的功能。有关详细信息，请参阅 MySQL Shell 手册，网址为

    MySQL Shell 包括以下用 JavaScript 和 Python 实现的 API，您可以使用它们来开发与 MySQL 交互的代码。

- 当 MySQL Shell 使用 X 协议连接到 MySQL 服务器时，X DevAPI 使开发人员能够处理关系数据和文档数据。这使您能够将 MySQL 用作文档存储，有时称为“使用 NoSQL ”。有关详细信息，请参阅 第 20 章，使用 MySQL 作为文档存储。有关在 MySQL Shell 中实现的 X DevAPI 的概念和用法的文档，请参阅X DevAPI 用户指南。
- AdminAPI 使数据库管理员能够使用 InnoDB Cluster，它使用基于 InnoDB 的 MySQL 数据库提供了高可用性和可扩展性的集成解决方案，而无需高级 MySQL 专业知识。AdminAPI 还包括对 InnoDB ReplicaSet 的支持，这使您能够以类似于 InnoDB Cluster 的方式管理一组运行基于 GTID 的异步复制的 MySQL 实例。此外，AdminAPI 使 MySQL Router 的管理更加容易，包括与 InnoDB Cluster 和 InnoDB ReplicaSet 的集成。请参阅MySQL 管理 API。

    MySQL Shell 有两个版本，社区版和商业版。社区版是免费提供的。商业版以低成本提供额外的企业功能。

---

[← 返回 第 19 章 MySQL Shell 索引](00-index.md) · [← 返回总索引](../00-index.md)
