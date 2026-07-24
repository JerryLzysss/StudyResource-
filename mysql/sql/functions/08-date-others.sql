-- ============================================================
-- 模块：08 其他日期函数
-- 文档：docs/functions/08-date-others.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT DAY('2017-06-15') AS day_num;
SELECT MONTH(NOW()) AS month_num, YEAR(NOW()) AS year_num;
SELECT DAYNAME('2011-11-11') AS weekday_name;
SELECT LAST_DAY('2017-06-20') AS month_last_day;
SELECT TIMESTAMPDIFF(DAY, '2003-02-01', '2003-05-01') AS ts_day_diff;
SELECT ADDTIME('2011-11-11 11:11:11', '2:10:05') AS add_time_demo;
SELECT TIMEDIFF('13:10:11', '13:10:10') AS time_diff;
