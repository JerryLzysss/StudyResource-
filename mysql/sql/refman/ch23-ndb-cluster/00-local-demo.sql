-- ============================================================
-- 第 23 章 MySQL NDB Cluster 8.0 · 本地可执行演示
-- ============================================================

-- 普通 MySQL 发行版通常无 NDB 引擎
SHOW ENGINES;
SELECT ENGINE, SUPPORT, COMMENT
FROM information_schema.ENGINES
WHERE ENGINE LIKE '%NDB%' OR ENGINE = 'ndbcluster';
