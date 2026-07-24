-- ============================================================
-- 模块：01 NOW / CURDATE / CURTIME
-- 文档：docs/functions/01-now-curdate.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT NOW() AS now_dt;
SELECT CURDATE() AS cur_date, CURTIME() AS cur_time;
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();
