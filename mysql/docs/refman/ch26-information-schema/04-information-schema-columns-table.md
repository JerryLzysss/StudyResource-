# 第 26 章 INFORMATION_SCHEMA 表 · COLUMNS

> 对应 SQL：[`sql/refman/ch26-information-schema/04-information-schema-columns-table.sql`](../../../sql/refman/ch26-information-schema/04-information-schema-columns-table.sql)

---

26.3.8 INFORMATION_SCHEMA COLUMNS 表_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 26 章 INFORMATION_SCHEMA 表 / 26.3 INFORMATION_SCHEMA 总表 / 26.3.8 INFORMATION_SCHEMA COLUMNS 表 该COLUMNS表提供有关表中列的信息。相关 ST_GEOMETRY_COLUMNS表提供有关存储空间数据的表列的信息。请参阅 第 26.3.35 节，“INFORMATION_SCHEMA ST_GEOMETRY_COLUMNS 表”。 该COLUMNS表有以下列： TABLE_CATALOG 包含该列的表所属目录的名称。该值始终为def.
- TABLE_SCHEMA 包含该列的表所属的模式（数据库）的名称。
- TABLE_NAME 包含该列的表的名称。
- COLUMN_NAME 列的名称。
- ORDINAL_POSITION 列在表中的位置。 ORDINAL_POSITION是必要的，因为你可能想说ORDER BY ORDINAL_POSITION。与 不同SHOW COLUMNS，SELECTfromCOLUMNS表没有自动排序。
- COLUMN_DEFAULT 列的默认值。这是 NULL如果列具有显式默认值NULL，或者如果列定义不包含任何DEFAULT子句。
- IS_NULLABLE 列的可空性。该值是值YES是否 NULL可以存储在列中， NO如果不是。
- DATA_TYPE 列数据类型。 该DATA_TYPE值只是类型名称，没有其他信息。该COLUMN_TYPE 值包含类型名称和可能的其他信息，例如精度或长度。
- CHARACTER_MAXIMUM_LENGTH 对于字符串列，以字符为单位的最大长度。
- CHARACTER_OCTET_LENGTH 对于字符串列，最大长度（以字节为单位）。
- NUMERIC_PRECISION 对于数字列，数字精度。
- NUMERIC_SCALE 对于数字列，数字刻度。
- DATETIME_PRECISION 对于时间列，小数秒精度。
- CHARACTER_SET_NAME 对于字符串列，字符集名称。
- COLLATION_NAME 对于字符串列，排序规则名称。
- COLUMN_TYPE 列数据类型。 该DATA_TYPE值只是类型名称，没有其他信息。该COLUMN_TYPE 值包含类型名称和可能的其他信息，例如精度或长度。
- COLUMN_KEY 该列是否被索引： 如果COLUMN_KEY为空，则该列未编制索引或仅作为多列非唯一索引中的辅助列编制索引。
- 如果COLUMN_KEY是 PRI，则该列是一个PRIMARY KEY或是多列中的列之一PRIMARY KEY。
- 如果COLUMN_KEY是 UNI，则该列是UNIQUE索引的第一列。（ UNIQUE索引允许多个 NULL值，但您可以NULL通过检查 Null列来判断该列是否允许。）
- 如果COLUMN_KEY是 MUL，则该列是非唯一索引的第一列，在该索引中允许在该列中多次出现给定值。

          如果多个`COLUMN_KEY`值应用于表的给定列，
          `COLUMN_KEY`则显示具有最高优先级的值，顺序为`PRI`,
           `UNI`, `MUL`。

`UNIQUE`索引可能显示为

          好像`PRI`它不能包含
          `NULL`值并且
          `PRIMARY KEY`表中没有。一个
          `UNIQUE`索引可能显示为
          `MUL`多个列组成一个复合
          `UNIQUE`索引；尽管列的组合是唯一的，但每一列仍然可以包含多次出现的给定值。

- EXTRA 有关给定列的任何其他可用信息。在这些情况下该值是非空的： auto_increment对于具有AUTO_INCREMENT属性的列。
- on update CURRENT_TIMESTAMPfor TIMESTAMP或 DATETIME具有ON UPDATE CURRENT_TIMESTAMP 属性的列。
- STORED GENERATED或VIRTUAL GENERATED生成的列。
- DEFAULT_GENERATED对于具有表达式默认值的列。

- PRIVILEGES 您对该列拥有的权限。
- COLUMN_COMMENT 列定义中包含的任何注释。
- GENERATION_EXPRESSION 对于生成的列，显示用于计算列值的表达式。对于非生成列为空。有关生成的列的信息，请参阅 第 13.1.20.8 节，“CREATE TABLE 和生成的列”。
- SRS_ID 此值适用于空间列。它包含 SRID指示列中存储的值的空间参考系统的列值。请参阅 第 11.4.1 节，“空间数据类型”和 第 11.4.5 节，“空间参考系统支持”。该值适用 NULL于非空间列和没有SRID属性的空间列。

#### 笔记

- 在SHOW COLUMNS中， Type显示包括来自几个不同COLUMNS列的值。
- CHARACTER_OCTET_LENGTH应与 相同CHARACTER_MAXIMUM_LENGTH，但多字节字符集除外。
- CHARACTER_SET_NAME可以从 派生 COLLATION_NAME。例如，如果您说 SHOW FULL COLUMNS FROM t，并且您在COLLATION_NAME列中看到值 utf8mb4_swedish_ci，则字符集是出现在第一个下划线之前的字符集： utf8mb4。

      列信息也可从
      `SHOW COLUMNS`语句中获得。请参阅
      第 13.7.7.5 节，“显示列语句”。下面的语句几乎是等价的：

```sql
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = 'tbl_name'
  [AND table_schema = 'db_name']
  [AND column_name LIKE 'wild']

SHOW COLUMNS
  FROM tbl_name
  [FROM db_name]
  [LIKE 'wild']
```

      在MySQL 8.0.30及之后的版本中，生成的不可见主键列的信息默认在该表中是可见的。您可以通过设置隐藏此类信息
      `show_gipk_in_create_table_and_information_schema = OFF`。有关详细信息，请参阅
      第 13.1.20.11 节，“生成的不可见主键”。

---

[← 返回 第 26 章 INFORMATION_SCHEMA 表 索引](00-index.md) · [← 返回总索引](../00-index.md)
