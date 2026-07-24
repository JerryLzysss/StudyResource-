-- ============================================================
-- 模块：18 ALTER 修改表结构
-- 文档：docs/tutorial/18-alter.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

ALTER TABLE w3cschool_tbl
ADD COLUMN tutorial_level VARCHAR(20) DEFAULT '初级';

DESC w3cschool_tbl;

ALTER TABLE w3cschool_tbl
MODIFY COLUMN tutorial_level VARCHAR(30);

ALTER TABLE w3cschool_tbl
CHANGE COLUMN tutorial_level level_name VARCHAR(30);

ALTER TABLE w3cschool_tbl
DROP COLUMN level_name;

-- 重命名演示（立即改回）
ALTER TABLE w3cschool_tbl RENAME TO tutorials_tbl;
ALTER TABLE tutorials_tbl RENAME TO w3cschool_tbl;
