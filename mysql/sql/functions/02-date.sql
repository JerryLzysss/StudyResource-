-- ============================================================
-- 模块：02 DATE()
-- 文档：docs/functions/02-date.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT DATE('2017-06-15 09:34:21') AS only_date;
SELECT DATE(NOW()) AS today;
