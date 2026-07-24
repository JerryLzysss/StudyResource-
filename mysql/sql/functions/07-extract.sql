-- ============================================================
-- 模块：07 EXTRACT()
-- 文档：docs/functions/07-extract.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT EXTRACT(YEAR FROM '2011-11-11 11:11:11') AS y;
SELECT EXTRACT(MONTH FROM '2011-11-11 11:11:11') AS m;
SELECT EXTRACT(DAY FROM '2011-11-11 11:11:11') AS d;
SELECT EXTRACT(MINUTE FROM '2011-11-11 11:11:11') AS mi;
SELECT EXTRACT(YEAR_MONTH FROM NOW()) AS ym;
