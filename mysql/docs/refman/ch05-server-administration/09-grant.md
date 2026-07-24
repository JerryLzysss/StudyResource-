# 第 5 章 MySQL 服务器管理 · GRANT

> 对应 SQL：[`sql/refman/ch05-server-administration/09-grant.sql`](../../../sql/refman/ch05-server-administration/09-grant.sql)

---

13.7.1.6 GRANT 语句_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 13 章 SQL 语句 / 13.7 数据库管理语句 / 13.7.1 账户管理报表 / 13.7.1.6 GRANT 语句 ```sql GRANT priv_type [(column_list)] [, priv_type [(column_list)]] ... ON [object_type] priv_level TO user_or_role [, user_or_role] ... [WITH GRANT OPTION] [AS user [WITH ROLE DEFAULT | NONE | ALL | ALL EXCEPT role [, role ] ... | role [, role ] ... ] ] } GRANT PROXY ON user_or_role TO user_or_role [, user_or_role] ... [WITH GRANT OPTION] GRANT role [, role] ... TO user_or_role [, user_or_role] ... [WITH ADMIN OPTION] object_type: { TABLE | FUNCTION | PROCEDURE } priv_level: { * | *.* | db_name.* | db_name.tbl_name | tbl_name | db_name.routine_name } user_or_role: { user (see Section 6.2.4, “Specifying Account Names”) | role (see Section 6.2.5, “Specifying Role Names”) } ``` 该GRANT语句将权限和角色分配给 MySQL 用户帐户和角色。该声明有几个方面GRANT ，在以下主题下进行了描述： GRANT 概述
- 对象引用指南
- 帐户名称
- MySQL 支持的权限
- 全球特权
- 数据库权限
- 表权限
- 列权限
- 存储例程特权
- 代理用户权限
- 授予角色
- 条款和AS特权限制
- 其他账户特征
- GRANT 的 MySQL 和标准 SQL 版本

GRANT 概述

          该`GRANT`语句使系统管理员能够授予权限和角色，这些权限和角色可以授予用户帐户和角色。这些语法限制适用：

- GRANT不能在同一语句中混合授予特权和角色。给定的 GRANT语句必须授予特权或角色。
- 该ON子句区分语句是授予特权还是授予角色： 使用ON，语句授予特权。
- 如果没有ON，该语句将授予角色。
- 允许将权限和角色分配给一个帐户，但您必须使用单独的 GRANT语句，每个语句的语法都适合要授予的内容。

          有关角色的更多信息，请参阅第 6.2.10 节，“使用角色”。

          要使用 授予特权
          `GRANT`，您必须拥有该
          `GRANT OPTION`特权，并且您必须拥有您授予的特权。（或者，如果您
          对系统架构
          `UPDATE`中的授权表具有权限，则可以授予任何帐户任何权限。）启用系统变量时，还需要该
          权限（或已弃用的
          权限）。
        `mysql``read_only``GRANT``CONNECTION_ADMIN``SUPER`

          `GRANT`要么对所有命名用户和角色成功，要么回滚，如果发生任何错误则无效。仅当对所有命名用户和角色成功时，该语句才会写入二进制日志。

          该`REVOKE`语句与管理员删除帐户权限相关`GRANT`并使管理员能够删除帐户权限。请参阅
          第 13.7.1.8 节，“REVOKE 语句”。

          每个帐户名都使用
          第 6.2.4 节“指定帐户名”中描述的格式。每个角色名称都使用第 6.2.5 节“指定角色名称”中描述的格式。例如：

```sql
GRANT ALL ON db1.* TO 'jeffrey'@'localhost';
GRANT 'role1', 'role2' TO 'user1'@'localhost', 'user2'@'localhost';
GRANT SELECT ON world.* TO 'role3';
```

          帐户或角色名称的主机名部分（如果省略）默认为`'%'`.

          通常，数据库管理员首先使用
          `CREATE USER`创建一个帐户并定义其非特权特征，如密码、是否使用安全连接以及对服务器资源的访问限制，然后使用
          `GRANT`定义其特权。
          `ALTER USER`可用于更改现有帐户的非特权特征。例如：

```sql
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON db1.* TO 'jeffrey'@'localhost';
GRANT SELECT ON db2.invoice TO 'jeffrey'@'localhost';
ALTER USER 'jeffrey'@'localhost' WITH MAX_QUERIES_PER_HOUR 90;
```

          来自**mysql**程序，
          成功执行时`GRANT`响应
          `Query OK, 0 rows affected`。要确定操作产生的特权，请使用`SHOW GRANTS`. 请参阅
          第 13.7.7.21 节，“SHOW GRANTS 语句”。

