-- ============================================================
-- 模块：12 排序（ORDER BY）
-- 文档：docs/tutorial/12-order-by.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT * FROM w3cschool_tbl
ORDER BY w3cschool_title ASC;

SELECT * FROM w3cschool_tbl
ORDER BY submission_date DESC;

SELECT * FROM w3cschool_tbl
ORDER BY w3cschool_author ASC, w3cschool_id DESC;
