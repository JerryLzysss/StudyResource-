-- ============================================================
-- 第 9 章 语言结构 · 表达式

-- 文档：docs/refman/ch09-language-structure/06-expressions.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT DATE_ADD('2018-05-01',INTERVAL 1 DAY);
        -> '2018-05-02'
SELECT DATE_SUB('2018-05-01',INTERVAL 1 YEAR);
        -> '2017-05-01'
SELECT DATE_ADD('2020-12-31 23:59:59',
    ->                 INTERVAL 1 SECOND);
        -> '2021-01-01 00:00:00'
SELECT DATE_ADD('2018-12-31 23:59:59',
    ->                 INTERVAL 1 DAY);
        -> '2019-01-01 23:59:59'
SELECT DATE_ADD('2100-12-31 23:59:59',
    ->                 INTERVAL '1:1' MINUTE_SECOND);
        -> '2101-01-01 00:01:00'
SELECT DATE_SUB('2025-01-01 00:00:00',
    ->                 INTERVAL '1 1:1:1' DAY_SECOND);
        -> '2024-12-30 22:58:59'
SELECT DATE_ADD('1900-01-01 00:00:00',
    ->                 INTERVAL '-1 10' DAY_HOUR);
        -> '1899-12-30 14:00:00'
SELECT DATE_SUB('1998-01-02', INTERVAL 31 DAY);
        -> '1997-12-02'
SELECT DATE_ADD('1992-12-31 23:59:59.000002',
    ->            INTERVAL '1.999999' SECOND_MICROSECOND);
        -> '1993-01-01 00:00:01.000001'

-- ---------- 原文示例 2 ----------
SELECT '2018-12-31 23:59:59' + INTERVAL 1 SECOND;
        -> '2019-01-01 00:00:00'
SELECT INTERVAL 1 DAY + '2018-12-31';
        -> '2019-01-01'
SELECT '2025-01-01' - INTERVAL 1 SECOND;
        -> '2024-12-31 23:59:59'

-- ---------- 原文示例 3 ----------
SELECT EXTRACT(YEAR FROM '2019-07-02');
        -> 2019
SELECT EXTRACT(YEAR_MONTH FROM '2019-07-02 01:02:03');
        -> 201907

-- ---------- 原文示例 4 ----------
CREATE EVENT myevent
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
    DO
      UPDATE myschema.mytable SET mycol = mycol + 1;

-- ---------- 原文示例 5 ----------
SELECT '6/4', 6/4;
        -> 1.5000
SELECT DATE_ADD('2019-01-01', INTERVAL '6/4' HOUR_MINUTE);
        -> '2019-01-01 06:04:00'
SELECT DATE_ADD('2019-01-01', INTERVAL 6/4 HOUR_MINUTE);
        -> '2019-01-04 12:20:00'

-- ---------- 原文示例 6 ----------
SELECT CAST(6/4 AS DECIMAL(3,1));
        -> 1.5
SELECT DATE_ADD('1970-01-01 12:00:00',
    ->                 INTERVAL CAST(6/4 AS DECIMAL(3,1)) HOUR_MINUTE);
        -> '1970-01-01 13:05:00'

-- ---------- 原文示例 7 ----------
SELECT DATE_ADD('2023-01-01', INTERVAL 1 DAY);
        -> '2023-01-02'
SELECT DATE_ADD('2023-01-01', INTERVAL 1 HOUR);
        -> '2023-01-01 01:00:00'

-- ---------- 原文示例 8 ----------
SELECT DATE_ADD('2019-01-30', INTERVAL 1 MONTH);
        -> '2019-02-28'

-- ---------- 原文示例 9 ----------
SELECT DATE_ADD('2016-07-00', INTERVAL 1 DAY);
        -> NULL
SELECT '2005-03-32' + INTERVAL 1 MONTH;
        -> NULL