重要的

            在某些情况下，
            `GRANT`可能会记录在服务器日志中或在客户端的历史文件中，例如
            `~/.mysql_history`，这意味着任何对该信息具有读取权限的人都可以读取明文密码。有关服务器日志发生这种情况的条件以及如何控制它的信息，请参阅第 6.1.2.3 节，“密码和日志记录”。有关客户端日志记录的类似信息，请参阅
            第 4.5.1.3 节，“mysql 客户端日志记录”。

          `GRANT`支持最长 255 个字符的主机名（MySQL 8.0.17 之前为 60 个字符）。用户名最多可包含 32 个字符。数据库、表、列和例程名称最多可以包含 64 个字符。

警告

            *不要试图通过更改`mysql.user` 系统表来更改用户名的允许长度。这样做会导致不可预测的行为，甚至可能使用户无法登录到 MySQL 服务器*。`mysql`除非通过
            第 2.11 节，“升级 MySQL”中描述的过程，否则切勿以任何方式更改系统模式中表的结构。

对象引用指南

          语句中的几个对象`GRANT`
          需要引用，尽管在许多情况下引用是可选的：帐户、角色、数据库、表、列和例程名称。例如，如果帐户名中的 a
          *`user_name`*或
          *`host_name`*值作为未加引号的标识符是合法的，则您无需将其加引号。但是，必须使用引号来指定
          *`user_name`*包含特殊字符（例如`-`）的
          *`host_name`*字符串，或者包含特殊字符或通配符（`%`
          例如）的字符串`'test-user'@'%.com'`。分别引用用户名和主机名。

          要指定引用值：

- 引用数据库、表、列和例程名称作为标识符。
- 引用用户名和主机名作为标识符或字符串。
- 将密码作为字符串引用。

          有关字符串引用和标识符引用指南，请参阅
          第 9.1.1 节，“字符串文字”和
          第 9.2 节，“模式对象名称”。

在数据库级别 ( ) 授予权限的语句中指定数据库名称时，允许
          使用`_`和`%`通配符
          。这意味着，例如，要将字符用作数据库名称的一部分，请

          在语句中使用转义字符指定它，以防止用户能够访问与通配符模式匹配的其他数据库（例如，
           ）。
        `GRANT``GRANT ... ON db_name`.*`_``\``\_``GRANT``GRANT ... ON `foo\_bar`.* TO ...`

          在权限分配中，MySQL 在这些情况下将数据库名称中出现的未转义字符`_`和`%`SQL 通配符解释为文字字符：

- 当数据库名称不用于在数据库级别授予权限时，而是用作向某些其他对象（例如表或例程）授予权限的限定符（例如，）。 GRANT ... ON db_name.tbl_name
- 启用partial_revokes 会导致 MySQL 将数据库名称中的未转义字符_ 和%通配符解释为文字字符，就好像它们已被转义为\_and 一样\%。因为这会改变 MySQL 解释权限的方式，所以建议在 partial_revokes可能启用的安装的权限分配中避免使用未转义的通配符。有关详细信息，请参阅 第 6.2.12 节，“使用部分撤销的权限限制”。

帐户名称

          语句中的*`user`*值
          `GRANT`表示该语句适用的 MySQL 帐户。为了适应向来自任意主机的用户授予权限，MySQL 支持*`user`*以
          .
        `'user_name`'@'*`host_name`*'

          您可以在主机名中指定通配符。例如，

          适用于域中
          的任何主机，
          适用于C 类子网
        中的任何主机。`'user_name`'@'%.example.com'*`user_name`*`example.com``'user_name`'@'198.51.100.%'*`user_name`*`198.51.100`

          简单形式
          是 的同义词
          。
        `'user_name`'`'user_name`'@'%'

          *MySQL 不支持用户名中的通配符*。要引用匿名用户，请使用以下
          `GRANT`语句指定一个具有空用户名的帐户：

```sql
GRANT ALL ON test.* TO ''@'localhost' ...;
```

          在这种情况下，任何使用匿名用户的正确密码从本地主机连接的用户都被允许访问，并具有与匿名用户帐户关联的特权。

          有关帐户名中的用户名和主机名值的其他信息，请参阅第 6.2.4 节，“指定帐户名”。

