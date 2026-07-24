# 第 26 章 INFORMATION_SCHEMA 表 · SCHEMATA

> 对应 SQL：[`sql/refman/ch26-information-schema/06-information-schema-schemata-table.sql`](../../../sql/refman/ch26-information-schema/06-information-schema-schemata-table.sql)

---

26.3.31 INFORMATION_SCHEMA SCHEMATA 表_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 26 章 INFORMATION_SCHEMA 表 / 26.3 INFORMATION_SCHEMA 总表 / 26.3.31 INFORMATION_SCHEMA SCHEMATA 表 架构是一个数据库，因此该 SCHEMATA表提供有关数据库的信息。 该SCHEMATA表有以下列： CATALOG_NAME 架构所属目录的名称。该值始终为def.
- SCHEMA_NAME 模式的名称。
- DEFAULT_CHARACTER_SET_NAME 架构默认字符集。
- DEFAULT_COLLATION_NAME 架构默认排序规则。
- SQL_PATH 该值始终为NULL.
- DEFAULT_ENCRYPTION 架构默认加密。此列是在 MySQL 8.0.16 中添加的。

      模式名称也可从`SHOW DATABASES`语句中获得。请参阅
      第 13.7.7.14 节，“显示数据库语句”。以下语句是等效的：

```sql
SELECT SCHEMA_NAME AS `Database`
  FROM INFORMATION_SCHEMA.SCHEMATA
  [WHERE SCHEMA_NAME LIKE 'wild']

SHOW DATABASES
  [LIKE 'wild']
```

      您只能看到您拥有某种特权的那些数据库，除非您拥有全局`SHOW DATABASES`特权。

警告

        因为任何静态全局权限都被认为是所有数据库的权限，所以任何静态全局权限都使用户能够使用`SHOW DATABASES`或通过检查
        `SCHEMATA`表
        来查看所有数据库名称`INFORMATION_SCHEMA`，但已通过部分撤销在数据库级别受到限制的数据库除外。

#### 笔记

- 该表使用有关架构选项的信息 SCHEMATA_EXTENSIONS扩充了表。SCHEMATA

---

[← 返回 第 26 章 INFORMATION_SCHEMA 表 索引](00-index.md) · [← 返回总索引](../00-index.md)
