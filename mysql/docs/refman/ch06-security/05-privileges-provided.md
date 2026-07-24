# 第 6 章 安全 · 权限

> 对应 SQL：[`sql/refman/ch06-security/05-privileges-provided.sql`](../../../sql/refman/ch06-security/05-privileges-provided.sql)

---

6.2.2 MySQL提供的权限_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 6 章 安全 / 6.2 访问控制和账户管理 / 6.2.2 MySQL提供的权限 授予 MySQL 帐户的权限决定了该帐户可以执行哪些操作。MySQL 特权在它们应用的上下文和不同的操作级别上有所不同： 管理权限使用户能够管理 MySQL 服务器的操作。这些权限是全局的，因为它们不特定于特定的数据库。
- 数据库权限适用于数据库及其中的所有对象。可以为特定数据库或全局授予这些权限，以便它们适用于所有数据库。
- 可以为数据库中的特定对象、数据库中给定类型的所有对象（例如，数据库中的所有表）或全局为所有对象授予表、索引、视图和存储例程等数据库对象的权限所有数据库中给定类型的对象。

      权限在它们是静态的（内置于服务器中）还是动态的（在运行时定义）方面也有所不同。特权是静态的还是动态的会影响其授予用户帐户和角色的可用性。有关静态和动态权限之间差异的信息，请参阅
      静态与动态权限。）

      有关帐户权限的信息存储在`mysql`系统数据库的授权表中。有关这些表的结构和内容的说明，请参阅
      第 6.2.3 节，“授权表”。MySQL 服务器在启动时将授权表的内容读入内存，并在
      第 6.2.13 节“权限更改生效时”中指示的情况下重新加载它们。服务器根据授权表的内存副本做出访问控制决策。

重要的

        一些 MySQL 版本引入了对授权表的更改以添加新的权限或功能。为确保您可以利用任何新功能，请在升级 MySQL 时将授权表更新为当前结构。请参阅
        第 2.11 节，“升级 MySQL”。

      以下部分总结了可用的权限，提供了每个权限的更详细描述，并提供了使用指南。

- 可用权限摘要
- 静态权限说明
- 动态权限说明
- 特权授予准则
- 静态与动态特权
- 将帐户从 SUPER 迁移到动态权限

#### 可用权限摘要

        下表显示了在
        `GRANT`和
        `REVOKE`语句中使用的静态权限名称，以及与授权表中每个权限关联的列名以及权限适用的上下文。

**表 6.2 GRANT 和 REVOKE 允许的静态权限**

| 特权 | 授予表列 | 语境 |
| --- | --- | --- |
| ALL [PRIVILEGES] | “所有特权”的同义词 | 服务器管理 |
| ALTER | Alter_priv | 表 |
| ALTER ROUTINE | Alter_routine_priv | 存储例程 |
| CREATE | Create_priv | 数据库、表或索引 |
| CREATE ROLE | Create_role_priv | 服务器管理 |
| CREATE ROUTINE | Create_routine_priv | 存储例程 |
| CREATE TABLESPACE | Create_tablespace_priv | 服务器管理 |
| CREATE TEMPORARY TABLES | Create_tmp_table_priv | 表 |
| CREATE USER | Create_user_priv | 服务器管理 |
| CREATE VIEW | Create_view_priv | 观点 |
| DELETE | Delete_priv | 表 |
| DROP | Drop_priv | 数据库、表或视图 |
| DROP ROLE | Drop_role_priv | 服务器管理 |
| EVENT | Event_priv | 数据库 |
| EXECUTE | Execute_priv | 存储例程 |
| FILE | File_priv | 服务器主机上的文件访问 |
| GRANT OPTION | Grant_priv | 数据库、表或存储例程 |
| INDEX | Index_priv | 表 |
| INSERT | Insert_priv | 表或列 |
| LOCK TABLES | Lock_tables_priv | 数据库 |
| PROCESS | Process_priv | 服务器管理 |
| PROXY | 见表proxies_priv_ | 服务器管理 |
| REFERENCES | References_priv | 数据库或表 |
| RELOAD | Reload_priv | 服务器管理 |
| REPLICATION CLIENT | Repl_client_priv | 服务器管理 |
| REPLICATION SLAVE | Repl_slave_priv | 服务器管理 |
| SELECT | Select_priv | 表或列 |
| SHOW DATABASES | Show_db_priv | 服务器管理 |
| SHOW VIEW | Show_view_priv | 观点 |
| SHUTDOWN | Shutdown_priv | 服务器管理 |
| SUPER | Super_priv | 服务器管理 |
| TRIGGER | Trigger_priv | 表 |
| UPDATE | Update_priv | 表或列 |
| USAGE | “无特权”的同义词 | 服务器管理 |

**下表显示了在 `GRANT`和 `REVOKE`语句中使用的动态权限名称，以及权限适用的上下文。 表 6.3 GRANT 和 REVOKE 允许的动态权限**