警告

            如果您允许本地匿名用户连接到 MySQL 服务器，您还应该将权限授予所有本地用户作为
            . 否则，当指定用户尝试从本地计算机登录 MySQL 服务器时，将使用系统表中
            的匿名用户帐户
            。有关详细信息，请参阅
            第 6.2.6 节“访问控制，第 1 阶段：连接验证”。
          `'user_name`'@'localhost'`localhost``mysql.user`

            要确定此问题是否适用于您，请执行以下查询，其中列出了所有匿名用户：

```sql
SELECT Host, User FROM mysql.user WHERE User='';
```

            为避免刚才描述的问题，请使用以下语句删除本地匿名用户帐户：

```sql
DROP USER ''@'localhost';
```

MySQL 支持的权限

          下表总结了可以为and
          语句*`priv_type`*指定的允许的静态和动态权限类型，
          以及可以授予每个权限的级别。有关每个权限的其他信息，请参阅
          第 6.2.2 节，“MySQL 提供的权限”。有关静态和动态权限之间差异的信息，请参阅
          静态与动态权限。
`GRANT``REVOKE`

**表 13.11 GRANT 和 REVOKE 允许的静态特权**

| 特权 | 含义和可授予级别 |
| --- | --- |
| ALL [PRIVILEGES] | 授予指定访问级别的所有权限，除了 GRANT OPTION和 PROXY。 |
| ALTER | 启用ALTER TABLE. 级别：全局、数据库、表。 |
| ALTER ROUTINE | 允许更改或删除存储的例程。级别：全局、数据库、例程。 |
| CREATE | 启用数据库和表创建。级别：全局、数据库、表。 |
| CREATE ROLE | 启用角色创建。级别：全球。 |
| CREATE ROUTINE | 启用存储例程创建。级别：全局，数据库。 |
| CREATE TABLESPACE | 允许创建、更改或删除表空间和日志文件组。级别：全球。 |
| CREATE TEMPORARY TABLES | 启用CREATE TEMPORARY TABLE. 级别：全局，数据库。 |
| CREATE USER | 启用CREATE USER、 DROP USER、 RENAME USER和 REVOKE ALL PRIVILEGES。级别：全球。 |
| CREATE VIEW | 启用要创建或更改的视图。级别：全局、数据库、表。 |
| DELETE | 启用DELETE. 级别：全局、数据库、表。 |
| DROP | 允许删除数据库、表和视图。级别：全局、数据库、表。 |
| DROP ROLE | 启用要删除的角色。级别：全球。 |
| EVENT | 为事件调度程序启用事件。级别：全局，数据库。 |
| EXECUTE | 使用户能够执行存储的例程。级别：全局、数据库、例程。 |
| FILE | 允许用户使服务器读取或写入文件。级别：全球。 |
| GRANT OPTION | 启用授予其他帐户或从其他帐户删除的权限。级别：全局、数据库、表、例程、代理。 |
| INDEX | 启用要创建或删除的索引。级别：全局、数据库、表。 |
| INSERT | 启用INSERT. 级别：全局、数据库、表、列。 |
| LOCK TABLES | LOCK TABLES在您有SELECT 权限的表上启用使用。级别：全局，数据库。 |
| PROCESS | 使用户能够查看带有SHOW PROCESSLIST. 级别：全球。 |
| PROXY | 启用用户代理。级别：从用户到用户。 |
| REFERENCES | 启用外键创建。级别：全局、数据库、表、列。 |
| RELOAD | 启用FLUSH操作。级别：全球。 |
| REPLICATION CLIENT | 使用户能够询问源服务器或副本服务器在哪里。级别：全球。 |
| REPLICATION SLAVE | 使副本能够从源读取二进制日志事件。级别：全球。 |
| SELECT | 启用SELECT. 级别：全局、数据库、表、列。 |
| SHOW DATABASES | 启用SHOW DATABASES以显示所有数据库。级别：全球。 |
| SHOW VIEW | 启用SHOW CREATE VIEW. 级别：全局、数据库、表。 |
| SHUTDOWN | 启用mysqladmin shutdown的使用。级别：全球。 |
| SUPER | 启用其他管理操作，例如 、 、 CHANGE REPLICATION SOURCE TO、CHANGE MASTER TO和KILLmysqladmin 调试命令。级别：全球。PURGE BINARY LOGSSET GLOBAL |
| TRIGGER | 启用触发操作。级别：全局、数据库、表。 |
| UPDATE | 启用UPDATE. 级别：全局、数据库、表、列。 |
| USAGE | “无特权”的同义词 |

**表 13.12 GRANT 和 REVOKE 允许的动态特权**

