-- ============================================================
-- 第 2 章 安装和升级 MySQL · 本地可执行演示
-- ============================================================

-- 安装后连通性与权限自检
SELECT USER(), CURRENT_USER();
SHOW DATABASES;
SHOW VARIABLES LIKE 'datadir';
SHOW VARIABLES LIKE 'basedir';
SHOW VARIABLES LIKE 'port';

-- 查看当前账户（需有权限）
SELECT user, host, plugin FROM mysql.user ORDER BY user, host;
