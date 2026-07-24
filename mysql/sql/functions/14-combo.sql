-- ============================================================
-- 模块：14 组合业务示例
-- 文档：docs/functions/14-combo.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT
  w3cschool_id,
  CONCAT('[', w3cschool_title, ']') AS title_fmt,
  UPPER(w3cschool_author) AS author_upper,
  DATE_FORMAT(submission_date, '%Y/%m/%d') AS submit_fmt,
  DATEDIFF(CURDATE(), submission_date) AS days_ago,
  DATE_ADD(submission_date, INTERVAL 30 DAY) AS review_date
FROM w3cschool_tbl
ORDER BY days_ago DESC;