| 特权 | 含义和可授予级别 |
| --- | --- |
| APPLICATION_PASSWORD_ADMIN | 启用双重密码管理。级别：全球。 |
| AUDIT_ABORT_EXEMPT | 允许被审核日志过滤器阻止的查询。级别：全球。 |
| AUDIT_ADMIN | 启用审核日志配置。级别：全球。 |
| AUTHENTICATION_POLICY_ADMIN | 启用身份验证策略管理。级别：全球。 |
| BACKUP_ADMIN | 启用备份管理。级别：全球。 |
| BINLOG_ADMIN | 启用二进制日志控制。级别：全球。 |
| BINLOG_ENCRYPTION_ADMIN | 启用二进制日志加密的激活和停用。级别：全球。 |
| CLONE_ADMIN | 启用克隆管理。级别：全球。 |
| CONNECTION_ADMIN | 启用连接限制/限制控制。级别：全球。 |
| ENCRYPTION_KEY_ADMIN | 启用InnoDB密钥轮换。级别：全球。 |
| FIREWALL_ADMIN | 启用防火墙规则管理，任何用户。级别：全球。 |
| FIREWALL_EXEMPT | 免除用户的防火墙限制。级别：全球。 |
| FIREWALL_USER | 启用防火墙规则管理，自我。级别：全球。 |
| FLUSH_OPTIMIZER_COSTS | 启用优化器成本重新加载。级别：全球。 |
| FLUSH_STATUS | 启用状态指示器刷新。级别：全球。 |
| FLUSH_TABLES | 启用表刷新。级别：全球。 |
| FLUSH_USER_RESOURCES | 启用用户资源刷新。级别：全球。 |
| GROUP_REPLICATION_ADMIN | 启用组复制控制。级别：全球。 |
| INNODB_REDO_LOG_ENABLE | 启用或禁用重做日志记录。级别：全球。 |
| INNODB_REDO_LOG_ARCHIVE | 启用重做日志归档管理。级别：全球。 |
| NDB_STORED_USER | 在 SQL 节点（NDB Cluster）之间启用用户或角色共享。级别：全球。 |
| PASSWORDLESS_USER_ADMIN | 启用无密码用户帐户管理。级别：全球。 |
| PERSIST_RO_VARIABLES_ADMIN | 启用持久只读系统变量。级别：全球。 |
| REPLICATION_APPLIER | 充当PRIVILEGE_CHECKS_USER复制通道。级别：全球。 |
| REPLICATION_SLAVE_ADMIN | 启用常规复制控制。级别：全球。 |
| RESOURCE_GROUP_ADMIN | 启用资源组管理。级别：全球。 |
| RESOURCE_GROUP_USER | 启用资源组管理。级别：全球。 |
| ROLE_ADMIN | 允许授予或撤销角色，使用WITH ADMIN OPTION. 级别：全球。 |
| SESSION_VARIABLES_ADMIN | 启用设置受限会话系统变量。级别：全球。 |
| SET_USER_ID | 启用设置非自身DEFINER值。级别：全球。 |
| SHOW_ROUTINE | 允许访问存储的例程定义。级别：全球。 |
| SKIP_QUERY_REWRITE | 不要重写此用户执行的查询。级别：全球。 |
| SYSTEM_USER | 将帐户指定为系统帐户。级别：全球。 |
| SYSTEM_VARIABLES_ADMIN | 启用修改或持久化全局系统变量。级别：全球。 |
| TABLE_ENCRYPTION_ADMIN | 启用覆盖默认加密设置。级别：全球。 |
| TP_CONNECTION_ADMIN | 启用线程池连接管理。级别：全球。 |
| VERSION_TOKEN_ADMIN | 启用版本令牌功能。级别：全球。 |
| XA_RECOVER_ADMIN | 启用XA RECOVER执行。级别：全球。 |

          触发器与表关联。要创建或删除触发器，您必须拥有
          `TRIGGER`表的权限，而不是触发器。

          在`GRANT`语句中，
          [`ALL [PRIVILEGES]`]()或`PROXY`
          权限必须单独命名，不能与其他权限一起指定。
          代表除和
          特权[`ALL [PRIVILEGES]`]()之外的所有可用于授予特权的级别的
          特权。
        `GRANT OPTION``PROXY`

          MySQL 帐户信息存储在
          `mysql`系统模式的表中。有关其他详细信息，请参阅第 6.2 节“访问控制和帐户管理”，其中广泛讨论了`mysql`系统架构和访问控制系统。

          如果授权表包含包含大小写混合的数据库或表名称的特权行，并且
          `lower_case_table_names`系统变量设置为非零值，
          `REVOKE`则不能用于撤销这些特权。在这种情况下有必要直接操作授权表。（设置`GRANT`时不创建此类行
          `lower_case_table_names`，但此类行可能在设置该变量之前已创建。该
          `lower_case_table_names`
          设置只能在服务器启动时配置。）

          可以在多个级别授予权限，具体取决于`ON`子句使用的语法。对于
          `REVOKE`，相同的
          `ON`语法指定要删除的权限。

          对于全局、数据库、表和例程级别，
          `GRANT ALL`
          仅分配存在于您授予的级别的权限。例如，是一个数据库级别的语句，因此它不会授予任何仅全局权限，例如. 授予不会分配或
          特权。
        `GRANT ALL ON db_name`.*`FILE``ALL``GRANT OPTION``PROXY`

          该*`object_type`*子句（如果存在）应指定为`TABLE`、
          `FUNCTION`或`PROCEDURE`
          当以下对象是表、存储函数或存储过程时。

          用户对数据库、表、列或例程所持有的权限是作为
          `OR`每个权限级别（包括全局级别）的帐户权限的逻辑添加形成的。不可能因为较低级别的权限缺失而拒绝较高级别授予的权限。例如，此语句全局授予
          `SELECT`和
          `INSERT`权限：

