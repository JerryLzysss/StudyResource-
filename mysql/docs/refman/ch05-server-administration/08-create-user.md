# 第 5 章 MySQL 服务器管理 · CREATE USER

> 对应 SQL：[`sql/refman/ch05-server-administration/08-create-user.sql`](../../../sql/refman/ch05-server-administration/08-create-user.sql)

---

13.7.1.3 创建用户语句_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 13 章 SQL 语句 / 13.7 数据库管理语句 / 13.7.1 账户管理报表 / 13.7.1.3 创建用户语句 ```sql CREATE USER [IF NOT EXISTS] user [auth_option] [, user [auth_option]] ... DEFAULT ROLE role [, role ] ... [REQUIRE {NONE | tls_option [[AND] tls_option] ...}] [WITH resource_option [resource_option] ...] [password_option | lock_option] ... [COMMENT 'comment_string' | ATTRIBUTE 'json_object'] user: (see Section 6.2.4, “Specifying Account Names”) auth_option: { IDENTIFIED BY 'auth_string' [AND 2fa_auth_option] | IDENTIFIED BY RANDOM PASSWORD [AND 2fa_auth_option] | IDENTIFIED WITH auth_plugin [AND 2fa_auth_option] | IDENTIFIED WITH auth_plugin BY 'auth_string' [AND 2fa_auth_option] | IDENTIFIED WITH auth_plugin BY RANDOM PASSWORD [AND 2fa_auth_option] | IDENTIFIED WITH auth_plugin AS 'auth_string' [AND 2fa_auth_option] | IDENTIFIED WITH auth_plugin [initial_auth_option] } 2fa_auth_option: { IDENTIFIED BY 'auth_string' [AND 3fa_auth_option] | IDENTIFIED BY RANDOM PASSWORD [AND 3fa_auth_option] | IDENTIFIED WITH auth_plugin [AND 3fa_auth_option] | IDENTIFIED WITH auth_plugin BY 'auth_string' [AND 3fa_auth_option] | IDENTIFIED WITH auth_plugin BY RANDOM PASSWORD [AND 3fa_auth_option] | IDENTIFIED WITH auth_plugin AS 'auth_string' [AND 3fa_auth_option] } 3fa_auth_option: { IDENTIFIED BY 'auth_string' | IDENTIFIED BY RANDOM PASSWORD | IDENTIFIED WITH auth_plugin | IDENTIFIED WITH auth_plugin BY 'auth_string' | IDENTIFIED WITH auth_plugin BY RANDOM PASSWORD | IDENTIFIED WITH auth_plugin AS 'auth_string' } initial_auth_option: { INITIAL AUTHENTICATION IDENTIFIED BY {RANDOM PASSWORD | 'auth_string'} | INITIAL AUTHENTICATION IDENTIFIED WITH auth_plugin AS 'auth_string' } tls_option: { SSL | X509 | CIPHER 'cipher' | ISSUER 'issuer' | SUBJECT 'subject' } resource_option: { MAX_QUERIES_PER_HOUR count | MAX_UPDATES_PER_HOUR count | MAX_CONNECTIONS_PER_HOUR count | MAX_USER_CONNECTIONS count } password_option: { PASSWORD EXPIRE [DEFAULT | NEVER | INTERVAL N DAY] | PASSWORD HISTORY {DEFAULT | N} | PASSWORD REUSE INTERVAL {DEFAULT | N DAY} | PASSWORD REQUIRE CURRENT [DEFAULT | OPTIONAL] | FAILED_LOGIN_ATTEMPTS N | PASSWORD_LOCK_TIME {N | UNBOUNDED} } lock_option: { ACCOUNT LOCK | ACCOUNT UNLOCK } ``` 该CREATE USER语句创建新的 MySQL 帐户。它支持为新帐户建立身份验证、角色、SSL/TLS、资源限制、密码管理、注释和属性属性。它还控制帐户最初是锁定还是解锁。 要使用CREATE USER，您必须具有全局CREATE USER权限或系统架构的INSERT权限 。启用系统变量mysql时 ，还需要 权限（或已弃用的 权限）。 read_onlyCREATE USERCONNECTION_ADMINSUPER 从 MySQL 8.0.27 开始，这些额外的权限注意事项适用： 系统authentication_policy 变量对如何使用与身份验证相关的语句子句施加了某些限制 CREATE USER；有关详细信息，请参阅该变量的说明。AUTHENTICATION_POLICY_ADMIN 如果您有权限， 则这些限制不适用 。
- 要创建使用无密码身份验证的帐户，您必须具有 PASSWORDLESS_USER_ADMIN 权限。

        从 MySQL 8.0.22 开始，如果要创建的任何帐户被命名为任何存储对象`CREATE USER`
        的属性，则会失败并出现错误
        。`DEFINER`（也就是说，如果创建一个帐户会导致该帐户采用当前孤立的存储对象，则该语句将失败。）无论如何要执行该操作，您必须具有
        `SET_USER_ID`特权；在这种情况下，语句成功并发出警告，而不是失败并出现错误。如果没有
        `SET_USER_ID`，执行用户创建操作，删除孤立对象，创建帐户并授予其权限，然后重新创建删除的对象。有关其他信息，包括如何识别哪些对象将给定帐户命名为
        `DEFINER`属性，请参阅
        孤立存储对象。

        `CREATE USER`要么对所有命名用户成功，要么回滚，如果发生任何错误则无效。默认情况下，如果您尝试创建一个已经存在的用户，则会发生错误。如果`IF NOT EXISTS`
        给出该子句，则该语句会为每个已存在的命名用户生成警告，而不是错误。

