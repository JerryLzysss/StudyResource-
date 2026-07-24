# 第 3 章 教程 · 检索信息

> 对应 SQL：[`sql/refman/ch03-tutorial/07-retrieving-data.sql`](../../../sql/refman/ch03-tutorial/07-retrieving-data.sql)

---

3.3.4 从表中检索信息_MySQL 8.0 参考手册

Skip to Main Content

			Documentation

Section Menu:

		* MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 3 章教程 / 3.3 创建和使用数据库 / 3.3.4 从表中检索信息 该`SELECT`语句用于从表中提取信息。语句的一般形式是： ```sql SELECT what_to_select FROM which_table WHERE conditions_to_satisfy; ``` `what_to_select`*表示您想看到的内容。这可以是列列表，或
        `*`指示“所有列。”
        *`which_table`*表示要从中检索数据的表。该`WHERE`
        子句是可选的。如果存在，
        *`conditions_to_satisfy`*则指定行必须满足才能符合检索条件的一个或多个条件。

---

[← 返回 第 3 章 教程 索引](00-index.md) · [← 返回总索引](../00-index.md)
