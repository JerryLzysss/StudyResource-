# 第 6 章 安全 · 密码管理

> 对应 SQL：[`sql/refman/ch06-security/08-password-management.sql`](../../../sql/refman/ch06-security/08-password-management.sql)

---

6.2.15 密码管理_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 6 章 安全 / 6.2 访问控制和账户管理 / 6.2.15 密码管理 MySQL 支持这些密码管理功能： 密码过期，要求定期更改密码。
- 密码重用限制，以防止再次选择旧密码。
- 密码验证，要求密码更改还指定要替换的当前密码。
- 双密码，使客户端能够使用主密码或辅助密码进行连接。
- 密码强度评估，要求密码强度高。
- 随机密码生成，作为要求明确的管理员指定的文字密码的替代方法。
- 密码失败跟踪，以在连续多次错误密码登录失败后启用临时帐户锁定。

      以下部分描述了这些功能，但密码强度评估除外，密码强度评估是使用该
      `validate_password`组件实现的，并在
      第 6.4.3 节“密码验证组件”中进行了描述。

- 内部与外部凭证存储
- 密码过期政策
- 密码重用政策
- 需要密码验证策略
- 双密码支持
- 随机密码生成
- 登录失败跟踪和临时帐户锁定

重要的

`mysql`MySQL 使用系统数据库
        中的表来实现密码管理功能。如果您从早期版本升级 MySQL，您的系统表可能不是最新的。在这种情况下，服务器会在启动过程中将类似于这些的消息写入错误日志（确切数字可能会有所不同）：

```text
[ERROR] Column count of mysql.user is wrong. Expected
49, found 47. The table is probably corrupted
[Warning] ACL table mysql.password_history missing.
Some operations may fail.
```

        要更正此问题，请执行 MySQL 升级过程。请参阅
        第 2.11 节，“升级 MySQL”。在此之前，
        *无法更改密码。*

#### 内部与外部凭证存储

        一些身份验证插件在`mysql.user`系统表中将帐户凭据内部存储到 MySQL：

- mysql_native_password
- caching_sha2_password
- sha256_password

        本节中的大部分讨论适用于此类身份验证插件，因为此处描述的大多数密码管理功能都基于 MySQL 本身处理的内部凭据存储。其他身份验证插件将帐户凭据存储在 MySQL 外部。对于使用针对外部凭证系统执行身份验证的插件的帐户，密码管理也必须针对该系统在外部进行处理。

        例外情况是失败登录跟踪和临时帐户锁定选项适用于所有帐户，而不仅仅是使用内部凭据存储的帐户，因为 MySQL 能够评估任何帐户的登录尝试状态，无论它使用内部或外部凭证存储。

        有关各个身份验证插件的信息，请参阅
        第 6.4.1 节，“身份验证插件”。

#### 密码过期政策

        MySQL 使数据库管理员能够手动使帐户密码过期，并建立自动密码过期策略。可以在全球范围内建立过期策略，并且可以将各个帐户设置为遵循全局策略或使用特定的每个帐户行为覆盖全局策略。

        要手动使帐户密码过期，请使用以下
        `ALTER USER`语句：

```sql
ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE;
```

`mysql.user`此操作在系统表

        的相应行中标记密码过期。

        根据策略，密码过期是自动的，并基于密码期限，对于给定帐户，密码期限是从其最近一次密码更改的日期和时间开始评估的。系统表为每个帐户指示上次更改其密码的
        `mysql.user`时间，如果密码的期限大于其允许的生存期，服务器会自动将密码视为在客户端连接时已过期。这适用于没有明确的手动密码过期。

        要在全局范围内建立自动密码过期策略，请使用`default_password_lifetime`
        系统变量。它的默认值为 0，即禁用自动密码过期。如果 的值为
        `default_password_lifetime`正整数*`N`*，则表示允许的密码生存期，即每天必须更改密码*`N`*。

        例子：

