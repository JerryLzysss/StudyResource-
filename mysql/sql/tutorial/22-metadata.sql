-- ============================================================
-- 模块：22 元数据
-- 文档：docs/tutorial/22-metadata.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SHOW DATABASES;
SHOW TABLES;
SHOW COLUMNS FROM w3cschool_tbl;
DESCRIBE w3cschool_tbl;
SHOW CREATE TABLE w3cschool_tbl;

SELECT TABLE_NAME, ENGINE, TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'W3CSCHOOL';

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_KEY
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'W3CSCHOOL'
  AND TABLE_NAME = 'w3cschool_tbl';
