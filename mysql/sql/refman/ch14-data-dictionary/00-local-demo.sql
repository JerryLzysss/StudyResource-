-- ============================================================
-- 第 14 章 MySQL 数据字典 · 本地可执行演示
-- ============================================================

SELECT TABLE_NAME, ENGINE, TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'W3CSCHOOL';

SELECT * FROM information_schema.INNODB_TABLES
WHERE NAME LIKE 'w3cschool/%' OR NAME LIKE 'W3CSCHOOL/%'
LIMIT 20;

SHOW CREATE TABLE W3CSCHOOL.w3cschool_tbl;
