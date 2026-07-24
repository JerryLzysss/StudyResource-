-- ============================================================
-- 模块：09 UPDATE 更新
-- 文档：docs/tutorial/09-update.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

START TRANSACTION;

UPDATE w3cschool_tbl
SET w3cschool_title = 'Learn MySQL 8'
WHERE w3cschool_id = 2;

SELECT * FROM w3cschool_tbl WHERE w3cschool_id = 2;

UPDATE w3cschool_tbl
SET w3cschool_author = 'Admin',
    submission_date = CURDATE()
WHERE w3cschool_id = 1;

SELECT * FROM w3cschool_tbl WHERE w3cschool_id = 1;

ROLLBACK;
