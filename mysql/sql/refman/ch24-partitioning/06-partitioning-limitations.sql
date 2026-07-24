-- ============================================================
-- 第 24 章 分区 · 分区限制

-- 文档：docs/refman/ch24-partitioning/06-partitioning-limitations.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT @@sql_mode;
-- +------------+
| @@sql_mode |
-- +------------+
|            |
-- +------------+
1 row in set (0.00 sec)

CREATE TABLE tu (c1 BIGINT UNSIGNED)
    ->   PARTITION BY RANGE(c1 - 10) (
    ->     PARTITION p0 VALUES LESS THAN (-5),
    ->     PARTITION p1 VALUES LESS THAN (0),
    ->     PARTITION p2 VALUES LESS THAN (5),
    ->     PARTITION p3 VALUES LESS THAN (10),
    ->     PARTITION p4 VALUES LESS THAN (MAXVALUE)
    -> );
-- ERROR 1563 (HY000): Partition constant is out of partition function domain

SET sql_mode='NO_UNSIGNED_SUBTRACTION';
-- Query OK, 0 rows affected (0.00 sec)

SELECT @@sql_mode;
-- +-------------------------+
| @@sql_mode              |
-- +-------------------------+
| NO_UNSIGNED_SUBTRACTION |
-- +-------------------------+
1 row in set (0.00 sec)

CREATE TABLE tu (c1 BIGINT UNSIGNED)
    ->   PARTITION BY RANGE(c1 - 10) (
    ->     PARTITION p0 VALUES LESS THAN (-5),
    ->     PARTITION p1 VALUES LESS THAN (0),
    ->     PARTITION p2 VALUES LESS THAN (5),
    ->     PARTITION p3 VALUES LESS THAN (10),
    ->     PARTITION p4 VALUES LESS THAN (MAXVALUE)
    -> );
-- Query OK, 0 rows affected (0.05 sec)

-- ---------- 原文示例 2 ----------
SET sql_mode='';
-- Query OK, 0 rows affected (0.00 sec)

SELECT * FROM tu;
-- ERROR 1563 (HY000): Partition constant is out of partition function domain
INSERT INTO tu VALUES (20);
-- ERROR 1563 (HY000): Partition constant is out of partition function domain