重要的

          在某些情况下，`CREATE USER`可能会记录在服务器日志中或在客户端的历史文件中，例如
          `~/.mysql_history`，这意味着任何对该信息具有读取权限的人都可以读取明文密码。有关服务器日志发生这种情况的条件以及如何控制它的信息，请参阅第 6.1.2.3 节，“密码和日志记录”。有关客户端日志记录的类似信息，请参阅
          第 4.5.1.3 节，“mysql 客户端日志记录”。

        该声明有几个方面`CREATE USER`，在以下主题下进行了描述：

- 创建用户概述
- 创建用户身份验证选项
- 创建用户多因素身份验证选项
- 创建用户角色选项
- 创建用户 SSL/TLS 选项
- 创建用户资源限制选项
- 创建用户密码管理选项
- 创建用户评论和属性选项
- 创建用户帐户锁定选项
- 创建用户二进制日志记录

创建用户概述

          对于每个帐户，在系统表`CREATE USER`
          中创建一个新行。`mysql.user`帐户行反映了报表中指定的属性。未指定的属性设置为其默认值：

- 身份验证：默认身份验证插件（如默认身份验证插件中所述确定 ）和空凭据
- 默认角色：NONE
- SSL/TLS：NONE
- 资源限制：无限制
- 密码管理：PASSWORD EXPIRE DEFAULT PASSWORD HISTORY DEFAULT PASSWORD REUSE INTERVAL DEFAULT PASSWORD REQUIRE CURRENT DEFAULT; 登录失败跟踪和临时帐户锁定已禁用
- 账户锁定：ACCOUNT UNLOCK

          首次创建的帐户没有权限，默认角色为`NONE`. 要分配特权或角色，请使用该`GRANT`语句。

          每个帐户名都使用
          第 6.2.4 节“指定帐户名”中描述的格式。例如：

```sql
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';
```

          帐户名的主机名部分（如果省略）默认为`'%'`.

          每个*`user`*命名帐户的值后面都可以跟一个可选
          *`auth_option`*值，指示帐户如何进行身份验证。这些值允许指定帐户身份验证插件和凭据（例如，密码）。每个
          *`auth_option`*值仅适用
          *于*紧接其前的命名帐户。

          按照*`user`*规范，该语句可能包括 SSL/TLS、资源限制、密码管理和锁定属性的选项。所有这些选项对报表都是*全局*的，适用于
          报表中指定的*所有*帐户。

          示例：创建一个使用默认身份验证插件和给定密码的帐户。将密码标记为过期，以便用户必须在第一次连接到服务器时选择一个新密码：

```sql
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED BY 'new_password' PASSWORD EXPIRE;
```

`caching_sha2_password`示例：创建一个使用身份验证插件和给定密码
          的帐户
          。要求每 180 天选择一个新密码，并启用登录失败跟踪，例如连续 3 次错误密码导致帐户临时锁定两天：

```sql
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED WITH caching_sha2_password BY 'new_password'
  PASSWORD EXPIRE INTERVAL 180 DAY
  FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;
```

          示例：创建多个帐户，指定一些每个帐户的属性和一些全局属性：

```sql
CREATE USER
  'jeffrey'@'localhost' IDENTIFIED WITH mysql_native_password
                                   BY 'new_password1',
  'jeanne'@'localhost' IDENTIFIED WITH caching_sha2_password
                                  BY 'new_password2'
  REQUIRE X509 WITH MAX_QUERIES_PER_HOUR 60
  PASSWORD HISTORY 5
  ACCOUNT LOCK;
```

          每个*`auth_option`*值（`IDENTIFIED WITH ... BY`在本例中）仅适用于紧接在其之前的命名帐户，因此每个帐户都使用紧随其后的身份验证插件和密码。

          其余属性全局适用于声明中指定的所有帐户，因此对于这两个帐户：

