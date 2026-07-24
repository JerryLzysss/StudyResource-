-- ============================================================
-- 第 26 章 INFORMATION_SCHEMA 表 · SCHEMATA

-- 文档：docs/refman/ch26-information-schema/06-information-schema-schemata-table.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT SCHEMA_NAME AS `Database`
  FROM INFORMATION_SCHEMA.SCHEMATA
  [WHERE SCHEMA_NAME LIKE 'wild']

SHOW DATABASES
  [LIKE 'wild']

