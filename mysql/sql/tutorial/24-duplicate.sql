-- ============================================================
-- 模块：24 处理重复数据
-- 文档：docs/tutorial/24-duplicate.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT w3cschool_author, COUNT(*) AS cnt
FROM w3cschool_tbl
GROUP BY w3cschool_author
HAVING cnt > 1;

SELECT DISTINCT w3cschool_author FROM w3cschool_tbl;

INSERT INTO w3cschool_tbl (w3cschool_id, w3cschool_title, w3cschool_author, submission_date)
VALUES (1, 'Learn PHP', 'John Poul', CURDATE())
ON DUPLICATE KEY UPDATE
  w3cschool_title = VALUES(w3cschool_title),
  submission_date = VALUES(submission_date);
