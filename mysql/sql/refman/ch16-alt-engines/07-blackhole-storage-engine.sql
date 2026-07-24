-- ============================================================
-- 第 16 章 替代存储引擎 · BLACKHOLE

-- 文档：docs/refman/ch16-alt-engines/07-blackhole-storage-engine.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE TABLE test(i INT, c CHAR(10)) ENGINE = BLACKHOLE;
-- Query OK, 0 rows affected (0.03 sec)

INSERT INTO test VALUES(1,'record one'),(2,'record two');
-- Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

SELECT * FROM test;
-- Empty set (0.00 sec)

-- ---------- 原文示例 2 ----------
CREATE TABLE t1 (public_col_1, ..., public_col_N,
                 secret_col_1, ..., secret_col_M) ENGINE=MyISAM;

-- ---------- 原文示例 3 ----------
CREATE TABLE t1 (public_col_1, ..., public_col_N) ENGINE=BLACKHOLE;

-- ---------- 原文示例 4 ----------
CREATE TABLE t1 (public_col_1, ..., public_col_N) ENGINE=MyISAM;