- 要建立密码有效期约为六个月的全局策略，请在服务器my.cnf文件中使用以下行启动服务器： ```text [mysqld] default_password_lifetime=180 ```
- 要建立密码永不过期的全局策略，请设置 default_password_lifetime 为 0： ```text [mysqld] default_password_lifetime=0 ```
- default_password_lifetime 也可以在运行时设置和持久化： ```sql SET PERSIST default_password_lifetime = 180; SET PERSIST default_password_lifetime = 0; ``` SET PERSIST为正在运行的 MySQL 实例设置一个值。它还会保存该值以用于随后的服务器重新启动；参见 第 13.7.6.1 节，“变量赋值的 SET 语法”。要更改正在运行的 MySQL 实例的值而不使其延续到后续重新启动，请使用GLOBAL 关键字而不是PERSIST.

        全局密码过期策略适用于所有未设置为覆盖它的帐户。要为个人帐户建立策略，请使用和
        语句的`PASSWORD EXPIRE`
        选项。请参阅
        第 13.7.1.3 节，“CREATE USER 语句”和第 13.7.1.1 节，“ALTER USER 语句”。
      `CREATE USER``ALTER USER`

        特定账户报表示例：

- 要求密码每 90 天更改一次： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY; ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY; ``` 此过期选项会覆盖该语句指定的所有帐户的全局策略。
- 禁用密码过期： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE NEVER; ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE NEVER; ``` 此过期选项会覆盖该语句指定的所有帐户的全局策略。
- 遵守语句指定的所有帐户的全局过期策略： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE DEFAULT; ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE DEFAULT; ```

        当客户端连接成功后，服务端判断账号密码是否过期：

- 服务器检查密码是否已手动过期。
- 否则，服务器根据自动密码过期策略检查密码使用期限是否大于其允许的生存期。如果是，服务器认为密码已过期。

        如果密码过期（无论是手动还是自动），服务器要么断开客户端连接，要么限制允许的操作（参见
        第 6.2.16 节，“服务器处理过期密码”）。在用户建立新帐户密码之前，受限客户端执行的操作会导致错误：

```sql
mysql> SELECT 1;
ERROR 1820 (HY000): You must reset your password using ALTER USER
statement before executing this statement.

