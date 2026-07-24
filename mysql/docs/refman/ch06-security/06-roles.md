# 第 6 章 安全 · 使用角色

> 对应 SQL：[`sql/refman/ch06-security/06-roles.sql`](../../../sql/refman/ch06-security/06-roles.sql)

---

6.2.10 使用角色_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 6 章 安全 / 6.2 访问控制和账户管理 / 6.2.10 使用角色 MySQL 角色是命名的权限集合。与用户帐户一样，角色可以拥有授予和撤销的特权。 用户帐户可以被授予角色，角色授予帐户与每个角色关联的权限。这允许将权限集分配给帐户，并提供一种方便的替代方法来授予个人权限，既可以概念化所需的权限分配，也可以实现它们。 以下列表总结了 MySQL 提供的角色管理功能： CREATE ROLE并 DROP ROLE创建和删除角色。
- GRANT并 REVOKE分配权限以撤销用户帐户和角色的权限。
- SHOW GRANTS显示用户帐户和角色的权限和角色分配。
- SET DEFAULT ROLE指定默认情况下哪些帐户角色处于活动状态。
- SET ROLE更改当前会话中的活动角色。
- 该CURRENT_ROLE()函数显示当前会话中的活动角色。
- 和系统变量允许定义强制角色mandatory_roles并 activate_all_roles_on_login 在用户登录到服务器时自动激活授予的角色。

      有关单个角色操作语句（包括使用它们所需的权限）的描述，请参阅
      第 13.7.1 节，“账户管理语句”。以下讨论提供了角色使用示例。除非另有说明，否则此处显示的 SQL 语句应使用具有足够管理权限的 MySQL 帐户执行，例如该`root`帐户。

- 创建角色并授予他们特权
- 定义强制角色
- 检查角色权限
- 激活角色
- 撤销角色或角色特权
- 删除角色
- 用户和角色互换性

#### 创建角色并授予他们特权

        考虑这种情况：

- 一个应用程序使用一个名为 app_db.
- 与应用程序相关联的是创建和维护应用程序的开发人员以及与之交互的用户的帐户。
- 开发人员需要对数据库的完全访问权限。一些用户只需要读访问权限，其他用户需要读/写访问权限。

        为避免单独向可能的许多用户帐户授予权限，请创建角色作为所需权限集的名称。这使得通过授予适当的角色向用户帐户授予所需的权限变得容易。

        要创建角色，请使用以下`CREATE ROLE`语句：

```sql
CREATE ROLE 'app_developer', 'app_read', 'app_write';
```

        角色名很像用户帐户名，在

        格式上由用户部分和主机部分组成。主机部分，如果省略，默认为
        . 用户和主机部分可以不加引号，除非它们包含特殊字符，例如
        or 。与账户名不同，角色名的用户部分不能为空。有关其他信息，请参阅第 6.2.5 节，“指定角色名称”。
      `'user_name`'@'*`host_name`*'`'%'``-``%`

        要为角色​​分配权限，请
        `GRANT`使用与为用户帐户分配权限相同的语法执行语句：

```sql
GRANT ALL ON app_db.* TO 'app_developer';
GRANT SELECT ON app_db.* TO 'app_read';
GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';
```

        现在假设最初您需要一个开发者帐户、两个需要只读访问权限的用户帐户和一个需要读/写访问权限的用户帐户。用于
        `CREATE USER`创建帐户：

```sql
CREATE USER 'dev1'@'localhost' IDENTIFIED BY 'dev1pass';
CREATE USER 'read_user1'@'localhost' IDENTIFIED BY 'read_user1pass';
CREATE USER 'read_user2'@'localhost' IDENTIFIED BY 'read_user2pass';
CREATE USER 'rw_user1'@'localhost' IDENTIFIED BY 'rw_user1pass';
```

        要为每个用户帐户分配所需的权限，您可以使用`GRANT`与刚才显示的相同形式的语句，但这需要为每个用户枚举单独的权限。相反，使用允许授予角色而不是特权的替代
        `GRANT`语法：