- 必须使用有效的 X.509 证书进行连接。
- 每小时最多允许 60 个查询。
- 密码更改不能重复使用五个最近的密码中的任何一个。
- 该帐户最初是锁定的，因此实际上它是一个占位符，在管理员解锁之前无法使用。

创建用户身份验证选项

          帐户名后面可能跟有
          *`auth_option`*指定帐户身份验证插件、凭据或两者的身份验证选项。

笔记

            在 MySQL 8.0.27 之前，
            *`auth_option`*定义了帐户验证的唯一方法。也就是说，所有帐户都使用单因素/单因素身份验证 (1FA/SFA)。MySQL 8.0.27 及更高版本支持多因素身份验证 (MFA)，这样帐户最多可以有三种身份验证方法。也就是说，帐户可以使用双因素身份验证 (2FA) 或三因素身份验证 (3FA)。的语法和语义
            *`auth_option`*保持不变，但
            *`auth_option`*可能会遵循其他身份验证方法的规范。本节介绍*`auth_option`*. 有关可选的 MFA 相关后续子句的详细信息，请参阅
            CREATE USER Multifactor Authentication Options。

笔记

            随机密码生成的条款仅适用于使用在 MySQL 内部存储凭据的身份验证插件的帐户。对于使用针对 MySQL 外部的凭证系统执行身份验证的插件的帐户，密码管理也必须针对该系统在外部进行处理。有关内部凭证存储的更多信息，请参阅
            第 6.2.15 节，“密码管理”。

- auth_plugin命名身份验证插件。插件名称可以是带引号的字符串文字或不带引号的名称。插件名称存储在系统表 的plugin列中 。mysql.user 对于auth_option未指定身份验证插件的语法，服务器分配默认插件，如 默认身份验证插件中所述确定。有关每个插件的说明，请参阅 第 6.4.1 节，“身份验证插件”。
- 内部存储的凭据存储在 mysql.user系统表中。一个 值或指定帐户凭据，可以是明文（未加密）字符串，也可以是与帐户关联的身份验证插件所期望的格式的哈希值，分别为： 'auth_string'RANDOM PASSWORD 对于使用的语法，字符串是明文并传递给身份验证插件以进行可能的哈希处理。插件返回的结果存储在 表中。插件可以使用指定的值，在这种情况下不会发生散列。 BY 'auth_string'mysql.user
- 对于使用 的语法BY RANDOM PASSWORD，MySQL 会生成一个随机密码并作为明文并将其传递给身份验证插件以进行可能的哈希处理。插件返回的结果存储在 mysql.user表中。插件可以使用指定的值，在这种情况下不会发生散列。 随机生成的密码从 MySQL 8.0.18 开始可用，并具有 随机密码生成中描述的特征。
- 对于使用的语法，假定字符串已经采用身份验证插件所需的格式，并按原样存储在表中。如果插件需要散列值，则该值必须已经以适合插件的格式散列；否则，插件无法使用该值，并且不会发生客户端连接的正确身份验证。 AS 'auth_string'mysql.user 从 MySQL 8.0.17 开始，散列字符串可以是字符串文字或十六进制值。后者对应于 启用系统变量 SHOW CREATE USER时包含不可打印字符的密码哈希 显示的值类型。print_identified_with_as_hex
- 如果身份验证插件不对身份验证字符串执行散列，则和 子句具有相同的效果：身份验证字符串按原样存储在 系统表中。 BY 'auth_string'AS 'auth_string'mysql.user

          `CREATE USER`允许这些
          *`auth_option`*语法：

- IDENTIFIED BY 'auth_string' 将帐户身份验证插件设置为默认插件，将明文 值传递给插件以进行可能的哈希处理，并将结果存储在 系统表的帐户行中。 'auth_string'mysql.user
- IDENTIFIED BY RANDOM PASSWORD 将帐户认证插件设置为默认插件，生成随机密码，将明文密码值传递给插件进行可能的哈希处理，并将结果存储在 mysql.user系统表的帐户行中。该语句还在结果集中返回明文密码，以供执行该语句的用户或应用程序使用。随机生成密码的结果集和特征详见 随机密码生成。
- IDENTIFIED WITH auth_plugin 将帐户认证插件设置为 auth_plugin，将凭据清除为空字符串，并将结果存储在mysql.user 系统表的帐户行中。
- IDENTIFIED WITH auth_plugin BY 'auth_string' 将帐户身份验证插件设置为 auth_plugin，将明文 值传递给插件以进行可能的哈希处理，并将结果存储在 系统表的帐户行中。 'auth_string'mysql.user
- IDENTIFIED WITH auth_plugin BY RANDOM PASSWORD 将帐户认证插件设置为 auth_plugin，生成一个随机密码，将明文密码值传递给插件进行可能的散列，并将结果存储在mysql.user系统表的帐户行中。该语句还在结果集中返回明文密码，以供执行该语句的用户或应用程序使用。随机生成密码的结果集和特征详见 随机密码生成。
- IDENTIFIED WITH auth_plugin AS 'auth_string' 将帐户身份验证插件设置为 auth_plugin并将 值按原样存储在帐户行中。如果插件需要哈希字符串，则假定该字符串已经按照插件所需的格式进行了哈希处理。 'auth_string'mysql.user

          示例：指定密码为明文；使用默认插件：

