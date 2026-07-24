-- ============================================================
-- 第 6 章 安全 · 使用角色

-- 文档：docs/refman/ch06-security/06-roles.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE ROLE 'app_developer', 'app_read', 'app_write';

-- ---------- 原文示例 2 ----------
GRANT ALL ON app_db.* TO 'app_developer';
GRANT SELECT ON app_db.* TO 'app_read';
GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';

-- ---------- 原文示例 3 ----------
CREATE USER 'dev1'@'localhost' IDENTIFIED BY 'dev1pass';
CREATE USER 'read_user1'@'localhost' IDENTIFIED BY 'read_user1pass';
CREATE USER 'read_user2'@'localhost' IDENTIFIED BY 'read_user2pass';
CREATE USER 'rw_user1'@'localhost' IDENTIFIED BY 'rw_user1pass';

-- ---------- 原文示例 4 ----------
GRANT 'app_developer' TO 'dev1'@'localhost';
GRANT 'app_read' TO 'read_user1'@'localhost', 'read_user2'@'localhost';
GRANT 'app_read', 'app_write' TO 'rw_user1'@'localhost';

-- ---------- 原文示例 5 ----------
SET PERSIST mandatory_roles = 'role1,role2@localhost,r3@%.example.com';

-- ---------- 原文示例 6 ----------
SHOW GRANTS FOR 'dev1'@'localhost';
-- +-------------------------------------------------+
| Grants for dev1@localhost                       |
-- +-------------------------------------------------+
| GRANT USAGE ON *.* TO `dev1`@`localhost`        |
| GRANT `app_developer`@`%` TO `dev1`@`localhost` |
-- +-------------------------------------------------+

-- ---------- 原文示例 7 ----------
SHOW GRANTS FOR 'dev1'@'localhost' USING 'app_developer';
-- +----------------------------------------------------------+
| Grants for dev1@localhost                                |
-- +----------------------------------------------------------+
| GRANT USAGE ON *.* TO `dev1`@`localhost`                 |
| GRANT ALL PRIVILEGES ON `app_db`.* TO `dev1`@`localhost` |
| GRANT `app_developer`@`%` TO `dev1`@`localhost`          |
-- +----------------------------------------------------------+

-- ---------- 原文示例 8 ----------
SHOW GRANTS FOR 'read_user1'@'localhost' USING 'app_read';
-- +--------------------------------------------------------+
| Grants for read_user1@localhost                        |
-- +--------------------------------------------------------+
| GRANT USAGE ON *.* TO `read_user1`@`localhost`         |
| GRANT SELECT ON `app_db`.* TO `read_user1`@`localhost` |
| GRANT `app_read`@`%` TO `read_user1`@`localhost`       |
-- +--------------------------------------------------------+
SHOW GRANTS FOR 'rw_user1'@'localhost' USING 'app_read', 'app_write';
-- +------------------------------------------------------------------------------+
| Grants for rw_user1@localhost                                                |
-- +------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `rw_user1`@`localhost`                                 |
| GRANT SELECT, INSERT, UPDATE, DELETE ON `app_db`.* TO `rw_user1`@`localhost` |
| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`localhost`               |
-- +------------------------------------------------------------------------------+

-- ---------- 原文示例 9 ----------
SELECT CURRENT_ROLE();
-- +----------------+
| CURRENT_ROLE() |
-- +----------------+
| NONE           |
-- +----------------+

-- ---------- 原文示例 10 ----------
SET DEFAULT ROLE ALL TO
  'dev1'@'localhost',
  'read_user1'@'localhost',
  'read_user2'@'localhost',
  'rw_user1'@'localhost';

-- ---------- 原文示例 11 ----------
SELECT CURRENT_ROLE();
-- +--------------------------------+
| CURRENT_ROLE()                 |
-- +--------------------------------+
| `app_read`@`%`,`app_write`@`%` |
-- +--------------------------------+

-- ---------- 原文示例 12 ----------
SET ROLE NONE; SELECT CURRENT_ROLE();
-- +----------------+
| CURRENT_ROLE() |
-- +----------------+
| NONE           |
-- +----------------+
SET ROLE ALL EXCEPT 'app_write'; SELECT CURRENT_ROLE();
-- +----------------+
| CURRENT_ROLE() |
-- +----------------+
| `app_read`@`%` |
-- +----------------+
SET ROLE DEFAULT; SELECT CURRENT_ROLE();
-- +--------------------------------+
| CURRENT_ROLE()                 |
-- +--------------------------------+
| `app_read`@`%`,`app_write`@`%` |
-- +--------------------------------+

-- ---------- 原文示例 13 ----------
REVOKE role FROM user;

-- ---------- 原文示例 14 ----------
REVOKE INSERT, UPDATE, DELETE ON app_db.* FROM 'app_write';

-- ---------- 原文示例 15 ----------
SHOW GRANTS FOR 'app_write';
-- +---------------------------------------+
| Grants for app_write@%                |
-- +---------------------------------------+
| GRANT USAGE ON *.* TO `app_write`@`%` |
-- +---------------------------------------+

-- ---------- 原文示例 16 ----------
SHOW GRANTS FOR 'rw_user1'@'localhost'
       USING 'app_read', 'app_write';
-- +----------------------------------------------------------------+
| Grants for rw_user1@localhost                                  |
-- +----------------------------------------------------------------+
| GRANT USAGE ON *.* TO `rw_user1`@`localhost`                   |
| GRANT SELECT ON `app_db`.* TO `rw_user1`@`localhost`           |
| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`localhost` |
-- +----------------------------------------------------------------+

-- ---------- 原文示例 17 ----------
GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';

-- ---------- 原文示例 18 ----------
DROP ROLE 'app_read', 'app_write';

-- ---------- 原文示例 19 ----------
CREATE USER 'u1';
CREATE ROLE 'r1';
GRANT SELECT ON db1.* TO 'u1';
GRANT SELECT ON db2.* TO 'r1';
CREATE USER 'u2';
CREATE ROLE 'r2';
GRANT 'u1', 'r1' TO 'u2';
GRANT 'u1', 'r1' TO 'r2';

-- ---------- 原文示例 20 ----------
SHOW GRANTS FOR 'u2' USING 'u1', 'r1';
-- +-------------------------------------+
| Grants for u2@%                     |
-- +-------------------------------------+
| GRANT USAGE ON *.* TO `u2`@`%`      |
| GRANT SELECT ON `db1`.* TO `u2`@`%` |
| GRANT SELECT ON `db2`.* TO `u2`@`%` |
| GRANT `u1`@`%`,`r1`@`%` TO `u2`@`%` |
-- +-------------------------------------+
SHOW GRANTS FOR 'r2' USING 'u1', 'r1';
-- +-------------------------------------+
| Grants for r2@%                     |
-- +-------------------------------------+
| GRANT USAGE ON *.* TO `r2`@`%`      |
| GRANT SELECT ON `db1`.* TO `r2`@`%` |
| GRANT SELECT ON `db2`.* TO `r2`@`%` |
| GRANT `u1`@`%`,`r1`@`%` TO `r2`@`%` |
-- +-------------------------------------+

-- ---------- 原文示例 21 ----------
CREATE USER 'old_app_dev'@'localhost' IDENTIFIED BY 'old_app_devpass';
GRANT ALL ON old_app.* TO 'old_app_dev'@'localhost';