```sql
GRANT 'app_developer' TO 'dev1'@'localhost';
GRANT 'app_read' TO 'read_user1'@'localhost', 'read_user2'@'localhost';
GRANT 'app_read', 'app_write' TO 'rw_user1'@'localhost';
```

        该帐户的`GRANT`语句
        `rw_user1`授予读取和写入角色，它们结合起来提供所需的读取和写入权限。

        向帐户授予角色的`GRANT`语法不同于授予权限的语法：有一个`ON`子句来分配权限，而没有`ON`子句来分配角色。由于语法不同，您不能在同一语句中混合分配特权和角色。（允许将权限和角色分配给一个帐户，但您必须使用单独的`GRANT`
        语句，每个语句的语法适合于要授予的内容。）从 MySQL 8.0.16 开始，角色不能授予匿名用户。

        创建的角色是锁定的，没有密码，并分配有默认的身份验证插件。（这些角色属性稍后可以由具有全局权限
      `ALTER USER`
        的用户使用语句
        更改。）`CREATE USER`

        锁定时，角色不能用于对服务器进行身份验证。如果解锁，则可以使用角色进行身份验证。这是因为角色和用户都是授权标识符，它们有很多共同点，但几乎没有什么区别。另请参阅
        用户和角色互换性。

#### 定义强制角色

`mandatory_roles`可以通过在系统变量
        的值中命名它们来将角色指定为强制性的
        。服务器将强制角色视为授予所有用户，因此无需明确授予任何帐户。

        要在服务器启动时指定强制角色，
        `mandatory_roles`请在服务器
        `my.cnf`文件中定义：

```text
[mysqld]
mandatory_roles='role1,role2@localhost,r3@%.example.com'
```

        要在运行时设置和持久
        `mandatory_roles`化，请使用如下语句：

```sql
SET PERSIST mandatory_roles = 'role1,role2@localhost,r3@%.example.com';
```

        `SET PERSIST`为正在运行的 MySQL 实例设置一个值。它还会保存该值，使其在随后的服务器重新启动时继续使用。要更改正在运行的 MySQL 实例的值而不使其延续到后续重新启动，请使用`GLOBAL`关键字而不是
        `PERSIST`. 请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。

        除了

        通常设置全局系统变量所需
      的特权（或已弃用的特权）之外，
        设置还`mandatory_roles`
        需要特权。`ROLE_ADMIN``SYSTEM_VARIABLES_ADMIN``SUPER`

        强制角色，如明确授予的角色，在激活之前不会生效（请参阅激活角色）。在登录时，如果启用了系统变量，则所有授予的角色都会激活`activate_all_roles_on_login`
        角色，否则会激活设置为默认角色的角色。在运行时，`SET ROLE`激活角色。

        在值中命名的角色
        `mandatory_roles`不能用 or 撤销或
        `REVOKE`删除。
      `DROP ROLE``DROP USER`

        为了防止会话默认成为系统会话，具有`SYSTEM_USER`
        特权的角色不能列在
        `mandatory_roles`系统变量的值中：

- 如果mandatory_roles在启动时分配了一个具有 SYSTEM_USER特权的角色，则服务器将一条消息写入错误日志并退出。
- 如果mandatory_roles在运行时分配了一个具有 SYSTEM_USER特权的角色，则会发生错误并且 mandatory_roles值保持不变。

        即使有这种保护措施，最好还是避免
        `SYSTEM_USER`通过角色授予特权，以防止特权升级的可能性。

`mandatory_roles`如果系统表中不存在
        名为 in
        `mysql.user`的角色，则不会向用户授予该角色。当服务器尝试为用户激活角色时，它不会将不存在的角色视为必需角色，并将警告写入错误日志。如果角色稍后创建并因此变得有效，`FLUSH PRIVILEGES`则可能需要使服务器将其视为强制性的。

        `SHOW GRANTS`根据第 13.7.7.21 节，“SHOW GRANTS 语句”中描述的规则显示强制角色
        。

#### 检查角色权限

        要验证分配给帐户的权限，请使用
        `SHOW GRANTS`。例如：

```sql
mysql> SHOW GRANTS FOR 'dev1'@'localhost';
+-------------------------------------------------+
| Grants for dev1@localhost                       |
+-------------------------------------------------+
| GRANT USAGE ON *.* TO `dev1`@`localhost`        |
| GRANT `app_developer`@`%` TO `dev1`@`localhost` |
+-------------------------------------------------+
```

        但是，这显示了每个授予的角色，而没有
        将其“扩展”为该角色所代表的特权。要同时显示角色权限，请添加一个
        `USING`子句，命名要显示权限的授予角色：

