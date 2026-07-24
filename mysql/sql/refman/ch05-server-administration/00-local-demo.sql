-- ============================================================
-- 第 5 章 MySQL 服务器管理 · 本地可执行演示
-- ============================================================

-- 关键系统变量与 SQL 模式
SELECT @@GLOBAL.sql_mode AS global_sql_mode;
SELECT @@SESSION.sql_mode AS session_sql_mode;
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';
SHOW VARIABLES LIKE 'log_error';
SHOW VARIABLES LIKE 'slow_query_log%';

-- 会话级临时调整示例（不影响全局持久配置）
SET SESSION sql_mode = CONCAT(@@sql_mode, ',STRICT_TRANS_TABLES');
SELECT @@SESSION.sql_mode;
