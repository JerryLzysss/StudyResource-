-- ============================================================
-- 模块：04 DATE_SUB()
-- 文档：docs/functions/04-date-sub.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT DATE_SUB('2017-06-15', INTERVAL 2 DAY) AS minus_2_days;
SELECT DATE_SUB(NOW(), INTERVAL 1 HOUR) AS one_hour_ago;
SELECT w3cschool_id,
       submission_date,
       DATE_SUB(submission_date, INTERVAL 2 DAY) AS pay_date
FROM w3cschool_tbl;
