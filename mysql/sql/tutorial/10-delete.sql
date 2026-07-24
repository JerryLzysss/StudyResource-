-- ============================================================
-- 模块：10 DELETE 删除
-- 文档：docs/tutorial/10-delete.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

START TRANSACTION;

DELETE FROM w3cschool_tbl
WHERE w3cschool_id = 9999;

SELECT COUNT(*) AS remain_rows FROM w3cschool_tbl;

ROLLBACK;

-- 清空表示例（默认注释）
-- TRUNCATE TABLE w3cschool_tbl;
-- DELETE FROM w3cschool_tbl;
