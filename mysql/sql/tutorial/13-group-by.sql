-- ============================================================
-- 模块：13 分组（GROUP BY）
-- 文档：docs/tutorial/13-group-by.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

SELECT w3cschool_author, COUNT(*) AS article_count
FROM w3cschool_tbl
GROUP BY w3cschool_author;

SELECT w3cschool_author, COUNT(*) AS article_count
FROM w3cschool_tbl
GROUP BY w3cschool_author
HAVING article_count >= 1;