mysql> ALTER USER USER() IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT 1;
+---+
| 1 |
+---+
| 1 |
+---+
1 row in set (0.00 sec)
```

        客户端重置密码后，服务器恢复会话的正常访问，以及使用该帐户的后续连接。管理用户也可以重置帐户密码，但该帐户的任何现有受限会话仍然受限。使用该帐户的客户端必须断开连接并重新连接才能成功执行语句。

笔记

          虽然可以通过将过期的密码设置为当前值来“重置”该密码，但作为一种好的策略，最好选择一个不同的密码。DBA 可以通过建立适当的密码重用策略来强制禁止重用。请参阅
          密码重用政策。

#### 密码重用政策

        MySQL 允许限制重用以前的密码。可以根据密码更改次数、经过的时间或两者来建立重用限制。可以在全局范围内建立重用策略，并且可以将各个帐户设置为遵循全局策略或使用特定的每个帐户行为覆盖全局策略。

        帐户的密码历史由过去分配的密码组成。MySQL 可以限制从该历史记录中选择新密码：

- 如果一个帐户是基于密码更改次数限制的，则不能从指定数量的最近密码中选择一个新密码。例如，如果密码的最小更改次数设置为 3，则新密码不能与最近的 3 个密码中的任何一个相同。
- 如果一个帐户是基于经过时间限制的，则不能从历史记录中比指定天数新的密码中选择新密码。例如，如果密码重用间隔设置为 60，则新密码不能是最近 60 天内选择的密码。

笔记

          空密码不计入密码历史记录，可以随时重复使用。

        要在全局范围内建立密码重用策略，请使用
        `password_history`和
        `password_reuse_interval`系统变量。

        例子：

- 要禁止重复使用最近 6 个密码或超过 365 天的密码，请将这些行放在服务器 my.cnf文件中： ```text [mysqld] password_history=6 password_reuse_interval=365 ```
- 要在运行时设置和持久化变量，请使用如下语句： ```sql SET PERSIST password_history = 6; SET PERSIST password_reuse_interval = 365; ``` SET PERSIST为正在运行的 MySQL 实例设置一个值。它还会保存该值以用于随后的服务器重新启动；参见 第 13.7.6.1 节，“变量赋值的 SET 语法”。要更改正在运行的 MySQL 实例的值而不使其延续到后续重新启动，请使用GLOBAL 关键字而不是PERSIST.

        全局密码重用策略适用于所有未设置为覆盖它的帐户。要为个人帐户建立策略，请使用and
        语句的`PASSWORD HISTORY`
        and`PASSWORD REUSE INTERVAL`选项
        。请参阅
        第 13.7.1.3 节，“CREATE USER 语句”和第 13.7.1.1 节，“ALTER USER 语句”。
      `CREATE USER``ALTER USER`

        特定账户报表示例：

- 在允许重新使用之前至少需要更改 5 次密码： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD HISTORY 5; ALTER USER 'jeffrey'@'localhost' PASSWORD HISTORY 5; ``` 此历史长度选项覆盖语句命名的所有帐户的全局策略。
- 需要至少 365 天后才允许重新使用： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REUSE INTERVAL 365 DAY; ALTER USER 'jeffrey'@'localhost' PASSWORD REUSE INTERVAL 365 DAY; ``` 这个经过时间的选项覆盖了语句命名的所有帐户的全局策略。
- 要组合两种类型的重用限制，请一起使用 PASSWORD HISTORY和PASSWORD REUSE INTERVAL： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD HISTORY 5 PASSWORD REUSE INTERVAL 365 DAY; ALTER USER 'jeffrey'@'localhost' PASSWORD HISTORY 5 PASSWORD REUSE INTERVAL 365 DAY; ``` 这些选项覆盖了语句命名的所有帐户的全局策略重用限制。
- 遵守两种类型的重用限制的全局策略： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD HISTORY DEFAULT PASSWORD REUSE INTERVAL DEFAULT; ALTER USER 'jeffrey'@'localhost' PASSWORD HISTORY DEFAULT PASSWORD REUSE INTERVAL DEFAULT; ```

#### 需要密码验证策略

        从 MySQL 8.0.13 开始，可以要求通过指定要替换的当前密码来验证更改帐户密码的尝试。这使 DBA 能够防止用户在未证明知道当前密码的情况下更改密码。否则可能会发生此类更改，例如，如果一个用户在没有注销的情况下暂时离开终端会话，并且恶意用户使用该会话更改原始用户的 MySQL 密码。这可能会产生不幸的后果：

- 在管理员重置帐户密码之前，原始用户将无法访问 MySQL。
- 在密码重置发生之前，恶意用户可以使用良性用户更改后的凭据访问 MySQL。

        可以在全球范围内建立密码验证策略，并且可以将各个帐户设置为遵循全局策略或以特定的每个帐户行为覆盖全局策略。

        对于每个帐户，其`mysql.user`行指示是否存在特定于帐户的设置，要求在尝试更改密码时验证当前密码。该设置由and
        语句
的`PASSWORD REQUIRE`选项建立：`CREATE USER``ALTER USER`

- 如果帐户设置为PASSWORD REQUIRE CURRENT，密码更改必须指定当前密码。
- 如果帐户设置为PASSWORD REQUIRE CURRENT OPTIONAL，密码更改可以但不需要指定当前密码。
- 如果账户设置为PASSWORD REQUIRE CURRENT DEFAULT，则 password_require_current 系统变量确定账户的需要验证的策略： 如果 password_require_current 启用，密码更改必须指定当前密码。
- 如果 password_require_current 禁用，密码更改可能但不需要指定当前密码。

        换句话说，如果帐户设置不是`PASSWORD REQUIRE CURRENT DEFAULT`，则帐户设置优先于
        `password_require_current`系统变量建立的全局策略。否则，该帐户将遵循该
        `password_require_current`
        设置。

        默认情况下，密码验证是可选的：
        `password_require_current`被禁用，没有`PASSWORD REQUIRE`选项的帐户创建默认为`PASSWORD REQUIRE CURRENT DEFAULT`。

        下表显示了每个帐户的设置如何与
        `password_require_current`系统变量值交互以确定帐户密码验证所需的策略。

**表 6.10 密码验证策略**

| 每个帐户设置 | password_require_current 系统变量 | 密码更改需要当前密码？ |
| --- | --- | --- |
| PASSWORD REQUIRE CURRENT | OFF | 是的 |
| PASSWORD REQUIRE CURRENT | ON | 是的 |
| PASSWORD REQUIRE CURRENT OPTIONAL | OFF | 不 |
| PASSWORD REQUIRE CURRENT OPTIONAL | ON | 不 |
| PASSWORD REQUIRE CURRENT DEFAULT | OFF | 不 |
| PASSWORD REQUIRE CURRENT DEFAULT | ON | 是的 |

笔记

          特权用户可以在不指定当前密码的情况下更改任何帐户密码，而不管需要验证的策略如何。特权用户是具有全局`CREATE USER`
          权限或系统数据库
`UPDATE`
          权限的用户。`mysql`

        要全局建立密码验证策略，请使用
        `password_require_current`系统变量。它的默认值为`OFF`，因此不需要更改帐户密码指定当前密码。

        例子：

- 要建立密码更改必须指定当前密码的全局策略，请在服务器my.cnf文件中使用以下行启动服务器： ```text [mysqld] password_require_current=ON ```
- 要在运行时设置和持久 password_require_current化，请使用如下语句之一： ```sql SET PERSIST password_require_current = ON; SET PERSIST password_require_current = OFF; ``` SET PERSIST为正在运行的 MySQL 实例设置一个值。它还会保存该值以用于随后的服务器重新启动；参见 第 13.7.6.1 节，“变量赋值的 SET 语法”。要更改正在运行的 MySQL 实例的值而不使其延续到后续重新启动，请使用GLOBAL 关键字而不是PERSIST.

        全局密码验证要求策略适用于所有未设置覆盖它的帐户。要为个人帐户建立策略，请使用和
        语句的`PASSWORD REQUIRE`选项。请参阅第 13.7.1.3 节，“CREATE USER 语句”和
        第 13.7.1.1 节，“ALTER USER 语句”。
      `CREATE USER``ALTER USER`

        特定账户报表示例：

- 要求密码更改指定当前密码： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT; ALTER USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT; ``` 此验证选项覆盖声明中指定的所有帐户的全局策略。
- 不要求密码更改指定当前密码（可以但不需要提供当前密码）： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT OPTIONAL; ALTER USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT OPTIONAL; ``` 此验证选项覆盖声明中指定的所有帐户的全局策略。
- 对语句指定的所有帐户遵循全局密码验证要求策略： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT DEFAULT; ALTER USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT DEFAULT; ```