| 特权 | 语境 |
| --- | --- |
| APPLICATION_PASSWORD_ADMIN | 双密码管理 |
| AUDIT_ABORT_EXEMPT | 允许被审核日志过滤器阻止的查询 |
| AUDIT_ADMIN | 审计日志管理 |
| AUTHENTICATION_POLICY_ADMIN | 认证管理 |
| BACKUP_ADMIN | 备份管理 |
| BINLOG_ADMIN | 备份和复制管理 |
| BINLOG_ENCRYPTION_ADMIN | 备份和复制管理 |
| CLONE_ADMIN | 克隆管理 |
| CONNECTION_ADMIN | 服务器管理 |
| ENCRYPTION_KEY_ADMIN | 服务器管理 |
| FIREWALL_ADMIN | 防火墙管理 |
| FIREWALL_EXEMPT | 防火墙管理 |
| FIREWALL_USER | 防火墙管理 |
| FLUSH_OPTIMIZER_COSTS | 服务器管理 |
| FLUSH_STATUS | 服务器管理 |
| FLUSH_TABLES | 服务器管理 |
| FLUSH_USER_RESOURCES | 服务器管理 |
| GROUP_REPLICATION_ADMIN | 复制管理 |
| GROUP_REPLICATION_STREAM | 复制管理 |
| INNODB_REDO_LOG_ARCHIVE | 重做日志归档管理 |
| NDB_STORED_USER | NDB集群 |
| PASSWORDLESS_USER_ADMIN | 认证管理 |
| PERSIST_RO_VARIABLES_ADMIN | 服务器管理 |
| REPLICATION_APPLIER | PRIVILEGE_CHECKS_USER对于复制通道 |
| REPLICATION_SLAVE_ADMIN | 复制管理 |
| RESOURCE_GROUP_ADMIN | 资源组管理 |
| RESOURCE_GROUP_USER | 资源组管理 |
| ROLE_ADMIN | 服务器管理 |
| SENSITIVE_VARIABLES_OBSERVER | 服务器管理 |
| SESSION_VARIABLES_ADMIN | 服务器管理 |
| SET_USER_ID | 服务器管理 |
| SHOW_ROUTINE | 服务器管理 |
| SKIP_QUERY_REWRITE | 服务器管理 |
| SYSTEM_USER | 服务器管理 |
| SYSTEM_VARIABLES_ADMIN | 服务器管理 |
| TABLE_ENCRYPTION_ADMIN | 服务器管理 |
| TP_CONNECTION_ADMIN | 线程池管理 |
| VERSION_TOKEN_ADMIN | 服务器管理 |
| XA_RECOVER_ADMIN | 服务器管理 |

#### 静态权限说明

        与在运行时定义的动态特权相反，静态特权内置于服务器中。以下列表描述了 MySQL 中可用的每个静态权限。

        特定的 SQL 语句可能具有比此处指示的更具体的权限要求。如果是这样，相关陈述的描述会提供详细信息。

- ALL, ALL PRIVILEGES 这些权限说明符是“在给定权限级别可用的所有权限” （除了GRANT OPTION）的简写。例如，ALL在全局或表级授予分别授予所有全局权限或所有表级权限。
- ALTER 允许使用ALTER TABLE语句来更改表的结构。 ALTER TABLE还需要 CREATE和 INSERT特权。重命名表需要在旧表上 和 ALTER在 新表上。 DROPCREATEINSERT
- ALTER ROUTINE 允许使用更改或删除存储例程（存储过程和函数）的语句。对于属于授予权限的范围内且用户不是命名为例程的用户的例程 DEFINER，还允许访问例程定义以外的例程属性。
- CREATE 允许使用创建新数据库和表的语句。
- CREATE ROLE 允许使用CREATE ROLE语句。（该CREATE USER权限还允许使用该 CREATE ROLE语句。）请参阅 第 6.2.10 节，“使用角色”。 和权限没有那么强大，CREATE ROLE因为 它们只能用于创建和删除帐户。它们不能用于修改帐户属性或重命名帐户。请参阅 用户和角色互换性。 DROP ROLECREATE USERCREATE USER
- CREATE ROUTINE 允许使用创建存储例程（存储过程和函数）的语句。对于属于授予权限的范围内且用户不是命名为例程的用户的例程 DEFINER，还允许访问例程定义以外的例程属性。
- CREATE TABLESPACE 允许使用创建、更改或删除表空间和日志文件组的语句。
- CREATE TEMPORARY TABLES 允许使用 CREATE TEMPORARY TABLE 语句创建临时表。 会话创建临时表后，服务器不会对该表执行进一步的权限检查。创建会话可以对表执行任何操作，例如DROP TABLE、 INSERT、 UPDATE或 SELECT。有关详细信息，请参阅第 13.1.20.2 节，“CREATE TEMPORARY TABLE 语句”。
- CREATE USER 允许使用ALTER USER, CREATE ROLE, CREATE USER, DROP ROLE, DROP USER, RENAME USER, 和 REVOKE ALL PRIVILEGES语句。
- CREATE VIEW 允许使用CREATE VIEW语句。
- DELETE 允许从数据库中的表中删除行。
- DROP 允许使用删除（删除）现有数据库、表和视图的语句。 在分区表上使用该语句需要 DROP特权。权限也是必需ALTER TABLE ... DROP PARTITION的 。 DROPTRUNCATE TABLE
- DROP ROLE 允许使用DROP ROLE 语句。（该CREATE USER 权限还允许使用该DROP ROLE语句。）请参阅第 6.2.10 节，“使用角色”。 和权限没有那么强大，CREATE ROLE因为 它们只能用于创建和删除帐户。它们不能用于修改帐户属性或重命名帐户。请参阅 用户和角色互换性。 DROP ROLECREATE USERCREATE USER
- EVENT 允许使用为事件计划程序创建、更改、删​​除或显示事件的语句。
- EXECUTE 允许使用执行存储例程（存储过程和函数）的语句。对于属于授予权限的范围内且用户不是命名为例程的用户的例程 DEFINER，还允许访问例程定义以外的例程属性。
- FILE 影响以下操作和服务器行为： LOAD DATA使用and SELECT ... INTO OUTFILE语句和 LOAD_FILE()函数 在服务器主机上启用读写文件。具有FILE 权限的用户可以读取服务器主机上任何全局可读或 MySQL 服务器可读的文件。（这意味着用户可以读取任何数据库目录中的任何文件，因为服务器可以访问这些文件中的任何一个。）
- 允许在 MySQL 服务器具有写访问权限的任何目录中创建新文件。这包括服务器的数据目录，其中包含实现权限表的文件。
- 允许对语句 使用DATA DIRECTORYor INDEX DIRECTORYtable 选项 。CREATE TABLE

            作为一项安全措施，服务器不会覆盖现有文件。

            要限制可以读写文件的位置，请将
            `secure_file_priv`系统变量设置为特定目录。请参阅
            第 5.1.8 节，“服务器系统变量”。