```sql
GRANT SELECT, INSERT ON *.* TO u1;
```

          全局授予的权限适用于所有数据库、表和列，即使未在任何较低级别授予。

`partial_revokes`从 MySQL 8.0.16 开始，如果启用了系统变量

          ，则可以通过为特定数据库撤销特权来显式拒绝在全局级别授予的特权
          ：

```sql
GRANT SELECT, INSERT, UPDATE ON *.* TO u1;
REVOKE INSERT, UPDATE ON db1.* FROM u1;
```

          上述语句的结果是
          `SELECT`全局适用于所有表，而`INSERT`全局
          `UPDATE`适用于除`db1`. 帐户访问权限
          `db1`为只读。

          特权检查程序的详细信息在
          第 6.2.7 节“访问控制，第 2 阶段：请求验证”中介绍。

          如果您甚至为一个用户使用表、列或例程权限，服务器会检查所有用户的表、列和例程权限，这会稍微减慢 MySQL 的速度。同样，如果您限制任何用户的查询、更新或连接数，服务器必须监视这些值。

          MySQL 使您能够授予对不存在的数据库或表的特权。对于表，要授予的权限必须包括`CREATE`
          权限。*此行为是设计使然*，旨在使数据库管理员能够为以后要创建的数据库或表准备用户帐户和权限。

重要的

            *当您删除数据库或表时，MySQL 不会自动撤销任何特权*。但是，如果您删除一个例程，那么为该例程授予的任何例程级特权都将被撤销。

全球特权

          全局权限是管理性的或适用于给定服务器上的所有数据库。要分配全局权限，请使用
          `ON *.*`语法：

```sql
GRANT ALL ON *.* TO 'someuser'@'somehost';
GRANT SELECT, INSERT ON *.* TO 'someuser'@'somehost';
```

          , `CREATE TABLESPACE`,
           `CREATE USER`,
           `FILE`,
           `PROCESS`,
           `RELOAD`,
           `REPLICATION CLIENT`,
           `REPLICATION SLAVE`,
          和
          static 权限是管理权限`SHOW DATABASES`，
          只能全局授予。
        `SHUTDOWN``SUPER`

          动态权限都是全局的，只能全局授予。

          可以全局或在更具体的级别授予其他特权。

`GRANT OPTION`
          在全局级别授予

          的效果对于静态和动态权限不同：

- GRANT OPTION为任何静态全局权限授予的权限适用于所有静态全局权限。
- GRANT OPTION为任何动态特权授予的权限仅适用于该动态特权。

          `GRANT ALL`在全局级别授予所有静态全局权限和所有当前注册的动态权限。在执行`GRANT`语句后注册的动态权限不会追溯授予任何帐户。

          MySQL 将全局权限存储在
          `mysql.user`系统表中。

数据库权限

          数据库权限适用于给定数据库中的所有对象。要分配数据库级权限，请使用语法：
        `ON db_name`.*