`ALTER USER`当用户使用or`SET PASSWORD`
        语句
        更改密码时，将验证当前密码。示例使用`ALTER USER`, 优先于`SET PASSWORD`, 但此处描述的原则对于这两个语句是相同的。

        在密码更改语句中，`REPLACE`
        子句指定要替换的当前密码。例子：

- 更改当前用户的密码： ```sql ALTER USER USER() IDENTIFIED BY 'auth_string' REPLACE 'current_auth_string'; ```
- 更改指定用户的密码： ```sql ALTER USER 'jeffrey'@'localhost' IDENTIFIED BY 'auth_string' REPLACE 'current_auth_string'; ```
- 更改指定用户的身份验证插件和密码： ```sql ALTER USER 'jeffrey'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'auth_string' REPLACE 'current_auth_string'; ```

        该`REPLACE`子句的工作原理如下：

- REPLACE如果需要更改帐户的密码以指定当前密码，则必须给出，以验证尝试进行更改的用户实际上知道当前密码。
- REPLACE如果帐户的密码更改可能但不需要指定当前密码，则该选项是可选的。
- 如果REPLACE指定，则必须指定正确的当前密码，否则会出错。即使REPLACE是可选的也是如此。
- REPLACE只有在更改当前用户的帐户密码时才能指定。（这意味着在刚刚显示的示例中，jeffrey 除非当前用户是 ，否则显式命名帐户的语句将失败jeffrey。）即使特权用户尝试对另一个用户进行更改也是如此；但是，这样的用户可以在不指定的情况下更改任何密码REPLACE。
- REPLACE从二进制日志中省略，以避免向其写入明文密码。

#### 双密码支持

        从 MySQL 8.0.14 开始，允许用户帐户拥有双重密码，指定为主密码和辅助密码。双密码功能可以在以下场景中无缝执行凭据更改：

