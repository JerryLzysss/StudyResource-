-- ============================================================
-- 第 8 章 优化 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

EXPLAIN SELECT * FROM w3cschool_tbl WHERE w3cschool_author = 'Sanjay';
EXPLAIN FORMAT=JSON
SELECT w3cschool_author, COUNT(*) FROM w3cschool_tbl GROUP BY w3cschool_author;

-- 8.0.18+ 可用（若版本支持）
-- EXPLAIN ANALYZE SELECT * FROM w3cschool_tbl WHERE w3cschool_title LIKE 'Learn%';

SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW STATUS LIKE 'Innodb_buffer_pool_read%';
