-- ============================================================
-- 模块：16 正则表达式（REGEXP）
-- 文档：docs/tutorial/16-regexp.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT * FROM w3cschool_tbl
WHERE w3cschool_title REGEXP 'PHP|MySQL';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_author REGEXP '^S';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_title REGEXP 'al$';
