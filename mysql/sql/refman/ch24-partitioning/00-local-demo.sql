-- ============================================================
-- 第 24 章 分区 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

DROP TABLE IF EXISTS demo_part;
CREATE TABLE demo_part (
  id INT NOT NULL,
  created_at DATE NOT NULL,
  note VARCHAR(50),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (YEAR(created_at)) (
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION p2026 VALUES LESS THAN (2027),
  PARTITION pmax  VALUES LESS THAN MAXVALUE
);

INSERT INTO demo_part VALUES
  (1, '2024-06-01', 'old'),
  (2, '2025-03-01', 'mid'),
  (3, '2026-07-01', 'new');

EXPLAIN SELECT * FROM demo_part WHERE created_at >= '2026-01-01';
SELECT * FROM demo_part PARTITION (p2026);
SELECT PARTITION_NAME, TABLE_ROWS
FROM information_schema.PARTITIONS
WHERE TABLE_SCHEMA='W3CSCHOOL' AND TABLE_NAME='demo_part';