```sql
mysql> SHOW GRANTS FOR 'dev1'@'localhost' USING 'app_developer';
+----------------------------------------------------------+
| Grants for dev1@localhost                                |
+----------------------------------------------------------+
| GRANT USAGE ON *.* TO `dev1`@`localhost`                 |
| GRANT ALL PRIVILEGES ON `app_db`.* TO `dev1`@`localhost` |
| GRANT `app_developer`@`%` TO `dev1`@`localhost`          |
+----------------------------------------------------------+
```

        类似地验证其他类型的用户：

```sql
mysql> SHOW GRANTS FOR 'read_user1'@'localhost' USING 'app_read';
+--------------------------------------------------------+
| Grants for read_user1@localhost                        |
+--------------------------------------------------------+
| GRANT USAGE ON *.* TO `read_user1`@`localhost`         |
| GRANT SELECT ON `app_db`.* TO `read_user1`@`localhost` |
| GRANT `app_read`@`%` TO `read_user1`@`localhost`       |
+--------------------------------------------------------+
mysql> SHOW GRANTS FOR 'rw_user1'@'localhost' USING 'app_read', 'app_write';
+------------------------------------------------------------------------------+
| Grants for rw_user1@localhost                                                |
+------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `rw_user1`@`localhost`                                 |
| GRANT SELECT, INSERT, UPDATE, DELETE ON `app_db`.* TO `rw_user1`@`localhost` |
| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`localhost`               |
+------------------------------------------------------------------------------+
```

        `SHOW GRANTS`根据第 13.7.7.21 节，“SHOW GRANTS 语句”中描述的规则显示强制角色
        。

#### 激活角色

        授予用户帐户的角色可以在帐户会话中处于活动状态或非活动状态。如果授予的角色在会话中处于活动状态，则其特权适用；否则，他们不会。要确定哪些角色在当前会话中处于活动状态，请使用该
        `CURRENT_ROLE()`函数。

        默认情况下，将角色授予帐户或在
        `mandatory_roles`系统变量值中为其命名不会自动导致角色在帐户会话中变为活动状态。例如，因为到目前为止在前面的讨论中没有`rw_user1`角色被激活，如果您连接到服务器
        `rw_user1`并调用
        `CURRENT_ROLE()`函数，结果是`NONE`（没有活动角色）：

```sql
mysql> SELECT CURRENT_ROLE();
+----------------+
| CURRENT_ROLE() |
+----------------+
| NONE           |
+----------------+
```

        要指定每次用户连接到服务器并进行身份验证时应激活哪些角色，请使用
        `SET DEFAULT ROLE`. 要为之前创建的每个帐户设置所有已分配角色的默认值，请使用以下语句：

```sql
SET DEFAULT ROLE ALL TO
  'dev1'@'localhost',
  'read_user1'@'localhost',
  'read_user2'@'localhost',
  'rw_user1'@'localhost';
```

        现在，如果您连接为`rw_user1`，则初始值`CURRENT_ROLE()`反映了新的默认角色分配：

```sql
mysql> SELECT CURRENT_ROLE();
+--------------------------------+
| CURRENT_ROLE()                 |
+--------------------------------+
| `app_read`@`%`,`app_write`@`%` |
+--------------------------------+
```

        要使所有显式授予和强制角色在用户连接到服务器时自动激活，请启用`activate_all_roles_on_login`
        系统变量。默认情况下，禁用自动角色激活。

        在会话中，用户可以执行`SET ROLE`更改活动角色集。例如，对于`rw_user1`：

