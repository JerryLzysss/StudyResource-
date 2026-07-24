-- ============================================================
-- 模块：21 复制表
-- 文档：docs/tutorial/21-copy-table.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

DROP TABLE IF EXISTS w3cschool_tbl_copy;
DROP TABLE IF EXISTS w3cschool_tbl_full;

CREATE TABLE w3cschool_tbl_copy LIKE w3cschool_tbl;

CREATE TABLE w3cschool_tbl_full AS
SELECT * FROM w3cschool_tbl;

INSERT INTO w3cschool_tbl_copy
SELECT * FROM w3cschool_tbl;

SELECT COUNT(*) AS copy_rows FROM w3cschool_tbl_copy;
SELECT COUNT(*) AS full_rows FROM w3cschool_tbl_full;
