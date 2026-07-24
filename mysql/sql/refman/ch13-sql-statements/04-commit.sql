-- ============================================================
-- 第 13 章 SQL 语句 · 事务语句

-- 文档：docs/refman/ch13-sql-statements/04-commit.md
-- ============================================================

-- ---------- 原文示例 1 ----------
START TRANSACTION;
SELECT @A:=SUM(salary) FROM table1 WHERE type=1;
UPDATE table2 SET summary=@A WHERE type=1;
COMMIT;

-- ---------- 原文示例 2 ----------
SET autocommit=0;

