-- ============================================================
-- 第 16 章 替代存储引擎 · 设置存储引擎

-- 文档：docs/refman/ch16-alt-engines/02-storage-engine-setting.md
-- ============================================================

-- ---------- 原文示例 1 ----------
-- ENGINE=INNODB not needed unless you have set a different
-- default storage engine.
CREATE TABLE t1 (i INT) ENGINE = INNODB;
-- Simple table definitions can be switched from one to another.
CREATE TABLE t2 (i INT) ENGINE = CSV;
CREATE TABLE t3 (i INT) ENGINE = MEMORY;

-- ---------- 原文示例 2 ----------
SET default_storage_engine=NDBCLUSTER;

-- ---------- 原文示例 3 ----------
ALTER TABLE t ENGINE = InnoDB;

