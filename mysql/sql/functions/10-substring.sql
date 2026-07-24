-- ============================================================
-- 模块：10 SUBSTRING / SUBSTR / MID
-- 文档：docs/functions/10-substring.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT SUBSTRING('HelloWorld', 1, 5) AS sub1;
SELECT SUBSTRING('HelloWorld', 6) AS sub2;
SELECT SUBSTR('HelloWorld', 2, 3) AS sub3;
SELECT MID('RUNOOB', 2, 3) AS mid_demo;

SELECT w3cschool_title,
       SUBSTRING(w3cschool_title, 1, 5) AS short_title
FROM w3cschool_tbl;
