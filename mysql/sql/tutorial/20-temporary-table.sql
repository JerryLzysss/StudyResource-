-- ============================================================
-- 模块：20 临时表
-- 文档：docs/tutorial/20-temporary-table.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

CREATE TEMPORARY TABLE temp_author AS
SELECT w3cschool_author, COUNT(*) AS cnt
FROM w3cschool_tbl
GROUP BY w3cschool_author;

SELECT * FROM temp_author;

DROP TEMPORARY TABLE IF EXISTS temp_author;
