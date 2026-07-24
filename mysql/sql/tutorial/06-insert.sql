-- ============================================================
-- 模块：06 插入数据（INSERT）
-- 文档：docs/tutorial/06-insert.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

-- 若表已有数据可先清空演示（学习环境）
-- TRUNCATE TABLE w3cschool_tbl;

INSERT INTO w3cschool_tbl
  (w3cschool_title, w3cschool_author, submission_date)
VALUES
  ('Learn PHP', 'John Poul', '2007-05-21');

INSERT INTO w3cschool_tbl
  (w3cschool_title, w3cschool_author, submission_date)
VALUES
  ('Learn MySQL', 'Abdul S', '2007-05-21'),
  ('JAVA Tutorial', 'Sanjay', '2007-05-21');

INSERT INTO w3cschool_tbl
  (w3cschool_title, w3cschool_author, submission_date)
VALUES
  ('Learn SQL', 'W3Cschool', CURDATE());

SELECT * FROM w3cschool_tbl;