```sql
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED BY 'password';
```

          示例：指定身份验证插件以及明文密码值：

```sql
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED WITH mysql_native_password BY 'password';
```

          在每种情况下，存储在帐户行中的密码值都是
          经过与帐户关联的身份验证插件散列后的明文值。
        `'password`'

          有关设置密码和身份验证插件的其他信息，请参阅
          第 6.2.14 节，“分配帐户密码”和
          第 6.2.17 节，“可插入身份验证”。

创建用户多因素身份验证选项

          的*`auth_option`*部分
          `CREATE USER`定义了单因素/单因素身份验证（1FA/SFA）的身份验证方法。从 MySQL 8.0.27 开始，
          `CREATE USER`有支持多因素身份验证 (MFA) 的条款，这样帐户最多可以有三种身份验证方法。也就是说，帐户可以使用双因素身份验证 (2FA) 或三因素身份验证 (3FA)。

系统变量为具有多因素身份验证 (MFA) 子句的语句
          定义`authentication_policy`
          约束
          。`CREATE USER`例如，该
          `authentication_policy`设置控制帐户可能具有的身份验证因素的数量，以及对于每个因素，允许使用哪些身份验证方法。请参阅
          配置多因素身份验证策略。

          有关为未命名插件的身份验证子句确定默认身份验证插件的特定因素规则的信息，请参阅
          默认身份验证插件。

          接下来*`auth_option`*，可能会出现不同的可选 MFA 条款：

- 2fa_auth_option：指定因子 2 身份验证方法。以下示例定义caching_sha2_password了因素 1 身份验证方法和 authentication_ldap_sasl因素 2 身份验证方法。 ```sql CREATE USER 'u1'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'sha2_password' AND IDENTIFIED WITH authentication_ldap_sasl AS 'uid=u1_ldap,ou=People,dc=example,dc=com'; ```
- 3fa_auth_option: 2fa_auth_option下面可能会出现一个3fa_auth_option子句来指定因子 3 身份验证方法。以下示例定义caching_sha2_password 了因素 1 身份验证方法、 authentication_ldap_sasl因素 2 身份验证方法和 authentication_fido因素 3 身份验证方法 ```sql CREATE USER 'u1'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'sha2_password' AND IDENTIFIED WITH authentication_ldap_sasl AS 'uid=u1_ldap,ou=People,dc=example,dc=com' AND IDENTIFIED WITH authentication_fido; ```
- initial_auth_option: 指定用于配置 FIDO 无密码身份验证的初始身份验证方法。如下所示，需要使用生成的随机密码或用户指定的临时身份验证 auth-string才能启用 FIDO 无密码身份验证。 ```sql CREATE USER user IDENTIFIED WITH authentication_fido INITIAL AUTHENTICATION IDENTIFIED BY {RANDOM PASSWORD | 'auth_string'}; ``` 有关使用 FIDO 可插入身份验证配置无密码身份验证的信息，请参阅 FIDO 无密码身份验证。

创建用户角色选项

          该`DEFAULT ROLE`子句定义当用户连接到服务器并进行身份验证时，或者当用户
          `SET ROLE DEFAULT`在会话期间执行语句时，哪些角色变为活动状态。

每个角色名称都使用第 6.2.5 节“指定角色名称”
          中描述的格式
          。例如：

```sql
CREATE USER 'joe'@'10.0.0.1' DEFAULT ROLE administrator, developer;
```

          角色名称的主机名部分（如果省略）默认为
          `'%'`.

          该`DEFAULT ROLE`子句允许列出一个或多个以逗号分隔的角色名称。这些角色在`CREATE USER`执行时必须存在；否则该语句会引发错误 ( `ER_USER_DOES_NOT_EXIST`)，并且不会创建用户。

