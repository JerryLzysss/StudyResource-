-- ============================================================
-- 第 12 章 函数和运算符 · 流量控制函数

-- 文档：docs/refman/ch12-functions/05-flow-control-functions.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT CASE 1 WHEN 1 THEN 'one'
    ->     WHEN 2 THEN 'two' ELSE 'more' END;
        -> 'one'
SELECT CASE WHEN 1>0 THEN 'true' ELSE 'false' END;
        -> 'true'
SELECT CASE BINARY 'B'
    ->     WHEN 'a' THEN 1 WHEN 'b' THEN 2 END;
        -> NULL

-- ---------- 原文示例 2 ----------
SELECT IF(1>2,2,3);
        -> 3
SELECT IF(1 'yes'
SELECT IF(STRCMP('test','test1'),'no','yes');
        -> 'no'