- GRANT OPTION 使您能够向其他用户授予或撤销您自己拥有的那些特权。
- INDEX 允许使用创建或删除（删除）索引的语句。INDEX适用于现有表。如果您有表的 权限，则可以在语句 CREATE中包含索引定义 。CREATE TABLE
- INSERT 允许将行插入到数据库中的表中。 、 和 表维护语句 INSERT也需要。ANALYZE TABLEOPTIMIZE TABLEREPAIR TABLE
- LOCK TABLES 允许使用显式LOCK TABLES语句来锁定您有SELECT权限的表。这包括使用写锁，防止其他会话读取锁定的表。
- PROCESS 特权控制对有关服务器内执行的线程的信息的PROCESS访问（即有关会话正在执行的语句的信息）。SHOW PROCESSLIST 使用语句、mysqladmin processlist 命令、 INFORMATION_SCHEMA.PROCESSLIST 表和 Performance Schema 表可用的线程信息可按processlist如下方式访问： 有了PROCESS 特权，用户就可以访问有关所有线程的信息，甚至是属于其他用户的线程。
- 如果没有PROCESS 特权，非匿名用户可以访问有关他们自己的线程的信息，但不能访问其他用户的线程，而匿名用户则无法访问线程信息。

笔记

              Performance Schema
              `threads`表也提供线程信息，但表访问使用不同的权限模型。请参阅
              第 27.12.21.7 节，“线程表”。

            该`PROCESS`权限还允许使用`SHOW ENGINE`语句、访问
            `INFORMATION_SCHEMA`
            `InnoDB`表（名称以 开头的表`INNODB_`）和（从 MySQL 8.0.21 开始）访问`INFORMATION_SCHEMA`
            `FILES`表。

- PROXY 使一个用户能够冒充或成为另一个用户。请参阅第 6.2.19 节，“代理用户”。
- REFERENCES 创建外键约束需要 REFERENCES父表的权限。
- RELOAD RELOAD启用以下操作 ： FLUSH 语句 的使用。
- 使用等效 于 操作的 mysqladmin命令： 、、、、、、、、 和 。 _ FLUSHflush-hostsflush-logsflush-privilegesflush-statusflush-tablesflush-threadsrefreshreload 该reload命令告诉服务器将授权表重新加载到内存中。 flush-privileges是的同义词 reload。该 refresh命令关闭并重新打开日志文件并刷新所有表。其他 命令执行的功能类似于 ，但更具体，在某些情况下可能更可取。例如，如果您只想刷新日志文件， 是比 . flush-xxxrefreshflush-logsrefresh
- 使用执行各种操作 的mysqldump选项：和 . FLUSH--flush-logs--master-data
- 使用RESET MASTER and RESET REPLICA（或在 MySQL 8.0.22 之前 RESET SLAVE）语句。

- REPLICATION CLIENT 允许使用SHOW MASTER STATUS、 SHOW REPLICA STATUS和SHOW BINARY LOGS语句。
- REPLICATION SLAVE 使帐户能够使用 SHOW REPLICAS（或在 MySQL 8.0.22 之前 SHOW SLAVE HOSTS）SHOW RELAYLOG EVENTS、、和SHOW BINLOG EVENTS语句请求对复制源服务器上的数据库进行的更新。使用mysqlbinlog选项 --read-from-remote-server ( -R)、, --read-from-remote-source和 也需要此权限--read-from-remote-master。将此权限授予副本用于连接到当前服务器作为其复制源服务器的帐户。
- SELECT 允许从数据库中的表中选择行。 SELECT语句 SELECT只有在实际访问表时才需要特权。有些 SELECT语句不访问表，可以在没有任何数据库权限的情况下执行。例如，您可以 SELECT用作一个简单的计算器来计算不引用表格的表达式： ```sql SELECT 1+1; SELECT PI()*2; ``` SELECT其他读取列值的语句也需要 该权限。例如，在语句中= 赋值SELECT右侧引用的 列或在or 语句的子句中 命名的列需要 。 col_nameexprUPDATEWHEREDELETEUPDATESELECT与 一起使用的表或视图需要 该权限EXPLAIN，包括视图定义中的任何基础表。
- SHOW DATABASES SHOW DATABASE通过发出语句 使帐户能够查看数据库名称 。没有此权限的帐户只能看到他们有一些权限的数据库，并且如果服务器是使用该 --skip-show-database选项启动的，则根本无法使用该语句。 警告 因为任何静态全局权限都被认为是所有数据库的权限，所以任何静态全局权限都使用户能够使用 SHOW DATABASES或通过检查SCHEMATA表来查看所有数据库名称INFORMATION_SCHEMA，但已通过部分撤销在数据库级别受到限制的数据库除外。
- SHOW VIEW 允许使用SHOW CREATE VIEW语句。与 一起使用的视图也需要此权限EXPLAIN。
- SHUTDOWN 允许使用SHUTDOWN andRESTART语句、 mysqladmin shutdown命令和 mysql_shutdown()C API 函数。
- SUPER SUPER是一项强大而影响深远的特权，不应轻易授予。如果一个帐户只需要执行一部分 SUPER操作，则可以通过授予一个或多个动态权限来实现所需的权限集，每个动态权限都授予更多有限的功能。请参阅 动态权限说明。 笔记 SUPER已弃用，您应该期望在未来的 MySQL 版本中将其删除。请参阅 将帐户从 SUPER 迁移到动态权限。 SUPER影响以下操作和服务器行为： 在运行时启用系统变量更改： SET GLOBAL使用和 启用对全局系统变量的服务器配置更改 SET PERSIST。 对应的动态权限是 SYSTEM_VARIABLES_ADMIN.
- 启用设置需要特殊权限的受限会话系统变量。 对应的动态权限是 SESSION_VARIABLES_ADMIN.

                另见第 5.1.9.1 节，“系统变量权限”。

