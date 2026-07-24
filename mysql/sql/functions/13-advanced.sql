-- ============================================================
-- 模块：13 高级函数
-- 文档：docs/functions/13-advanced.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT IF(1 > 0, '正确', '错误') AS if_demo;
SELECT IFNULL(NULL, '默认值') AS ifnull_demo;
SELECT ISNULL(NULL) AS isnull_demo;
SELECT NULLIF(25, 25) AS nullif_demo;

SELECT CASE
         WHEN 1 > 0 THEN '1 > 0'
         WHEN 2 > 0 THEN '2 > 0'
         ELSE 'other'
       END AS case_demo;

SELECT w3cschool_title,
       CASE
         WHEN w3cschool_title LIKE 'Learn%' THEN '入门'
         WHEN w3cschool_title LIKE 'JAVA%' THEN '进阶'
         ELSE '其他'
       END AS category
FROM w3cschool_tbl;

SELECT CAST('2017-08-29' AS DATE) AS cast_date;
SELECT CONVERT('123', UNSIGNED) AS convert_num;
SELECT COALESCE(NULL, NULL, 'first_non_null') AS coalesce_demo;

SELECT DATABASE() AS db_name;
SELECT USER() AS user_name, CURRENT_USER() AS current_user_name;
SELECT VERSION() AS version_info;
SELECT CONNECTION_ID() AS conn_id;
SELECT BIN(15) AS bin_15;
SELECT CONV(15, 10, 2) AS conv_15;