```sql
mysql> SET ROLE NONE; SELECT CURRENT_ROLE();
+----------------+
| CURRENT_ROLE() |
+----------------+
| NONE           |
+----------------+
mysql> SET ROLE ALL EXCEPT 'app_write'; SELECT CURRENT_ROLE();
+----------------+
| CURRENT_ROLE() |
+----------------+
| `app_read`@`%` |
+----------------+
mysql> SET ROLE DEFAULT; SELECT CURRENT_ROLE();
+--------------------------------+
| CURRENT_ROLE()                 |
+--------------------------------+
| `app_read`@`%`,`app_write`@`%` |
+--------------------------------+
```

        第一条`SET ROLE`语句停用所有角色。第二个使
        `rw_user1`有效只读。第三个恢复默认角色。

        存储程序和视图对象的有效用户受`DEFINER`和`SQL SECURITY`属性的约束，这些属性确定执行是发生在调用者还是定义者上下文中（请参阅
        第 25.6 节，“存储对象访问控制”）：

- 在调用者上下文中执行的存储程序和视图对象与在当前会话中处于活动状态的角色一起执行。
- 在定义者上下文中执行的存储程序和视图对象以其DEFINER属性中命名的用户的默认角色执行。如果 activate_all_roles_on_login 启用，则此类对象将执行授予DEFINER用户的所有角色，包括强制角色。对于存储的程序，如果以不同于默认的角色执行，则程序主体可以执行SET ROLE以激活所需的角色。必须谨慎执行此操作，因为分配给角色的权限可以更改。

#### 撤销角色或角色特权

        正如可以将角色授予帐户一样，也可以从帐户中撤销角色：

```sql
REVOKE role FROM user;
```

        在系统变量值中命名的角色
        `mandatory_roles`不能被撤销。

        `REVOKE`也可以应用于角色以修改授予它的特权。这不仅会影响角色本身，还会影响授予该角色的任何帐户。假设您希望暂时将所有应用程序用户设置为只读。为此，请使用`REVOKE`撤销
        `app_write`角色的修改权限：

```sql
REVOKE INSERT, UPDATE, DELETE ON app_db.* FROM 'app_write';
```

        碰巧的是，这使得角色根本没有任何特权，正如可以看到的那样`SHOW GRANTS`
        （这表明该语句可以与角色一起使用，而不仅仅是用户）：

```sql
mysql> SHOW GRANTS FOR 'app_write';
+---------------------------------------+
| Grants for app_write@%                |
+---------------------------------------+
| GRANT USAGE ON *.* TO `app_write`@`%` |
+---------------------------------------+
```

        因为撤销角色的权限会影响分配了修改后的角色的任何用户的权限，
        `rw_user1`现在没有表修改权限（`INSERT`、
        `UPDATE`和
        `DELETE`不再存在）：

```sql
mysql> SHOW GRANTS FOR 'rw_user1'@'localhost'
       USING 'app_read', 'app_write';
+----------------------------------------------------------------+
| Grants for rw_user1@localhost                                  |
+----------------------------------------------------------------+
| GRANT USAGE ON *.* TO `rw_user1`@`localhost`                   |
| GRANT SELECT ON `app_db`.* TO `rw_user1`@`localhost`           |
| GRANT `app_read`@`%`,`app_write`@`%` TO `rw_user1`@`localhost` |
+----------------------------------------------------------------+
```

        实际上，`rw_user1`读/写用户已成为只读用户。对于被授予角色的任何其他帐户也会发生这种情况`app_write`，说明角色的使用如何使修改单个帐户的权限变得不必要。

        要恢复角色的修改权限，只需重新授予它们：

```sql
GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';
```

        现在`rw_user1`再次具有修改权限，就像授予该
        `app_write`角色的任何其他帐户一样。

#### 删除角色

        要删除角色，请使用`DROP ROLE`：

```sql
DROP ROLE 'app_read', 'app_write';
```

        删除角色会从授予它的每个帐户中撤销它。

`mandatory_roles`不能删除

        在系统变量值中命名的角色
        。

#### 用户和角色互换性

        正如前面 for 所暗示的那样`SHOW GRANTS`，它显示了对用户帐户或角色的授权，帐户和角色可以互换使用。

        角色和用户之间的一个区别是
        `CREATE ROLE`创建一个默认锁定的授权标识符，而
        `CREATE USER`创建一个默认解锁的授权标识符。但是，区别并不是一成不变的，因为具有适当权限的用户可以在创建角色或用户后锁定或解锁角色或用户。

        如果数据库管理员偏好特定授权标识符必须是角色，则可以使用名称方案来传达此意图。例如，您可以
        `r_`为您打算成为角色的所有授权标识符使用前缀，而不是其他任何内容。

        角色和用户之间的另一个区别在于可用于管理它们的特权：

