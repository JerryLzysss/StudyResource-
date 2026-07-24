-- ============================================================
-- 第 17 章 复制 · 本地可执行演示
-- ============================================================

-- 单机可查看复制相关配置（未必已搭建主从）
SHOW VARIABLES LIKE 'server_uuid';
SHOW VARIABLES LIKE 'log_bin';
SHOW VARIABLES LIKE 'gtid_mode';
SHOW VARIABLES LIKE 'enforce_gtid_consistency';
SHOW VARIABLES LIKE 'binlog_format';

-- 从库常用（未配置会报错，故注释）
-- SHOW REPLICA STATUS\G
-- SHOW SLAVE STATUS\G
