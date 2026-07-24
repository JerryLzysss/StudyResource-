-- ============================================================
-- 第 10 章 字符集、排序规则、Unicode · 连接字符集和排序规则

-- 文档：docs/refman/ch10-charset/04-charset-connection.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT * FROM performance_schema.session_variables
WHERE VARIABLE_NAME IN (
  'character_set_client', 'character_set_connection',
  'character_set_results', 'collation_connection'
) ORDER BY VARIABLE_NAME;

-- ---------- 原文示例 2 ----------
SHOW SESSION VARIABLES LIKE 'character\_set\_%';
SHOW SESSION VARIABLES LIKE 'collation\_%';

-- ---------- 原文示例 3 ----------
SET character_set_client = 'ucs2';
-- ERROR 1231 (42000): Variable 'character_set_client'
can't be set to the value of 'ucs2'

-- ---------- 原文示例 4 ----------
SHOW SESSION VARIABLES LIKE 'character\_set\_%';
-- +--------------------------+--------+
| Variable_name            | Value  |
-- +--------------------------+--------+
| character_set_client     | latin1 |
| character_set_connection | latin1 |
...
| character_set_results    | latin1 |
...
-- +--------------------------+--------+
SHOW SESSION VARIABLES LIKE 'collation_connection';
-- +----------------------+-------------------+
| Variable_name        | Value             |
-- +----------------------+-------------------+
| collation_connection | latin1_swedish_ci |
-- +----------------------+-------------------+

-- ---------- 原文示例 5 ----------
SET NAMES 'ucs2';
-- ERROR 1231 (42000): Variable 'character_set_client' can't be set to
the value of 'ucs2'

-- ---------- 原文示例 6 ----------
SET NAMES 'bogus';
-- ERROR 1115 (42000): Unknown character set: 'bogus'

SET NAMES 'utf8mb4' COLLATE 'bogus';
-- ERROR 1273 (HY000): Unknown collation: 'bogus'

-- ---------- 原文示例 7 ----------
SELECT @@character_set_client;

