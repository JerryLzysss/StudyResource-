-- ============================================================
-- 模块：26 导出 / 导入数据
-- 文档：docs/tutorial/26-import-export.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

-- 以下语句需要 FILE 权限且 secure_file_priv 允许，默认全部注释
-- SELECT w3cschool_id, w3cschool_title, w3cschool_author
-- INTO OUTFILE '/tmp/w3cschool_out.csv'
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- FROM w3cschool_tbl;

-- LOAD DATA INFILE '/tmp/w3cschool_out.csv'
-- INTO TABLE w3cschool_tbl_copy
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- (w3cschool_id, w3cschool_title, w3cschool_author);

SELECT '请使用 mysqldump / mysql 命令行完成导入导出' AS tip;
