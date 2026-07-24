-- ============================================================
-- 第 23 章 MySQL NDB Cluster 8.0 · 快速测试设置

-- 文档：docs/refman/ch23-ndb-cluster/04-mysql-cluster-quick.md
-- ============================================================

-- ---------- 原文示例 1 ----------
$> mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1 to server version: 8.0.31

Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

SHOW ENGINES\G
...
*************************** 12. row ***************************
Engine: NDBCLUSTER
Support: YES
Comment: Clustered, fault-tolerant, memory-based tables
*************************** 13. row ***************************
Engine: NDB
Support: YES
Comment: Alias for NDBCLUSTER
...

-- ---------- 原文示例 2 ----------
$> mysql
USE test;
Database changed

CREATE TABLE ctest (i INT) ENGINE=NDBCLUSTER;
-- Query OK, 0 rows affected (0.09 sec)

SHOW CREATE TABLE ctest \G
*************************** 1. row ***************************
       Table: ctest
Create Table: CREATE TABLE `ctest` (
  `i` int(11) default NULL
) ENGINE=ndbcluster DEFAULT CHARSET=latin1
1 row in set (0.00 sec)