- 启用对全局事务特征的更改（请参阅第 13.3.7 节，“SET TRANSACTION 语句”）。 对应的动态权限是 SYSTEM_VARIABLES_ADMIN.
- 使帐户能够启动和停止复制，包括组复制。 对应的动态权限是 REPLICATION_SLAVE_ADMIN 针对regular replication， GROUP_REPLICATION_ADMIN 针对Group Replication。
- 启用CHANGE REPLICATION SOURCE TO语句（从 MySQL 8.0.23 开始）、CHANGE MASTER TO 语句（MySQL 8.0.23 之前）和 CHANGE REPLICATION FILTER 语句。 对应的动态权限是 REPLICATION_SLAVE_ADMIN.
- 通过 PURGE BINARY LOGSand BINLOG语句启用二进制日志控制。 对应的动态权限是 BINLOG_ADMIN.
- 在执行视图或存储的程序时启用设置有效授权 ID。具有此权限的用户可以在 DEFINER视图或存储程序的属性中指定任何帐户。 对应的动态权限是 SET_USER_ID.
- 允许使用CREATE SERVER、ALTER SERVER和DROP SERVER语句。
- 允许使用mysqladmin 调试 命令。
- 启用InnoDB加密密钥轮换。 对应的动态权限是 ENCRYPTION_KEY_ADMIN.
- 启用版本令牌功能的执行。 对应的动态权限是 VERSION_TOKEN_ADMIN.
- 允许授予和撤销角色、使用语句的 WITH ADMIN OPTION子句以及 函数 结果中的GRANT非空元素内容 。ROLES_GRAPHML() 对应的动态权限是 ROLE_ADMIN.
- SUPER启用对非帐户 不允许的客户端连接的控制： 允许使用 KILL语句或 mysqladmin kill命令来终止属于其他帐户的线程。（一个帐户总是可以杀死它自己的线程。）
- 客户端连接 时 服务器不执行 init_connect系统变量内容 。SUPER
- SUPER即使 max_connections 达到系统变量 配置的连接限制 ，服务器也接受来自客户端的一个连接 。
- 处于离线模式（offline_mode 启用）的服务器不会 SUPER在下一个客户端请求时终止客户端连接，并接受来自 SUPER客户端的新连接。
- 即使 read_only启用系统变量也可以执行更新。这适用于显式表更新，以及使用账户管理语句，例如隐GRANT式 REVOKE更新表。

                前面的连接控制操作对应的动态权限是
                `CONNECTION_ADMIN`.

            如果启用了二进制日志记录，您可能还需要`SUPER`
            创建或更改存储函数的权限，如
            第 25.7 节“存储程序二进制日志记录”中所述。

- TRIGGER 启用触发操作。您必须对表具有此权限才能为该表创建、删除、执行或显示触发器。 当触发器被激活时（由有权对与触发器关联的表执行INSERT、 UPDATE或 DELETE语句的用户激活），触发器执行要求定义触发器的用户仍然具有该TRIGGER表的权限。
- UPDATE 允许在数据库的表中更新行。
- USAGE 此特权说明符代表“无特权”。”它在全局级别 GRANT用于指定子句，例如WITH GRANT OPTION不在权限列表中命名特定帐户权限。 SHOW GRANTS显示 USAGE以指示帐户在特权级别上没有特权。

#### 动态权限说明

        动态权限是在运行时定义的，与服务器内置的静态权限不同。以下列表描述了 MySQL 中可用的每个动态权限。

        大多数动态权限是在服务器启动时定义的。其他由特定组件或插件定义，如权限描述中所示。在这种情况下，除非启用定义它的组件或插件，否则该权限不可用。

        特定的 SQL 语句可能具有比此处指示的更具体的权限要求。如果是这样，相关陈述的描述会提供详细信息。

- APPLICATION_PASSWORD_ADMIN (MySQL 8.0.14 新增) 对于双密码功能，此权限允许使用适用于您自己帐户的条款 和 RETAIN CURRENT PASSWORD声明 。需要此权限才能操作您自己的二级密码，因为大多数用户只需要一个密码。 DISCARD OLD PASSWORDALTER USERSET PASSWORD 如果允许一个帐户操作所有帐户的辅助密码，则应该授予它 CREATE USER特权而不是 APPLICATION_PASSWORD_ADMIN. 有关使用双重密码的更多信息，请参阅 第 6.2.15 节，“密码管理”。
- AUDIT_ABORT_EXEMPT(MySQL 8.0.28 新增) 允许查询被审计日志过滤器中的“中止”项阻止。此权限由 audit_log插件定义；请参阅 第 6.4.5 节，“MySQL 企业审计”。 在 MySQL 8.0.28 或更高版本中创建的具有 SYSTEM_USER权限的帐户在创建AUDIT_ABORT_EXEMPT 时会自动分配权限。当您使用 MySQL 8.0.28 或更高版本执行升级过程时，如果现有帐户没有分配该权限，该 AUDIT_ABORT_EXEMPT权限也会分配给具有该 权限的现有帐户。SYSTEM_USER因此，具有特权的帐户SYSTEM_USER 可用于在审计配置错误后重新获得对系统的访问权限。
- AUDIT_ADMIN 启用审核日志配置。此权限由audit_log插件定义；请参阅 第 6.4.5 节，“MySQL 企业审计”。
- BACKUP_ADMIN 启用LOCK INSTANCE FOR BACKUP语句的执行和对性能模式log_status表的访问。 笔记 此外BACKUP_ADMIN， 它的访问也需要表 的SELECT特权 。log_status 当从早期版本执行到 MySQL 8.0 的就地升级时， 该BACKUP_ADMIN权限会自动授予具有权限的用户 。RELOAD
- AUTHENTICATION_POLICY_ADMIN (MySQL 8.0.27 新增) 系统变量对如何使用和 语句authentication_policy 的身份验证相关子句设置了某些限制 。拥有 特权的用户不受这些限制。（对于否则不允许的语句，确实会出现警告。） CREATE USERALTER USERAUTHENTICATION_POLICY_ADMIN 有关 施加的约束的详细信息 authentication_policy，请参阅该变量的说明。
- BINLOG_ADMIN 通过 PURGE BINARY LOGSand BINLOG语句启用二进制日志控制。
- BINLOG_ENCRYPTION_ADMIN 启用设置系统变量 binlog_encryption，激活或停用二进制日志文件和中继日志文件的加密。BINLOG_ADMIN、 SYSTEM_VARIABLES_ADMIN或 SESSION_VARIABLES_ADMIN 特权不提供此能力 。相关的系统变量 binlog_rotate_encryption_master_key_at_startup，它在服务器重新启动时自动轮换二进制日志主密钥，不需要此权限。
- CLONE_ADMIN 启用CLONE 语句的执行。包括 BACKUP_ADMIN和 SHUTDOWN特权。
- CONNECTION_ADMIN 允许使用KILL 语句或mysqladmin kill命令来终止属于其他帐户的线程。（一个帐户总是可以杀死它自己的线程。） 启用设置与客户端连接相关的系统变量，或规避与客户端连接相关的限制。从 MySQL 8.0.31 开始， CONNECTION_ADMIN需要激活 MySQL Server 的离线模式，这是通过将 offline_mode系统变量的值更改为 来完成的ON。 该CONNECTION_ADMIN 权限使管理员能够绕过这些系统变量的影响： init_connect:客户端连接 时服务器不执行 init_connect系统变量内容 。CONNECTION_ADMIN
- max_connectionsCONNECTION_ADMIN：即使 max_connections达到系统变量 配置的连接限制，服务器也接受一个来自 客户端的连接。
- offline_mode：处于离线模式（offline_mode启用）的服务器不会 CONNECTION_ADMIN在下一个客户端请求时终止客户端连接，并接受来自 CONNECTION_ADMIN客户端的新连接。
- read_onlyCONNECTION_ADMIN：即使 read_only启用系统变量，也可以执行来自客户端的更新 。这适用于显式表更新，以及隐式更新表的帐户管理 GRANT语句 REVOKE。

            Group Replication 组成员需要
            `CONNECTION_ADMIN`特权，以便在涉及的服务器之一处于离线模式时，Group Replication 连接不会终止。如果 MySQL 通信堆栈正在使用 ( `group_replication_communication_stack = MYSQL`)，没有此权限，处于离线模式的成员将被从组中驱逐。