```sql
GRANT ALL ON mydb.* TO 'someuser'@'somehost';
GRANT SELECT, INSERT ON mydb.* TO 'someuser'@'somehost';
```

          如果您使用`ON *`语法（而不是
          `ON *.*`），则在数据库级别为默认数据库分配权限。如果没有默认数据库，则会发生错误。

          、`CREATE`、
           `DROP`、
           `EVENT`、
          `GRANT OPTION`和
          权限可以在数据库级别指定`LOCK TABLES`。
          `REFERENCES`也可以在数据库级别指定表或例程权限，在这种情况下，它们适用于数据库中的所有表或例程。

          MySQL 将数据库权限存储在
          `mysql.db`系统表中。

表权限

          表权限适用于给定表中的所有列。要分配表级权限，请使用语法：
        `ON db_name.tbl_name`

```sql
GRANT ALL ON mydb.mytbl TO 'someuser'@'somehost';
GRANT SELECT, INSERT ON mydb.mytbl TO 'someuser'@'somehost';
```

          如果您指定*`tbl_name`*而不是
          *`db_name.tbl_name`*，则该语句适用*`tbl_name`*于默认数据库。如果没有默认数据库，则会发生错误。

*`priv_type`*表级别
          的允许值是`ALTER`,
           `CREATE VIEW`,
           `CREATE`,
           `DELETE`,
           `DROP`,
           `GRANT OPTION`,
           `INDEX`,
           `INSERT`,
           `REFERENCES`,
           `SELECT`,
           `SHOW VIEW`,
           `TRIGGER`, 和
          `UPDATE`。

          表级权限适用于基表和视图。它们不适用于使用 创建`CREATE TEMPORARY TABLE`的表，即使表名匹配也是如此。有关`TEMPORARY`表权限的信息，请参阅第 13.1.20.2 节，“CREATE TEMPORARY TABLE 语句”。

          MySQL 将表权限存储在
          `mysql.tables_priv`系统表中。

列权限

          列特权适用于给定表中的单个列。在列级别授予的每个权限必须后跟列，并用括号括起来。

```sql
GRANT SELECT (col1), INSERT (col1, col2) ON mydb.mytbl TO 'someuser'@'somehost';
```

          列的允许*`priv_type`*值（即，当您使用
          *`column_list`*子句时）是
          `INSERT`、
           `REFERENCES`、
          `SELECT`和
          `UPDATE`。

          MySQL 将列权限存储在
          `mysql.columns_priv`系统表中。

存储例程特权

          、`ALTER ROUTINE`、
          `CREATE ROUTINE`和
          特权适用于存储例程（过程和函数）`EXECUTE`。
          `GRANT OPTION`它们可以在全局和数据库级别授予。除了
          `CREATE ROUTINE`，这些特权可以在例程级别授予个别例程。

```sql
GRANT CREATE ROUTINE ON mydb.* TO 'someuser'@'somehost';
GRANT EXECUTE ON PROCEDURE mydb.myproc TO 'someuser'@'somehost';
```

*`priv_type`*例程级别
          的允许值是`ALTER ROUTINE`、`EXECUTE`和
          `GRANT OPTION`。
          `CREATE ROUTINE`不是例程级别的特权，因为您必须首先具有全局或数据库级别的特权才能创建例程。

          MySQL 将例程级别的权限存储在
          `mysql.procs_priv`系统表中。

代理用户权限

          该`PROXY`特权使一个用户能够成为另一个用户的代理。代理用户冒充或冒用被代理用户的身份；也就是说，它承担了被代理用户的特权。

```sql
GRANT PROXY ON 'localuser'@'localhost' TO 'externaluser'@'somehost';
```

          当`PROXY`被授予时，它必须是
          `GRANT`语句中指定的唯一权限，并且唯一允许的`WITH`选项是`WITH GRANT OPTION`.

          代理要求代理用户通过插件进行身份验证，该插件在代理用户连接时将代理用户的名称返回给服务器，并且代理用户具有代理用户的
          `PROXY`权限。有关详细信息和示例，请参阅第 6.2.19 节，“代理用户”。

          MySQL 将代理权限存储在
          `mysql.proxies_priv`系统表中。

授予角色

          `GRANT`没有子句的语法
          `ON`授予角色而不是个人特权。角色是特权的命名集合；请参阅第 6.2.10 节，“使用角色”。例如：

```sql
GRANT 'role1', 'role2' TO 'user1'@'localhost', 'user2'@'localhost';
```

          每个要授予的角色都必须存在，每个用户帐户或角色都必须存在。从 MySQL 8.0.16 开始，角色不能授予匿名用户。

          授予角色不会自动使角色处于活动状态。有关角色激活和停用的信息，请参阅激活角色。

          授予角色需要这些特权：

