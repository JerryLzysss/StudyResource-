-- ============================================================
-- 模块：19 索引
-- 文档：docs/tutorial/19-index.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

CREATE INDEX idx_author ON w3cschool_tbl (w3cschool_author);
CREATE UNIQUE INDEX uk_title ON w3cschool_tbl (w3cschool_title);

SHOW INDEX FROM w3cschool_tbl;

CREATE TABLE IF NOT EXISTS demo_idx (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  email VARCHAR(100),
  INDEX idx_name (name),
  UNIQUE KEY uk_email (email)
) ENGINE=InnoDB;

-- 清理本模块索引（可按需取消注释）
-- DROP INDEX idx_author ON w3cschool_tbl;
-- DROP INDEX uk_title ON w3cschool_tbl;
