-- ============================================================
-- 第 10 章 字符集、排序规则、Unicode · 元数据字符集

-- 文档：docs/refman/ch10-charset/08-charset-metadata.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SHOW VARIABLES LIKE 'character_set_system';
-- +----------------------+---------+
| Variable_name        | Value   |
-- +----------------------+---------+
| character_set_system | utf8mb3 |
-- +----------------------+---------+

-- ---------- 原文示例 2 ----------
SELECT * FROM t1 WHERE USER() = latin1_column;

-- ---------- 原文示例 3 ----------
INSERT INTO t1 (latin1_column) SELECT USER();

