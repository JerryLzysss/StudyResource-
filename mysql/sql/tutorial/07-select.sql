-- ============================================================
-- 模块：07 查询数据（SELECT）
-- 文档：docs/tutorial/07-select.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT * FROM w3cschool_tbl;

SELECT w3cschool_id, w3cschool_title, w3cschool_author
FROM w3cschool_tbl;

SELECT * FROM w3cschool_tbl LIMIT 2;
SELECT * FROM w3cschool_tbl LIMIT 2 OFFSET 1;
SELECT * FROM w3cschool_tbl LIMIT 1, 2;
