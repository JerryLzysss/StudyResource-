-- ============================================================
-- 模块：05 DATEDIFF()
-- 文档：docs/functions/05-datediff.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT DATEDIFF('2001-02-02', '2001-01-01') AS day_diff;
SELECT DATEDIFF(CURDATE(), '2007-05-21') AS days_passed;
