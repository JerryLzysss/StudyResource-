-- ============================================================
-- 模块：00 环境初始化（建库建表+示例数据）
-- 文档：docs/tutorial/00-index.md
-- ============================================================

CREATE DATABASE IF NOT EXISTS W3CSCHOOL
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE W3CSCHOOL;

DROP TABLE IF EXISTS tcount_tbl;
DROP TABLE IF EXISTS w3cschool_tbl_copy;
DROP TABLE IF EXISTS w3cschool_tbl_full;
DROP TABLE IF EXISTS demo_idx;
DROP TABLE IF EXISTS demo_types;
DROP TABLE IF EXISTS w3cschool_tbl;

CREATE TABLE w3cschool_tbl (
  w3cschool_id     INT NOT NULL AUTO_INCREMENT,
  w3cschool_title  VARCHAR(100) NOT NULL,
  w3cschool_author VARCHAR(40) NOT NULL,
  submission_date  DATE,
  PRIMARY KEY (w3cschool_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO w3cschool_tbl
  (w3cschool_title, w3cschool_author, submission_date)
VALUES
  ('Learn PHP', 'John Poul', '2007-05-21'),
  ('Learn MySQL', 'Abdul S', '2007-05-21'),
  ('JAVA Tutorial', 'Sanjay', '2007-05-21'),
  ('Learn SQL', 'W3Cschool', CURDATE());

SELECT * FROM w3cschool_tbl;
