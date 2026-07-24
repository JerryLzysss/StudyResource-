-- ============================================================
-- 第 6 章 安全 · 本地可执行演示
-- ============================================================

-- 权限与角色演示（学习环境；生产请改强密码）
CREATE USER IF NOT EXISTS 'app_ro'@'localhost' IDENTIFIED BY 'AppRo_Pass_123';
CREATE ROLE IF NOT EXISTS 'read_w3c';
GRANT SELECT ON W3CSCHOOL.* TO 'read_w3c';
GRANT 'read_w3c' TO 'app_ro'@'localhost';
SET DEFAULT ROLE 'read_w3c' TO 'app_ro'@'localhost';

SHOW GRANTS FOR 'app_ro'@'localhost';
SELECT user, host, plugin FROM mysql.user WHERE user IN ('app_ro', 'root');

-- 清理（可选）
-- REVOKE 'read_w3c' FROM 'app_ro'@'localhost';
-- DROP USER IF EXISTS 'app_ro'@'localhost';
-- DROP ROLE IF EXISTS 'read_w3c';
