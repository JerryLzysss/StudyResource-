-- ============================================================
-- 第 9 章 语言结构 · 标识符

-- 文档：docs/refman/ch09-language-structure/03-identifiers.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT * FROM `select` WHERE `select`.id > 100;

-- ---------- 原文示例 2 ----------
CREATE TABLE "test" (col INT);
-- ERROR 1064: You have an error in your SQL syntax...
SET sql_mode='ANSI_QUOTES';
CREATE TABLE "test" (col INT);
-- Query OK, 0 rows affected (0.00 sec)

-- ---------- 原文示例 3 ----------
CREATE TABLE `a``b` (`c"d` INT);

-- ---------- 原文示例 4 ----------
SELECT 1 AS `one`, 2 AS 'two';
-- +-----+-----+
| one | two |
-- +-----+-----+
|   1 |   2 |
-- +-----+-----+

