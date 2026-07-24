-- ============================================================
-- 第 16 章 替代存储引擎 · MEMORY

-- 文档：docs/refman/ch16-alt-engines/04-memory-storage-engine.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE TABLE t (i INT) ENGINE = MEMORY;

-- ---------- 原文示例 2 ----------
CREATE TABLE test ENGINE=MEMORY
           SELECT ip,SUM(downloads) AS down
           FROM log_table GROUP BY ip;
SELECT COUNT(ip),AVG(down) FROM test;
DROP TABLE test;

-- ---------- 原文示例 3 ----------
CREATE TABLE lookup
    (id INT, INDEX USING HASH (id))
    ENGINE = MEMORY;
CREATE TABLE lookup
    (id INT, INDEX USING BTREE (id))
    ENGINE = MEMORY;

-- ---------- 原文示例 4 ----------
SET max_heap_table_size = 1024*1024;
-- Query OK, 0 rows affected (0.00 sec)

CREATE TABLE t1 (id INT, UNIQUE(id)) ENGINE = MEMORY;
-- Query OK, 0 rows affected (0.01 sec)

SET max_heap_table_size = 1024*1024*2;
-- Query OK, 0 rows affected (0.00 sec)

CREATE TABLE t2 (id INT, UNIQUE(id)) ENGINE = MEMORY;
-- Query OK, 0 rows affected (0.00 sec)