- 如果您拥有ROLE_ADMIN 特权（或已弃用的 SUPER特权），则可以向用户或角色授予或撤销任何角色。
- 如果您被授予一个 GRANT包含该子句的声明的角色WITH ADMIN OPTION，您就可以将该角色授予其他用户或角色，或者从其他用户或角色中撤销它，只要该角色在您随后授予的时候处于活动状态或撤销它。WITH ADMIN OPTION这包括使用自身 的能力 。
- 要授予具有特权的角色 SYSTEM_USER，您必须具有SYSTEM_USER 特权。

          可以使用创建循环引用
          `GRANT`。例如：

```sql
CREATE USER 'u1', 'u2';
CREATE ROLE 'r1', 'r2';

GRANT 'u1' TO 'u1';   -- simple loop: u1 => u1
GRANT 'r1' TO 'r1';   -- simple loop: r1 => r1

GRANT 'r2' TO 'u2';
GRANT 'u2' TO 'r2';   -- mixed user/role loop: u2 => r2 => u2
```

          循环授予引用是允许的，但不会向被授予者添加新的特权或角色，因为用户或角色已经拥有其特权和角色。

条款和`AS`特权限制

          从 MySQL 8.0.16 开始，`GRANT`有一个子句指定有关用于语句执行的特权上下文的附加信息。这种语法在 SQL 级别是可见的，尽管它的主要目的是通过使这些限制出现在二进制日志中来在所有节点上实现由部分撤销施加的授予者权限限制的统一复制。有关部分撤销的信息，请参阅
          第 6.2.12 节，“使用部分撤销的权限限制”。
        `AS user` [WITH
          ROLE]

          指定子句时
          ，语句执行会考虑与指定用户关联的任何权限限制，包括 指定的所有角色（如果存在）。结果是语句实际授予的权限可能相对于指定的权限有所减少。
        `AS user``WITH ROLE`

          这些条件适用于该条款：
`AS user`

- AS仅当 named user具有特权限制（这意味着 partial_revokes系统变量已启用）时才有效。
- 如果WITH ROLE给出，则必须将所有命名的角色授予命名的 user。
- nameduser应该是指定为 、 或 的 MySQL 帐户 。当前用户可以与 一起命名，以防执行用户想要 执行一组应用的角色，这些角色可能不同于当前会话中活动的角色。 'user_name'@'host_name'CURRENT_USERCURRENT_USER()WITH ROLEGRANT
- AS不能用于获得执行该 GRANT语句的用户不具备的特权。执行用户必须至少拥有被授予的权限，但该AS子句只能限制授予的权限，而不能升级它们。
- 关于要授予的权限， AS不能指定比执行该 GRANT语句的用户具有更多权限（更少限制）的用户/角色组合。允许用户/角色组合拥有比执行用户更多的 AS权限，但前提是该语句不授予那些额外的权限。
- AS仅支持授予全局权限 ( ON *.*)。
- AS不支持 PROXY补助金。

          以下示例说明了该
          `AS`子句的效果。创建一个
          `u1`具有一些全局权限的用户，以及对这些权限的限制：

```sql
CREATE USER u1;
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO u1;
REVOKE INSERT, UPDATE ON schema1.* FROM u1;
REVOKE SELECT ON schema2.* FROM u1;
```

          还要创建一个`r1`解除某些权限限制的角色，并将该角色授予
          `u1`：

```sql
CREATE ROLE r1;
GRANT INSERT ON schema1.* TO r1;
GRANT SELECT ON schema2.* TO r1;
GRANT r1 TO u1;
```

          现在，使用一个自己没有权限限制的帐户，向多个用户授予同一组全局权限，但每个用户都有不同的`AS`子句施加的限制，并检查实际授予了哪些权限。