- ENCRYPTION_KEY_ADMIN 启用InnoDB加密密钥轮换。
- FIREWALL_ADMIN 使用户能够管理任何用户的防火墙规则。此权限由 MYSQL_FIREWALL插件定义；请参阅 第 6.4.7 节，“MySQL 企业防火墙”。
- FIREWALL_EXEMPT(MySQL 8.0.27 新增) 具有此权限的用户不受防火墙限制。此权限由 MYSQL_FIREWALL插件定义；请参阅 第 6.4.7 节，“MySQL 企业防火墙”。
- FIREWALL_USER 允许用户更新他们自己的防火墙规则。此权限由 MYSQL_FIREWALL插件定义；请参阅 第 6.4.7 节，“MySQL 企业防火墙”。
- FLUSH_OPTIMIZER_COSTS(MySQL 8.0.23 新增) 允许使用FLUSH OPTIMIZER_COSTS语句。
- FLUSH_STATUS(MySQL 8.0.23 新增) 允许使用FLUSH STATUS语句。
- FLUSH_TABLES(MySQL 8.0.23 新增) 允许使用FLUSH TABLES语句。
- FLUSH_USER_RESOURCES(MySQL 8.0.23 新增) 允许使用FLUSH USER_RESOURCES语句。
- GROUP_REPLICATION_ADMIN 使帐户能够使用START GROUP REPLICATIONandSTOP GROUP REPLICATION语句启动和停止 Group Replication，更改 group_replication_consistency 系统变量的全局设置，以及使用 group_replication_set_write_concurrency() and group_replication_set_communication_protocol() 函数。将此特权授予用于管理作为复制组成员的服务器的帐户。
- GROUP_REPLICATION_STREAM 允许用户帐户用于建立组复制的组通信连接。当 MySQL 通信堆栈用于组复制 ( group_replication_communication_stack=MYSQL) 时，必须将其授予恢复用户。
- INNODB_REDO_LOG_ARCHIVE 使帐户能够激活和停用重做日志归档。
- INNODB_REDO_LOG_ENABLE 允许使用 ALTER INSTANCE {ENABLE|DISABLE} INNODB REDO_LOG 语句来启用或禁用重做日志记录。在 MySQL 8.0.21 中引入。 请参阅禁用重做日志记录。
- NDB_STORED_USER 一旦用户或角色及其权限NDB加入给定的 NDB Cluster，就可以在所有启用的 MySQL 服务器之间共享和同步。此权限仅在 NDB启用存储引擎时可用。 对给定用户或角色所做的任何权限更改或撤销都会立即与所有连接的 MySQL 服务器（SQL 节点）同步。您应该知道，不能保证来自不同 SQL 节点的多个影响权限的语句以相同的顺序在所有 SQL 节点上执行。出于这个原因，强烈建议所有用户管理都从一个指定的 SQL 节点完成。 NDB_STORED_USER是全局权限，必须使用 . 授予或撤销ON *.*。尝试为此特权设置任何其他范围会导致错误。此权限可以授予大多数应用程序和管理用户，但不能授予系统保留帐户，例如 mysql.session@localhost或 mysql.infoschema@localhost。 被授予 NDB_STORED_USER权限的用户存储在 NDB（因此由所有 SQL 节点共享），具有此权限的角色也是如此。仅被授予角色的用户未NDB_STORED_USER 存储在 ; 每个存储的用户都必须明确授予权限。 NDBNDB 有关这在其中如何工作的更多详细信息 NDB，请参阅 第 23.6.12 节，“权限同步和 NDB_STORED_USER”。 该NDB_STORED_USER权限从 NDB 8.0.18 开始可用。
- PASSWORDLESS_USER_ADMIN (MySQL 8.0.27 新增) 此权限适用于无密码用户帐户： 对于帐户创建，执行 CREATE USER创建无密码帐户的用户必须拥有 PASSWORDLESS_USER_ADMIN 权限。
- 在复制上下文中，该 PASSWORDLESS_USER_ADMIN 权限适用于复制用户，并允许 ALTER USER ... MODIFY为配置为无密码身份验证的用户帐户复制语句。

            有关无密码身份验证的信息，请参阅
            FIDO 无密码身份验证。

