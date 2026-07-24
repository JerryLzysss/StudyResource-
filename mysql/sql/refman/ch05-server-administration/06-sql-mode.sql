-- ============================================================
-- 第 5 章 MySQL 服务器管理 · SQL 模式

-- 文档：docs/refman/ch05-server-administration/06-sql-mode.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';

-- ---------- 原文示例 2 ----------
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;

-- ---------- 原文示例 3 ----------
CREATE TABLE t (i INT NOT NULL PRIMARY KEY);
INSERT INTO t (i) VALUES(1),(1);
-- ERROR 1062 (23000): Duplicate entry '1' for key 't.PRIMARY'

-- ---------- 原文示例 4 ----------
INSERT IGNORE INTO t (i) VALUES(1),(1);
-- Query OK, 1 row affected, 1 warning (0.01 sec)
Records: 2  Duplicates: 1  Warnings: 1

SHOW WARNINGS;
-- +---------+------+-----------------------------------------+
| Level   | Code | Message                                 |
-- +---------+------+-----------------------------------------+
| Warning | 1062 | Duplicate entry '1' for key 't.PRIMARY' |
-- +---------+------+-----------------------------------------+
1 row in set (0.00 sec)

-- ---------- 原文示例 5 ----------
CREATE TABLE t2 (id INT NOT NULL);
INSERT INTO t2 (id) VALUES(1),(NULL),(3);
-- ERROR 1048 (23000): Column 'id' cannot be null
SELECT * FROM t2;
-- Empty set (0.00 sec)

-- ---------- 原文示例 6 ----------
INSERT INTO t2 (id) VALUES(1),(NULL),(3);
SELECT * FROM t2;
-- +----+
| id |
-- +----+
|  1 |
|  0 |
|  3 |
-- +----+

-- ---------- 原文示例 7 ----------
SET sql_mode = '';
-- Query OK, 0 rows affected (0.00 sec)

INSERT INTO t (i) VALUES('abc');
-- Query OK, 1 row affected, 1 warning (0.01 sec)

SHOW WARNINGS;
-- +---------+------+--------------------------------------------------------+
| Level   | Code | Message                                                |
-- +---------+------+--------------------------------------------------------+
| Warning | 1366 | Incorrect integer value: 'abc' for column 'i' at row 1 |
-- +---------+------+--------------------------------------------------------+
1 row in set (0.00 sec)

-- ---------- 原文示例 8 ----------
SET sql_mode = 'STRICT_ALL_TABLES';
-- Query OK, 0 rows affected (0.00 sec)

INSERT INTO t (i) VALUES('abc');
-- ERROR 1366 (HY000): Incorrect integer value: 'abc' for column 'i' at row 1

