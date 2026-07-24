-- ============================================================
-- 第 3 章 教程 · 加载数据

-- 文档：docs/refman/ch03-tutorial/06-loading-tables.md
-- ============================================================

-- ---------- 原文示例 1 ----------
LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet;

-- ---------- 原文示例 2 ----------
LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet
       LINES TERMINATED BY '\r\n';

-- ---------- 原文示例 3 ----------
INSERT INTO pet
       VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);