- PERSIST_RO_VARIABLES_ADMIN 对于同时拥有 的用户 SYSTEM_VARIABLES_ADMIN， PERSIST_RO_VARIABLES_ADMIN 可以使用 SET PERSIST_ONLY将全局系统变量持久保存到mysqld-auto.cnf数据目录中的选项文件中。该语句类似于 SET PERSIST但不修改运行时全局系统变量值。这 SET PERSIST_ONLY适用于配置只能在服务器启动时设置的只读系统变量。 另见第 5.1.9.1 节，“系统变量权限”。
- REPLICATION_APPLIER 使该帐户充当 复制通道的角色，并在mysqlbinlog输出PRIVILEGE_CHECKS_USER中执行BINLOG语句。将此权限授予使用 （从 MySQL 8.0.23 开始）或（在 MySQL 8.0.23 之前）为复制通道提供安全上下文并处理这些通道上的复制错误的帐户。除了 权限之外，您还必须为帐户提供执行复制通道接收的或包含在mysqlbinlog中的事务所需的权限CHANGE REPLICATION SOURCE TOCHANGE MASTER TOREPLICATION_APPLIER输出，例如更新受影响的表。有关详细信息，请参阅第 17.3.3 节，“复制权限检查”。
- REPLICATION_SLAVE_ADMIN 使账号可以连接复制源服务器，使用 START REPLICAand STOP REPLICA语句启动和停止复制，使用 CHANGE REPLICATION SOURCE TO 语句（MySQL 8.0.23以后）或CHANGE MASTER TO语句（MySQL 8.0.23之前）和 CHANGE REPLICATION FILTER 语句。将此权限授予副本用于连接到当前服务器作为其复制源服务器的帐户。此特权不适用于组复制；为此使用 GROUP_REPLICATION_ADMIN。
- RESOURCE_GROUP_ADMIN 启用资源组管理，包括创建、更改和删除资源组，以及将线程和语句分配给资源组。具有此权限的用户可以执行与资源组相关的任何操作。
- RESOURCE_GROUP_USER 允许将线程和语句分配给资源组。具有此权限的用户可以使用该 SET RESOURCE GROUP语句和RESOURCE_GROUP 优化器提示。
- ROLE_ADMIN 允许授予和撤销角色、使用语句的 WITH ADMIN OPTION子句以及 函数结果中的GRANT非空 元素内容 。ROLES_GRAPHML()需要设置 mandatory_roles系统变量的值。
- SENSITIVE_VARIABLES_OBSERVER (MySQL 8.0.29 新增) global_variables使持有者能够在 Performance Schema 表、 session_variables、 variables_by_thread和 中查看敏感系统变量的值 persisted_variables，以发出 SELECT语句以返回它们的值，并在连接的会话跟踪器中跟踪对它们的更改。没有此权限的用户无法查看或跟踪这些系统变量值。请参阅 保留敏感系统变量。
- SERVICE_CONNECTION_ADMIN 启用到仅允许管理连接的网络接口的连接（请参阅 第 5.1.12.1 节，“连接接口”）。
- SESSION_VARIABLES_ADMIN (MySQL 8.0.14 新增) 对于大多数系统变量，设置会话值不需要特殊权限，任何用户都可以影响当前会话。对于某些系统变量，设置会话值可能会在当前会话之外产生影响，因此是受限操作。对于这些， SESSION_VARIABLES_ADMIN 权限使用户能够设置会话值。 如果系统变量受到限制并且需要特殊权限才能设置会话值，则变量描述会指示该限制。示例包括 binlog_format、 sql_log_bin和 sql_log_off。 在 MySQL 8.0.14 之前 SESSION_VARIABLES_ADMIN添加时，限制会话系统变量只能由具有 SYSTEM_VARIABLES_ADMIN或 SUPER权限的用户设置。 该SESSION_VARIABLES_ADMIN 特权是 SYSTEM_VARIABLES_ADMIN和 SUPER特权的子集。拥有这些特权中的任何一个的用户也被允许设置受限的会话变量并且实际上具有 SESSION_VARIABLES_ADMIN暗示并且不需要 SESSION_VARIABLES_ADMIN 明确授予。 另见第 5.1.9.1 节，“系统变量权限”。
- SET_USER_ID 在执行视图或存储的程序时启用设置有效授权 ID。具有此权限的用户可以将任何帐户指定为 DEFINER视图或存储程序的属性。存储程序以指定帐户的权限执行，因此请确保您遵循 第 25.6 节“存储对象访问控制”中列出的风险最小化指南。 从 MySQL 8.0.22 开始， SET_USER_ID还启用了覆盖安全检查，旨在防止（可能无意中）导致存储对象成为孤立对象或导致采用当前孤立的存储对象的操作。有关详细信息，请参阅 孤立存储对象。
- SHOW_ROUTINE(MySQL 8.0.20 新增) 使用户能够访问所有存储例程（存储过程和函数）的定义和属性，即使是那些用户未被命名为例程的那些 DEFINER。此访问权限包括： 表的内容 INFORMATION_SCHEMA.ROUTINES 。
- 和SHOW CREATE FUNCTION 语句SHOW CREATE PROCEDURE 。
- 和SHOW FUNCTION CODE 语句SHOW PROCEDURE CODE 。
- 和SHOW FUNCTION STATUS 语句SHOW PROCEDURE STATUS 。

            在MySQL 8.0.20之前，用户要访问自己没有定义的例程定义，用户必须有全局`SELECT`权限，范围很广。从 8.0.20 开始，
            `SHOW_ROUTINE`可以改为授予具有更受限范围的权限，允许访问例程定义。（也就是说，管理员可以
            `SELECT`从不需要全局权限的用户那里
            取消全局权限，`SHOW_ROUTINE`而是改为授予权限。）这使帐户能够备份存储的例程，而无需广泛的权限。

