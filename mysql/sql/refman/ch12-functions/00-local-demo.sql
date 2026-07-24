-- ============================================================
-- 第 12 章 函数和运算符 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

SELECT MOD(29, 9) AS mod_demo;
SELECT IFNULL(NULL, 'default') AS ifnull_demo;
SELECT CONCAT(w3cschool_title, '/', w3cschool_author) AS t
FROM w3cschool_tbl LIMIT 3;

SELECT w3cschool_author,
       COUNT(*) OVER (PARTITION BY w3cschool_author) AS cnt_by_author,
       ROW_NUMBER() OVER (ORDER BY w3cschool_id) AS rn
FROM w3cschool_tbl;
