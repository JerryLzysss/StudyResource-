-- ============================================================
-- 第 1 章 一般信息 · 1.3 MySQL 8.0 的新特性

-- 文档：docs/refman/ch01-introduction/05-mysql-nutshell.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT a FROM t1 FORCE INDEX (i_a) FOR JOIN WHERE a=1 AND b=2;

SELECT /*+ JOIN_INDEX(t1 i_a) */ a FROM t1 WHERE a=1 AND b=2;