创建用户 SSL/TLS 选项

          除了通常基于用户名和凭据的身份验证之外，MySQL 还可以检查 X.509 证书属性。有关在 MySQL 中使用 SSL/TLS 的背景信息，请参阅第 6.3 节，“使用加密连接”。

          要为 MySQL 帐户指定与 SSL/TLS 相关的选项，请使用
          `REQUIRE`指定一个或多个
          *`tls_option`*值的子句。

          选项的顺序`REQUIRE`无关紧要，但任何选项都不能指定两次。`AND`关键字在选项之间是可选
          的
          `REQUIRE`。

          `CREATE USER`允许这些
          *`tls_option`*值：

- NONE 表示该语句命名的所有帐户都没有 SSL 或 X.509 要求。如果用户名和密码有效，则允许未加密的连接。如果客户端具有适当的证书和密钥文件，则可以根据客户端的选择使用加密连接。 ```sql CREATE USER 'jeffrey'@'localhost' REQUIRE NONE; ``` 默认情况下，客户端会尝试建立安全连接。对于具有REQUIRE NONE的客户端，如果无法建立安全连接，连接尝试将退回到未加密的连接。要要求加密连接，客户端只需要指定 --ssl-mode=REQUIRED 选项；如果无法建立安全连接，则连接尝试失败。 NONE如果未指定与 SSL 相关的 REQUIRE选项，则为默认值。
- SSL 告诉服务器只允许语句指定的所有帐户的加密连接。 ```sql CREATE USER 'jeffrey'@'localhost' REQUIRE SSL; ``` 默认情况下，客户端会尝试建立安全连接。对于具有REQUIRE SSL的帐户，如果无法建立安全连接，连接尝试将失败。
- X509 对于声明命名的所有帐户，要求客户出示有效证书，但确切的证书、发行人和主题无关紧要。唯一的要求是应该可以使用其中一个 CA 证书来验证其签名。使用 X.509 证书总是意味着加密，因此 SSL在这种情况下不需要该选项。 ```sql CREATE USER 'jeffrey'@'localhost' REQUIRE X509; ``` 对于具有 的帐户REQUIRE X509，客户端必须指定--ssl-key 和--ssl-cert选项才能连接。（建议但不要求 --ssl-ca也指定，以便可以验证服务器提供的公共证书。）这也是正确的ISSUER ，SUBJECT因为这些 REQUIRE选项暗示了X509.
- ISSUER 'issuer' 对于声明命名的所有帐户，要求客户端出示由 CA 颁发的有效 X.509 证书 。如果客户端提供的证书有效但颁发者不同，则服务器会拒绝连接。使用 X.509 证书总是意味着加密，因此 在这种情况下不需要该选项。 'issuer'SSL ```sql CREATE USER 'jeffrey'@'localhost' REQUIRE ISSUER '/C=SE/ST=Stockholm/L=Stockholm/ O=MySQL/CN=CA/emailAddress=ca@example.com'; ``` 因为ISSUER隐含了 的要求X509，客户端必须指定 --ssl-key和 --ssl-cert选项才能连接。（建议但不要求 --ssl-ca也指定，以便验证服务器提供的公共证书。）
- SUBJECT 'subject' 对于语句命名的所有帐户，要求客户端出示包含 subject 的有效 X.509 证书subject。如果客户端提供的证书有效但主题不同，则服务器会拒绝连接。使用 X.509 证书总是意味着加密，因此 SSL在这种情况下不需要该选项。 ```sql CREATE USER 'jeffrey'@'localhost' REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/ O=MySQL demo client certificate/ CN=client/emailAddress=client@example.com'; ``` MySQL 对值与证书中的值进行简单的字符串比较 ，因此字母大小写和组件顺序必须与证书中的完全一致。 'subject' 因为SUBJECT隐含了 的要求X509，客户端必须指定--ssl-key和 --ssl-cert选项才能连接。（建议但不要求 --ssl-ca也指定，以便验证服务器提供的公共证书。）
- CIPHER 'cipher' 对于语句命名的所有帐户，需要特定的密码方法来加密连接。需要此选项以确保使用足够强度的密码和密钥长度。如果使用使用短加密密钥的旧算法，加密可能很弱。 ```sql CREATE USER 'jeffrey'@'localhost' REQUIRE CIPHER 'EDH-RSA-DES-CBC3-SHA'; ```

          、和
          选项可以在
          子句
        `SUBJECT`中组合：`ISSUER``CIPHER``REQUIRE`

```sql
CREATE USER 'jeffrey'@'localhost'
  REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/
    O=MySQL demo client certificate/
    CN=client/emailAddress=client@example.com'
  AND ISSUER '/C=SE/ST=Stockholm/L=Stockholm/
    O=MySQL/CN=CA/emailAddress=ca@example.com'
  AND CIPHER 'EDH-RSA-DES-CBC3-SHA';
```

