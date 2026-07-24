-- ============================================================
-- 第 25 章 存储对象 · 视图

-- 文档：docs/refman/ch25-stored-objects/02-create-view.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE VIEW v (mycol) AS SELECT 'abc';
-- Query OK, 0 rows affected (0.01 sec)

SET sql_mode = '';
-- Query OK, 0 rows affected (0.00 sec)

SELECT "mycol" FROM v;
-- +-------+
| mycol |
-- +-------+
| mycol |
-- +-------+
1 row in set (0.01 sec)

SET sql_mode = 'ANSI_QUOTES';
-- Query OK, 0 rows affected (0.00 sec)

SELECT "mycol" FROM v;
-- +-------+
| mycol |
-- +-------+
| abc   |
-- +-------+
1 row in set (0.00 sec)

-- ---------- 原文示例 2 ----------
CREATE VIEW v AS SELECT * FROM t WHERE t.id = f(t.name);