- 一个系统有大量的MySQL服务器，可能涉及复制。
- 多个应用程序连接到不同的 MySQL 服务器。
- 必须对应用程序用来连接服务器的一个或多个帐户定期更改凭据。

        考虑在只允许一个帐户使用一个密码的情况下，在上述类型的场景中必须如何执行凭据更改。在这种情况下，必须密切合作更改帐户密码并在所有服务器中传播的时间，以及更新使用该帐户的所有应用程序以使用新密码的时间。此过程可能涉及服务器或应用程序不可用的停机时间。

        使用双密码，可以更轻松地分阶段更改凭据，无需密切合作，也无需停机：

- 对于每个受影响的帐户，在服务器上建立一个新的主密码，保留当前密码作为辅助密码。这使服务器能够识别每个帐户的主要或次要密码，而应用程序可以继续使用与以前相同的密码（现在是次要密码）连接到服务器。
- 在密码更改传播到所有服务器后，修改使用任何受影响帐户的应用程序以使用帐户主密码进行连接。
- 在所有应用程序都从二级密码迁移到一级密码后，二级密码不再需要，可以丢弃。此更改传播到所有服务器后，只能使用每个帐户的主密码进行连接。凭据更改现已完成。

        MySQL 使用保存和丢弃二级密码的语法实现双密码功能：

- 当您分配新的主密码时， and 语句 的RETAIN CURRENT PASSWORD子句将帐户当前密码保存为其辅助密码。 ALTER USERSET PASSWORD
- DISCARD OLD PASSWORD子句 丢弃一个帐户 的ALTER USER二级密码，只留下主密码。

        假设，对于前面描述的凭据更改场景，
        `'appuser1'@'host1.example.com'`应用程序使用名为 的帐户连接到服务器，并且帐户密码将从 更改
        为
        。
      `'password_a`'`'password_b`'

        要执行此凭据更改，请`ALTER USER`按如下方式使用：

- 在不是副本的每个服务器上，建立 新的主密码，保留当前密码作为辅助密码： 'password_b'appuser1 ```sql ALTER USER 'appuser1'@'host1.example.com' IDENTIFIED BY 'password_b' RETAIN CURRENT PASSWORD; ```
- 等待密码更改在整个系统中复制到所有副本。
- 修改使用该 appuser1帐户的每个应用程序，以便它使用密码 而不是 连接到服务器。 'password_b''password_a'
- 此时，不再需要二级密码。在不是副本的每台服务器上，丢弃辅助密码： ```sql ALTER USER 'appuser1'@'host1.example.com' DISCARD OLD PASSWORD; ```
- 在丢弃密码更改复制到所有副本后，凭证更改完成。

`RETAIN CURRENT PASSWORD`and
        `DISCARD OLD PASSWORD`子句具有以下作用

        ：

- RETAIN CURRENT PASSWORD保留帐户当前密码作为其辅助密码，替换任何现有的辅助密码。新密码成为主密码，但客户端可以使用该帐户使用主密码或辅助密码连接到服务器。ALTER USER （例外：如果or语句指定的新密码SET PASSWORD为空，即使 RETAIN CURRENT PASSWORD给出了二级密码也为空。）
- 如果您RETAIN CURRENT PASSWORD 为主密码为空的帐户指定，该语句将失败。
- 如果一个帐户有一个二级密码，而您在没有指定的情况下更改了它的主密码RETAIN CURRENT PASSWORD，则二级密码将保持不变。
- 对于ALTER USER，如果您更改分配给该帐户的身份验证插件，则二级密码将被丢弃。如果您更改身份验证插件并指定RETAIN CURRENT PASSWORD，则语句失败。
- 对于ALTER USER, DISCARD OLD PASSWORD丢弃二级密码（如果存在）。该帐户只保留其主密码，客户端只能使用主密码使用该帐户连接到服务器。

        修改辅助密码的语句需要这些权限：

- APPLICATION_PASSWORD_ADMIN 需要权限才能使用适用于您自己帐户 的 RETAIN CURRENT PASSWORDorDISCARD OLD PASSWORD子句ALTER USER和语句。SET PASSWORD由于大多数用户只需要一个密码，因此需要该权限来操作您自己的二级密码。
- 如果允许一个帐户操作所有帐户的辅助密码，则应该授予它 CREATE USER特权而不是 APPLICATION_PASSWORD_ADMIN.

#### 随机密码生成

        从 MySQL 8.0.18 开始，`CREATE USER`、`ALTER USER`和
        `SET PASSWORD`语句能够为用户帐户生成随机密码，作为要求显式管理员指定的文字密码的替代方法。有关语法的详细信息，请参阅每个语句的描述。本节介绍生成的随机密码的共同特征。

        默认情况下，生成的随机密码的长度为 20 个字符。该长度由
        `generated_random_password_length`
        系统变量控制，范围从 5 到 255。

        对于语句生成随机密码的每个帐户，该语句将密码存储在
        `mysql.user`系统表中，并为帐户身份验证插件适当地散列。该语句还在结果集中的一行中返回明文密码，以使其可供执行该语句的用户或应用程序使用。结果集列命名为`user`、
         `host`、`generated password`，并`auth_factor`指示标识
        `mysql.user`系统表中受影响的行的用户名和主机名值、明文生成的密码以及显示的密码值适用的身份验证因素。

```sql
mysql> CREATE USER
       'u1'@'localhost' IDENTIFIED BY RANDOM PASSWORD,
       'u2'@'%.example.com' IDENTIFIED BY RANDOM PASSWORD,
       'u3'@'%.org' IDENTIFIED BY RANDOM PASSWORD;
