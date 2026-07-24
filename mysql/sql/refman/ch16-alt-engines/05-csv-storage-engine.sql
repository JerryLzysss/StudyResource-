-- ============================================================
-- 第 16 章 替代存储引擎 · CSV

-- 文档：docs/refman/ch16-alt-engines/05-csv-storage-engine.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE TABLE test (i INT NOT NULL, c CHAR(10) NOT NULL)
       ENGINE = CSV;
-- Query OK, 0 rows affected (0.06 sec)

INSERT INTO test VALUES(1,'record one'),(2,'record two');
-- Query OK, 2 rows affected (0.05 sec)
Records: 2  Duplicates: 0  Warnings: 0

SELECT * FROM test;
-- +---+------------+
| i | c          |
-- +---+------------+
| 1 | record one |
| 2 | record two |
-- +---+------------+
2 rows in set (0.00 sec)

