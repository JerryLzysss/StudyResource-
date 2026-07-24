-- ============================================================
-- 第 1 章 一般信息 · 1.7 MySQL 标准合规性

-- 文档：docs/refman/ch01-introduction/08-compatibility.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET GLOBAL sql_mode = 'ANSI';

-- ---------- 原文示例 2 ----------
SET GLOBAL sql_mode='ANSI';
SELECT @@GLOBAL.sql_mode;
        -> 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ANSI'

