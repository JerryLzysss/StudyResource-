-- ============================================================
-- 模块：09 CONCAT / CONCAT_WS
-- 文档：docs/functions/09-concat.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT CONCAT('SQL ', 'Tutorial ', 'is ', 'fun!') AS concat_demo;
SELECT CONCAT_WS('-', 'SQL', 'Tutorial', 'is', 'fun!') AS concat_ws_demo;
SELECT CONCAT(w3cschool_title, ' - ', w3cschool_author) AS title_author
FROM w3cschool_tbl;
