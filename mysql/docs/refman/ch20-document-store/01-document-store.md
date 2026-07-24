# 第 20 章 使用 MySQL 作为文档存储 · 章首

> 对应 SQL：[`sql/refman/ch20-document-store/01-document-store.sql`](../../../sql/refman/ch20-document-store/01-document-store.sql)

---

# 第 20 章使用 MySQL 作为文档存储

    本章介绍另一种将 MySQL 用作文档存储的方法，有时称为“使用 NoSQL ”。如果您打算以传统 (SQL) 方式使用 MySQL，那么本章可能与您无关。

    传统上，关系数据库（如 MySQL）通常需要在存储文档之前定义模式。本节中描述的功能使您能够将 MySQL 用作文档存储，它是一种无模式的文档存储系统，因此模式灵活。例如，当您创建描述产品的文档时，您不需要在存储和操作文档之前了解和定义任何产品的所有可能属性。这不同于使用关系数据库并将产品存储在表中，后者在将任何产品添加到数据库之前必须知道并定义表的所有列。本章中描述的特性使您能够选择如何配置 MySQL，仅使用文档存储模型，

    要将 MySQL 用作文档存储，您可以使用以下服务器功能：

- X Plugin 使 MySQL Server 能够使用 X 协议与客户端通信，这是使用 MySQL 作为文档存储的先决条件。从 MySQL 8.0 开始，X 插件在 MySQL 服务器中默认启用。有关验证 X 插件安装以及配置和监视 X 插件的说明，请参阅 第 20.5 节 “X 插件”。
- X 协议支持 CRUD 和 SQL 操作，通过 SASL 进行身份验证，允许流式传输（流水线）命令，并且在协议和消息层上是可扩展的。与 X 协议兼容的客户端包括 MySQL Shell 和 MySQL 8.0 连接器。
- 使用 X 协议与 MySQL 服务器通信的客户端可以使用 X DevAPI 来开发应用程序。X DevAPI 提供现代编程接口，其设计简单但功能强大，支持已建立的行业标准概念。本章介绍如何开始使用 MySQL Shell 中 X DevAPI 的 JavaScript 或 Python 实现作为客户端。有关使用 X DevAPI 的深入教程， 请参阅 X DevAPI 用户指南。

---

[← 返回 第 20 章 使用 MySQL 作为文档存储 索引](00-index.md) · [← 返回总索引](../00-index.md)