创建用户资源限制选项

          可以限制帐户对服务器资源的使用，如第 6.2.21 节“设置帐户资源限制”中所述。为此，请使用`WITH`指定一个或多个*`resource_option`*值的子句。

          选项的顺序`WITH`无关紧要，除非多次指定给定的资源限制，最后一个实例优先。

          `CREATE USER`允许这些
          *`resource_option`*值：

- MAX_QUERIES_PER_HOUR count, , MAX_UPDATES_PER_HOUR countMAX_CONNECTIONS_PER_HOUR count 对于语句指定的所有帐户，这些选项限制在任何给定的一小时内每个帐户允许的服务器查询、更新和连接数。如果count是 0（默认值），这意味着该帐户没有限制。
- MAX_USER_CONNECTIONS count 对于语句命名的所有帐户，限制每个帐户同时连接到服务器的最大数量。非零 count值明确指定帐户的限制。如果 count是（默认值），服务器根据 系统变量0 的全局值确定帐户的同时连接数 。max_user_connections如果 max_user_connections也是零，则帐户没有限制。

          例子：

```sql
CREATE USER 'jeffrey'@'localhost'
  WITH MAX_QUERIES_PER_HOUR 500 MAX_UPDATES_PER_HOUR 100;
```

创建用户密码管理选项

          `CREATE USER`支持
          *`password_option`*密码管理的多个值：

- 密码过期选项：您可以手动使帐户密码过期并建立其密码过期策略。策略选项不会使密码过期。相反，他们确定服务器如何根据密码使用期限对帐户应用自动过期，密码使用期限是从最近一次帐户密码更改的日期和时间开始评估的。
- 密码重用选项：您可以根据密码更改次数、经过的时间或两者来限制密码重用。
- 需要密码验证的选项：您可以指示更改帐户密码的尝试是否必须指定当前密码，以验证尝试进行更改的用户实际上知道当前密码。
- 密码错误登录失败跟踪选项：您可以使服务器跟踪失败的登录尝试，并临时锁定连续输入错误密码过多的帐户。所需的故障次数和锁定时间是可配置的。

          本节介绍密码管理选项的语法。有关建立密码管理策略的信息，请参阅
          第 6.2.15 节，“密码管理”。

          如果指定了多个给定类型的密码管理选项，则最后一个优先。例如，
          `PASSWORD EXPIRE DEFAULT PASSWORD EXPIRE NEVER`与 相同`PASSWORD EXPIRE NEVER`。

笔记

            除了与失败登录跟踪相关的选项外，密码管理选项仅适用于使用身份验证插件的帐户，该插件在 MySQL 内部存储凭据。对于使用针对 MySQL 外部的凭证系统执行身份验证的插件的帐户，密码管理也必须针对该系统在外部进行处理。有关内部凭证存储的更多信息，请参阅
            第 6.2.15 节，“密码管理”。

          如果帐户密码已手动过期，或者根据自动过期策略，密码期限被认为大于其允许的生命周期，则客户端的密码已过期。在这种情况下，服务器要么断开客户端，要么限制允许的操作（请参阅
          第 6.2.16 节，“服务器处理过期密码”）。在用户建立新帐户密码之前，受限客户端执行的操作会导致错误。

          `CREATE USER`允许使用这些
          *`password_option`*值来控制密码过期：

- PASSWORD EXPIRE 立即将语句指定的所有帐户的密码标记为过期。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE; ```
- PASSWORD EXPIRE DEFAULT 设置语句命名的所有帐户，以便应用全局过期策略，如 default_password_lifetime 系统变量所指定。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE DEFAULT; ```
- PASSWORD EXPIRE NEVER 此过期选项会覆盖该语句指定的所有帐户的全局策略。对于每个，它都禁用密码过期，以便密码永不过期。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE NEVER; ```
- PASSWORD EXPIRE INTERVAL N DAY 此过期选项会覆盖该语句指定的所有帐户的全局策略。对于每一个，它都将密码有效期设置为N几天。以下语句要求每 180 天更改一次密码： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE INTERVAL 180 DAY; ```

          `CREATE USER`允许这些
          *`password_option`*值根据所需的最小密码更改次数来控制以前密码的重用：

- PASSWORD HISTORY DEFAULT 设置语句命名的所有帐户，以便应用关于密码历史长度的全局策略，以禁止在 password_history系统变量指定的更改次数之前重复使用密码。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD HISTORY DEFAULT; ```
- PASSWORD HISTORY N 此历史长度选项覆盖语句命名的所有帐户的全局策略。对于每一个，它将密码历史长度设置为N passwords，以禁止重复使用任何 N最近选择的密码。以下声明禁止重复使用前面 6 个密码中的任何一个： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD HISTORY 6; ```

          `CREATE USER`允许这些
          *`password_option`*值用于根据经过的时间控制以前密码的重用：