- 和权限分别 只允许使用CREATE ROLE和 语句。 DROP ROLECREATE ROLEDROP ROLE
- 该CREATE USER特权允许使用ALTER USER、CREATE ROLE、 CREATE USER、 DROP ROLE、 DROP USER、 RENAME USER和 REVOKE ALL PRIVILEGES语句。

        因此，`CREATE ROLE`和
        `DROP ROLE`特权并不像`CREATE USER`应该被授予创建和删除角色的用户那样强大，也可能被授予这些用户，而不能执行更一般的帐户操作。

        关于用户和角色的权限和互换性，您可以将用户帐户视为角色，并将该帐户授予另一个用户或角色。效果是将帐户的权限和角色授予其他用户或角色。

        这组语句演示了您可以将用户授予用户、将角色授予用户、将用户授予角色或将角色授予角色：

```sql
CREATE USER 'u1';
CREATE ROLE 'r1';
GRANT SELECT ON db1.* TO 'u1';
GRANT SELECT ON db2.* TO 'r1';
CREATE USER 'u2';
CREATE ROLE 'r2';
GRANT 'u1', 'r1' TO 'u2';
GRANT 'u1', 'r1' TO 'r2';
```

        在每种情况下，结果都是将与被授予对象关联的特权授予被授予者对象。执行这些语句后，每个`u2`和
        `r2`都被授予了用户 ( `u1`) 和角色 ( `r1`) 的权限：

```sql
mysql> SHOW GRANTS FOR 'u2' USING 'u1', 'r1';
+-------------------------------------+
| Grants for u2@%                     |
+-------------------------------------+
| GRANT USAGE ON *.* TO `u2`@`%`      |
| GRANT SELECT ON `db1`.* TO `u2`@`%` |
| GRANT SELECT ON `db2`.* TO `u2`@`%` |
| GRANT `u1`@`%`,`r1`@`%` TO `u2`@`%` |
+-------------------------------------+
mysql> SHOW GRANTS FOR 'r2' USING 'u1', 'r1';
+-------------------------------------+
| Grants for r2@%                     |
+-------------------------------------+
| GRANT USAGE ON *.* TO `r2`@`%`      |
| GRANT SELECT ON `db1`.* TO `r2`@`%` |
| GRANT SELECT ON `db2`.* TO `r2`@`%` |
| GRANT `u1`@`%`,`r1`@`%` TO `r2`@`%` |
+-------------------------------------+
```

        前面的示例只是说明性的，但是用户帐户和角色的互换性具有实际应用，例如在以下情况中：假设遗留应用程序开发项目在 MySQL 角色出现之前开始，因此与该项目关联的所有用户帐户都是直接授予特权（而不是通过授予角色授予特权）。其中一个帐户是开发者帐户，最初被授予以下权限：

```sql
CREATE USER 'old_app_dev'@'localhost' IDENTIFIED BY 'old_app_devpass';
GRANT ALL ON old_app.* TO 'old_app_dev'@'localhost';
```

        如果此开发人员离开项目，则有必要将权限分配给另一个用户，或者如果开发活动已扩展，则可能分配给多个用户。以下是处理该问题的一些方法：

- 不使用角色：修改账号密码，让原开发者无法使用，让新开发者使用该账号： ```sql ALTER USER 'old_app_dev'@'localhost' IDENTIFIED BY 'new_password'; ```
- 使用角色：锁定账户以防止任何人使用它连接到服务器： ```sql ALTER USER 'old_app_dev'@'localhost' ACCOUNT LOCK; ``` 然后将帐户视为角色。对于项目的每个新开发者，创建一个新帐户并授予其原始开发者帐户： ```sql CREATE USER 'new_app_dev1'@'localhost' IDENTIFIED BY 'new_password'; GRANT 'old_app_dev'@'localhost' TO 'new_app_dev1'@'localhost'; ``` 作用是将原开发者账号权限赋予新账号。

---

[← 返回 第 6 章 安全 索引](00-index.md) · [← 返回总索引](../00-index.md)
