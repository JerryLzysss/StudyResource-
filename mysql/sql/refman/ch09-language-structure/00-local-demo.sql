-- ============================================================
-- 第 9 章 语言结构 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

-- 用户变量
SET @title_prefix := 'Learn';
SELECT @title_prefix;
SELECT * FROM w3cschool_tbl WHERE w3cschool_title LIKE CONCAT(@title_prefix, '%');

-- 字面量与注释
SELECT '字符串', 123, 3.14, DATE '2007-05-21', TRUE;
/* 块注释 */
SELECT 1; -- 行注释
