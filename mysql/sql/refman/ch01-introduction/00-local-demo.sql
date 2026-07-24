-- ============================================================
-- 第 1 章 一般信息 · 本地可执行演示
-- ============================================================

-- 查看版本与基础信息
SELECT VERSION() AS mysql_version;
SELECT @@version_comment AS version_comment;
SHOW VARIABLES LIKE 'version%';
