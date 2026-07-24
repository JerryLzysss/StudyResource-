-- ============================================================
-- 第 26 章 INFORMATION_SCHEMA 表 · COLUMNS

-- 文档：docs/refman/ch26-information-schema/04-information-schema-columns-table.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = 'tbl_name'
  [AND table_schema = 'db_name']
  [AND column_name LIKE 'wild']

SHOW COLUMNS
  FROM tbl_name
  [FROM db_name]
  [LIKE 'wild']