- SKIP_QUERY_REWRITE(MySQL 8.0.31 新增) 具有此权限的用户发出的查询不受Rewriter插件重写的影响（请参阅第 5.6.4 节，“重写器查询重写插件”）。 应将此特权授予发出不应重写的管理或控制语句的用户，以及 用于从复制源应用语句的 PRIVILEGE_CHECKS_USER帐户（请参阅 第 17.3.3 节，“复制特权检查” ）。
- SYSTEM_USER(MySQL 8.0.16 新增) 该SYSTEM_USER权限将系统用户与普通用户区分开来： 具有 SYSTEM_USER权限的用户是系统用户。
- 没有 SYSTEM_USER特权的用户是普通用户。

            该`SYSTEM_USER`权限会影响给定用户可以应用其其他权限的帐户，以及该用户是否受到其他帐户的保护：

- 系统用户可以修改系统帐户和普通帐户。也就是说，拥有对普通帐户执行给定操作的适当权限的用户也可以通过拥有 SYSTEM_USER来对系统帐户执行操作。系统帐户只能由具有适当权限的系统用户修改，普通用户不能修改。
- 具有适当权限的普通用户可以修改普通帐户，但不能修改系统帐户。具有适当权限的系统用户和普通用户都可以修改普通帐户。

            有关详细信息，请参阅
            第 6.2.11 节，“帐户类别”。

            特权为系统帐户提供的防止被常规帐户修改的保护
            `SYSTEM_USER`不适用于对
            `mysql`系统模式具有特权的常规帐户，因此可以直接修改该模式中的授权表。为获得全面保护，请勿将`mysql`模式权限授予普通帐户。请参阅
            保护系统帐户免受常规帐户的操纵。

            如果`audit_log`插件正在使用中（请参阅
            第 6.4.5 节，“MySQL 企业审计”），从 MySQL 8.0.28 开始，具有`SYSTEM_USER`
            特权的帐户将自动分配
            `AUDIT_ABORT_EXEMPT`特权，这允许他们的查询即使在
            “中止”项目时也能执行在过滤器中配置会阻止它们。因此，具有特权的帐户
            `SYSTEM_USER`可用于在审计配置错误后重新获得对系统的访问权限。

- SYSTEM_VARIABLES_ADMIN 影响以下操作和服务器行为： 在运行时启用系统变量更改： SET GLOBAL使用和 启用对全局系统变量的服务器配置更改 SET PERSIST。
- SET PERSIST_ONLY如果用户还具有 ，则 启用对全局系统变量的服务器配置更改 PERSIST_RO_VARIABLES_ADMIN。
- 启用设置需要特殊权限的受限会话系统变量。实际上， SYSTEM_VARIABLES_ADMIN 暗示 SESSION_VARIABLES_ADMIN 没有明确授予 SESSION_VARIABLES_ADMIN。

                另见第 5.1.9.1 节，“系统变量权限”。

- 启用对全局事务特征的更改（请参阅第 13.3.7 节，“SET TRANSACTION 语句”）。

- TABLE_ENCRYPTION_ADMIN(MySQL 8.0.16 新增) 允许用户在 table_encryption_privilege_check 启用时覆盖默认加密设置；请参阅 为模式和通用表空间定义加密默认值。
- TP_CONNECTION_ADMIN 允许使用特权连接连接到服务器。当达到定义的限制时 thread_pool_max_transactions_limit ，不允许新连接。特权连接忽略事务限制并允许连接到服务器以增加事务限制、删除限制或终止正在运行的事务。默认情况下，此权限不会授予任何用户。要建立特权连接，发起连接的用户必须具有 TP_CONNECTION_ADMIN 特权。 当达到由定义的限制时，特权连接可以执行语句并启动事务 thread_pool_max_transactions_limit。特权连接放在 Admin线程组中。请参阅 特权连接。
- VERSION_TOKEN_ADMIN 启用版本令牌功能的执行。此权限由 version_tokens插件定义；参见 第 5.6.6 节，“版本标记”。
- XA_RECOVER_ADMIN 启用 XA RECOVER语句的执行；请参阅 第 13.3.8.1 节，“XA 事务 SQL 语句”。 在 MySQL 8.0 之前，任何用户都可以执行该 XA RECOVER语句来发现未完成的准备好的 XA 事务的 XID 值，这可能导致启动 XA 事务的用户以外的用户提交或回滚 XA 事务。在 MySQL 8.0 中， XA RECOVER仅允许具有以下权限的用户 XA_RECOVER_ADMIN特权，预计仅授予需要它的管理用户。这可能是这种情况，例如，对于 XA 应用程序的管理员来说，如果它崩溃并且有必要找到应用程序启动的未完成的事务以便它们可以回滚。此特权要求可防止用户发现除他们自己之外的未完成的准备好的 XA 事务的 XID 值。它不会影响 XA 事务的正常提交或回滚，因为启动它的用户知道它的 XID。

#### 特权授予准则

        只授予帐户所需的权限是个好主意。`FILE`在授予和管理权限
时，您应该特别小心：

- FILE可以滥用将 MySQL 服务器可以在服务器主机上读取的任何文件读入数据库表。这包括所有世界可读的文件和服务器数据目录中的文件。然后可以访问该表 SELECT以将其内容传输到客户端主机。
- GRANT OPTION使用户能够将他们的特权授予其他用户。具有不同权限和具有GRANT OPTION权限的两个用户能够合并权限。
- ALTER可用于通过重命名表来颠覆特权系统。
- SHUTDOWN可以被滥用以通过终止服务器来完全拒绝为其他用户提供服务。
- PROCESS可用于查看当前正在执行的语句的纯文本，包括设置或更改密码的语句。
- SUPER可用于终止其他会话或更改服务器的操作方式。
- 为系统数据库本身授予的权限mysql可用于更改密码和其他访问权限信息： 密码是加密存储的，因此恶意用户无法简单地阅读它们来获知明文密码。mysql.user但是，对系统表 列具有写入权限的用户 authentication_string可以更改帐户的密码，然后使用该帐户连接到 MySQL 服务器。
- INSERT或 UPDATE授予 mysql系统数据库使用户能够分别添加权限或修改现有权限。
- DROP对于 mysql系统数据库，用户可以远程访问权限表，甚至是数据库本身。

