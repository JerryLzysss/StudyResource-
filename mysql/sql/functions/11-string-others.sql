-- ============================================================
-- 模块：11 其他字符串函数
-- 文档：docs/functions/11-string-others.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT CHAR_LENGTH('RUNOOB') AS char_len;
SELECT UPPER('runoob') AS up, LOWER('RUNOOB') AS low;
SELECT LEFT('runoob', 2) AS left2, RIGHT('runoob', 2) AS right2;
SELECT TRIM('  runoob  ') AS trimmed;
SELECT REPLACE('abc', 'a', 'x') AS replaced;
SELECT REVERSE('abc') AS reversed;
SELECT REPEAT('ab', 3) AS repeated;
SELECT LOCATE('st', 'myteststring') AS locate_pos;
SELECT INSERT('google.com', 1, 6, 'runoob') AS inserted;
SELECT LPAD('abc', 5, 'x') AS lpad_demo, RPAD('abc', 5, 'x') AS rpad_demo;
SELECT FIND_IN_SET('c', 'a,b,c,d,e') AS find_pos;
SELECT STRCMP('abc', 'abc') AS strcmp_eq;
