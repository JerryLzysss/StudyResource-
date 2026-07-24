-- ============================================================
-- 第 13 章 SQL 语句 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

-- 预处理语句
SET @sql := 'SELECT w3cschool_id, w3cschool_title FROM w3cschool_tbl WHERE w3cschool_id = ?';
PREPARE stmt FROM @sql;
SET @id := 1;
EXECUTE stmt USING @id;
DEALLOCATE PREPARE stmt;

-- CTE（第 13 章查询能力相关）
WITH authors AS (
  SELECT DISTINCT w3cschool_author AS author FROM w3cschool_tbl
)
SELECT * FROM authors ORDER BY author;
