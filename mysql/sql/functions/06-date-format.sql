-- ============================================================
-- 模块：06 DATE_FORMAT()
-- 文档：docs/functions/06-date-format.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT DATE_FORMAT('2011-11-11 11:11:11', '%Y-%m-%d %H:%i:%s') AS fmt1;
SELECT DATE_FORMAT(NOW(), '%Y年%m月%d日') AS fmt_cn;
SELECT DATE_FORMAT(NOW(), '%W %M %Y') AS fmt_en;
