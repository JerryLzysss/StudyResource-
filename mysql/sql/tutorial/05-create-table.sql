-- ============================================================
-- 模块：05 创建 / 删除数据表
-- 文档：docs/tutorial/05-create-table.md
-- ============================================================

CREATE DATABASE IF NOT EXISTS W3CSCHOOL
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE W3CSCHOOL;

CREATE TABLE IF NOT EXISTS w3cschool_tbl (
  w3cschool_id     INT NOT NULL AUTO_INCREMENT,
  w3cschool_title  VARCHAR(100) NOT NULL,
  w3cschool_author VARCHAR(40) NOT NULL,
  submission_date  DATE,
  PRIMARY KEY (w3cschool_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DESC w3cschool_tbl;
SHOW CREATE TABLE w3cschool_tbl;

-- DROP TABLE IF EXISTS w3cschool_tbl;
