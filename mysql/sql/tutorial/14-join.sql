-- ============================================================
-- 模块：14 表连接（JOIN）
-- 文档：docs/tutorial/14-join.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

CREATE TABLE IF NOT EXISTS tcount_tbl (
  w3cschool_author VARCHAR(40) NOT NULL,
  w3cschool_count  INT
);

DELETE FROM tcount_tbl;
INSERT INTO tcount_tbl (w3cschool_author, w3cschool_count) VALUES
  ('John Poul', 1),
  ('Abdul S', 1),
  ('Sanjay', 1),
  ('Guest', 0);

SELECT a.w3cschool_id, a.w3cschool_title, b.w3cschool_count
FROM w3cschool_tbl AS a
INNER JOIN tcount_tbl AS b
  ON a.w3cschool_author = b.w3cschool_author;

SELECT a.w3cschool_title, a.w3cschool_author, b.w3cschool_count
FROM w3cschool_tbl AS a
LEFT JOIN tcount_tbl AS b
  ON a.w3cschool_author = b.w3cschool_author;

SELECT a.w3cschool_title, b.w3cschool_author, b.w3cschool_count
FROM w3cschool_tbl AS a
RIGHT JOIN tcount_tbl AS b
  ON a.w3cschool_author = b.w3cschool_author;

SELECT a.w3cschool_title, b.w3cschool_count
FROM w3cschool_tbl a, tcount_tbl b
WHERE a.w3cschool_author = b.w3cschool_author;
