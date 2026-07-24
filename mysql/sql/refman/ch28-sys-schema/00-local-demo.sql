-- ============================================================
-- 第 28 章 MySQL 系统模式 · 本地可执行演示
-- ============================================================

-- 若 sys 存在则查看热点（无权限/无安装时会失败）
SHOW DATABASES LIKE 'sys';

SELECT * FROM sys.version;

-- 全表扫描语句（可能为空）
SELECT * FROM sys.statements_with_full_table_scans LIMIT 5;

-- 占用 IO 较多的表（若有负载）
SELECT * FROM sys.io_global_by_wait_by_bytes LIMIT 5;
