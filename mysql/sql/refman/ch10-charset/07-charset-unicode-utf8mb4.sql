-- ============================================================
-- 第 10 章 字符集、排序规则、Unicode · utf8mb4

-- 文档：docs/refman/ch10-charset/07-charset-unicode-utf8mb4.md
-- ============================================================

-- ---------- 原文示例 1 ----------
SELECT CONCAT(utf8mb3_col, utf8mb4_col);

-- ---------- 原文示例 2 ----------
SELECT * FROM utf8mb3_tbl, utf8mb4_tbl
WHERE utf8mb3_tbl.utf8mb3_col = utf8mb4_tbl.utf8mb4_col;

