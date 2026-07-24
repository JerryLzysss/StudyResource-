-- ============================================================
-- 模块：03 创建 / 删除 / 选择数据库
-- 文档：docs/tutorial/03-database.md
-- ============================================================

CREATE DATABASE IF NOT EXISTS W3CSCHOOL
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE W3CSCHOOL;

SHOW DATABASES;

-- 删除示例（默认注释）
-- DROP DATABASE IF EXISTS W3CSCHOOL;