- 此处的GRANT语句没有AS子句，因此授予的权限正是指定的权限： ```sql mysql> CREATE USER u2; mysql> GRANT SELECT, INSERT, UPDATE ON *.* TO u2; mysql> SHOW GRANTS FOR u2; +-------------------------------------------------+ | Grants for u2@% | +-------------------------------------------------+ | GRANT SELECT, INSERT, UPDATE ON *.* TO `u2`@`%` | +-------------------------------------------------+ ```
- 这里的GRANT语句有一个AS子句，因此授予的权限是指定的权限但应用了限制 u1： ```sql mysql> CREATE USER u3; mysql> GRANT SELECT, INSERT, UPDATE ON *.* TO u3 AS u1; mysql> SHOW GRANTS FOR u3; +----------------------------------------------------+ | Grants for u3@% | +----------------------------------------------------+ | GRANT SELECT, INSERT, UPDATE ON *.* TO `u3`@`%` | | REVOKE INSERT, UPDATE ON `schema1`.* FROM `u3`@`%` | | REVOKE SELECT ON `schema2`.* FROM `u3`@`%` | +----------------------------------------------------+ ``` 如前所述，该AS子句只能添加权限限制；它不能升级特权。因此，尽管u1具有 DELETE特权，但不包括在授予的特权中，因为该语句未指定授予 DELETE。
- 此处语句的AS子句 GRANT使角色r1对 有效 u1。该角色解除了对u1. 因此，授予的权限有一些限制，但没有前面GRANT 声明那么多： ```sql mysql> CREATE USER u4; mysql> GRANT SELECT, INSERT, UPDATE ON *.* TO u4 AS u1 WITH ROLE r1; mysql> SHOW GRANTS FOR u4; +-------------------------------------------------+ | Grants for u4@% | +-------------------------------------------------+ | GRANT SELECT, INSERT, UPDATE ON *.* TO `u4`@`%` | | REVOKE UPDATE ON `schema1`.* FROM `u4`@`%` | +-------------------------------------------------+ ```

          如果`GRANT`语句包含
          子句，则忽略对执行该语句的用户的权限限制（而不是像没有子句时那样应用）。
`AS user``AS`

其他账户特征

          可选`WITH`子句用于使用户能够将特权授予其他用户。该`WITH GRANT OPTION`子句使用户能够将其在指定权限级别的任何权限授予其他用户。

          要将`GRANT OPTION`
          权限授予帐户而不更改其权限，请执行以下操作：

```sql
GRANT USAGE ON *.* TO 'someuser'@'somehost' WITH GRANT OPTION;
```

          请注意您授予`GRANT OPTION`权限的对象，因为具有不同权限的两个用户可以合并权限！

          您不能授予其他用户您自己没有的特权；该`GRANT OPTION`
          特权使您只能分配您自己拥有的那些特权。

          请注意，当您授予用户
          `GRANT OPTION`特定权限级别的权限时，该用户在该级别拥有（或将来可能授予）的任何权限也可以由该用户授予其他用户。假设您授予用户`INSERT`对数据库的权限。如果您随后授予
          `SELECT`对数据库的权限并指定`WITH GRANT OPTION`，则该用户不仅可以向其他用户
          `SELECT`授予权限，还
          可以向其他用户授予`INSERT`。如果您随后向
          `UPDATE`用户授予对数据库的权限，则该用户可以授予
          `INSERT`、
          `SELECT`和
          `UPDATE`。

          对于非管理员用户，您不应授予
          `ALTER`全局权限或`mysql`系统模式权限。如果这样做，用户可以尝试通过重命名表来颠覆特权系统！

          有关与特定权限相关的安全风险的其他信息，请参阅
          第 6.2.2 节，“MySQL 提供的权限”。

GRANT 的 MySQL 和标准 SQL 版本

          MySQL 和标准 SQL 版本之间的最大区别`GRANT`是：

- MySQL 将权限与主机名和用户名的组合相关联，而不仅仅是与用户名相关联。
- 标准 SQL 没有全局或数据库级别的权限，也不支持 MySQL 支持的所有权限类型。
- MySQL 不支持标准 SQL UNDER权限。
- 标准 SQL 权限以分层方式构建。如果您删除一个用户，则该用户被授予的所有权限都将被撤销。如果您使用DROP USER. 请参阅 第 13.7.1.5 节，“DROP USER 语句”。
- 在标准 SQL 中，当您删除一个表时，该表的所有权限都将被撤销。在标准 SQL 中，当您撤销特权时，所有基于该特权授予的特权也将被撤销。在 MySQL 中，可以使用DROP USERor REVOKE语句删除权限。
- 在 MySQL 中，可以 INSERT只对表中的某些列具有权限。在这种情况下，您仍然可以INSERT 在表上执行语句，前提是您只为那些您有 INSERT权限的列插入值。如果未启用严格 SQL 模式，则省略的列将设置为其隐式默认值。在严格模式下，如果任何省略的列没有默认值，则该语句将被拒绝。（标准 SQL 要求您拥有 INSERT所有列的权限。）有关严​​格 SQL 模式和隐式默认值的信息，请参阅第 5.1.11 节，“服务器 SQL 模式”和第 11.6 节，“数据类型默认值”。

---

[← 返回 第 5 章 MySQL 服务器管理 索引](00-index.md) · [← 返回总索引](../00-index.md)