- PASSWORD REUSE INTERVAL DEFAULT 设置帐户命名的所有语句，以便应用关于经过时间的全局策略，以禁止重用比 password_reuse_interval 系统变量指定的天数新的密码。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REUSE INTERVAL DEFAULT; ```
- PASSWORD REUSE INTERVAL N DAY 这个经过时间的选项覆盖了语句命名的所有帐户的全局策略。对于每一个，它将密码重用间隔设置为N 天数，以禁止重用比该天数更新的密码。以下声明禁止密码重复使用 360 天： ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REUSE INTERVAL 360 DAY; ```

          `CREATE USER`允许使用这些
          *`password_option`*值来控制更改帐户密码的尝试是否必须指定当前密码，以验证尝试进行更改的用户实际上知道当前密码：

- PASSWORD REQUIRE CURRENT 此验证选项覆盖声明中指定的所有帐户的全局策略。对于每一个，它都要求密码更改指定当前密码。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT; ```
- PASSWORD REQUIRE CURRENT OPTIONAL 此验证选项覆盖声明中指定的所有帐户的全局策略。对于每个，它不需要密码更改指定当前密码。（可以但不必提供当前密码。） ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT OPTIONAL; ```
- PASSWORD REQUIRE CURRENT DEFAULT 设置帐户命名的所有语句，以便应用有关密码验证的全局策略，如 password_require_current 系统变量所指定。 ```sql CREATE USER 'jeffrey'@'localhost' PASSWORD REQUIRE CURRENT DEFAULT; ```

          从 MySQL 8.0.19 开始，`CREATE USER`
          允许使用这些*`password_option`*
          值来控制失败登录跟踪：

- FAILED_LOGIN_ATTEMPTS N 是否跟踪指定错误密码的帐户登录尝试。N必须是 0 到 32767 之间的数字。值为 0 将禁用登录失败跟踪。大于 0 的值表示有多少次连续密码失败导致临时帐户锁定（如果PASSWORD_LOCK_TIME也是非零）。
- PASSWORD_LOCK_TIME {N | UNBOUNDED} 在多次连续登录尝试提供不正确的密码后锁定帐户多长时间。 N必须是 0 到 32767 之间的数字，或者UNBOUNDED. 值为 0 禁用临时帐户锁定。大于 0 的值表示锁定帐户的天数。的值 UNBOUNDED导致帐户锁定持续时间不受限制；锁定后，帐户将保持锁定状态，直到解锁。有关发生解锁的条件的信息，请参阅 失败登录跟踪和临时帐户锁定。

          要进行登录失败跟踪和临时锁定，帐户`FAILED_LOGIN_ATTEMPTS`和
          `PASSWORD_LOCK_TIME`选项都必须非零。以下语句创建一个帐户，该帐户在连续四次密码失败后保持锁定状态两天：

```sql
CREATE USER 'jeffrey'@'localhost'
  FAILED_LOGIN_ATTEMPTS 4 PASSWORD_LOCK_TIME 2;
```

创建用户评论和属性选项

          从 MySQL 8.0.21 开始，您可以创建一个带有可选注释或属性的帐户，如下所述：

- 用户评论 要设置用户评论，请添加到 语句中， 用户评论的文本在哪里。 COMMENT 'user_comment'CREATE USERuser_comment 示例（省略任何其他选项）： ```sql CREATE USER 'jon'@'localhost' COMMENT 'Some information about Jon'; ```
- 用户属性 用户属性是由一个或多个键值对组成的 JSON 对象，并通过 作为. 必须是有效的 JSON 对象。 ATTRIBUTE 'json_object'CREATE USERjson_object 示例（省略任何其他选项）： ```sql CREATE USER 'jim'@'localhost' ATTRIBUTE '{"fname": "James", "lname": "Scott", "phone": "123-456-7890"}'; ```

          用户评论和用户属性一起存储在表的
          `ATTRIBUTE`列中
          `INFORMATION_SCHEMA.USER_ATTRIBUTES`
          。此查询显示此表中由刚才显示的用于创建用户的语句插入的行
          `jim@localhost`：

```sql
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
    ->    WHERE USER = 'jim' AND HOST = 'localhost'\G
*************************** 1. row ***************************
     USER: jim
     HOST: localhost
ATTRIBUTE: {"fname": "James", "lname": "Scott", "phone": "123-456-7890"}
1 row in set (0.00 sec)
```

