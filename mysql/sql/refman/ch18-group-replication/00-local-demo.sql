-- ============================================================
-- 第 18 章 组复制 · 本地可执行演示
-- ============================================================

-- 组复制相关变量（未启用组复制时仅供查看）
SHOW VARIABLES LIKE 'group_replication%';
SHOW VARIABLES LIKE 'transaction_write_set_extraction';

-- 启用后可查看
-- SELECT * FROM performance_schema.replication_group_members;
