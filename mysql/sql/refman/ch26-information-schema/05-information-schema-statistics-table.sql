-- ============================================================
-- 第 26 章 INFORMATION_SCHEMA 表 · STATISTICS

-- 文档：docs/refman/ch26-information-schema/05-information-schema-statistics-table.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT * FROM INFORMATION_SCHEMA.STATISTICS
  WHERE table_name = 'tbl_name'
  AND table_schema = 'db_name'

SHOW INDEX
  FROM tbl_name
  FROM db_name

