-- ============================================================
-- 第 4 章 MySQL 程序 · 本地可执行演示
-- ============================================================

-- 在客户端内可查看的程序相关状态
SHOW STATUS LIKE 'Uptime';
SHOW STATUS LIKE 'Threads_connected';
SHOW PROCESSLIST;
SELECT @@hostname AS host, @@port AS port, @@socket AS socket_path;
