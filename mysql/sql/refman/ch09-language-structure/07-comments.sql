-- ============================================================
-- 第 9 章 语言结构 · 注释语法

-- 文档：docs/refman/ch09-language-structure/07-comments.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT 1+1;     # This comment continues to the end of line
SELECT 1+1;     -- This comment continues to the end of line
SELECT 1 /* this is an in-line comment */ + 1;
SELECT 1+
/*
this is a
multiple-line comment
*/
1;

-- ---------- 原文示例 2 ----------
SELECT /*! STRAIGHT_JOIN */ col1 FROM table1,table2 WHERE ...

-- ---------- 原文示例 3 ----------
CREATE TABLE t1(a INT, KEY (a)) /*!50110 KEY_BLOCK_SIZE=1024 */;

-- ---------- 原文示例 4 ----------
SELECT /*+ BKA(t1) */ FROM ... ;

