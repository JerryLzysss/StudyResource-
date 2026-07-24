-- ============================================================
-- 模块：15 NULL 值处理
-- 文档：docs/tutorial/15-null.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT * FROM w3cschool_tbl
WHERE submission_date IS NULL;

SELECT * FROM w3cschool_tbl
WHERE submission_date IS NOT NULL;

SELECT w3cschool_title,
       IFNULL(submission_date, '1900-01-01') AS submit_day
FROM w3cschool_tbl;

SELECT COALESCE(NULL, NULL, submission_date, CURDATE()) AS day_val
FROM w3cschool_tbl;
