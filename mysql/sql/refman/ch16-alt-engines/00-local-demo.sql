-- ============================================================
-- 第 16 章 替代存储引擎 · 本地可执行演示
-- ============================================================

SHOW ENGINES;

USE W3CSCHOOL;
DROP TABLE IF EXISTS demo_memory;
CREATE TABLE demo_memory (
  id INT PRIMARY KEY,
  val VARCHAR(50)
) ENGINE=MEMORY;

INSERT INTO demo_memory VALUES (1, 'in-memory');
SELECT * FROM demo_memory;
SHOW TABLE STATUS LIKE 'demo_memory';
