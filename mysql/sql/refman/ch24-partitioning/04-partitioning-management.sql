-- ============================================================
-- 第 24 章 分区 · 分区管理

-- 文档：docs/refman/ch24-partitioning/04-partitioning-management.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE TABLE trb3 (id INT, name VARCHAR(50), purchased DATE)
    PARTITION BY RANGE( YEAR(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990),
        PARTITION p1 VALUES LESS THAN (1995),
        PARTITION p2 VALUES LESS THAN (2000),
        PARTITION p3 VALUES LESS THAN (2005)
    );

-- ---------- 原文示例 2 ----------
ALTER TABLE trb3 PARTITION BY KEY(id) PARTITIONS 2;

