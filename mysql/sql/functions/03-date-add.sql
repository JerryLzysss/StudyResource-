-- ============================================================
-- 模块：03 DATE_ADD()
-- 文档：docs/functions/03-date-add.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT DATE_ADD('2017-06-15', INTERVAL 10 DAY) AS plus_10_days;
SELECT DATE_ADD('2017-06-15 09:34:21', INTERVAL 15 MINUTE) AS plus_15_min;
SELECT DATE_ADD('2017-06-15 09:34:21', INTERVAL -3 HOUR) AS minus_3_hour;
SELECT DATE_ADD(CURDATE(), INTERVAL 1 MONTH) AS next_month;
SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR) AS next_year;
