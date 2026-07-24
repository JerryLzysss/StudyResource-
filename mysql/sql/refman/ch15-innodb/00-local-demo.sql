-- ============================================================
-- 第 15 章 InnoDB 存储引擎 · 本地可执行演示
-- ============================================================

SHOW ENGINES;
SELECT ENGINE, SUPPORT FROM information_schema.ENGINES WHERE ENGINE = 'InnoDB';

SHOW VARIABLES LIKE 'innodb_file_per_table';
SHOW VARIABLES LIKE 'innodb_flush_log_at_trx_commit';
SHOW VARIABLES LIKE 'transaction_isolation';

USE W3CSCHOOL;
SHOW TABLE STATUS LIKE 'w3cschool_tbl';

START TRANSACTION;
SELECT * FROM w3cschool_tbl WHERE w3cschool_id = 1 FOR UPDATE;
COMMIT;
