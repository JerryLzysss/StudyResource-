-- ============================================================
-- 第 6 章 安全 · 权限

-- 文档：docs/refman/ch06-security/05-privileges-provided.md
-- ============================================================

-- ---------- 原文示例 1 ----------
GRANT REPLICATION_SLAVE_ADMIN, GROUP_REPLICATION_ADMIN, BINLOG_ADMIN
ON *.* TO 'u1'@'localhost';

