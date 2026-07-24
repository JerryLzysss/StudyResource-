-- ============================================================
-- 第 7 章 备份与恢复 · 本地可执行演示
-- ============================================================

-- 备份相关状态检查（实际备份多用命令行）
SHOW VARIABLES LIKE 'log_bin';
SHOW VARIABLES LIKE 'binlog_format';
SHOW MASTER STATUS;
-- MySQL 8.0.22+ 也可用：SHOW BINARY LOG STATUS;

-- 逻辑导出提示（在 shell 执行）：
-- mysqldump -u root -p --single-transaction --routines --triggers W3CSCHOOL > w3cschool.sql
-- mysql -u root -p W3CSCHOOL < w3cschool.sql

SELECT '使用 mysqldump / 物理备份工具完成真实备份' AS tip;