#### 静态与动态特权

        MySQL 支持静态和动态权限：

- 静态特权内置于服务器中。它们始终可以授予用户帐户，并且不能取消注册。
- 可以在运行时注册和取消注册动态权限。这会影响它们的可用性：无法授予尚未注册的动态权限。

        例如，`SELECT`和
        `INSERT`权限是静态的并且始终可用，而动态权限只有在实现它的组件已启用时才可用。

        本节的其余部分描述动态权限如何在 MySQL 中工作。讨论使用术语
        “组件”，但同样适用于插件。

笔记

          服务器管理员应该知道哪些服务器组件定义了动态权限。对于 MySQL 发行版，定义动态权限的组件文档描述了这些权限。

          第三方组件也可以定义动态权限；管理员应该了解这些权限，而不是安装可能会冲突或危及服务器操作的组件。例如，如果一个组件与另一个组件都定义了具有相同名称的权限，则会发生冲突。组件开发人员可以通过选择具有基于组件名称的前缀的权限名称来降低这种情况发生的可能性。

        服务器在内存中维护一组已注册的动态权限。注销发生在服务器关闭时。

        通常，定义动态权限的组件会在安装时在其初始化序列中注册它们。卸载时，组件不会注销其已注册的动态权限。（这是当前的做法，不是必需的。也就是说，组件可以但不能随时注销它们注册的特权。）

        尝试注册已注册的动态权限不会出现警告或错误。考虑以下语句序列：

```text
INSTALL COMPONENT 'my_component';
UNINSTALL COMPONENT 'my_component';
INSTALL COMPONENT 'my_component';
```

        第一条`INSTALL COMPONENT`
        语句注册了 component 定义的任何权限
        `my_component`，但
        `UNINSTALL COMPONENT`没有注销它们。对于第二`INSTALL COMPONENT`条语句，发现其注册的组件权限已经被注册，但是没有出现警告或错误。

        动态权限仅适用于全局级别。`mysql.global_grants`服务器在系统表
中存储有关当前为用户帐户分配的动态权限的信息
        ：

- 服务器在服务器启动期间自动注册命名的权限 global_grants（除非 --skip-grant-tables给出该选项）。
- GRANTand 语句修改 的REVOKE内容global_grants。
- 中列出的动态权限分配 global_grants是持久的。它们不会在服务器关闭时被删除。

        示例：以下语句授予用户
        `u1`控制副本上的复制（包括组复制）和修改系统变量所需的权限：

```sql
GRANT REPLICATION_SLAVE_ADMIN, GROUP_REPLICATION_ADMIN, BINLOG_ADMIN
ON *.* TO 'u1'@'localhost';
```

        授予的动态权限出现在
        `SHOW GRANTS`语句和
        `INFORMATION_SCHEMA`
        `USER_PRIVILEGES`表的输出中。

        对于全局级别`GRANT`，
        `REVOKE`任何未被识别为静态的命名权限都会根据当前注册的动态权限集进行检查，如果找到则授予。否则，会发生错误以指示未知的特权标识符。

        for`GRANT`和
        at the global level`REVOKE`的含义
        `ALL [PRIVILEGES]`包括所有静态全局权限，以及所有当前注册的动态权限：

- GRANT ALL在全局级别授予所有静态全局权限和所有当前注册的动态权限。在执行GRANT 语句后注册的动态权限不会追溯授予任何帐户。
- REVOKE ALL在全局级别撤销所有授予的静态全局权限和所有授予的动态权限。

        该`FLUSH PRIVILEGES`语句读取`global_grants`动态权限分配表并注册在那里找到的任何未注册的权限。

        有关 MySQL 服务器和 MySQL 发行版中包含的组件提供的动态权限的描述，请参阅
        第 6.2.2 节，“MySQL 提供的权限”。

#### 将帐户从 SUPER 迁移到动态权限

        在 MySQL 8.0 中，许多以前需要`SUPER`特权的操作也与范围更有限的动态特权相关联。（有关这些权限的描述，请参阅
        第 6.2.2 节，“MySQL 提供的权限”。）通过授予关联的动态权限而不是 ，可以允许帐户执行每个此类操作`SUPER`。`SUPER`此更改使 DBA 能够避免授予和定制用户权限，使其更接近允许的操作
        ，从而提高了安全性
        。`SUPER`现在已弃用；希望在未来的 MySQL 版本中将其删除。

        当删除`SUPER`发生时，以前需要的操作
        `SUPER`失败，除非授予的帐户`SUPER`被迁移到适当的动态权限。使用以下说明来实现该目标，以便在
        `SUPER`删除之前准备好帐户：

- 执行此查询以识别授予的帐户 SUPER： ```sql SELECT GRANTEE FROM INFORMATION_SCHEMA.USER_PRIVILEGES WHERE PRIVILEGE_TYPE = 'SUPER'; ```
- 对于前面查询标识的每个帐户，确定它需要的操作 SUPER。然后授予与这些操作对应的动态权限，并撤销 SUPER。 例如，如果'u1'@'localhost'需要 SUPER清除二进制日志和修改系统变量，这些语句对帐户进行所需的更改： ```sql GRANT BINLOG_ADMIN, SYSTEM_VARIABLES_ADMIN ON *.* TO 'u1'@'localhost'; REVOKE SUPER ON *.* FROM 'u1'@'localhost'; ``` 修改所有适用帐户后， INFORMATION_SCHEMA第一步中的查询应生成一个空结果集。

---

[← 返回 第 6 章 安全 索引](00-index.md) · [← 返回总索引](../00-index.md)
