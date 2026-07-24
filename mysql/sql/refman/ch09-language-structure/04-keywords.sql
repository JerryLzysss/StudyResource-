-- ============================================================
-- 第 9 章 语言结构 · 关键字和保留字

-- 文档：docs/refman/ch09-language-structure/04-keywords.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE TABLE interval (begin INT, end INT);
-- ERROR 1064 (42000): You have an error in your SQL syntax ...
near 'interval (begin INT, end INT)'

-- ---------- 原文示例 2 ----------
CREATE TABLE `interval` (begin INT, end INT);
-- Query OK, 0 rows affected (0.01 sec)

-- ---------- 原文示例 3 ----------
CREATE TABLE mydb.interval (begin INT, end INT);
-- Query OK, 0 rows affected (0.01 sec)

