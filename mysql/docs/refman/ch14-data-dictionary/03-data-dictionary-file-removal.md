# 第 14 章 MySQL 数据字典 · 数据字典与文件移除

> 对应 SQL：[`sql/refman/ch14-data-dictionary/03-data-dictionary-file-removal.sql`](../../../sql/refman/ch14-data-dictionary/03-data-dictionary-file-removal.sql)

---

## 14.2 删除基于文件的元数据存储

      在以前的 MySQL 版本中，字典数据部分存储在元数据文件中。基于文件的元数据存储的问题包括昂贵的文件扫描、对文件系统相关错误的敏感性、处理复制和崩溃恢复失败状态的复杂代码，以及缺乏可扩展性，这使得为新功能和关系对象添加元数据变得困难.

      下面列出的元数据文件已从 MySQL 中删除。除非另有说明，否则以前存储在元数据文件中的数据现在存储在数据字典表中。

- .frm文件：表元数据文件。随着.frm文件的删除： .frm删除了文件结构 强加的 64KB 表定义大小限制 。
- 该列报告硬编码值，这是 MySQL 5.7 中使用的最后一个 文件版本。 INFORMATION_SCHEMA.TABLES VERSION10.frm

- .parfiles：分区定义文件。 InnoDB随着对表的本机分区支持的引入，在 MySQL 5.7 中停止使用分区定义文件InnoDB。
- .TRNfiles：触发器命名空间文件。
- .TRGfiles：触发参数文件。
- .islfiles：InnoDB 符号链接文件，包含 在数据目录之外创建 的file-per-table 表空间文件的位置。
- db.optfiles：数据库配置文件。这些文件（每个数据库目录一个）包含数据库默认字符集属性。
- ddl_log.log文件：该文件包含由数据定义语句（如DROP TABLE 和）生成的元数据操作的记录ALTER TABLE。

---

[← 返回 第 14 章 MySQL 数据字典 索引](00-index.md) · [← 返回总索引](../00-index.md)
