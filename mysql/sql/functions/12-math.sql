-- ============================================================
-- 模块：12 数学函数
-- 文档：docs/functions/12-math.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT ABS(-12) AS abs_v;
SELECT CEIL(3.2) AS ceil_v, FLOOR(3.8) AS floor_v;
SELECT ROUND(3.14159, 2) AS round_v, TRUNCATE(3.14159, 2) AS trunc_v;
SELECT MOD(10, 3) AS mod_v, 10 % 3 AS percent_mod;
SELECT POW(2, 3) AS pow_v, SQRT(16) AS sqrt_v;
SELECT PI() AS pi_v, RAND() AS rand_v;
SELECT GREATEST(1, 5, 3) AS greatest_v, LEAST(1, 5, 3) AS least_v;
SELECT SIGN(-10) AS sign_v;
SELECT FORMAT(250500.5634, 2) AS format_v;

SELECT AVG(w3cschool_id) AS avg_id,
       MAX(w3cschool_id) AS max_id,
       MIN(w3cschool_id) AS min_id,
       SUM(w3cschool_id) AS sum_id,
       COUNT(*) AS total
FROM w3cschool_tbl;
