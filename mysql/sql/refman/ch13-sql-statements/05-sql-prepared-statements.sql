-- ============================================================
-- 第 13 章 SQL 语句 · 预处理语句

-- 文档：docs/refman/ch13-sql-statements/05-sql-prepared-statements.md
-- ============================================================

-- ---------- 原文示例 1 ----------
PREPARE stmt1 FROM 'SELECT SQRT(POW(?,2) + POW(?,2)) AS hypotenuse';
SET @a = 3;
SET @b = 4;
EXECUTE stmt1 USING @a, @b;
-- +------------+
| hypotenuse |
-- +------------+
|          5 |
-- +------------+
DEALLOCATE PREPARE stmt1;

-- ---------- 原文示例 2 ----------
SET @s = 'SELECT SQRT(POW(?,2) + POW(?,2)) AS hypotenuse';
PREPARE stmt2 FROM @s;
SET @a = 6;
SET @b = 8;
EXECUTE stmt2 USING @a, @b;
-- +------------+
| hypotenuse |
-- +------------+
|         10 |
-- +------------+
DEALLOCATE PREPARE stmt2;

-- ---------- 原文示例 3 ----------
USE test;
CREATE TABLE t1 (a INT NOT NULL);
INSERT INTO t1 VALUES (4), (8), (11), (32), (80);

SET @table = 't1';
SET @s = CONCAT('SELECT * FROM ', @table);

PREPARE stmt3 FROM @s;
EXECUTE stmt3;
-- +----+
| a  |
-- +----+
|  4 |
|  8 |
| 11 |
| 32 |
| 80 |
-- +----+

DEALLOCATE PREPARE stmt3;

-- ---------- 原文示例 4 ----------
ALTER TABLE
ALTER USER
ANALYZE TABLE
CACHE INDEX
CALL
CHANGE MASTER
CHECKSUM {TABLE | TABLES}
COMMIT
{CREATE | DROP} INDEX
{CREATE | RENAME | DROP} DATABASE
{CREATE | DROP} TABLE
{CREATE | RENAME | DROP} USER
{CREATE | DROP} VIEW
DELETE
DO
FLUSH {TABLE | TABLES | TABLES WITH READ LOCK | HOSTS | PRIVILEGES
  | LOGS | STATUS | MASTER | SLAVE | USER_RESOURCES}
GRANT
INSERT
INSTALL PLUGIN
KILL
LOAD INDEX INTO CACHE
OPTIMIZE TABLE
RENAME TABLE
REPAIR TABLE
REPLACE
RESET {MASTER | SLAVE}
REVOKE
SELECT
SET
SHOW BINLOG EVENTS
SHOW CREATE {PROCEDURE | FUNCTION | EVENT | TABLE | VIEW}
SHOW {MASTER | BINARY} LOGS
SHOW {MASTER | SLAVE} STATUS
SLAVE {START | STOP}
TRUNCATE TABLE
UNINSTALL PLUGIN
UPDATE

