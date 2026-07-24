-- ============================================================
-- 模块：11 LIKE 模糊查询
-- 文档：docs/tutorial/11-like.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT * FROM w3cschool_tbl
WHERE w3cschool_title LIKE 'Learn%';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_author LIKE '%an%';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_title LIKE '_e%';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_title NOT LIKE 'JAVA%';