`COMMENT`实际上，

          该选项提供了一种设置用户属性的快捷方式，该属性的唯一元素`comment`作为其键，其值是为该选项提供的参数。您可以通过执行语句`CREATE USER 'jon'@'localhost' COMMENT 'Some information about Jon'`并观察它插入到
          `USER_ATTRIBUTES`表中的行来看到这一点：

```sql
mysql> CREATE USER 'jon'@'localhost' COMMENT 'Some information about Jon';
Query OK, 0 rows affected (0.06 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
    ->    WHERE USER = 'jon' AND HOST = 'localhost';
+------+-----------+-------------------------------------------+
| USER | HOST      | ATTRIBUTE                                 |
+------+-----------+-------------------------------------------+
| jon  | localhost | {"comment": "Some information about Jon"} |
+------+-----------+-------------------------------------------+
1 row in set (0.00 sec)
```

          您不能在同一
          语句中同时使用`COMMENT`和
          ；尝试这样做会导致语法错误。要在设置用户属性的同时设置用户评论，请在其参数中使用并包含一个带
          键的值，如下所示：
        `ATTRIBUTE``CREATE USER``ATTRIBUTE``comment`

```sql
mysql> CREATE USER 'bill'@'localhost'
    ->        ATTRIBUTE '{"fname":"William", "lname":"Schmidt",
    ->        "comment":"Website developer"}';
Query OK, 0 rows affected (0.16 sec)
```

          由于`ATTRIBUTE`行的内容是一个 JSON 对象，您可以使用任何适当的 MySQL JSON 函数或运算符来操作它，如下所示：

```sql
mysql> SELECT
    ->   USER AS User,
    ->   HOST AS Host,
    ->   CONCAT(ATTRIBUTE->>"$.fname"," ",ATTRIBUTE->>"$.lname") AS 'Full Name',
    ->   ATTRIBUTE->>"$.comment" AS Comment
    -> FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
    -> WHERE USER='bill' AND HOST='localhost';
+------+-----------+-----------------+-------------------+
| User | Host      | Full Name       | Comment           |
+------+-----------+-----------------+-------------------+
| bill | localhost | William Schmidt | Website developer |
+------+-----------+-----------------+-------------------+
1 row in set (0.00 sec)
```

          要设置或更改现有用户的用户评论或用户属性，您可以使用

          带有
          语句
        的`COMMENT`or选项。`ATTRIBUTE``ALTER USER`

          因为用户评论和用户属性在内部一起存储在单个
          `JSON`列中，所以这为它们的最大组合大小设置了上限；有关详细信息，请参阅
          JSON 存储要求。

          有关更多信息和示例，另请参阅信息模式
          `USER_ATTRIBUTES`表的描述。

创建用户帐户锁定选项

          MySQL 支持使用
          `ACCOUNT LOCK`和`ACCOUNT UNLOCK`选项来锁定和解锁帐户，这些选项指定帐户的锁定状态。有关其他讨论，请参阅
          第 6.2.20 节，“帐户锁定”。

          如果指定了多个帐户锁定选项，则最后一个优先。

创建用户二进制日志记录

          `CREATE USER`如果成功则写入二进制日志，但如果失败则不写入；在这种情况下，将发生回滚并且不进行任何更改。写入二进制日志的语句包括所有命名用户。如果`IF NOT EXISTS`给出了子句，这甚至包括已经存在但未创建的用户。

          写入二进制日志的语句为每个用户指定了一个认证插件，确定如下：

- 原始语句中命名的插件（如果已指定）。
- 否则，默认身份验证插件。特别是，如果用户u1已经存在并使用非默认身份验证插件，则写入二进制日志的语句将CREATE USER IF NOT EXISTS u1命名为默认身份验证插件。（如果写入二进制日志的语句必须为用户指定一个非默认的身份验证插件，请将其包含在原始语句中。）

          如果服务器在写入二进制日志的语句中为任何不存在的用户添加了默认身份验证插件，它会向错误日志写入一条警告，指出这些用户。

          如果原始语句指定了
          `FAILED_LOGIN_ATTEMPTS`or
          `PASSWORD_LOCK_TIME`选项，则写入二进制日志的语句将包含该选项。

          `CREATE USER`带有支持多因素身份验证 (MFA) 子句的语句将写入二进制日志。

- CREATE USER ... IDENTIFIED WITH .. INITIAL AUTHENTICATION IDENTIFIED WITH ...语句被写入二进制日志，其中是用户指定的或指定子句 时服务器生成的随机密码 。CREATE USER .. IDENTIFIED WITH .. INITIAL AUTHENTICATION IDENTIFIED WITH .. AS 'password-hash'password-hashauth-stringRANDOM PASSWORD

---

[← 返回 第 5 章 MySQL 服务器管理 索引](00-index.md) · [← 返回总索引](../00-index.md)
