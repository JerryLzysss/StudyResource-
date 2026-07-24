-- ============================================================
-- 第 9 章 语言结构 · 用户变量

-- 文档：docs/refman/ch09-language-structure/05-user-variables.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SET @var_name = expr [, @var_name = expr] ...

-- ---------- 原文示例 2 ----------
SET @v1 = X'41';
SET @v2 = X'41'+0;
SET @v3 = CAST(X'41' AS UNSIGNED);
SELECT @v1, @v2, @v3;
-- +------+------+------+
| @v1  | @v2  | @v3  |
-- +------+------+------+
| A    |   65 |   65 |
-- +------+------+------+
SET @v1 = b'1000001';
SET @v2 = b'1000001'+0;
SET @v3 = CAST(b'1000001' AS UNSIGNED);
SELECT @v1, @v2, @v3;
-- +------+------+------+
| @v1  | @v2  | @v3  |
-- +------+------+------+
| A    |   65 |   65 |
-- +------+------+------+

-- ---------- 原文示例 3 ----------
SELECT c1 FROM t;
-- +----+
| c1 |
-- +----+
|  0 |
-- +----+
|  1 |
-- +----+
2 rows in set (0.00 sec)

SET @col = "c1";
-- Query OK, 0 rows affected (0.00 sec)

SELECT @col FROM t;
-- +------+
| @col |
-- +------+
| c1   |
-- +------+
1 row in set (0.00 sec)

SELECT `@col` FROM t;
-- ERROR 1054 (42S22): Unknown column '@col' in 'field list'

SET @col = "`c1`";
-- Query OK, 0 rows affected (0.00 sec)

SELECT @col FROM t;
-- +------+
| @col |
-- +------+
| `c1` |
-- +------+
1 row in set (0.00 sec)

-- ---------- 原文示例 4 ----------
SET @c = "c1";
-- Query OK, 0 rows affected (0.00 sec)

SET @s = CONCAT("SELECT ", @c, " FROM t");
-- Query OK, 0 rows affected (0.00 sec)

PREPARE stmt FROM @s;
-- Query OK, 0 rows affected (0.04 sec)
Statement prepared

EXECUTE stmt;
-- +----+
| c1 |
-- +----+
|  0 |
-- +----+
|  1 |
-- +----+
2 rows in set (0.00 sec)

DEALLOCATE PREPARE stmt;
-- Query OK, 0 rows affected (0.00 sec)

