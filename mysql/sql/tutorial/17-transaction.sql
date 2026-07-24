-- ============================================================
-- 模块：17 事务（Transaction）
-- 文档：docs/tutorial/17-transaction.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SET autocommit = 0;

START TRANSACTION;

UPDATE w3cschool_tbl
SET w3cschool_title = 'Learn PHP Updated'
WHERE w3cschool_id = 1;

SAVEPOINT sp1;

UPDATE w3cschool_tbl
SET w3cschool_author = 'Temp Author'
WHERE w3cschool_id = 1;

ROLLBACK TO sp1;
COMMIT;

SET autocommit = 1;

SELECT * FROM w3cschool_tbl WHERE w3cschool_id = 1;
