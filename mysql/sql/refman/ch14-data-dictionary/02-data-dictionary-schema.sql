-- ============================================================
-- 第 14 章 MySQL 数据字典 · 数据字典架构

-- 文档：docs/refman/ch14-data-dictionary/02-data-dictionary-schema.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SET SESSION debug='+d,skip_dd_table_access_check';

-- ---------- 原文示例 2 ----------
SELECT name, schema_id, hidden, type FROM mysql.tables where schema_id=1 AND hidden='System';

-- ---------- 原文示例 3 ----------
SHOW CREATE TABLE mysql.catalogs\G

