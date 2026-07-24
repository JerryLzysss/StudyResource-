-- ============================================================
-- 模块：08 WHERE 子句
-- 文档：docs/tutorial/08-where.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT * FROM w3cschool_tbl
WHERE w3cschool_author = 'Sanjay';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_author = 'Sanjay'
  AND submission_date = '2007-05-21';

SELECT * FROM w3cschool_tbl
WHERE BINARY w3cschool_author = 'sanjay';

SELECT * FROM w3cschool_tbl
WHERE w3cschool_id IN (1, 3);

SELECT * FROM w3cschool_tbl
WHERE submission_date BETWEEN '2007-01-01' AND '2007-12-31';
