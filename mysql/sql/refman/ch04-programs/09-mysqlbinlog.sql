-- ============================================================
-- 第 4 章 MySQL 程序 · mysqlbinlog

-- 文档：docs/refman/ch04-programs/09-mysqlbinlog.md
-- ============================================================

-- ---------- 原文示例 1 ----------
INSERT INTO test.t1 (i) VALUES(100);
INSERT INTO db2.t2 (j)  VALUES(200);
USE test;
INSERT INTO test.t1 (i) VALUES(101);
INSERT INTO t1 (i)      VALUES(102);
INSERT INTO db2.t2 (j)  VALUES(201);
USE db2;
INSERT INTO test.t1 (i) VALUES(103);
INSERT INTO db2.t2 (j)  VALUES(202);
INSERT INTO t2 (j)      VALUES(203);

