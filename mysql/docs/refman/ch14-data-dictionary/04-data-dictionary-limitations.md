# 第 14 章 MySQL 数据字典 · 限制

> 对应 SQL：[`sql/refman/ch14-data-dictionary/04-data-dictionary-limitations.sql`](../../../sql/refman/ch14-data-dictionary/04-data-dictionary-limitations.sql)

---

## 14.8 数据字典限制

      本节介绍 MySQL 数据字典引入的临时限制。

- 不支持在数据目录下手动创建数据库目录（例如，使用mkdir）。MySQL 服务器无法识别手动创建的数据库目录。
- 由于写入存储、撤消日志和重做日志而不是.frm 文件，DDL 操作需要更长的时间。

---

[← 返回 第 14 章 MySQL 数据字典 索引](00-index.md) · [← 返回总索引](../00-index.md)
