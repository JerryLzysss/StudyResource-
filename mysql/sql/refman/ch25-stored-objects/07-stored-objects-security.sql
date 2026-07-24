-- ============================================================
-- 第 25 章 存储对象 · 安全

-- 文档：docs/refman/ch25-stored-objects/07-stored-objects-security.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE DEFINER = 'admin'@'localhost' PROCEDURE p1()
SQL SECURITY DEFINER
BEGIN
  UPDATE t1 SET counter = counter + 1;
END;

-- ---------- 原文示例 2 ----------
CREATE DEFINER = 'admin'@'localhost' PROCEDURE p2()
SQL SECURITY INVOKER
BEGIN
  UPDATE t1 SET counter = counter + 1;
END;

-- ---------- 原文示例 3 ----------
SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS
       WHERE COLUMN_NAME = 'DEFINER';
-- +--------------------+------------+
| TABLE_SCHEMA       | TABLE_NAME |
-- +--------------------+------------+
| information_schema | EVENTS     |
| information_schema | ROUTINES   |
| information_schema | TRIGGERS   |
| information_schema | VIEWS      |
-- +--------------------+------------+

