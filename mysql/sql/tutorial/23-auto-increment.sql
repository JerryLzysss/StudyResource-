-- ============================================================
-- 模块：23 序列 / 自增（AUTO_INCREMENT）
-- 文档：docs/tutorial/23-auto-increment.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SHOW TABLE STATUS LIKE 'w3cschool_tbl';

ALTER TABLE w3cschool_tbl AUTO_INCREMENT = 100;

INSERT INTO w3cschool_tbl (w3cschool_title, w3cschool_author, submission_date)
VALUES ('Auto Inc Demo', 'System', CURDATE());

SELECT LAST_INSERT_ID() AS last_id;
SELECT * FROM w3cschool_tbl ORDER BY w3cschool_id DESC LIMIT 3;