+------+---------------+----------------------+-------------+
| user | host          | generated password   | auth_factor |
+------+---------------+----------------------+-------------+
| u1   | localhost     | iOeqf>Mh9:;XD&qn(Hl} |           1 |
| u2   | %.example.com | sXTSAEvw3St-R+_-C3Vb |           1 |
| u3   | %.org         | nEVe%Ctw/U/*Md)Exc7& |           1 |
+------+---------------+----------------------+-------------+
mysql> ALTER USER
       'u1'@'localhost' IDENTIFIED BY RANDOM PASSWORD,
       'u2'@'%.example.com' IDENTIFIED BY RANDOM PASSWORD;
+------+---------------+----------------------+-------------+
| user | host          | generated password   | auth_factor |
+------+---------------+----------------------+-------------+
| u1   | localhost     | Seiei:&cw}8]@3OA64vh |           1 |
| u2   | %.example.com | j@&diTX80l8}(NiHXSae |           1 |
+------+---------------+----------------------+-------------+
mysql> SET PASSWORD FOR 'u3'@'%.org' TO RANDOM;
+------+-------+----------------------+-------------+
| user | host  | generated password   | auth_factor |
+------+-------+----------------------+-------------+
| u3   | %.org | n&cz2xF;P3!U)+]Vw52H |           1 |
+------+-------+----------------------+-------------+
```

        为帐户生成随机密码的`CREATE USER`,
        `ALTER USER`或
        语句作为带有
        , 子句的 or 语句写入二进制日志，其中是
        `SET PASSWORD`帐户身份验证插件，
        是帐户哈希密码值。
      `CREATE USER``ALTER USER``IDENTIFIED WITH auth_plugin`
        AS '*`auth_string`*'*`auth_plugin`*`'auth_string`'

        如果`validate_password`安装了该组件，则它实施的策略对生成的密码没有影响。（密码验证的目的是帮助人们创建更好的密码。）

#### 登录失败跟踪和临时帐户锁定

        从 MySQL 8.0.19 开始，管理员可以配置用户帐户，使得连续登录失败过多导致临时帐户锁定。

        “登录失败”在此上下文中表示客户端在连接尝试期间未能提供正确的密码。它不包括由于未知用户或网络问题等原因而导致的连接失败。对于具有双重密码的帐户（请参阅双重密码支持），任一帐户密码均视为正确。

        每个帐户所需的登录失败次数和锁定时间是可配置的，使用
        and
        语句的`FAILED_LOGIN_ATTEMPTS`and
        `PASSWORD_LOCK_TIME`选项
        。例子：
      `CREATE USER``ALTER USER`

```sql
CREATE USER 'u1'@'localhost' IDENTIFIED BY 'password'
  FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 3;

ALTER USER 'u2'@'localhost'
  FAILED_LOGIN_ATTEMPTS 4 PASSWORD_LOCK_TIME UNBOUNDED;
```

        当连续登录失败次数过多时，客户端会收到如下所示的错误：

```text
ERROR 3957 (HY000): Access denied for user user.
Account is blocked for D day(s) (R day(s) remaining)
due to N consecutive failed logins.
```

        使用如下选项：

- FAILED_LOGIN_ATTEMPTS N 此选项指示是否跟踪指定不正确密码的帐户登录尝试。该数字 N指定有多少次连续错误的密码导致临时帐户锁定。
- PASSWORD_LOCK_TIME {N | UNBOUNDED} 此选项指示在多次连续登录尝试提供错误密码后锁定帐户的时间。该值是一个数字N ，指定帐户保持锁定的天数，或者 UNBOUNDED指定当帐户进入临时锁定状态时，该状态的持续时间是无限的，直到帐户被解锁才结束。发生解锁的条件将在后面描述。

        每个选项的允许值*`N`*在 0 到 32767 的范围内。值为 0 将禁用该选项。

        登录失败跟踪和临时帐户锁定具有以下特征：

- 对于帐户的失败登录跟踪和临时锁定，其FAILED_LOGIN_ATTEMPTS和 PASSWORD_LOCK_TIME选项都必须为非零。
- 对于CREATE USER，如果 FAILED_LOGIN_ATTEMPTS或 PASSWORD_LOCK_TIME未指定，则对于语句命名的所有帐户，其隐式默认值为 0。这意味着登录失败跟踪和临时帐户锁定被禁用。（这些隐式默认值也适用于在引入失败登录跟踪之前创建的帐户。）
- 对于ALTER USER，如果 FAILED_LOGIN_ATTEMPTS或 PASSWORD_LOCK_TIME未指定，则其值对于语句命名的所有帐户保持不变。
- 要发生临时帐户锁定，密码失败必须是连续的。在达到FAILED_LOGIN_ATTEMPTS 失败登录值之前发生的任何成功登录都会导致失败计数重置。例如，如果FAILED_LOGIN_ATTEMPTS是 4 并且连续出现 3 次密码失败，则需要再失败一次才能开始锁定。但是，如果下一次登录成功，该帐户的登录失败计数将被重置，因此再次需要连续四次登录失败才能锁定。
- 一旦临时锁定开始，即使使用正确的密码也无法成功登录，直到锁定持续时间结束或通过以下讨论中列出的帐户重置方法之一解锁帐户。

        当服务器读取授权表时，它会为每个帐户初始化状态信息，包括是否启用登录失败跟踪、帐户当前是否被临时锁定以及锁定何时开始、如果帐户发生临时锁定前的失败次数未锁定。

        可以重置账户的状态信息，即重置登录失败计数，当前暂时锁定的账户将被解锁。帐户重置可以针对所有帐户或每个帐户进行全局设置：

- 对于以下任何情况，将对所有帐户进行全局重置： 服务器重启。
- 的执行FLUSH PRIVILEGES。（启动服务器 --skip-grant-tables 导致不读取授权表，这会禁用登录失败跟踪。在这种情况下，第一次执行FLUSH PRIVILEGES 会导致服务器读取授权表并启用登录失败跟踪，此外还会重置所有帐户.)

- 对于以下任何情况，都会发生每个帐户的重置： 账号登录成功。
- 锁定时间结束。在这种情况下，失败登录计数会在下次登录尝试时重置。
- ALTER USER为将其中一个FAILED_LOGIN_ATTEMPTS或 PASSWORD_LOCK_TIME（或两者）设置为任何值（包括当前期权值）的账户执行语句，或为账户执行 语句ALTER USER ... UNLOCK。 该帐户的其他ALTER USER 语句对其当前登录失败计数或其锁定状态没有影响。

        失败登录跟踪与用于检查凭据的登录帐户相关联。如果正在使用用户代理，则会对代理用户而不是被代理用户进行跟踪。也就是说，跟踪与 指示的帐户绑定
        `USER()`，而不是 指示的帐户`CURRENT_USER()`。有关代理和被代理用户之间区别的信息，请参阅第 6.2.19 节，“代理用户”。

---

[← 返回 第 6 章 安全 索引](00-index.md) · [← 返回总索引](../00-index.md)
