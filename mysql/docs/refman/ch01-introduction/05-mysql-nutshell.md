# 第 1 章 一般信息 · 1.3 MySQL 8.0 的新特性

> 对应 SQL：[`sql/refman/ch01-introduction/05-mysql-nutshell.sql`](../../../sql/refman/ch01-introduction/05-mysql-nutshell.sql)

---

## 1.3 MySQL 8.0 的新特性

      本节总结了 MySQL 8.0 中添加、弃用和删除的内容。配套部分列出了在 MySQL 8.0 中添加、弃用或删除的 MySQL 服务器选项和变量；请参阅
      第 1.4 节，“MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项”。

- MySQL 8.0 新增功能
- MySQL 8.0 中弃用的功能
- MySQL 8.0 中删除的功能

### MySQL 8.0 新增功能

        MySQL 8.0 新增了以下特性：

- 数据字典。 MySQL 现在合并了一个事务数据字典，用于存储有关数据库对象的信息。在以前的 MySQL 版本中，字典数据存储在元数据文件和非事务表中。有关详细信息，请参阅第 14 章，MySQL 数据字典。
- 原子数据定义语句（Atomic DDL）。 原子 DDL 语句将与 DDL 操作关联的数据字典更新、存储引擎操作和二进制日志写入组合到单个原子事务中。有关详细信息，请参阅 第 13.1.1 节，“原子数据定义语句支持”。
- 升级程序。 以前，安装新版本的MySQL后，MySQL服务器会在下次启动时自动升级数据字典表，之后需要DBA手动调用mysql_upgrade 来升级 mysqlschema中的系统表，以及其他中的对象模式，例如sys模式和用户模式。 从 MySQL 8.0.16 开始，服务器执行以前由mysql_upgrade处理的任务。安装新的 MySQL 版本后，服务器现在会在下次启动时自动执行所有必要的升级任务，而不依赖于 DBA 调用 mysql_upgrade。此外，服务器更新帮助表的内容（ mysql_upgrade没有做的事情）。一个新的 --upgrade服务器选项可以控制服务器如何执行自动数据字典和服务器升级操作。有关更多信息，请参阅 第 2.11.3 节，“MySQL 升级过程升级了什么”.
- 会话重用。 MySQL 服务器现在默认支持 SSL 会话重用，并通过超时设置来控制服务器维护会话缓存的时间，该会话缓存建立允许客户端请求新连接的会话重用的时间段。所有 MySQL 客户端程序都支持会话重用。有关服务器端和客户端配置信息，请参阅 第 6.3.5 节，“重用 SSL 会话”。 此外，C 应用程序现在可以使用 C API 功能为加密连接启用会话重用（请参阅SSL 会话重用）。
- 安全和帐户管理。 添加这些增强功能是为了提高安全性并使 DBA 在帐户管理方面具有更大的灵活性： mysql系统数据库中 的授权表现在是InnoDB （事务性）表。以前，这些是 MyISAM（非事务性）表。授权表存储引擎的变化是伴随账户管理报表行为变化的基础。以前，帐户管理声明（例如 CREATE USER或 DROP USER) 命名多个用户可能对某些用户成功而对其他用户失败。现在，每个语句都是事务性的，并且要么对所有指定用户成功，要么回滚，如果发生任何错误则无效。语句成功则写入二进制日志，失败则不写入；在这种情况下，将发生回滚并且不进行任何更改。有关详细信息，请参阅第 13.1.1 节，“原子数据定义语句支持”。
- 一个新的caching_sha2_password 身份验证插件可用。与 sha256_password插件一样， caching_sha2_password实现 SHA-256 密码哈希，但使用缓存来解决连接时的延迟问题。它还支持更多的传输协议，并且不需要针对基于 RSA 密钥对的密码交换功能的 OpenSSL 进行链接。请参阅 第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。 和caching_sha2_password身份 sha256_password验证插件提供比插件更安全的密码加密 mysql_native_password，并 caching_sha2_password提供比sha256_password. 由于这些卓越的安全性和性能特征 caching_sha2_password，它现在是首选的身份验证插件，也是默认的身份验证插件，而不是 mysql_native_password. 有关此更改对服务器操作的默认插件的影响以及服务器与客户端和连接器的兼容性的信息，请参阅 caching_sha2_password 作为首选身份验证插件。
- MySQL 企业版 SASL LDAP 身份验证插件现在支持 GSSAPI/Kerberos 作为 Linux 上 MySQL 客户端和服务器的身份验证方法。这在应用程序使用默认启用 Kerberos 的 Microsoft Active Directory 访问 LDAP 的 Linux 环境中很有用。请参阅 LDAP 身份验证方法。
- MySQL Enterprise Edition 现在支持一种身份验证方法，使用户能够使用 Kerberos 向 MySQL Server 进行身份验证，前提是提供或可以获得适当的 Kerberos 票证。有关详细信息，请参阅 第 6.4.1.8 节，“Kerberos 可插入身份验证”。
- MySQL 现在支持角色，即命名的权限集合。可以创建和删除角色。角色可以拥有授予和撤销的特权。可以向用户帐户授予和撤销角色。可以从授予该帐户的角色中选择帐户的活动适用角色，并且可以在该帐户的会话期间更改。有关详细信息，请参阅第 6.2.10 节，“使用角色”。
- MySQL现在加入了用户账户类别的概念，系统用户和普通用户根据他们是否有 SYSTEM_USER权限来区分。请参阅第 6.2.11 节，“帐户类别”。
- 以前，不可能授予全局应用的特权，但某些模式除外。partial_revokes如果启用了系统变量，这现在是可能的 。请参阅 第 6.2.12 节，“使用部分撤销的权限限制”。
- 该GRANT语句有一个子句指定有关用于语句执行的特权上下文的附加信息。这种语法在 SQL 级别是可见的，尽管它的主要目的是通过使这些限制出现在二进制日志中来在所有节点上实现由部分撤销施加的授予者权限限制的统一复制。请参阅 第 13.7.1.6 节，“GRANT 语句”。 AS user [WITH ROLE]
- MySQL 现在维护有关密码历史的信息，从而限制重复使用以前的密码。DBA 可以要求在某些密码更改次数或一段时间内不从以前的密码中选择新密码。可以在全局以及每个帐户的基础上建立密码重用策略。 现在可以要求通过指定要替换的当前密码来验证更改帐户密码的尝试。这使 DBA 能够防止用户在不证明他们知道当前密码的情况下更改密码。可以在全局以及每个帐户的基础上建立密码验证策略。 现在允许帐户使用双密码，这使得可以在复杂的多服务器系统中无缝地执行分阶段密码更改，而无需停机。 MySQL 现在允许管理员配置用户帐户，这样由于密码不正确导致的连续登录失败过多会导致临时帐户锁定。每个帐户所需的失败次数和锁定时间是可配置的。 这些新功能使 DBA 可以更全面地控制密码管理。有关详细信息，请参阅第 6.2.15 节，“密码管理”。
- 如果使用 OpenSSL 编译，MySQL 现在支持 FIPS 模式，并且 OpenSSL 库和 FIPS 对象模块在运行时可用。FIPS 模式对加密操作施加条件，例如对可接受的加密算法的限制或对更长密钥长度的要求。请参见第 6.8 节 “FIPS 支持”。
- 服务器用于新连接的 TLS 上下文现在可以在运行时重新配置。此功能可能很有用，例如，可以避免重新启动运行时间过长以致其 SSL 证书已过期的 MySQL 服务器。请参阅 服务器端运行时配置和监控加密连接。
- OpenSSL 1.1.1 支持用于加密连接的 TLS v1.3 协议，如果服务器和客户端都使用 OpenSSL 1.1.1 或更高版本编译，则 MySQL 8.0.16 及更高版本也支持 TLS v1.3。请参阅 第 6.3.2 节，“加密连接 TLS 协议和密码”。
- MySQL 现在将命名管道上授予客户端的访问控制设置为在 Windows 上成功通信所需的最低限度。较新的 MySQL 客户端软件无需任何额外配置即可打开命名管道连接。如果不能立即升级旧的客户端软件，可以 named_pipe_full_access_group 使用新的系统变量为 Windows 组提供打开命名管道连接所需的权限。完全访问组的成员资格应该是受限制的和临时的。
- 以前，MySQL 用户帐户使用单一身份验证方法向服务器进行身份验证。从 MySQL 8.0.27 开始，MySQL 支持多因素身份验证 (MFA)，这使得创建最多具有三种身份验证方法的帐户成为可能。MFA 支持需要进行以下更改： CREATE USERALTER USER语法已扩展为允许指定多种身份验证方法 。
- 系统 authentication_policy 变量允许通过控制可以使用的因素数量以及每个因素允许的身份验证类型来建立 MFA 策略。CREATE USER这对如何使用和 ALTER USER语句 的认证相关子句施加了限制 。
- 客户端程序具有用于指定多个密码的新 --password1的 --password2、 和 --password3 命令行选项。对于使用 C API 的应用程序，C API 函数的新MYSQL_OPT_USER_PASSWORD选项 mysql_options4()可实现相同的功能。

                此外，MySQL Enterprise Edition 现在支持使用智能卡、安全密钥和生物识别读取器等设备对 MySQL Server 进行身份验证。这种身份验证方法基于快速身份在线（FIDO）标准，并使用一对插件，
                `authentication_fido`在服务器端和`authentication_fido_client`
                在客户端。服务器端 FIDO 身份验证插件仅包含在 MySQL 企业版发行版中。它不包含在 MySQL 社区发行版中。但是，客户端插件包含在所有发行版中，包括社区发行版。这使来自任何发行版的客户端都可以连接到加载了服务器端插件的服务器。

                多因素身份验证可以使用现有的 MySQL 身份验证方法、新的 FIDO 身份验证方法或两者的组合。有关详细信息，请参阅第 6.2.18 节，“多因素身份验证”和
                第 6.4.1.11 节，“FIDO 可插入身份验证”。

- 资源管理。 MySQL 现在支持资源组的创建和管理，并允许将服务器中运行的线程分配给特定的组，以便线程根据组可用的资源执行。组属性可以控制其资源，以启用或限制组中线程的资源消耗。DBA 可以根据不同的工作负载修改这些属性。目前，CPU时间是一种可管理的资源，以“虚拟CPU ”的概念为代表作为一个术语，包括 CPU 核心、超线程、硬件线程等。服务器在启动时确定有多少虚拟 CPU 可用，具有适当权限的数据库管理员可以将这些 CPU 与资源组相关联并将线程分配给组。有关详细信息，请参阅 第 5.1.16 节，“资源组”。
- 表加密管理。 现在可以通过定义和强制执行加密默认值来全局管理表加密。该 default_table_encryption 变量为新创建的模式和通用表空间定义加密默认值。模式的加密默认值也可以DEFAULT ENCRYPTION在创建模式时使用子句定义。默认情况下，表会继承创建它的架构或通用表空间的加密。加密默认值是通过启用 table_encryption_privilege_check 多变的。当使用不同于设置的加密设置创建或更改模式或通用表空间 default_table_encryption 时，或者使用不同于默认模式加密的加密设置创建或更改表时，将进行权限检查。该 TABLE_ENCRYPTION_ADMIN 权限允许在启用时覆盖默认加密设置 table_encryption_privilege_check 。有关详细信息，请参阅 为模式和通用表空间定义加密默认值。
- InnoDB 增强功能。 添加了这些InnoDB增强功能： 每次值更改时，当前最大自动增量计数器值都会写入重做日志，并保存到每个检查点上的引擎私有系统表中。这些更改使当前最大自动递增计数器值在服务器重新启动后保持不变。此外： 服务器重新启动不再取消 AUTO_INCREMENT = N表选项的影响。如果将自动递增计数器初始化为特定值，或者如果将自动递增计数器值更改为更大的值，则新值将在服务器重新启动后保留。
- 服务器在操作后立即重新启动 ROLLBACK 不再导致重用分配给回​​滚事务的自动增量值。
- 如果您将AUTO_INCREMENT 列值修改为大于当前最大自动增量值的值（ UPDATE例如，在操作中），则新值将被持久化，并且后续 INSERT操作会从新的较大值开始分配自动增量值。

                有关详细信息，请参阅
                第 15.6.1.6 节，“InnoDB 中的 AUTO_INCREMENT 处理”和
                InnoDB AUTO_INCREMENT 计数器初始化。

- 当遇到索引树损坏时， InnoDB将损坏标志写入重做日志，这使得损坏标志崩溃安全。InnoDB还将内存中的损坏标志数据写入每个检查点上的引擎专用系统表。在恢复期间， InnoDB在将内存表和索引对象标记为损坏之前，从两个位置读取损坏标志并合并结果。
- InnoDB memcached插件支持多种 操作（ 在单个memcachedget查询中获取多个键值对 ）和范围查询。请参阅 第 15.20.4 节，“InnoDB memcached 多获取和范围查询支持”。
- 一个新的动态变量， innodb_deadlock_detect可用于禁用死锁检测。在高并发系统上，当大量线程等待同一个锁时，死锁检测会导致速度减慢。innodb_lock_wait_timeout 有时，禁用死锁检测并依赖发生死锁时事务回滚 的设置可能更有效 。
- 新 表报告缓存在每个索引的缓冲池中 INFORMATION_SCHEMA.INNODB_CACHED_INDEXES 的索引页数 。InnoDB
- InnoDB现在在共享临时表空间中创建了临时表， ibtmp1.
- 表InnoDB 空间加密功能支持对重做日志和撤消日志数据进行加密。请参阅 重做日志加密和 撤消日志加密。
- InnoDB支持 NOWAIT和SKIP LOCKED选项SELECT ... FOR SHARE以及SELECT ... FOR UPDATE锁定读取语句。 NOWAIT如果请求的行被另一个事务锁定，则语句立即返回。SKIP LOCKED从结果集中删除锁定的行。请参阅 使用 NOWAIT 和 SKIP LOCKED 锁定读取并发。 SELECT ... FOR SHARE替换 SELECT ... LOCK IN SHARE MODE，但 LOCK IN SHARE MODE仍可用于向后兼容。这些陈述是等价的。但是，FOR UPDATE支持 FOR SHARE、 NOWAIT和SKIP LOCKED选项。请参阅第 13.2.10 节，“SELECT 语句”。 OF tbl_name OF tbl_name将锁定查询应用于命名表。
- ADD PARTITION、DROP PARTITION、COALESCE PARTITION、REORGANIZE PARTITION和REBUILD PARTITION ALTER TABLE选项由原生分区就地 API 支持，并且可以与 ALGORITHM={COPY|INPLACE}和 LOCK子句一起使用。 DROP PARTITIONwith ALGORITHM=INPLACE删除存储在分区中的数据并删除分区。但是， DROP PARTITION使用 ALGORITHM=COPY或 old_alter_table=ON 重建分区表并尝试将数据从删除的分区移动到具有兼容PARTITION ... VALUES 定义的另一个分区。无法移动到另一个分区的数据将被删除。
- 存储引擎现在InnoDB使用 MySQL 数据字典，而不是它自己的特定于存储引擎的数据字典。有关数据字典的信息，请参阅 第 14 章，MySQL 数据字典。
- mysql系统表和数据字典表现在在 MySQL 数据目录中InnoDB命名 的单个表空间文件中创建 。mysql.ibd以前，这些表是在数据库目录 中的各个InnoDB表空间文件中创建的。mysql
- MySQL 8.0 中引入了以下撤消表空间更改： 默认情况下，撤消日志现在驻留在两个撤消表空间中，这两个表空间是在初始化 MySQL 实例时创建的。撤消日志不再在系统表空间中创建。
- 从 MySQL 8.0.14 开始，可以在运行时使用 CREATE UNDO TABLESPACE语法在选定位置创建额外的撤消表空间。 ```sql CREATE UNDO TABLESPACE tablespace_name ADD DATAFILE 'file_name.ibu'; ``` 使用语法创建的撤消表空间 CREATE UNDO TABLESPACE可以在运行时使用 DROP UNDO TABLESPACE语法删除。 ```sql DROP UNDO TABLESPACE tablespace_name; ``` ALTER UNDO TABLESPACE语法可用于将撤消表空间标记为活动或非活动。 ```sql ALTER UNDO TABLESPACE tablespace_name SET {ACTIVE|INACTIVE}; ``` 显示表空间状态的STATE列已添加到 INFORMATION_SCHEMA.INNODB_TABLESPACES 表中。撤消表空间必须处于 empty可以删除之前的状态。
- 默认情况下启用该 innodb_undo_log_truncate 变量。
- 该 innodb_rollback_segments 变量定义每个撤消表空间的回滚段数。以前， innodb_rollback_segments 指定 MySQL 实例的回滚段总数。此更改增加了可用于并发事务的回滚段数。更多的回滚段增加了并发事务为撤消日志使用单独的回滚段的可能性，从而减少了资源争用。

- 影响缓冲池预冲洗和冲洗行为的变量的默认值已修改： innodb_max_dirty_pages_pct_lwm 默认值现在是 10。以前的默认值 0 禁用缓冲池预刷新 。 当缓冲池中的脏页百分比超过 10% 时，值为 10 将启用预刷新。启用预冲洗可提高性能一致性。
- innodb_max_dirty_pages_pct 默认值已从 75 增加到 90。 尝试从缓冲池中刷新数据以 使 InnoDB脏页的百分比不超过此值。增加的默认值允许缓冲池中有更大百分比的脏页。

- 现在默认 innodb_autoinc_lock_mode 设置为 2（交错）。交错锁模式允许并行执行多行插入，从而提高并发性和可扩展性。新的 innodb_autoinc_lock_mode 默认设置反映了从基于语句的复制到基于行的复制的变化，作为 MySQL 5.7 中的默认复制类型。Statement-based replication需要连续自增锁模式（之前的默认）来保证给定的SQL语句序列自增值按照可预测和可重复的顺序赋值，而row-based replication对SQL语句的执行顺序。有关更多信息，请参阅 InnoDB AUTO_INCREMENT 锁定模式。 对于使用基于语句的复制的系统，新的 innodb_autoinc_lock_mode 默认设置可能会破坏依赖于顺序自动增量值的应用程序。要恢复以前的默认值，请设置 innodb_autoinc_lock_mode 为 1。
- ALTER TABLESPACE ... RENAME TO语法 支持重命名通用表空间 。
- 默认情况下禁用的新 innodb_dedicated_server 变量可用于InnoDB根据服务器上检测到的内存量自动配置以下选项： innodb_buffer_pool_size
- innodb_log_file_size
- innodb_flush_method

                此选项适用于在专用服务器上运行的 MySQL 服务器实例。有关详细信息，请参阅
                第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。

- 新 INFORMATION_SCHEMA.INNODB_TABLESPACES_BRIEF 视图提供表空间的空间、名称、路径、标志和空间类型数据InnoDB。
- 与 MySQL 捆绑的zlib 库版本从 1.2.3 版本提升到 1.2.11 版本。MySQL 在 zlib 库的帮助下实现压缩。 如果您使用InnoDB压缩表，请参阅第 2.11.4 节，“MySQL 8.0 中的更改”以了解相关的升级影响。
- 序列化字典信息 (SDI) 存在于InnoDB除全局临时表空间和撤消表空间文件之外的所有表空间文件中。SDI 是表和表空间对象的序列化元数据。SDI 数据的存在提供了元数据冗余。例如，如果数据字典变得不可用，则可以从表空间文件中提取字典对象元数据。SDI 提取是使用ibd2sdi工具执行的。SDI 数据以JSON格式存储。 在表空间文件中包含 SDI 数据会增加表空间文件的大小。SDI 记录需要单个索引页，默认情况下大小为 16KB。但是，SDI 数据在存储时会进行压缩以减少存储占用空间。
- 存储引擎现在InnoDB支持原子 DDL，这确保 DDL 操作完全提交或回滚，即使服务器在操作期间停止也是如此。有关详细信息，请参阅第 13.1.1 节，“原子数据定义语句支持”。
- innodb_directories 使用该选项可以 在服务器离线时将表空间文件移动或恢复到新位置 。有关详细信息，请参阅 第 15.6.3.6 节，“在服务器离线时移动表空间文件”。
- 实施了以下重做日志记录优化： 用户线程现在可以在不同步写入的情况下并发写入日志缓冲区。
- 用户线程现在可以以宽松的顺序将脏页添加到刷新列表。
- 一个专用的日志线程现在负责将日志缓冲区写入系统缓冲区，将系统缓冲区刷新到磁盘，通知用户线程有关已写入和刷新的重做，维护宽松刷新列表顺序所需的滞后，以及写入检查点。
- 添加了系统变量，用于配置等待刷新重做的用户线程使用自旋延迟： innodb_log_wait_for_flush_spin_hwm：定义最大平均日志刷新时间，超过该时间用户线程在等待刷新重做时不再旋转。
- innodb_log_spin_cpu_abs_lwm：定义最小 CPU 使用量，低于此值用户线程在等待刷新重做时不再旋转。
- innodb_log_spin_cpu_pct_hwm：定义最大 CPU 使用率，超过该值用户线程在等待刷新重做时不再自旋。

- 该 innodb_log_buffer_size 变量现在是动态的，允许在服务器运行时调整日志缓冲区的大小。

                有关更多信息，请参阅
                第 8.5.4 节，“优化 InnoDB 重做日志记录”。

- 从 MySQL 8.0.12 开始，支持对大对象 (LOB) 数据的小更新进行撤消日志记录，这提高了大小为 100 字节或更小的 LOB 更新的性能。以前，LOB 更新的大小至少为一个 LOB 页面，这对于可能只修改几个字节的更新来说不是最佳选择。此增强功能基于 MySQL 8.0.4 中添加的对 LOB 数据的部分更新的支持。
- 从 MySQL 8.0.12 开始，ALGORITHM=INSTANT 支持以下 ALTER TABLE操作： 添加一列。此功能也称为 “即时ADD COLUMN”。限制适用。请参阅 第 15.12.1 节，“在线 DDL 操作”。
- 添加或删除虚拟列。
- 添加或删除列默认值。
- 修改 ENUMor SET列的定义。
- 更改索引类型。
- 重命名表。

                只支持
                `ALGORITHM=INSTANT`修改数据字典中元数据的操作。表上没有元数据锁，表数据不受影响，使操作即时进行。如果未明确指定，`ALGORITHM=INSTANT`则默认由支持它的操作使用。如果
                `ALGORITHM=INSTANT`指定但不受支持，则操作会立即失败并出现错误。

                有关支持的操作的更多信息
                `ALGORITHM=INSTANT`，请参阅
                第 15.12.1 节，“在线 DDL 操作”。

- 从 MySQL 8.0.13 开始，TempTable 存储引擎支持二进制大对象 (BLOB) 类型列的存储。此增强功能提高了使用包含 BLOB 数据的临时表的查询的性能。以前，包含 BLOB 数据的临时表存储在由 internal_tmp_disk_storage_engine. 有关详细信息，请参阅 第 8.4.4 节，“MySQL 中的内部临时表使用”。
- 从 MySQL 8.0.13 开始，静态InnoDB 数据加密功能支持通用表空间。以前，只能加密 file-per-table 表空间。为了支持通用表空间的加密，CREATE TABLESPACE语法ALTER TABLESPACE被扩展为包含一个 ENCRYPTION子句。 该 表现在INFORMATION_SCHEMA.INNODB_TABLESPACES 包含一个ENCRYPTION 列，指示表空间是否已加密。 添加了stage/innodb/alter tablespace (encryption)Performance Schema 阶段工具以允许监视一般表空间加密操作。
- 禁用该 变量通过排除缓冲池页面innodb_buffer_pool_in_core_file 来减小核心文件的大小 。InnoDB要使用此变量，core_file 必须启用该变量并且操作系统必须支持对 的MADV_DONTDUMP非 POSIX 扩展madvise()，Linux 3.4 及更高版本支持该扩展。有关详细信息，请参阅第 15.8.3.7 节，“从核心文件中排除缓冲池页面”。
- 从 MySQL 8.0.13 开始，用户创建的临时表和优化器创建的内部临时表存储在会话临时表空间中，这些临时表空间从临时表空间池中分配给会话。当会话断开连接时，其临时表空间将被截断并释放回池中。在以前的版本中，临时表是在全局临时表空间 ( ibtmp1) 中创建的，临时表被删除后不会将磁盘空间返回给操作系统。 该 innodb_temp_tablespaces_dir 变量定义创建会话临时表空间的位置。默认位置是 #innodb_temp数据目录中的目录。 该 INNODB_SESSION_TEMP_TABLESPACES 表提供有关会话临时表空间的元数据。 全局临时表空间 ( ibtmp1) 现在存储回滚段，用于对用户创建的临时表所做的更改。
- 从 MySQL 8.0.14 开始，InnoDB支持并行聚集索引读取，可以提高 CHECK TABLE性能。此功能不适用于二级索引扫描。innodb_parallel_read_threads 会话变量必须设置为大于 1 的值才能进行并行聚集索引读取。 默认值为 4。用于执行并行聚集索引读取的实际线程数由 innodb_parallel_read_threads 设置或要扫描的索引子树数决定，以较小者为准。
- 从 8.0.14 开始， innodb_dedicated_server 启用该变量后，日志文件的大小和数量将根据自动配置的缓冲池大小进行配置。以前，日志文件大小是根据服务器上检测到的内存量配置的，日志文件的数量不是自动配置的。
- 从 8.0.14 开始，该语句的ADD DATAFILE子句CREATE TABLESPACE 是可选的，它允许没有 FILE权限的用户创建表空间。在CREATE TABLESPACE没有 ADD DATAFILE子句的情况下执行的语句会隐式地创建一个具有唯一文件名的表空间数据文件。
- 默认情况下，当 TempTable 存储引擎占用的内存量超过 temptable_max_ram 变量定义的内存限制时，TempTable 存储引擎开始从磁盘分配内存映射的临时文件。从 MySQL 8.0.16 开始，此行为由 temptable_use_mmap 变量控制。禁用 temptable_use_mmap 会导致 TempTable 存储引擎使用 InnoDB磁盘内部临时表而不是内存映射文件作为其溢出机制。有关详细信息，请参阅 内部临时表存储引擎。
- 从 MySQL 8.0.16 开始，静态InnoDB 数据加密功能支持mysql系统表空间的加密。系统 mysql表空间包含 mysql系统数据库和 MySQL 数据字典表。有关更多信息，请参阅 第 15.13 节，“InnoDB 静态数据加密”。
- 该 innodb_spin_wait_pause_multiplier 变量在 MySQL 8.0.16 中引入，可以更好地控制线程等待获取互斥锁或读写锁时发生的自旋锁轮询延迟的持续时间。可以更精细地调整延迟以解决不同处理器架构上 PAUSE 指令持续时间的差异。有关详细信息，请参阅 第 15.8.8 节，“配置自旋锁轮询”。
- InnoDB通过更好地利用读取线程、减少并行扫描期间发生的预取活动的读取线程 I/O 以及支持分区并行扫描，MySQL 8.0.17 提高了大型数据集的并行读取线程性能。 并行读取线程功能由 innodb_parallel_read_threads 变量控制。现在最大设置为 256，这是所有客户端连接的线程总数。如果达到线程限制，连接将退回到使用单个线程。
- 该 innodb_idle_flush_pct 变量在 MySQL 8.0.18 中引入，允许在空闲期间限制页面刷新，这有助于延长固态存储设备的使用寿命。请参阅 在空闲期间限制缓冲区刷新。
- InnoDB从 MySQL 8.0.19 开始支持为生成直方图统计信息而进行的 高效数据采样。请参阅 直方图统计分析。
- 从 MySQL 8.0.20 开始，双写缓冲区存储区域驻留在双写文件中。在以前的版本中，存储区域位于系统表空间中。将存储区域移出系统表空间可减少写入延迟，增加吞吐量，并在双写缓冲区页面的放置方面提供灵活性。为高级双写缓冲区配置引入了以下系统变量： innodb_doublewrite_dir 定义双写缓冲区文件目录。
- innodb_doublewrite_files 定义双写文件的数量。
- innodb_doublewrite_pages 为批量写入定义每个线程的最大双写页数。
- innodb_doublewrite_batch_size 定义要批量写入的双写页数。

                有关详细信息，请参阅
                第 15.6.4 节，“双写缓冲区”。

- MySQL 8.0.20 改进了竞争感知事务调度 (CATS) 算法，该算法优先考虑等待锁的事务。事务调度权重计算现在完全在一个单独的线程中执行，这提高了计算性能和准确性。 删除了也用于事务调度的先进先出 (FIFO) 算法。CATS 算法增强使 FIFO 算法变得冗余。以前由 FIFO 算法执行的事务调度现在由 CATS 算法执行。 TRX_SCHEDULE_WEIGHT表中增加了 一列INFORMATION_SCHEMA.INNODB_TRX，可以查询CATS算法分配的事务调度权重。 添加了以下INNODB_METRICS计数器用于监视代码级事务调度事件： lock_rec_release_attempts 尝试释放记录锁的次数。
- lock_rec_grant_attempts 尝试授予记录锁的次数。
- lock_schedule_refreshes 分析等待图以更新事务计划权重的次数。

                有关详细信息，请参阅
                第 15.7.6 节，“事务调度”。

- 从 MySQL 8.0.21 开始，为了提高需要访问表和行资源的锁队列的操作的并发性，锁系统互斥体 ( lock_sys->mutex) 被分片闩锁取代，锁队列被分组为表和页锁队列分片，每个分片都由专用互斥锁保护。以前，单锁系统mutex保护所有的锁队列，这是高并发系统的一个争论点。新的分片实现允许更细粒度地访问锁队列。 锁系统互斥锁 ( lock_sys->mutex) 被以下分片锁存器取代： lock_sys->latches.global_latch由 64 个读写锁对象 ( ) 组成的 全局锁存器 ( rw_lock_t)。访问单个锁队列需要一个共享的全局锁存器和锁队列分片上的一个锁存器。需要访问所有锁队列的操作采用独占全局锁存器，锁存所有表和页锁队列分片。
- 表分片锁存器 ( lock_sys->latches.table_shards.mutexes)，实现为 512 个互斥锁的数组，每个互斥锁专用于 512 个表锁队列分片之一。
- 页面分片锁存器 ( lock_sys->latches.page_shards.mutexes)，实现为 512 个互斥锁的数组，每个互斥锁专用于 512 个页面锁定队列分片之一。

                用于监视单锁系统互斥锁的 Performance Schema
                `wait/synch/mutex/innodb/lock_mutex`
                工具被用于监视新的全局、表分片和页面分片锁存器的工具所取代：

- wait/synch/sxlock/innodb/lock_sys_global_rw_lock
- wait/synch/mutex/innodb/lock_sys_table_mutex
- wait/synch/mutex/innodb/lock_sys_page_mutex

- 从 MySQL 8.0.21 开始，使用该 DATA DIRECTORY子句在数据目录外创建的表和表分区数据文件仅限于InnoDB. 此更改允许数据库管理员控制创建表空间数据文件的位置，并确保在恢复期间可以找到数据文件。 一般和每个表文件表空间数据文件 (.ibd文件 ) 不能再在撤消表空间目录 ( innodb_undo_directory) 中创建，除非直接知道 InnoDB。 已知目录是由 datadir、 innodb_data_home_dir和innodb_directories 变量定义的目录。 截断InnoDB驻留在 file-per-table 表空间中的表会删除现有表空间并创建一个新表空间。从 MySQL 8.0.21 开始，InnoDB在默认位置创建新表空间，如果当前表空间目录未知，则会向错误日志写入警告。要在其当前位置创建表空间，请 在运行之前TRUNCATE TABLE将目录添加到 设置中。 innodb_directoriesTRUNCATE TABLE
- 从 MySQL 8.0.21 开始，可以使用 ALTER INSTANCE {ENABLE|DISABLE} INNODB REDO_LOG 语法启用和禁用重做日志记录。此功能旨在将数据加载到新的 MySQL 实例中。禁用重做日志记录有助于通过避免重做日志写入来加快数据加载。 新 INNODB_REDO_LOG_ENABLE 权限允许启用和禁用重做日志记录。 新的 Innodb_redo_log_enabled 状态变量允许监视重做日志状态。 请参阅禁用重做日志记录。
- 在启动时，InnoDB根据存储在数据字典中的表空间文件路径验证已知表空间文件的路径，以防表空间文件已移动到其他位置。innodb_validate_tablespace_paths MySQL 8.0.21 中引入的新 变量允许禁用表空间路径验证。此功能适用于不移动表空间文件的环境。禁用表空间路径验证可缩短具有大量表空间文件的系统的启动时间。 有关详细信息，请参阅 第 15.6.3.7 节，“禁用表空间路径验证”。
- 从 MySQL 8.0.21 开始，在支持原子 DDL 的存储引擎上， CREATE TABLE ... SELECT当使用基于行的复制时，语句在二进制日志中记录为一个事务。以前，它被记录为两个事务，一个用于创建表，另一个用于插入数据。通过此更改， CREATE TABLE ... SELECT语句现在对于基于行的复制是安全的，并且允许与基于 GTID 的复制一起使用。有关详细信息，请参阅 第 13.1.1 节，“原子数据定义语句支持”。
- 在繁忙的系统上截断撤消表空间可能会影响性能，因为相关的刷新操作会从缓冲池中删除旧的撤消表空间页面并将新撤消表空间的初始页面刷新到磁盘。为了解决这个问题，从 MySQL 8.0.21 开始删除了刷新操作。 旧的撤消表空间页面在最近最少使用时被被动释放，或者在下一个完整检查点被删除。新撤消表空间的初始页面现在在截断操作期间被重做记录而不是刷新到磁盘，这也提高了撤消表空间截断操作的持久性。 为了防止过多的撤消表空间截断操作引起的潜在问题，检查点之间对同一撤消表空间的截断操作现在限制为 64。如果超过限制，撤消表空间仍然可以变为非活动状态，但不会被截断直到下一个检查点之后。 INNODB_METRICS与失效的撤消截断刷新操作关联的计数器已被删除。删除的计数器包括： undo_truncate_sweep_count、 undo_truncate_sweep_usec、 undo_truncate_flush_count和 undo_truncate_flush_usec。 请参阅第 15.6.3.4 节，“撤消表空间”。
- 从 MySQL 8.0.22 开始，新 innodb_extend_and_initialize 变量允许配置如何 InnoDB在 Linux 上为 file-per-table 和通用表空间分配空间。默认情况下，当操作需要表空间中的额外空间时，InnoDB将页面分配给表空间并将 NULL 物理写入这些页面。如果频繁分配新页面，此行为会影响性能。您可以在 Linux 系统上禁用 innodb_extend_and_initialize 以避免将 NULL 物理写入新分配的表空间页面。innodb_extend_and_initialize 禁用 时 ，使用分配空间posix_fallocate()调用，它保留空间而不实际写入 NULL。 操作不是原子的posix_fallocate()，这使得在为表空间文件分配空间和更新文件元数据之间可能发生失败。这种故障会使新分配的页面处于未初始化状态，从而导致在InnoDB 尝试访问这些页面时失败。为了防止这种情况，InnoDB在分配新的表空间页面之前写入重做日志记录。如果页面分配操作被中断，则在恢复期间从重做日志记录中重播该操作。
- 从 MySQL 8.0.23 开始，InnoDB支持对属于加密表空间的双写文件页进行加密。使用关联表空间的加密密钥对页面进行加密。有关更多信息，请参阅 第 15.13 节，“InnoDB 静态数据加密”。
- MySQL 8.0.23 中引入的temptable_max_mmap 变量定义了 TempTable 存储引擎在开始在磁盘上存储内部临时表数据之前允许从内存映射 (MMAP) 文件分配的最大内存量。设置为 0 将禁用从 MMAP 文件分配。有关详细信息，请参阅 第 8.4.4 节，“MySQL 中的内部临时表使用”。
- 该AUTOEXTEND_SIZE选项在 MySQL 8.0.23 中引入，定义了 InnoDB当表空间变满时扩展表空间大小的量，从而可以以更大的增量扩展表空间大小。、 、 和 语句AUTOEXTEND_SIZE支持该 选项。有关详细信息，请参阅 第 15.6.3.9 节，“表空间 AUTOEXTEND_SIZE 配置”。 CREATE TABLEALTER TABLECREATE TABLESPACEALTER TABLESPACE 表中添加了AUTOEXTEND_SIZE尺寸列 INFORMATION_SCHEMA.INNODB_TABLESPACES 。
- MySQL 8.0.26 中引入的 innodb_segment_reserve_factor 系统变量允许配置保留为空页的表空间文件段页的百分比。有关详细信息，请参阅 配置保留文件段页面的百分比。
- 在支持fdatasync() 系统调用的 平台上innodb_use_fdatasync ，MySQL 8.0.26 中引入的变量允许使用 fdatasync()instead of fsync()操作系统刷新。除非fdatasync()后续数据检索需要，否则系统调用不会刷新对文件元数据的更改，从而提供潜在的性能优势。
- 从 MySQL 8.0.28 开始，该 tmp_table_size变量定义了由 TempTable 存储引擎创建的任何单个内存内部临时表的最大大小。适当的大小限制可防止单个查询消耗过多的全局 TempTable 资源。请参阅 内部临时表存储引擎。
- 从 MySQL 8.0.28 开始， innodb_open_files 定义 InnoDB一次可以打开的文件数的变量可以在运行时使用 语句设置。该语句执行设置新限制的存储过程。 SELECT innodb_set_open_files_limit(N) 为了防止非 LRU 管理文件消耗整个 innodb_open_files 限制，非 LRU 管理文件被限制为限制的 90% innodb_open_files ，这为 LRU 管理文件保留了 10% 的 innodb_open_files限制。 该innodb_open_files 限制包括临时表空间文件，这些文件以前不计入限制。
- 从 MySQL 8.0.28 开始，InnoDB支持 ALTER TABLE ... RENAME COLUMN使用 ALGORITHM=INSTANT. 有关此操作和支持的其他 DDL 操作的更多信息ALGORITHM=INSTANT，请参阅 第 15.12.1 节，“在线 DDL 操作”。
- 从 MySQL 8.0.29 开始，InnoDB支持 ALTER TABLE ... DROP COLUMN使用 ALGORITHM=INSTANT. 在 MySQL 8.0.29 之前，即时添加的列只能添加为表的最后一列。从 MySQL 8.0.29 开始，即时添加的列可以添加到表中的任意位置。 立即添加或删除列会创建受影响行的新版本。最多允许 64 行版本。表中添加了一个新TOTAL_ROW_VERSIONS 列 INFORMATION_SCHEMA.INNODB_TABLES 来跟踪行版本数。 有关支持的 DDL 操作的更多信息 ALGORITHM=INSTANT，请参阅 第 15.12.1 节，“在线 DDL 操作”。
- 从 MySQL 8.0.30 开始， innodb_doublewrite 系统变量支持DETECT_ONLY 和DETECT_AND_RECOVER设置。使用该DETECT_ONLY设置，数据库页面内容不会写入双写缓冲区，并且恢复不会使用双写缓冲区来修复不完整的页面写入。此轻量级设置仅用于检测不完整的页面写入。该 DETECT_AND_RECOVER设置等同于现有ON 设置。有关详细信息，请参阅 第 15.6.4 节，“双写缓冲区”。
- 从MySQL 8.0.30开始，InnoDB支持动态配置redo log容量。可以在 innodb_redo_log_capacity 运行时设置系统变量来增加或减少重做日志文件占用的磁盘空间总量。 通过此更改，重做日志文件的数量及其默认位置也发生了变化。从MySQL 8.0.30开始， 在data目录InnoDB下的目录下维护了32个redo log文件。#innodb_redo之前InnoDB 默认在data目录下创建了两个redo log文件，redo log文件的数量和大小由 innodb_log_files_in_group 和 innodb_log_file_size 变量控制。这两个变量现在已弃用。 innodb_redo_log_capacity 定义 设置 时innodb_log_files_in_group ， innodb_log_file_size 忽略设置；否则，这些设置用于计算 innodb_redo_log_capacity设置 ( innodb_log_files_in_group * innodb_log_file_size = innodb_redo_log_capacity)。如果没有设置这些变量，重做日志容量将设置为innodb_redo_log_capacity默认值，即 104857600 字节 (100MB)。 提供了几个状态变量来监视重做日志和重做日志调整大小操作。 有关详细信息，请参阅 第 15.6.5 节，“重做日志”。
- 在 MySQL 8.0.31 中，有两个新的状态变量用于监视在线缓冲池大小调整操作。Innodb_buffer_pool_resize_status_code 状态变量报告指示在线缓冲池大小调整操作阶段的状态代码。 状态变量报告一个百分比值， Innodb_buffer_pool_resize_status_progress 指示每个阶段的进度。 有关更多信息，请参阅 第 15.8.3.1 节，“配置 InnoDB 缓冲池大小”。

- 字符集支持。 默认字符集已从 更改 latin1为utf8mb4。该utf8mb4字符集有几个新的排序规则，包括 utf8mb4_ja_0900_as_csMySQL 中第一个可用于 Unicode 的日语特定排序规则。有关详细信息，请参阅 第 10.10.1 节，“Unicode 字符集”。
- JSON 增强功能。 对 MySQL 的 JSON 功能进行了以下增强或添加： 添加了 (inline path) 运算符， ->> 相当于调用 JSON_UNQUOTE().JSON_EXTRACT()-> 这是对 MySQL 5.7 中引入 的列路径运算符的改进 ；col->>"$.path"相当于 JSON_UNQUOTE(col->"$.path"). 内联路径运算符可以用在任何可以使用 的地方JSON_UNQUOTE(JSON_EXTRACT())，例如 SELECT列列表、 子句 和WHERE子句。有关详细信息，请参阅运算符的说明以及JSON 路径语法。 HAVINGORDER BYGROUP BY
- 添加了两个 JSON 聚合函数 JSON_ARRAYAGG()和 JSON_OBJECTAGG(). JSON_ARRAYAGG()将列或表达式作为其参数，并将结果聚合为单个JSON数组。表达式可以计算为任何 MySQL 数据类型；这不一定是一个JSON值。 JSON_OBJECTAGG()采用将其解释为键和值的两列或表达式；它将结果作为单个JSON 对象返回。有关更多信息和示例，请参阅 第 12.20 节，“聚合函数”。
- 添加了 JSON 实用函数 ，它 以易于阅读的格式JSON_PRETTY()输出现有值；JSON每个 JSON 对象成员或数组值都打印在单独的行上，子对象或数组相对于其父对象有 2 个空格。 此函数还适用于可解析为 JSON 值的字符串。 有关更多详细信息和示例，请参阅 第 12.18.8 节，“JSON 实用程序函数”。
- JSON使用 对查询中的值进行 排序时ORDER BY，每个值现在都由排序键的可变长度部分表示，而不是固定 1K 大小的一部分。在许多情况下，这可以减少过度使用。例如，一个标量INT或偶 BIGINT数值实际上只需要很少的字节，因此这个空间的剩余部分（高达 90% 或更多）被填充占用了。此更改对性能有以下好处： 排序缓冲区空间现在得到了更有效的使用，因此文件排序不需要像使用固定长度排序键那样早或经常刷新到磁盘。这意味着可以在内存中对更多数据进行排序，避免不必要的磁盘访问。
- 比较短的键可以比较长的键更快，从而显着提高性能。对于完全在内存中执行的排序以及需要写入磁盘和从磁盘读取的排序都是如此。

- 在 MySQL 8.0.2 中添加了对列值的部分就地更新的支持JSON，这比完全删除现有 JSON 值并在其位置写入新值更有效，就像之前更新任何 JSON列时所做的那样。要应用此优化，必须使用 JSON_SET()、 JSON_REPLACE()或 应用更新JSON_REMOVE()。正在更新的 JSON 文档中不能添加新元素；文档中的值不能占用比更新前更多的空间。请参阅 JSON 值的部分更新，以详细讨论这些要求。 JSON 文档的部分更新可以写入二进制日志，比记录完整的 JSON 文档占用更少的空间。当使用基于语句的复制时，部分更新总是被记录下来。为了使其与基于行的复制一起使用，您必须首先设置 binlog_row_value_options=PARTIAL_JSON；有关详细信息，请参阅此变量的描述。
- 添加了 JSON 实用函数 JSON_STORAGE_SIZE()和 JSON_STORAGE_FREE(). JSON_STORAGE_SIZE()返回在任何部分更新之前用于 JSON 文档的二进制表示的存储空间（以字节为单位）（请参阅上一项）。 显示使用or 部分更新后JSON_STORAGE_FREE()type 的表列中剩余的空间量 ；如果新值的二进制表示小于先前值的二进制表示，则 this 大于零。 JSONJSON_SET()JSON_REPLACE() 这些函数中的每一个还接受 JSON 文档的有效字符串表示。对于这样的值， JSON_STORAGE_SIZE()返回其二进制表示在转换为 JSON 文档后使用的空间。对于包含 JSON 文档的字符串表示形式的变量， JSON_STORAGE_FREE()返回零。如果无法将其（非空）参数解析为有效的 JSON 文档，并且 NULL参数为 NULL. 有关更多信息和示例，请参阅 第 12.18.8 节，“JSON 实用程序函数”。 JSON_STORAGE_SIZE()并 JSON_STORAGE_FREE()在 MySQL 8.0.2 中实现。
- 在 MySQL 8.0.2 中添加了对 $[1 to 5]XPath 表达式等范围的支持。在此版本中还添加了对 last关键字和相对寻址的支持，以便$[last]始终选择数组中的最后一个（编号最大的）元素和 $[last-1]倒数第二个元素。 last使用它的表达式也可以包含在范围定义中。例如， $[last-2 to last-1]返回最后两个元素，但一个来自数组。有关其他信息和示例， 请参阅 搜索和修改 JSON 值。
- 添加了旨在符合 RFC 7396的 JSON 合并功能。 JSON_MERGE_PATCH()，当用于 2 个 JSON 对象时，将它们合并为一个 JSON 对象，该对象具有以下集合的并集作为成员： 第一个对象的每个成员在第二个对象中没有具有相同键的成员。
- 第二个对象的每个成员在第一个对象中没有成员具有相同的键，并且其值不是 JSON null文字。
- 每个成员都有一个存在于两个对象中的键，并且其在第二个对象中的值不是 JSONnull文字。

                作为这项工作的一部分，该
                `JSON_MERGE()`功能已重命名
                `JSON_MERGE_PRESERVE()`。
                `JSON_MERGE()`继续被识别为
                `JSON_MERGE_PRESERVE()`MySQL 8.0 中的别名，但现在已弃用，并可能在未来版本的 MySQL 中删除。

                有关更多信息和示例，请参阅
                第 12.18.4 节，“修改 JSON 值的函数”。

- 实现了重复键的“ last duplicate key wins ” 规范化，与 RFC 7159和大多数 JavaScript 解析器一致。此处显示了此行为的一个示例，其中仅x保留具有密钥的最右边的成员： ```sql mysql> SELECT JSON_OBJECT('x', '32', 'y', '[true, false]', > 'x', '"abc"', 'x', '100') AS Result; +------------------------------------+ | Result | +------------------------------------+ | {"x": "100", "y": "[true, false]"} | +------------------------------------+ 1 row in set (0.00 sec) ``` 插入 MySQL JSON列的值也以这种方式规范化，如本例所示： ```sql mysql> CREATE TABLE t1 (c1 JSON); mysql> INSERT INTO t1 VALUES ('{"x": 17, "x": "red", "x": [3, 5, 7]}'); mysql> SELECT c1 FROM t1; +------------------+ | c1 | +------------------+ | {"x": [3, 5, 7]} | +------------------+ ``` 这是与以前版本的 MySQL 不兼容的更改，在这种情况下使用了“第一个重复键获胜” 算法。 有关更多信息和示例， 请参阅JSON 值的规范化、合并和自动包装。
- MySQL 8.0.4新增该JSON_TABLE() 功能。此函数接受 JSON 数据并将其作为具有指定列的关系表返回。 此函数的语法 为，其中 是返回 JSON 数据的表达式，是应用于源的 JSON 路径， 是列定义列表。此处显示了一个示例： JSON_TABLE(expr, path COLUMNS column_list) [AS] alias)exprpathcolumn_list ```sql mysql> SELECT * -> FROM -> JSON_TABLE( -> '[{"a":3,"b":"0"},{"a":"3","b":"1"},{"a":2,"b":1},{"a":0},{"b":[1,2]}]', -> "$[*]" COLUMNS( -> rowid FOR ORDINALITY, -> -> xa INT EXISTS PATH "$.a", -> xb INT EXISTS PATH "$.b", -> -> sa VARCHAR(100) PATH "$.a", -> sb VARCHAR(100) PATH "$.b", -> -> ja JSON PATH "$.a", -> jb JSON PATH "$.b" -> ) -> ) AS jt1; +-------+------+------+------+------+------+--------+ | rowid | xa | xb | sa | sb | ja | jb | +-------+------+------+------+------+------+--------+ | 1 | 1 | 1 | 3 | 0 | 3 | "0" | | 2 | 1 | 1 | 3 | 1 | "3" | "1" | | 3 | 1 | 1 | 2 | 1 | 2 | 1 | | 4 | 1 | 0 | 0 | NULL | 0 | NULL | | 5 | 0 | 1 | NULL | NULL | NULL | [1, 2] | +-------+------+------+------+------+------+--------+ ``` JSON 源表达式可以是生成有效 JSON 文档的任何表达式，包括 JSON 文字、表列或返回 JSON 的函数调用，例如JSON_EXTRACT(t1, data, '$.post.comments'). 有关详细信息，请参阅 第 12.18.6 节，“JSON 表函数”。

- 数据类型支持。 MySQL 现在支持使用表达式作为数据类型规范中的默认值。这包括将表达式用作 、 、 和 数据类型的 BLOB默认 TEXT值 GEOMETRY， JSON以前根本无法为这些类型分配默认值。有关详细信息，请参阅第 11.6 节，“数据类型默认值”。
- 优化器。 添加了这些优化器增强功能： MySQL 现在支持不可见索引。优化器根本不使用不可见索引，但会正常维护。默认情况下索引是可见的。不可见的索引使测试删除索引对查询性能的影响成为可能，而无需进行破坏性更改，如果索引被证明是必需的，则必须撤消该更改。请参阅 第 8.3.12 节，“不可见索引”。
- MySQL 现在支持降序索引： DESC在索引定义中不再被忽略，但会导致按降序存储键值。以前，可以按相反顺序扫描索引，但会降低性能。降序索引可以正向扫描，效率更高。当最有效的扫描顺序混合了某些列的升序和其他列的降序时，降序索引还使优化器可以使用多列索引。请参阅第 8.3.13 节，“降序索引”。
- MySQL 现在支持创建索引表达式值而不是列值的功能索引键部分。功能键部分可以索引无法以其他方式索引的值，例如 JSON值。有关详细信息，请参阅第 13.1.15 节，“CREATE INDEX 语句”。
- 在 MySQL 8.0.14 及更高版本中， WHERE由常量文字表达式引起的琐碎条件在准备期间被删除，而不是在稍后的优化期间删除。在过程的早期删除条件可以简化具有微不足道条件的外部连接的查询的连接，例如： ```sql SELECT * FROM t1 LEFT JOIN t2 ON condition_1 WHERE condition_2 OR 0 = 1 ``` 优化器现在在准备过程中发现 0 = 1 始终为假，因此变得OR 0 = 1 多余，并将其删除，留下： ```sql SELECT * FROM t1 LEFT JOIN t2 ON condition_1 where condition_2 ``` 现在优化器可以将查询重写为内部连接，如下所示： ```sql SELECT * FROM t1 LEFT JOIN t2 WHERE condition_1 AND condition_2 ``` 有关更多信息，请参阅 第 8.2.1.9 节，“外部连接优化”。
- 在 MySQL 8.0.16 及更高版本中，MySQL 可以在优化时使用常量折叠来处理列与常量值之间的比较，其中常量超出范围或在列类型的范围边界上，而不是做所以对于执行时的每一行。例如，给定一个包含列 的表 t，TINYINT UNSIGNED优化c器可以重写一个条件，例如WHERE c = 255to WHERE c = 255。 有关详细信息，请参阅第 8.2.1.14 节，“常量折叠优化”。
- 从 MySQL 8.0.16 开始，用于子查询的半连接优化IN现在也可以应用于EXISTS子查询。此外，优化器现在对 WHERE附加到子查询的条件中的平凡相关的相等谓词进行去相关，以便它们可以像IN子查询中的表达式一样对待；这适用于EXISTS和 IN子查询。 有关详细信息，请参阅第 8.2.2.1 节，“使用半连接转换优化 IN 和 EXISTS 子查询谓词”。
- 从 MySQL 8.0.17 开始，服务器在上下文化阶段在内部重写任何不完整的 SQL 谓词（即具有形式的谓词 ，其中 是列名或常量表达式并且不使用比较运算符） ，以便查询解析器、查询优化器和查询执行器只需要处理完整的谓词。 WHERE valuevalueWHERE value <> 0 这一变化的一个明显影响是，对于布尔值，EXPLAIN输出现在显示trueand false，而不是 1and 0。 此更改的另一个影响是 SQL 布尔上下文中的 JSON 值的评估执行与 JSON 整数 0 的隐式比较。考虑创建和填充的表，如下所示： ```sql mysql> CREATE TABLE test (id INT, col JSON); mysql> INSERT INTO test VALUES (1, '{"val":true}'), (2, '{"val":false}'); ``` 以前，服务器在 SQL 布尔值上下文中比较时尝试将提取的 true或false 值转换为 SQL 布尔值，如以下查询所示 IS TRUE： ```sql mysql> SELECT id, col, col->"$.val" FROM test WHERE col->"$.val" IS TRUE; +------+---------------+--------------+ | id | col | col->"$.val" | +------+---------------+--------------+ | 1 | {"val": true} | true | +------+---------------+--------------+ ``` 在 MySQL 8.0.17 及更高版本中，提取值与 JSON 整数 0 的隐式比较会导致不同的结果： ```sql mysql> SELECT id, col, col->"$.val" FROM test WHERE col->"$.val" IS TRUE; +------+----------------+--------------+ | id | col | col->"$.val" | +------+----------------+--------------+ | 1 | {"val": true} | true | | 2 | {"val": false} | false | +------+----------------+--------------+ ``` 从 MySQL 8.0.21 开始，您可以 JSON_VALUE()在执行测试之前使用提取的值进行类型转换，如下所示： ```sql mysql> SELECT id, col, col->"$.val" FROM test -> WHERE JSON_VALUE(col, "$.val" RETURNING UNSIGNED) IS TRUE; +------+---------------+--------------+ | id | col | col->"$.val" | +------+---------------+--------------+ | 1 | {"val": true} | true | +------+---------------+--------------+ ``` 同样从 MySQL 8.0.21 开始，服务器提供警告Evaluating a JSON value in SQL boolean context does an implicit comparison against JSON integer 0; 如果这不是您想要的，请考虑在以这种方式比较 SQL 布尔上下文中提取的值时使用 JSON_VALUE RETURNING 将 JSON 转换为 SQL 数字类型。
- 在 MySQL 8.0.17 及更高版本中，具有或 的WHERE 条件在内部转换为反连接。（反连接从表中返回所有行，而在其连接的表中没有与连接条件匹配的行。）这会删除子查询，这会导致更快的查询执行，因为子查询的表现在在顶部处理等级。 NOT IN (subquery)NOT EXISTS (subquery) 这类似于并重用了现有的IS NULL( Not exists) 外连接优化；请参阅 解释额外信息。
- 从 MySQL 8.0.21 开始，单个表 UPDATE或 DELETE语句现在在许多情况下可以使用半连接转换或子查询实现。这适用于此处所示形式的陈述： UPDATE t1 SET t1.a=value WHERE t1.a IN (SELECT t2.a FROM t2)
- DELETE FROM t1 WHERE t1.a IN (SELECT t2.a FROM t2)

                对于单表
                `UPDATE`或者`DELETE`
                满足以下条件可以这样做：

- UPDATEor DELETE语句使用具有[NOT] INor [NOT] EXISTS谓词 的子查询。
- 该语句没有ORDER BY 子句，也没有LIMIT子句。 UPDATE（ and 的多表版本 DELETE不支持 ORDER BYor LIMIT。）
- 目标表不支持先读后写删除（仅与 NDB表相关）。
- 基于子查询中包含的任何提示和 的值，允许半连接或子查询具体化 optimizer_switch。

                当半连接优化用于符合条件的单表`DELETE`或
                `UPDATE`时，这在优化器跟踪中是可见的：对于多表语句，
                `join_optimization`跟踪中有一个对象，而对于单表语句则没有。`EXPLAIN FORMAT=TREE`转换在or
                的输出中也可见
                `EXPLAIN ANALYZE`；单表语句显示``，而多表语句报告完整计划。

`UPDATE`
                同样从MySQL 8.0.21开始，使用表的多表语句
                支持半一致性读`InnoDB`
                ，事务隔离级别弱于
                `REPEATABLE READ`.

- 改进了散列连接性能。 MySQL 8.0.23 重新实现了用于散列连接的散列表，从而在散列连接性能方面进行了多项改进。这项工作包括对一个问题（错误 #31516149、错误 #99933）的修复，其中只有大约 2/3 分配给连接缓冲区 ( join_buffer_size) 的内存实际上可以被哈希连接使用。 新的哈希表一般比旧的快，并且在对齐、键/值和有很多相同键的场景中使用更少的内存。此外，当哈希表的大小增加时，服务器现在可以释放旧内存。

- 常用表表达式。 MySQL 现在支持非递归和递归的公用表表达式。公用表表达式允许使用命名的临时结果集，通过允许在语句和某些其他语句WITH之前的子句来实现。SELECT有关详细信息，请参阅 第 13.2.15 节，“WITH（公用表表达式）”。 从 MySQL 8.0.19 开始， SELECT递归公用表表达式 (CTE) 的递归部分支持 LIMIT子句。也支持LIMIT 。OFFSET有关详细信息，请参阅 递归公用表表达式。
- 窗口函数。 MySQL 现在支持窗口函数，对于查询中的每一行，使用与该行相关的行执行计算。其中包括 RANK()、 LAG()和 等函数NTILE()。此外，几个现有的聚合函数现在可以用作窗口函数（例如， SUM()和 AVG()）。有关详细信息，请参阅第 12.21 节，“窗口函数”。
- 横向派生表。 派生表现在可以在 LATERAL关键字前面指定允许在同一FROM子句中引用（依赖于）前面表的列。横向派生表使某些 SQL 操作成为可能，而这些操作无法使用非横向派生表完成，或者需要低效的变通方法。请参阅 第 13.2.11.9 节，“横向派生表”。
- 单表 DELETE 语句中的别名。 MySQL 8.0.16及以后版本，单表 DELETE语句支持使用表别名。
- 正则表达式支持。 以前，MySQL 使用 Henry Spencer 正则表达式库来支持正则表达式运算符 ( REGEXP, RLIKE)。正则表达式支持已使用 Unicode 国际组件 (ICU) 重新实现，它提供完整的 Unicode 支持并且是多字节安全的。该 函数以and 运算符REGEXP_LIKE()的方式执行正则表达式匹配 ，现在它们是该函数的同义词。此外， 、 和 REGEXPRLIKEREGEXP_INSTR()REGEXP_REPLACE()REGEXP_SUBSTR()函数可用于分别查找匹配位置和执行子字符串替换和提取。regexp_stack_limit和 regexp_time_limit系统变量提供对匹配引擎资源消耗的控制。 有关详细信息，请参阅 第 12.8.2 节，“正则表达式”。有关使用正则表达式的应用程序可能受实施更改影响的方式的信息，请参阅 正则表达式兼容性注意事项。
- 内部临时表。 TempTable存储引擎取代MEMORY存储引擎成为内存内部临时表的默认引擎 。TempTable存储引擎为 VARCHAR和 列提供高效存储VARBINARY。会话变量定义内存内部临时表的 internal_tmp_mem_storage_engine 存储引擎。允许的值为 TempTable（默认值）和 MEMORY. 该 变量定义了在数据存储到磁盘之前存储引擎可以使用 temptable_max_ram 的最大内存量 。TempTable
- 记录。 添加了这些增强功能以​​改进日志记录： 错误日志被重写以使用 MySQL 组件架构。传统的错误日志记录是使用内置组件实现的，而使用系统日志的日志记录是作为可加载组件实现的。此外，还提供可加载的 JSON 日志编写器。有关详细信息，请参阅第 5.4.2 节 “错误日志”。
- 从 MySQL 8.0.30 开始，错误日志组件可以在 InnoDB存储引擎可用之前在启动时隐式加载。这种加载错误日志组件的新方法加载并启用由 log_error_services 变量定义的组件。 以前，错误日志组件必须先使用安装，INSTALL COMPONENT并且只能在 InnoDB完全可用后才能加载，因为要加载的组件列表是从 mysql.components表中读取的，这是一个 InnoDB表。 错误日志组件的隐式加载具有以下优点： 日志组件在启动顺序中较早加载，使记录的信息更快可用。
- 如果在启动期间发生故障，它有助于避免丢失缓冲日志信息。
- INSTALL COMPONENT不需要 使用加载日志组件 ，简化错误日志配置。

`INSTALL COMPONENT`
                为了向后兼容，仍然支持

                加载日志组件的显式方法
                。

                有关详细信息，请参阅
                第 5.4.2.1 节，“错误日志配置”。

- 备用锁。 一种新型备份锁允许在线备份期间进行 DML，同时防止可能导致快照不一致的操作。LOCK INSTANCE FOR BACKUP 和 UNLOCK INSTANCE语法支持新的备份锁 。使用这些 BACKUP_ADMIN语句需要特权。
- 复制。 对 MySQL 复制进行了以下增强： MySQL Replication 现在支持使用紧凑的二进制格式对 JSON 文档的部分更新进行二进制日志记录，从而比记录完整的 JSON 文档节省日志空间。当使用基于语句的日志记录时，这种紧凑的日志记录会自动完成，并且可以通过将新 binlog_row_value_options系统变量设置为 来启用PARTIAL_JSON。有关详细信息，请参阅JSON 值的部分更新以及 binlog_row_value_options.

- 连接管理。 MySQL 服务器现在允许专门为管理连接配置 TCP/IP 端口。这为用于普通连接的网络接口上允许的单一管理连接提供了一种替代方法，即使 max_connections 连接已经建立。请参阅 第 5.1.12.1 节，“连接接口”。 MySQL 现在提供了对压缩使用的更多控制，以最大限度地减少通过连接发送到服务器的字节数。以前，给定的连接要么未压缩，要么使用zlib压缩算法。现在，还可以使用该 zstd算法，并为zstd连接选择压缩级别。允许的压缩算法可以在服务器端配置，也可以在连接发起端配置，用于客户端程序和参与源/副本复制或组复制的服务器的连接。有关详细信息，请参阅 第 4.2.8 节，“连接压缩控制”.
- 配置。 整个 MySQL 主机名的最大允许长度已从之前的 60 个字符的限制提高到 255 个 ASCII 字符。这适用于，例如，数据字典、 mysql系统架构、性能架构INFORMATION_SCHEMA和 sys架构中与主机名相关的列；声明的 MASTER_HOST价值 CHANGE MASTER TO；语句输出中的Host列 ；SHOW PROCESSLIST帐户名中的主机名（例如用于帐户管理语句和 DEFINER属性）; 和主机名相关的命令选项和系统变量。 注意事项： 允许的主机名长度的增加会影响在主机名列上具有索引的表。例如，mysql系统模式中索引主机名的表现在具有显式 ROW_FORMAT属性 DYNAMIC以容纳更长的索引值。
- 一些文件名值配置设置可能是基于服务器主机名构建的。允许的值受底层操作系统的限制，它可能不允许文件名足够长以包含 255 个字符的主机名。这会影响 general_log_file、 log_error、 pid_file、 relay_log和 slow_query_log_file 系统变量以及相应的选项。如果基于主机名的值对于操作系统来说太长，则必须提供明确的更短的值。
- 尽管服务器现在支持 255 个字符的主机名，但使用该 --ssl-mode=VERIFY_IDENTITY 选项建立的与服务器的连接受到 OpenSSL 支持的最大主机名长度的限制。主机名匹配属于SSL证书的两个字段，最大长度如下： Common Name：最大长度64；主题备用名称：根据 RFC#1034 的最大长度。

- 插件。 以前，MySQL 插件可以用 C 或 C++ 编写。插件使用的 MySQL 头文件现在包含 C++ 代码，这意味着插件必须用 C++ 编写，而不是 C。
- C API。 MySQL C API 现在支持与 MySQL 服务器进行非阻塞通信的异步函数。每个函数都是现有同步函数的异步副本。如果从服务器连接读取或写入必须等待，则同步函数会阻塞。异步函数使应用程序能够检查服务器连接上的工作是否准备好继续。如果没有，应用程序可以在稍后再次检查之前执行其他工作。请参阅 C API 异步接口。
- 演员表的其他目标类型。 函数CAST()和 CONVERT()现在支持转换为类型 DOUBLE、 FLOAT和 REAL。在 MySQL 8.0.17 中添加。请参阅第 12.11 节，“Cast 函数和运算符”。
- JSON 模式验证。 MySQL 8.0.17 添加了两个功能 JSON_SCHEMA_VALID()， JSON_SCHEMA_VALIDATION_REPORT() 用于再次验证 JSON 文档 JSON 模式。 JSON_SCHEMA_VALID()如果文档根据架构进行验证，则返回 TRUE (1)，否则返回 FALSE (0)。 JSON_SCHEMA_VALIDATION_REPORT()返回一个 JSON 文档，其中包含有关验证结果的详细信息。以下陈述适用于这两个函数： 架构必须符合 JSON 架构规范的草案 4。
- required支持属性。
- $ref 不支持 外部资源和关键字。
- 支持正则表达式模式；无效的模式被默默地忽略。

有关更多信息和示例，

            请参阅第 12.18.7 节，“JSON 模式验证函数” 。

- 多值索引。 从 MySQL 8.0.17 开始， InnoDB支持创建多值索引，多值索引是在JSON存储值数组的列上定义的二级索引，对于单个数据记录可以有多个索引记录。这样的索引使用关键部分定义，例如 CAST(data->'$.zipcode' AS UNSIGNED ARRAY). MySQL 优化器自动使用多值索引进行合适的查询，如 的输出所示 EXPLAIN。 作为这项工作的一部分，MySQL 添加了一个新函数 JSON_OVERLAPS()和一个新 MEMBER OF()运算符来处理JSON文档，另外还 CAST()使用新 ARRAY关键字扩展了该函数，如下表所述： JSON_OVERLAPS()比较两个 JSON文档。如果它们包含任何共同的键值对或数组元素，则函数返回 TRUE (1)；否则返回 FALSE (0)。如果两个值都是标量，则该函数执行简单的相等性测试。如果一个参数是 JSON 数组而另一个是标量，则标量将被视为数组元素。因此， JSON_OVERLAPS()作为 的补充JSON_CONTAINS()。
- MEMBER OF()测试第一个操作数（标量或 JSON 文档）是否是作为第二个操作数传递的 JSON 数组的成员，如果是则返回 TRUE (1)，否则返回 FALSE (0)。不执行操作数的类型转换。
- CAST(expression AS type ARRAY)允许通过将在 JSON 文档中找到的 JSON 数组 json_path转换为 SQL 数组来创建功能索引。类型说明符仅限于 已经支持的类型说明符CAST()，但 BINARY(not supported) 除外。CAST()（和 关键字）的这种用法 ARRAY仅由 支持 InnoDB，并且仅用于创建多值索引。

            有关多值索引的详细信息（包括示例），请参阅
            多值索引。
            第 12.18.3 节，“搜索 JSON 值的函数”，提供了关于`JSON_OVERLAPS()`和
            的信息`MEMBER OF()`，以及使用示例。

- 提示时区。 从 MySQL 8.0.17 开始， time_zone会话变量可以使用 SET_VAR.
- 重做日志归档。 从 MySQL 8.0.17 开始，InnoDB支持重做日志归档。当备份操作正在进行时，复制重做日志记录的备份实用程序有时可能无法跟上重做日志生成的步伐，从而导致由于重做日志记录被覆盖而丢失重做日志记录。重做日志归档功能通过将重做日志记录顺序写入归档文件来解决这个问题。备份实用程序可以根据需要从归档文件中复制重做日志记录，从而避免潜在的数据丢失。有关详细信息，请参阅重做日志归档。
- 克隆插件。 从 MySQL 8.0.17 开始，MySQL 提供了一个克隆插件，允许InnoDB在本地或从远程 MySQL 服务器实例克隆数据。本地克隆操作将克隆的数据存储在运行 MySQL 实例的同一服务器或节点上。远程克隆操作通过网络将克隆数据从捐赠者 MySQL 服务器实例传输到发起克隆操作的接收服务器或节点。 克隆插件支持复制。除了克隆数据之外，克隆操作还从捐赠者那里提取和传输复制坐标，并将它们应用于接收者，这使得可以使用克隆插件来配置组复制成员和副本。使用克隆插件进行配置比复制大量事务要快得多，效率也高得多。组复制成员也可以配置为使用克隆插件作为替代恢复方法，以便成员自动选择最有效的方式从种子成员检索组数据。 有关更多信息，请参阅第 5.6.7 节，“克隆插件”和第 18.5.4.2 节，“为分布式恢复克隆”。 从 MySQL 8.0.27 开始，在进行克隆操作时，允许对供体 MySQL 服务器实例执行并发 DDL 操作。以前，在克隆操作期间会持有一个备份锁，以防止对捐赠者进行并发 DDL。要恢复到先前在克隆操作期间阻止捐助者上的并发 DDL 的行为，请启用该clone_block_ddl 变量。请参阅第 5.6.7.4 节，“克隆和并发 DDL”。 从 MySQL 8.0.29 开始，该 clone_delay_after_data_drop 变量允许在远程克隆操作开始时删除接收方 MySQL 服务器实例上的现有数据后立即指定延迟时间。延迟旨在为接收方主机上的文件系统提供足够的时间，以便在从捐赠方 MySQL 服务器实例克隆数据之前释放空间。某些文件系统在后台进程中异步释放空间。在这些文件系统上，在删除现有数据后过早地克隆数据可能会因空间不足而导致克隆操作失败。最长延迟时间为 3600 秒（1 小时）。默认设置为 0（无延迟）。
- 哈希连接优化。 从 MySQL 8.0.18 开始，只要连接中的每对表至少包含一个等值连接条件，并且没有索引适用于任何连接条件，就会使用哈希连接。散列连接不需要索引，尽管它可以与仅应用于单表谓词的索引一起使用。在大多数情况下，散列连接比块嵌套循环算法更有效。可以通过这种方式优化此处显示的连接： ```sql SELECT * FROM t1 JOIN t2 ON t1.c1=t2.c1; SELECT * FROM t1 JOIN t2 ON (t1.c1 = t2.c1 AND t1.c2 散列连接也可用于笛卡尔乘积——也就是说，当没有指定连接条件时。 EXPLAIN FORMAT=TREE您可以使用or 查看哈希连接优化何时用于特定查询 EXPLAIN ANALYZE。（在MySQL 8.0.20及之后的版本中，也可以使用EXPLAIN，省略 FORMAT=TREE。） 哈希连接可用的内存量受限于 的值 join_buffer_size。在磁盘上执行需要更多内存的散列连接；磁盘上哈希连接可以使用的磁盘文件数受 open_files_limit. 从 MySQL 8.0.19 开始， hash_join不再支持 MySQL 8.0.18 中引入的优化器开关（hash_join=on 仍然作为 optimizer_switch 值的一部分出现，但设置它不再有任何效果）。和优化HASH_JOIN器 NO_HASH_JOIN提示也不再受支持。开关和提示现在都已弃用；希望它们在未来的 MySQL 版本中被删除。在 MySQL 8.0.18 及更高版本中，可以使用NO_BNL 优化器开关禁用散列连接。 在 MySQL 8.0.20 及更高版本中，MySQL 服务器不再使用块嵌套循环，并且在任何时候使用块嵌套循环时都会使用哈希连接，即使查询不包含等连接条件。这适用于内部非等值连接、半连接、反连接、左外部连接和右外部连接。系统变量的 block_nested_loop标志optimizer_switch以及 BNL和 NO_BNL仍然支持优化器提示，但此后仅控制散列连接的使用。此外，内连接和外连接（包括半连接和反连接）现在都可以使用批处理键访问 (BKA)，它以增量方式分配连接缓冲区内存，这样单个查询就不必占用大量它们实际上不需要解析的资源. 从 MySQL 8.0.18 开始，仅支持用于内部联接的 BKA。 MySQL 8.0.20 还将之前版本的 MySQL 中使用的执行器替换为迭代器执行器。这项工作包括替换旧的索引子查询引擎，这些引擎管理那些尚未优化为半连接的查询的形式查询，以及以相同形式实现的查询，这些查询以前依赖于旧的执行程序。 WHERE value IN (SELECT column FROM table WHERE ...)IN 有关更多信息和示例，请参阅 第 8.2.1.4 节，“哈希连接优化”。另请参阅 成批密钥访问联接。
- EXPLAIN ANALYZE 语句。 在 MySQL 8.0.18 中实现了一种新形式的EXPLAIN 语句，以 格式为处理查询中使用的每个迭代器EXPLAIN ANALYZE提供有关语句执行的扩展信息 ，并且可以将估计成本与查询的实际成本进行比较. 此信息包括启动成本、总成本、此迭代器返回的行数以及执行的循环数。 SELECTTREE 在 MySQL 8.0.21 及更高版本中，该语句还支持 FORMAT=TREE说明符。 TREE是唯一支持的格式。 有关详细信息，请参阅使用 EXPLAIN ANALYZE 获取信息。
- 查询投射。 在 8.0.18 及更高版本中，MySQL 在参数的数据类型与预期数据类型不匹配的表达式和条件中将强制转换操作注入到查询项树中。这对查询结果或执行速度没有影响，但使执行的查询等同于符合 SQL 标准的查询，同时保持与以前版本的 MySQL 的向后兼容性。 每当 使用任何标准 数字比较运算符（ 、、、、、、、/ DATE、 DATETIME_ TIMESTAMP_ _ _ _ _ _ _ _ _ _ _ _ _ 或者 TIMESMALLINTTINYINTMEDIUMINTINTINTEGERBIGINTDECIMALNUMERICFLOATDOUBLEREALBIT=>=>!=). 在这种情况下，任何不是 a 的值都 DOUBLE被转换为 1。现在还执行强制转换以比较 DATEor TIMEvalues 和 DATETIMEvalues，其中参数在必要时强制转换为 DATETIME. 从 MySQL 8.0.21 开始，在将字符串类型与其他类型进行比较时也会执行此类转换。强制转换的字符串类型包括CHAR、 VARCHAR、 BINARY、 VARBINARY、 BLOB、 TEXT、 ENUM和 SET。将字符串类型的值与数字类型 or 进行比较时 YEAR，字符串转换为 DOUBLE; 如果另一个参数的类型不是FLOAT、DOUBLE或REAL，它也会被转换为 DOUBLE。将字符串类型与 DATETIMEorTIMESTAMP 值进行比较时，字符串被强制转换为DATETIME; 将字符串类型与 进行比较时DATE，字符串将转换为DATE. EXPLAIN ANALYZE可以通过查看、或 的输出来查看强制转换何时被注入到给定查询中EXPLAIN FORMAT=JSON，如下所示EXPLAIN FORMAT=TREE： ```sql mysql> CREATE TABLE d (dt DATETIME, d DATE, t TIME); Query OK, 0 rows affected (0.62 sec) mysql> CREATE TABLE n (i INT, d DECIMAL, f FLOAT, dc DECIMAL); Query OK, 0 rows affected (0.51 sec) mysql> CREATE TABLE s (c CHAR(25), vc VARCHAR(25), -> bn BINARY(50), vb VARBINARY(50), b BLOB, t TEXT, -> e ENUM('a', 'b', 'c'), se SET('x' ,'y', 'z')); Query OK, 0 rows affected (0.50 sec) mysql> EXPLAIN FORMAT=TREE SELECT * from d JOIN n ON d.dt = n.i\G *************************** 1. row *************************** EXPLAIN: -> Inner hash join (cast(d.dt as double) = cast(n.i as double)) (cost=0.70 rows=1) -> Table scan on n (cost=0.35 rows=1) -> Hash -> Table scan on d (cost=0.35 rows=1) mysql> EXPLAIN FORMAT=TREE SELECT * from s JOIN d ON d.dt = s.c\G *************************** 1. row *************************** EXPLAIN: -> Inner hash join (d.dt = cast(s.c as datetime(6))) (cost=0.72 rows=1) -> Table scan on d (cost=0.37 rows=1) -> Hash -> Table scan on s (cost=0.35 rows=1) 1 row in set (0.01 sec) mysql> EXPLAIN FORMAT=TREE SELECT * from n JOIN s ON n.d = s.c\G *************************** 1. row *************************** EXPLAIN: -> Inner hash join (cast(n.d as double) = cast(s.c as double)) (cost=0.70 rows=1) -> Table scan on s (cost=0.35 rows=1) -> Hash -> Table scan on n (cost=0.35 rows=1) 1 row in set (0.00 sec) ``` 这样的转换也可以通过执行看到EXPLAIN [FORMAT=TRADITIONAL]，在这种情况下也有必要SHOW WARNINGS在执行 EXPLAIN语句后发出。
- TIMESTAMP 和 DATETIME 的时区支持。 从 MySQL 8.0.19 开始，服务器接受带有插入日期时间 (TIMESTAMP和 DATETIME) 值的时区偏移量。此偏移量使用与设置系统变量时采用的格式相同的格式time_zone，除了当偏移量的小时部分小于 10 时需要前导零，这 '-00:00'是不允许的。包含时区偏移量的日期时间文字的示例是 '2019-12-11 10:40:30-05:00'、 '2003-04-14 03:30:00+10:00'和 '2020-01-01 15:35:45+05:30'。 选择日期时间值时不显示时区偏移量。 包含时区偏移量的日期时间文字可用作准备好的语句参数值。 作为这项工作的一部分，用于设置 time_zone系统变量的值现在也限制在 到 的范围内 -13:59，+14:00包括 。（如果加载了 MySQL 时区表， 则仍然可以将名称值分配给 time_zone、 和 此变量；请参阅填充 时区表）。 'EST''Posix/Australia/Brisbane''Europe/Stockholm' 有关更多信息和示例，请参阅 第 5.1.15 节，“MySQL 服务器时区支持”，以及 第 11.2.2 节，“DATE、DATETIME 和 TIMESTAMP 类型”。
- JSON 模式 CHECK 约束失败的准确信息。 在使用 JSON_SCHEMA_VALID()指定CHECK约束时，MySQL 8.0.19及之后的版本提供了此类约束失效原因的准确信息。 有关示例和更多信息，请参阅 JSON_SCHEMA_VALID() 和 CHECK 约束。另见第 13.1.20.6 节，“检查约束”。
- ON DUPLICATE KEY UPDATE 的行和列别名。 从 MySQL 8.0.19 开始，可以使用别名引用要插入的行，以及可选的列。在具有列 和的表上考虑以下 INSERT语句 ： tab ```sql INSERT INTO t SET a=9,b=5 ON DUPLICATE KEY UPDATE a=VALUES(a)+VALUES(b); ``` 使用new新行的别名，在某些情况下，使用该行的列的别名，可以用许多不同的方式重写该 m语句 ，此处显示了其中的一些示例： nINSERT ```sql INSERT INTO t SET a=9,b=5 AS new ON DUPLICATE KEY UPDATE a=new.a+new.b; INSERT INTO t VALUES(9,5) AS new ON DUPLICATE KEY UPDATE a=new.a+new.b; INSERT INTO t SET a=9,b=5 AS new(m,n) ON DUPLICATE KEY UPDATE a=m+n; INSERT INTO t VALUES(9,5) AS new(m,n) ON DUPLICATE KEY UPDATE a=m+n; ``` 有关更多信息和示例，请参阅 第 13.2.6.2 节，“INSERT ... ON DUPLICATE KEY UPDATE 语句”。
- SQL 标准显式表子句和表值构造函数。 根据 SQL 标准添加表值构造函数和显式表子句。这些在MySQL 8.0.19中分别实现为 TABLEstatement和 VALUESstatement。 该TABLE语句的格式为 ，等同于。它支持 和 子句（后者可选 ），但不允许选择单个表列。 可以用在任何你会使用等效 语句的地方；这包括联接、联合、、、 语句 和子查询。例如： TABLE table_nameSELECT * FROM table_nameORDER BYLIMITOFFSETTABLESELECTINSERT ... SELECTREPLACECREATE TABLE ... SELECT TABLE t1 UNION TABLE t2相当于SELECT * FROM t1 UNION SELECT * FROM t2
- CREATE TABLE t2 TABLE t1相当于CREATE TABLE t2 SELECT * FROM t1
- SELECT a FROM t1 WHERE b > ANY (TABLE t2)相当于SELECT a FROM t1 WHERE b > ANY (SELECT * FROM t2).

            `VALUES`可用于向 、 或 语句提供表值`INSERT`，
            `REPLACE`由
            `SELECT`关键字和`VALUES`后跟一系列行构造函数 ( `ROW()`) 的关键字组成，以逗号分隔。例如，该语句
            `INSERT INTO t1 VALUES ROW(1,2,3), ROW(4,5,6), ROW(7,8,9)`提供了一个与 SQL 兼容的等效于 MySQL 特定的`INSERT INTO t1 VALUES (1,2,3), (4,5,6), (7,8,9)`. 您还可以像选择
            `VALUES`表一样从表值构造函数中进行选择，请记住，这样做时必须提供表别名，并像使用
            `SELECT`其他任何东西一样使用它；这包括联接、联合和子查询。

            有关`TABLE`和
            的更多信息`VALUES`及其使用示例，请参阅本文档的以下部分：

- 第 13.2.12 节，“TABLE 语句”
- 第 13.2.14 节，“VALUES 语句”
- 第 13.1.20.4 节，“CREATE TABLE ... SELECT 语句”
- 第 13.2.6.1 节，“INSERT ... SELECT 语句”
- 第 13.2.10.2 节，“JOIN 子句”
- 第 13.2.11 节，“子查询”
- 第 13.2.10.3 节，“UNION 子句”

- FORCE INDEX、IGNORE INDEX 的优化器提示。 MySQL 8.0 引入了索引级优化器提示，它类似于第 8.9.4 节“索引提示”中描述的传统索引提示。此处列出了新的提示及其FORCE INDEX对应的提示IGNORE INDEX ： GROUP_INDEX： 相当于FORCE INDEX FOR GROUP BY NO_GROUP_INDEX： 相当于IGNORE INDEX FOR GROUP BY
- JOIN_INDEX： 相当于FORCE INDEX FOR JOIN NO_JOIN_INDEX： 相当于IGNORE INDEX FOR JOIN
- ORDER_INDEX： 相当于FORCE INDEX FOR ORDER BY NO_ORDER_INDEX： 相当于IGNORE INDEX FOR ORDER BY
- INDEX: 与 plus GROUP_INDEX相同 ; 相当于没有修饰符 JOIN_INDEXORDER_INDEXFORCE INDEX NO_INDEX: 与 plus NO_GROUP_INDEX相同 ; 相当于没有修饰符 NO_JOIN_INDEXNO_ORDER_INDEXIGNORE INDEX

            例如，以下两个查询是等价的：

```sql
SELECT a FROM t1 FORCE INDEX (i_a) FOR JOIN WHERE a=1 AND b=2;

SELECT /*+ JOIN_INDEX(t1 i_a) */ a FROM t1 WHERE a=1 AND b=2;
```

            前面列出的优化器提示遵循与现有索引级优化器提示相同的语法和用法基本规则。

            这些优化器提示旨在替换`FORCE INDEX`和`IGNORE INDEX`，我们计划在未来的 MySQL 版本中弃用，并随后从 MySQL 中删除。他们没有为 ; 实现一个精确的等价物`USE INDEX`；相反，您可以使用 、 、 或 中的一个或多个
            `NO_INDEX`来
            `NO_JOIN_INDEX`达到
            `NO_GROUP_INDEX`相同
            `NO_ORDER_INDEX`的效果。

            有关更多信息和使用示例，请参阅
            索引级优化器提示。

- JSON_VALUE() 函数。 MySQL 8.0.21 实现了一个 JSON_VALUE()旨在简化JSON 列索引的新功能。在其最基本的形式中，它将一个 JSON 文档和一个指向该文档中单个值的 JSON 路径作为参数，并且（可选）允许您使用 RETURNING关键字指定返回类型。 等同于： JSON_VALUE(json_doc, path RETURNING type) ```text CAST( JSON_UNQUOTE( JSON_EXTRACT(json_doc, path) ) AS type ); ``` 您还可以指定ON EMPTY、 ON ERROR或同时指定这两个子句，类似于使用 的子句 JSON_TABLE()。 您可以使用在列JSON_VALUE()上的表达式上创建索引，JSON如下所示： ```sql CREATE TABLE t1( j JSON, INDEX i1 ( (JSON_VALUE(j, '$.id' RETURNING UNSIGNED)) ) ); INSERT INTO t1 VALUES ROW('{"id": "123", "name": "shoes", "price": "49.95"}'); ``` 使用此表达式的查询（如此处所示）可以使用索引： ```sql SELECT name, price FROM t1 WHERE JSON_VALUE(j, '$.id' RETURNING UNSIGNED) = 123; ``` 在许多情况下，这比从列创建生成列JSON然后在生成列上创建索引更简单。 有关更多信息和示例，请参阅 的说明 JSON_VALUE()。
- 用户评论和用户属性。 MySQL 8.0.21 引入了在创建或更新用户帐户时设置用户评论和用户属性的功能。用户评论由作为参数传递给与or 语句COMMENT一起使用的子句的任意文本组成。用户属性由 JSON 对象形式的数据组成，这些数据作为参数传递给与 这两个语句中的任何一个一起使用的子句。该属性可以包含 JSON 对象表示法中的任何有效键值对。或中只能 使用一个或 CREATE USERALTER USERATTRIBUTECOMMENTATTRIBUTECREATE USERALTER USER陈述。 用户评论和用户属性作为 JSON 对象在内部存储在一起，评论文本作为元素的值comment作为其键。可以从表的 ATTRIBUTE列中 检索此信息INFORMATION_SCHEMA.USER_ATTRIBUTES ；由于它是 JSON 格式，您可以使用 MySQL 的 JSON 函数和运算符来解析其内容（请参阅 第 12.18 节，“JSON 函数”）。JSON_MERGE_PATCH() 与使用该函数 时一样，对用户属性的连续更改将与其当前值合并。 例子： ```sql mysql> CREATE USER 'mary'@'localhost' COMMENT 'This is Mary Smith\'s account'; Query OK, 0 rows affected (0.33 sec) mysql> ALTER USER 'mary'@'localhost' -≫ ATTRIBUTE '{"fname":"Mary", "lname":"Smith"}'; Query OK, 0 rows affected (0.14 sec) mysql> ALTER USER 'mary'@'localhost' -≫ ATTRIBUTE '{"email":"mary.smith@example.com"}'; Query OK, 0 rows affected (0.12 sec) mysql> SELECT -> USER, -> HOST, -> ATTRIBUTE->>"$.fname" AS 'First Name', -> ATTRIBUTE->>"$.lname" AS 'Last Name', -> ATTRIBUTE->>"$.email" AS 'Email', -> ATTRIBUTE->>"$.comment" AS 'Comment' -> FROM INFORMATION_SCHEMA.USER_ATTRIBUTES -> WHERE USER='mary' AND HOST='localhost'\G *************************** 1. row *************************** USER: mary HOST: localhost First Name: Mary Last Name: Smith Email: mary.smith@example.com Comment: This is Mary Smith's account 1 row in set (0.00 sec) ``` 有关更多信息和示例，请参阅 第 13.7.1.3 节，“CREATE USER 语句”，第 13.7.1.1 节，“ALTER USER 语句”和 第 26.3.46 节，“INFORMATION_SCHEMA USER_ATTRIBUTES 表”。
- 新的 optimizer_switch 标志。 MySQL 8.0.21 为 optimizer_switch系统变量添加了两个新标志，如下表所述： prefer_ordering_index 旗帜 默认情况下， 只要优化器确定这会导致更快的执行，MySQL 就会尝试对任何具有子句的查询ORDER BY使用有序索引。因为在某些情况下，为此类查询选择不同的优化可能实际上会执行得更好，所以现在可以通过将 标志设置为来禁用此优化。 GROUP BYLIMITprefer_ordering_indexoff 此标志的默认值为 on。
- subquery_to_derived 旗帜 当此标志设置为on时，优化器将符合条件的标量子查询转换为派生表上的连接。例如，查询 SELECT * FROM t1 WHERE t1.a > (SELECT COUNT(a) FROM t2)被重写为 SELECT t1.a FROM t1 JOIN ( SELECT COUNT(t2.a) AS c FROM t2 ) AS d WHERE t1.a > d.c. 这种优化可以应用于子查询，它是SELECT, WHERE, JOIN, or HAVING子句的一部分；包含一个或多个聚合函数但没有GROUP BY 子句；不相关；并且不使用任何非确定性函数。 优化也可以应用于表子查询，它是、、 或 的参数IN， 并且不包含. 例如，查询被重写为. NOT INEXISTSNOT EXISTSGROUP BYSELECT * FROM t1 WHERE t1.b  0可以重写为 SELECT t1.* FROM t1 LEFT OUTER JOIN (SELECT a, COUNT(*) AS ct FROM t2 GROUP BY a) AS derived ON t1.a = derived.a WHERE derived.a > 0。MySQL 执行基数检查以确保子查询不会返回多于一行 ( ER_SUBQUERY_NO_1_ROW)。有关详细信息，请参阅第 13.2.11.7 节，“相关子查询”。 这种优化通常被禁用，因为它在大多数情况下不会产生明显的性能优势；该标志off默认设置为。

            有关详细信息，请参阅
            第 8.9.2 节，“可切换优化”。另见
            第 8.2.1.19 节“LIMIT 查询优化”、
            第 8.2.2.1 节“使用半连接转换优化 IN 和 EXISTS 子查询谓词”和
            第 8.2.2.4 节“使用合并优化派生表、视图引用和公用表表达式”或物化”。

- XML 增强功能。 从 MySQL 8.0.21 开始，该LOAD XML语句现在支持 CDATA导入 XML 中的部分。
- 现在支持转换为 YEAR 类型。 从 MySQL 8.0.22 开始，服务器允许转换为 YEAR. CAST()和 函数都 CONVERT()支持个位数、两位数和四位数的 YEAR值。对于一位数和两位数的值，允许的范围是 0-99。四位数的值必须在 1901-2155 范围内。 YEAR也可以用作JSON_VALUE() 函数的返回类型；此函数仅支持四位数年份。 字符串、时间和日期以及浮点值都可以转换为YEAR. 不支持 将 GEOMETRY值转换 为。YEAR 有关更多信息，包括转换规则，请参阅CONVERT() 函数说明。
- 检索 TIMESTAMP 值作为 UTC。 MySQL 8.0.22 及更高版本支持 在检索时将TIMESTAMP列值从系统时区转换为 UTC DATETIME，使用，其中说明符是 或 之一。如果需要，可以将转换返回的值的精度 指定为最多 6 位小数。此构造不支持 该 关键字。CAST(value AT TIME ZONE specifier AS DATETIME)[INTERVAL] '+00:00''UTC'DATETIMEARRAY TIMESTAMP还支持使用时区偏移量将值插入表中。AT TIME ZONE不支持使用 或 CONVERT()任何其他 MySQL 函数或构造。 有关更多信息和示例，请参阅CAST()函数说明。
- 转储文件输出同步。 SELECT INTO DUMPFILEMySQL 8.0.22及以后支持andSELECT INTO OUTFILE语句 写入文件时的周期同步 。这可以通过将 select_into_disk_sync 系统变量设置为启用ON；写缓冲区的大小由为 ; 设置的值决定 select_into_buffer_size；默认值为 131072 (2 17 ) 字节。 此外，可以使用设置同步到磁盘后的可选延迟 select_into_disk_sync_delay；默认为无延迟（0 毫秒）。 有关详细信息，请参阅本项目前面引用的变量的描述。
- 单独编制报表。 从 MySQL 8.0.22 开始，准备好的语句只准备一次，而不是每次执行一次。这是在执行时完成的 PREPARE。对于存储过程中的任何语句也是如此；当第一次执行存储过程时，语句准备一次。 此更改的一个结果是，解析准备语句中使用的动态参数的方式也以此处列出的方式更改： 准备好的语句参数在准备语句时被分配数据类型；该类型在语句的每次后续执行中都保持不变（除非重新准备该语句；请参见下文）。 在准备好的语句中为给定的参数或用户变量使用不同的数据类型来执行第一次执行后的语句可能会导致重新准备该语句；出于这个原因，建议在重新执行准备好的语句时对给定参数使用相同的数据类型。
- 为了与 SQL 标准保持一致，不再接受以下使用窗口函数的结构： NTILE(NULL)
- NTH_VALUE(expr, NULL)
- LEAD(expr, nn)和 , 其中 是一个负数 LAG(expr, nn)nn

                这有助于更好地遵守 SQL 标准。有关详细信息，请参阅各个功能说明。

- 在准备语句中引用的用户变量现在在准备语句时确定其数据类型；该类型对于该语句的每次后续执行都保持不变。
- 存储过程中出现的语句引用的用户变量现在在第一次执行该语句时确定其数据类型；该类型对于包含存储过程的任何后续调用都保持不变。
- 在执行 形式的准备语句时， 为参数传递整数值 不再导致结果按 选择列表中的第 th 个 表达式排序；结果不再按 . 预期的那样排序。 SELECT expr1, expr2, ... FROM table ORDER BY ?NNORDER BY constant

            准备用作准备好的语句或仅在存储过程中使用一次的语句可以提高语句的性能，因为它可以抵消重复准备的额外成本。这样做还可以避免可能的准备结构多次回滚，这一直是 MySQL 中众多问题的根源。

            有关详细信息，请参阅第 13.5.1 节，“PREPARE 语句”。

- RIGHT JOIN 作为 LEFT JOIN 处理。 从 MySQL 8.0.22 开始，服务器将 RIGHT JOIN内部的所有实例处理为LEFT JOIN，消除了一些在解析时未执行完整转换的特殊情况。
- 派生条件下推优化。 MySQL 8.0.22（及更高版本）为具有物化派生表的查询实现派生条件下推。对于诸如 的查询，现在在许多情况下可以将外部 条件下推到派生表，在这种情况下会导致. SELECT * FROM (SELECT i, j FROM t1) AS dt WHERE i > constantWHERESELECT * FROM (SELECT i, j FROM t1 WHERE i > constant) AS dt 以前，如果派生表被具体化而不是合并，MySQL 会具体化整个表，然后用WHERE条件限定行。使用派生条件下推优化将条件移动WHERE到子查询中通常可以减少必须处理的行数，从而减少执行查询所需的时间。 WHERE当派生表不使用任何聚合或窗口函数时，可以将 外部条件直接下推到物化派生表。当派生表有aGROUP BY且不使用任何窗口函数时，WHERE可以将外部条件作为条件下推到派生表HAVING 。当派生表使用窗口函数并且外部引用列在窗口函数的 子句 中WHERE时，也可以下推条件。WHEREPARTITION 默认情况下启用派生条件下推，如 optimizer_switch系统变量的 derived_condition_pushdown 标志所示。该标志在 MySQL 8.0.22 中添加， on默认设置为；要禁用特定查询的优化，可以使用 NO_DERIVED_CONDITION_PUSHDOWN 优化器提示（也在 MySQL 8.0.22 中添加）。如果由于 derived_condition_pushdown 设置为优化被禁用off，您可以使用 为给定的查询启用它 DERIVED_CONDITION_PUSHDOWN。 派生条件下推优化不能用于包含 LIMIT子句的派生表。在 MySQL 8.0.29 之前，当查询包含 . 时也不能使用优化 UNION。在 MySQL 8.0.29 及更高版本中，大多数情况下可以将条件下推到联合的两个查询块；有关更多信息，请参阅 第 8.2.2.5 节，“派生条件下推优化”。 另外，本身使用子查询的条件不能下推，WHERE条件不能下推到同为外连接内表的派生表。有关其他信息和示例，请参阅 第 8.2.2.5 节，“派生条件下推优化”。
- 对 MySQL 授权表的非锁定读取。 从 MySQL 8.0.22 开始，为了允许对 MySQL 授权表进行并发 DML 和 DDL 操作，以前在 MySQL 授权表上获取行锁的读取操作将作为非锁定读取执行。 现在在 MySQL 授权表上作为非锁定读取执行的操作包括： SELECT语句和其他只读语句，它们通过连接列表和子查询从授权表中读取数据，包括 SELECT ... FOR SHARE使用任何事务隔离级别的语句。
- 使用任何事务隔离级别从授权表（通过连接列表或子查询）读取数据但不修改它们的 DML 操作。

            有关其他信息，请参阅
            授予表并发性。

- 64 位支持 FROM_UNIXTIME()、UNIX_TIMESTAMP()、CONVERT_TZ()。 从 MySQL 8.0.28 开始，函数 FROM_UNIXTIME()、 UNIX_TIMESTAMP()和 CONVERT_TZ()在支持它们的平台上处理 64 位值。这包括 64 位版本的 Linux、MacOS 和 Windows。 在兼容平台上，UNIX_TIMESTAMP() 现在处理的值最多为'3001-01-18 23:59:59.999999'UTC，并且 FROM_UNIXTIME()可以转换自 Unix Epoch 以来最多 32536771199.999999 秒的值； CONVERT_TZ()现在接受转换后不超过'3001-01-18 23:59:59.999999' UTC 的值。 这些函数在 32 位平台上的行为不受这些更改的影响。该 TIMESTAMP类型的行为也不受影响（在任何平台上）；要在 UTC 之后处理日期 '2038-01-19 03:14:07.999999'时间，请改用该DATETIME类型。 有关详细信息，请参阅第 12.7 节“日期和时间函数” 中对刚才讨论的各个函数的描述 。
- 资源分配控制。 Global_connection_memory 从 MySQL 8.0.28 开始，您可以通过检查状态变量 来查看用于所有普通用户发出的查询的内存 量。（这个总数不包括系统用户使用的资源，例如 MySQL root。它也不包括 InnoDB缓冲池占用的任何内存。） 要启用更新 Global_connection_memory，必须设置 global_connection_memory_tracking = 1；默认情况0下（关闭）。Global_connection_memory您可以通过设置 来控制更新的频率 connection_memory_chunk_size。 通过设置此处列出的一个或两个系统变量，也可以在会话或全局级别或两者上为普通用户设置内存使用限制： connection_memory_limit：为每个连接分配的内存量。每当任何用户超过此限制时，都会拒绝来自该用户的新查询。
- global_connection_memory_limit：为所有连接分配的内存量。每当超过此限制时，来自任何普通用户的新查询都会被拒绝。

            这些限制不适用于系统进程或管理帐户。

            有关详细信息，请参阅引用变量的说明。

- 分离的 XA 事务。 MySQL 8.0.29 添加了对 XA 事务的支持，这些事务一旦准备好，就不再连接到原始连接。这意味着它们可以由另一个连接提交或回滚，并且当前会话可以立即开始另一个事务。 系统变量 xa_detach_on_prepare 控制 XA 事务是否分离；默认值为 ON，这会导致分离所有 XA 事务。当这生效时，XA 事务不允许使用临时表。 有关详细信息，请参阅第 13.3.8.2 节，“XA 事务状态”。
- 自动二进制日志清除控制。 MySQL 8.0.29 添加了 binlog_expire_logs_auto_purge 系统变量，它提供了一个单一的接口来启用和禁用二进制日志的自动清除。默认情况下启用 ( ON)；要禁用二进制日志文件的自动清除，请将此变量设置为OFF. binlog_expire_logs_auto_purge必须是 ON为了自动清除二进制日志文件才能继续进行；此变量的值优先于任何其他服务器选项或变量的值，包括（但不限于） binlog_expire_logs_seconds。 的设置对 binlog_expire_logs_auto_purge没有影响PURGE BINARY LOGS。
- 条件例程和触发器创建语句。 从 MySQL 8.0.29 开始，以下语句支持一个IF NOT EXISTS选项： CREATE FUNCTION
- CREATE PROCEDURE
- CREATE TRIGGER

            对于`CREATE FUNCTION`创建存储函数 and 时`CREATE PROCEDURE`，此选项可防止在已存在同名例程时发生错误。对于
            `CREATE FUNCTION`用于创建可加载函数时，如果已存在具有该名称的可加载函数，该选项可防止错误。对于`CREATE TRIGGER`，该选项可防止在同一模式和同一表中已存在同名触发器时发生错误。

            此增强功能使这些语句的语法与 、 、 和（所有这些都已经支持 ）的语法更紧密地对齐`CREATE DATABASE`，`CREATE TABLE`并`CREATE USER`用于`CREATE EVENT`补充`IF NOT EXISTS`、和
            语句
            支持
          的`IF EXISTS`选项。`DROP PROCEDURE``DROP FUNCTION``DROP TRIGGER`

            有关详细信息，请参阅指示的 SQL 语句的说明以及
            函数名称解析。另见
            第 17.5.1.7 节，“CREATE TABLE ... SELECT 语句的复制”。

- 包括 FIDO 库升级。 MySQL 8.0.30 将包含的 fido2库（与 authentication_fido插件一起使用）从 1.5.0 版本升级到 1.8.0 版本。 有关详细信息，请参阅第 6.4.1.11 节，“FIDO 可插入身份验证”。
- 字符集：特定于语言的归类。 以前，当不止一种语言具有完全相同的排序规则定义时，MySQL 只为其中一种语言实现排序规则，这意味着某些语言仅由utf8mb4特定于其他语言的 Unicode 9.0 排序规则涵盖。MySQL 8.0.30（及更高版本）通过为那些以前仅由其他语言的特定语言排序规则涵盖的语言提供特定于语言的排序规则来修复此类问题。此处列出了新排序规则涵盖的语言： 挪威语（尼诺斯克语） 和 挪威语（博克马尔语）
- 塞尔维亚语（拉丁字符）
- 波斯尼亚语（拉丁字符）
- 保加利亚语
- 加利西亚语
- 蒙古文（西里尔字母）

            MySQL 为刚刚列出的每种语言提供`*_as_cs`和
            `*_ai_ci`整理。

            有关详细信息，请参阅
            特定于语言的排序规则。

- IF EXISTS 和 IGNORE UNKNOWN USER 选项用于 REVOKE。 MySQL 8.0.30 实现了两个新选项 REVOKE，可用于在语句中指定的用户、角色或权限找不到或无法分配时确定语句是产生错误还是警告。此处提供了显示这些新选项位置的非常基本的语法： ```sql REVOKE [IF EXISTS] privilege_or_role ON object FROM user_or_role [IGNORE UNKNOWN USER] ``` IF EXISTSREVOKE只要命名的目标用户或角色实际存在， 就会导致不成功的 语句引发警告而不是错误，尽管语句中对任何无法找到的角色或特权的任何引用。 IGNORE UNKNOWN USERREVOKE当找不到语句中指定的目标用户或角色时， 会导致不成功发出警告而不是错误。 有关更多信息和示例，请参阅 第 13.7.1.8 节，“REVOKE 语句”。
- 生成不可见的主键。 从 MySQL 8.0.30 开始，可以在 GIPK 模式下运行复制源服务器，这会导致生成的不可见主键 (GIPK) 添加到InnoDB 没有显式主键创建的任何表中。添加到此类表的生成的键列定义等同于此处显示的内容： ```text my_row_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT INVISIBLE PRIMARY KEY ``` 默认情况下不启用 GIPK 模式。要启用它，请将 sql_generate_invisible_primary_key 服务器系统变量设置为ON. 副本忽略 sql_generate_invisible_primary_key 复制表的任何设置，并且不为不是在源上使用它们创建的任何表生成主键。 生成的不可见主键通常在语句的输出中可见，例如SHOW CREATE TABLEand SHOW INDEX，以及在 MySQL Information Schema 表中，例如COLUMNSand STATISTICS表。show_gipk_in_create_table_and_information_schema 在这种情况下，您可以通过设置为来隐藏它们 OFF。 作为这项工作的一部分，一个新 --skip-generated-invisible-primary-key 选项被添加到mysqldump和 mysqlpump以从它们的输出中排除生成的不可见主键、列和列值。 有关更多信息和示例，请参阅 第 13.1.20.11 节，“生成的不可见主键”。
- 崩溃安全的 XA 事务。 以前，XA 事务对于二进制日志的意外停止没有完全的弹性，如果这发生在服务器正在执行 XA PREPARE，，XA COMMIT或 XA ROLLBACK，服务器不能保证可以恢复到正确的状态，可能会使二进制日志中包含未应用的额外 XA 事务，或者丢失一个或多个已应用的 XA 事务。从 MySQL 8.0.30 开始，这不再是问题，无论出于何种原因退出复制拓扑的服务器在重新加入时总是可以恢复到一致的 XA 事务状态。 已知问题：当使用同一个事务 XID 顺序执行 XA 事务并且在执行过程中发生中断时XA COMMIT ... ONE PHASE，使用同一个 XID，在存储引擎中准备好该事务后，可能无法再同步二进制日志和存储引擎之间的状态。 有关详细信息，请参阅第 13.3.8.3 节，“对 XA 事务的限制”。
- 与 UNION 嵌套。 从 MySQL 8.0.31 开始，带括号的查询表达式的主体最多可以嵌套 63 层，并结合UNION. 此类查询以前因错误而被拒绝 ER_NOT_SUPPORTED_YET，但现在被允许。EXPLAIN 此类查询的输出显示如下： ```sql mysql> EXPLAIN FORMAT=TREE ( -> (SELECT a, b, c FROM t ORDER BY a LIMIT 3) ORDER BY b LIMIT 2 -> ) ORDER BY c LIMIT 1\G *************************** 1. row *************************** EXPLAIN: -> Limit: 1 row(s) (cost=5.55..5.55 rows=1) -> Sort: c, limit input to 1 row(s) per chunk (cost=2.50 rows=0) -> Table scan on (cost=2.50 rows=0) -> Temporary table (cost=5.55..5.55 rows=1) -> Limit: 2 row(s) (cost=2.95..2.95 rows=1) -> Sort: b, limit input to 2 row(s) per chunk (cost=2.50 rows=0) -> Table scan on (cost=2.50 rows=0) -> Temporary table (cost=2.95..2.95 rows=1) -> Limit: 3 row(s) (cost=0.35 rows=1) -> Sort: t.a, limit input to 3 row(s) per chunk (cost=0.35 rows=1) -> Table scan on t (cost=0.35 rows=1) 1 row in set (0.00 sec) ``` MySQL 在折叠带括号的查询表达式的主体时遵循 SQL 标准语义，因此较高的外部限制不能覆盖内部较低的限制。例如， (SELECT ... LIMIT 5) LIMIT 10可以返回不超过五行。 只有在 MySQL 优化器的解析器执行了它可以执行的任何简化或合并之后，才会施加 63 级限制。 有关详细信息，请参阅 第 13.2.10.6 节，“带括号的查询表达式”。
- 禁用查询重写。 以前，在使用该Rewriter 插件时，所有查询都可能被重写，而与用户无关。这在某些情况下可能会出现问题，例如在管理系统时，或者在应用源自复制源的语句或由mysqldump或其他 MySQL 程序创建的转储文件时。MySQL 8.0.31 通过实现新的用户权限来解决此类问题 SKIP_QUERY_REWRITE；具有此权限的用户发出的语句将被忽略Rewriter并且不会被重写。 MySQL 8.0.31 还增加了一个新的服务器系统变量 rewriter_enabled_for_threads_without_privilege_checks。当设置为 时，插件不会重写由 线程（例如复制应用程序线程） OFF发出的可重写语句 。默认值为 ，这意味着此类语句将被重写。 PRIVILEGE_CHECKS_USERNULLRewriterON 有关详细信息，请参阅 第 5.6.4 节，“重写器查询重写插件”。
- XA 语句的复制过滤。 以前，每当使用or 时， 语句 XA START、XA END、XA COMMIT和XA ROLLBACK都会被默认数据库过滤 ，这可能会导致错过事务。从 MySQL 8.0.31 开始，在这种情况下不会过滤这些语句，无论 . --replicate-do-db--replicate-ignore-dbbinlog_format
- 复制过滤和权限检查。 从 MySQL 8.0.31 开始，当使用复制过滤时，副本不再引发与 require_row_format 过滤掉的事件的权限检查或验证相关的复制错误，从而可以过滤掉任何验证失败的事务。 由于对筛选行的权限检查不再导致复制停止，因此副本现在只能接受给定用户已被授予访问权限的数据库部分；只要对这部分数据库的更新仅以基于行的格式进行复制，情况就是如此。 当从使用表进行管理或入站复制用户无权访问的其他目的的内部部署或云服务迁移到 MySQL 数据库服务时，此功能也可能有用。 有关详细信息，请参阅 第 17.2.5 节，“服务器如何评估复制过滤规则”，以及 第 17.5.1.29 节，“复制期间的副本错误”。
- INTERSECT 和 EXCEPT 表运算符。 MySQL 8.0.31 添加了对 SQL INTERSECT和 EXCEPT表运算符的支持。其中a和 b表示查询的结果集，这些运算符的行为如下： a INTERSECT b仅包括同时出现在结果集中 a和 中的行b。
- a EXCEPT b仅返回结果集中a 未出现在 b.

            `INTERSECT DISTINCT`, `INTERSECT ALL`, `EXCEPT DISTINCT`, 和
            `EXCEPT ALL`都支持；
            `DISTINCT`是 和 的默认值
            （这`INTERSECT`与`EXCEPT`
            相同
            `UNION`）。

            有关更多信息和示例，请参阅
            第 13.2.10.4 节“INTERSECT 子句”和第 13.2.10.5 节“EXCEPT 子句”。

- 用户定义的直方图。 从 MySQL 8.0.31 开始，可以将列的直方图设置为用户指定的 JSON 值。这可以使用以下 SQL 语法完成： ```sql ANALYZE TABLE tbl_name UPDATE HISTOGRAM ON col_name USING DATA 'json_data' ``` 此语句使用直方图的 JSON 表示形式 col_name为表 的列创建或覆盖直方图 。执行此语句后，您可以通过查询 Information Schema 表来验证直方图是否已创建或更新 ，如下所示： tbl_namejson_dataCOLUMN_STATISTICS ```sql SELECT HISTOGRAM FROM INFORMATION_SCHEMA.COLUMN_STATISTICS WHERE TABLE_NAME='tbl_name' AND COLUMN_NAME='col_name'; ``` 返回的列值应与 上一条语句 json_data中使用 的相同。ANALYZE TABLE 这在直方图采样过程遗漏了认为重要的值的情况下很有用。发生这种情况时，您可能希望修改直方图或根据完整数据集设置自己的直方图。此外，对大型用户数据集进行采样并从中构建直方图是资源密集型操作，可能会影响用户查询。通过此增强功能，直方图生成可以从（主）服务器上移开并在副本上执行；然后可以将生成的直方图分配给源服务器上适当的表列。 有关更多信息和示例，请参阅 直方图统计分析。

### MySQL 8.0 中弃用的功能

        以下功能在 MySQL 8.0 中已弃用，可能会在未来的系列中删除。在显示备选方案的地方，应更新应用程序以使用它们。

        对于使用 MySQL 8.0 中已弃用的功能的应用程序，这些功能已在更高的 MySQL 系列中删除，当从 MySQL 8.0 源复制到更高系列的副本时，语句可能会失败，或者可能对源和副本产生不同的影响。为避免此类问题，应修改使用 8.0 中弃用功能的应用程序以避免出现此类问题，并尽可能使用替代方案。

- utf8mb3字符集已弃用 。请utf8mb4改用。
- 以下字符集已弃用： ucs2（参见 第 10.9.4 节，“ucs2 字符集（UCS-2 Unicode 编码）”）
- macroman和macce （参见第 10.10.2 节，“西欧字符集”和 第 10.10.3 节，“中欧字符集”）
- dec（参见 第 10.10.2 节，“西欧字符集”）
- hp8（参见 第 10.10.2 节，“西欧字符集”）

            在 MySQL 8.0.28 及更高版本中，任何这些字符集或其排序规则在以下列任一方式使用时都会产生弃用警告：

- 使用 --character-set-server或 启动 MySQL 服务器时--collation-server
- 在任何 SQL 语句中指定时，包括但不限于CREATE TABLE、 CREATE DATABASE、 SET NAMES和 ALTER TABLE

            您应该改用`utf8mb4`前面列出的任何字符集。

- 因为是 MySQL 8.0 中的默认身份验证插件，并提供身份验证插件 caching_sha2_password功能的超集 ，已弃用；希望在未来的 MySQL 版本中将其删除。使用身份验证的 MySQL 帐户 应迁移为使用 。 sha256_passwordsha256_passwordsha256_passwordcaching_sha2_password
- 该validate_password插件已重新实现以使用组件基础结构。的插件形式validate_password仍然可用，但现已弃用；希望在未来的 MySQL 版本中将其删除。使用该插件的 MySQL 安装应该改为使用该组件。请参阅 第 6.4.3.3 节，“转换到密码验证组件”。
- and 语句 的ENGINE子句 已弃用。 ALTER TABLESPACEDROP TABLESPACE
- PAD_CHAR_TO_FULL_LENGTH SQL 模式已弃用 。
- AUTO_INCREMENT不推荐对类型列FLOAT和 DOUBLE（以及任何同义词）的支持。考虑AUTO_INCREMENT 从此类列中删除属性，或将它们转换为整数类型。
- 对于类型为、 和 （以及任何同义词）UNSIGNED的列， 该属性已弃用。考虑对此类列使用简单的约束。 FLOATDOUBLEDECIMALCHECK
- FLOAT(M,D) 和 语法来指定类型列的位数 并且 （和任何同义词）是一个非标准的 MySQL 扩展。此语法已弃用。 DOUBLE(M,D)FLOATDOUBLE
- 对于数字数据类型，该ZEROFILL属性已弃用，整数数据类型的显示宽度属性也是如此。考虑使用替代方法来产生这些属性的效果。例如，应用程序可以使用该 LPAD()函数将数字补零到所需的宽度，或者它们可以将格式化后的数字存储在CHAR 列中。
- 对于字符串数据类型，该BINARY 属性是一个非标准的 MySQL 扩展，它是指定_bin列字符集（如果未指定列字符集，则为表默认字符集）的二进制 ( ) 排序规则的简写。在 MySQL 8.0 中，这个非标准的使用 BINARY是有歧义的，因为 utf8mb4字符集有多个 _bin排序规则，所以这个 BINARY属性被弃用了；希望在未来版本的 MySQL 中删除对它的支持。应调整应用程序以改为使用显式 _bin排序规则。 使用BINARY指定数据类型或字符集保持不变。
- 以前版本的 MySQL分别 支持非标准的简写表达式ASCIIand 和 。 并已弃用（MySQL 8.0.28 及更高版本），现在会产生警告。在这两种情况下都使用。 UNICODECHARACTER SET latin1CHARACTER SET ucs2ASCIIUNICODECHARACTER SET
- 非标准 C 风格 &&、 ||和 !运算符分别是标准 SQL AND、 OR和 运算符的同义词NOT，已弃用。使用非标准运算符的应用程序应调整为使用标准运算符。 笔记 ||除非 PIPES_AS_CONCAT启用 SQL 模式，否则不推荐 使用。在这种情况下，||表示 SQL 标准字符串连接运算符）。
- 该JSON_MERGE()功能已弃用。改用 JSON_MERGE_PRESERVE() 。
- 不推荐使用SQL_CALC_FOUND_ROWS查询修饰符和伴随FOUND_ROWS() 函数。FOUND_ROWS()有关替代策略的信息， 请参阅 说明。
- 从 MySQL 8.0.13 开始，不推荐使用 对TABLESPACE = innodb_file_per_tableandTABLESPACE = innodb_temporary子句的 支持。CREATE TEMPORARY TABLE
- 对于SELECT语句，从 MySQL 8.0.20 开始不推荐在 theINTO之后 FROM但不在末尾 使用子句。SELECT最好将 the INTO放在语句的末尾。 对于UNION语句，这两个包含的变体INTO从 MySQL 8.0.20 开始被弃用： 在查询表达式的尾随查询块中，使用INTObefore FROM。
- 在查询表达式的带括号的尾随块中，使用INTO，无论其相对于 的位置如何FROM。

            请参阅第 13.2.10.1 节，“SELECT ... INTO 语句”和
            第 13.2.10.3 节，“UNION 子句”。

- FLUSH HOSTS从 MySQL 8.0.23 开始不推荐使用。相反，截断性能模式 host_cache表： ```sql TRUNCATE TABLE performance_schema.host_cache; ``` 该TRUNCATE TABLE操作需要DROP表的权限。
- mysql_upgrade客户端已被弃用，因为它升级系统模式中的系统表mysql和其他模式中的对象的功能已移至 MySQL 服务器。请参阅 第 2.11.3 节，“MySQL 升级过程升级了什么”。
- 服务器选项已--no-dd-upgrade弃用。它被 --upgrade选项所取代，它提供了对数据字典和服务器升级行为的更好控制。
- mysql_upgrade_info创建数据目录并用于存储MySQL版本号的文件已弃用 ；希望在未来的 MySQL 版本中将其删除。
- 系统relay_log_info_file变量和--master-info-file选项已弃用。以前，这些用于在设置时指定中继日志信息日志和源信息日志的名称 relay_log_info_repository=FILE ， master_info_repository=FILE 但这些设置已被弃用。中继日志信息日志和源信息日志文件的使用已被崩溃安全副本表取代，这是 MySQL 8.0 中的默认设置。
- max_length_for_sort_data 由于优化器更改使其过时且无效， 因此 系统变量现已弃用。
- 这些用于压缩与服务器的连接的遗留参数已被弃用： --compress客户端命令行选项；C API函数的 MYSQL_OPT_COMPRESS选项 ；mysql_options()系统 slave_compressed_protocol 变量。有关要使用的参数的信息，请参阅 第 4.2.8 节，“连接压缩控制”。
- 不推荐使用MYSQL_PWD环境变量来指定 MySQL 密码。
- 从 MySQL 8.0.20 开始，不推荐使用 访问VALUES()新行值 。INSERT ... ON DUPLICATE KEY UPDATE而是为新的行和列使用别名。
- 因为在调用 ON ERROR之前 指定是违反 SQL 标准的，所以这种语法现在在 MySQL 中已被弃用。从 MySQL 8.0.20 开始，每当您尝试这样做时，服务器都会打印一条警告。在一次 调用中指定这两个子句时，请确保首先使用它。 ON EMPTYJSON_TABLE()JSON_TABLE()ON EMPTY
- 从来不支持带有索引前缀的列作为表分区键的一部分；以前，这些在创建、更改或升级分区表时是允许的，但会被表的分区功能排除，并且服务器不会发出发生这种情况的警告。这种允许的行为现在已被弃用，并且在未来版本的 MySQL 中将被删除，在该版本中，在分区键中使用任何此类列会导致它们中的CREATE TABLE orALTER TABLE语句被拒绝。 从 MySQL 8.0.21 开始，只要使用索引前缀的列被指定为分区键的一部分，就会为每个这样的列生成警告。每当 CREATE TABLEor ALTER TABLE语句因为建议的分区键中的所有列都具有索引前缀而被拒绝时，由此产生的错误现在会提供拒绝的确切原因。在任何一种情况下，这都包括分区函数中使用的列通过使用空 PARTITION BY KEY()子句隐式定义为表主键中的列的情况。 有关更多信息和示例，请参阅 键分区不支持的列索引前缀。
- 从 MySQL 8.0.22 开始不推荐使用 InnoDB memcached 插件；希望在未来版本的 MySQL 中删除对它的支持。
- temptable_use_mmap 从MySQL 8.0.26 开始不推荐使用 该变量；希望在未来版本的 MySQL 中删除对它的支持。
- 该BINARY运算符从 MySQL 8.0.27 开始被弃用，您应该期望在未来版本的 MySQL 中将其删除。使用 BINARYnow 会导致警告。改用 CAST(... AS BINARY)。
- default_authentication_plugin 从MySQL 8.0.27 开始不推荐使用 该 变量；希望在未来版本的 MySQL 中删除对它的支持。 该 default_authentication_plugin 变量仍在 MySQL 8.0.27 中使用，但与新系统变量一起使用且优先级低于新 authentication_policy系统变量，后者在 MySQL 8.0.27 中引入，具有多因素身份验证功能。有关详细信息，请参阅 默认身份验证插件。
- MySQL 测试套件使用的--abort-slave-event-count 和 --disconnect-slave-event-count 服务器选项，通常不用于生产，从 MySQL 8.0.29 开始被弃用；希望在未来版本的 MySQL 中删除这两个选项。
- 从MySQL 8.0.29 开始，不推荐使用myisam_repair_threads 系统变量和myisamchk选项； --parallel-recover期望在 MySQL 的未来版本中删除对两者的支持。 从 MySQL 8.0.29 开始，除 1（默认值）以外的值 myisam_repair_threads 会产生警告。
- 以前，MySQL 接受 包含任意数量（任意）分隔符的 、 、DATE和 TIME文字 DATETIME， 以及在日期和时间部分之前、之后和之间具有任意数量的空白字符的和 文字。从 MySQL 8.0.29 开始，每当文字值包含以下任何内容时，服务器都会发出弃用警告： TIMESTAMPDATETIMETIMESTAMP 一个或多个非标准分隔符
- 过多的分隔符
- 空格字符以外的空格 (' ', 0x20)
- 多余的空格字符

            每个时间值都会发出一个弃用警告，即使它存在多个问题。此警告不会在严格模式下升级为错误，因此
            `INSERT`在严格模式生效时执行此类值的操作仍然会成功。

            您应该期望在未来版本的 MySQL 中删除非标准行为，并立即采取措施确保您的应用程序不依赖于它。

有关更多信息和示例，

            请参阅日期和时间上下文中的字符串和数字文字。

- 从MySQL 8.0.29 开始，replica_parallel_type 系统变量及其关联的服务器选项 --replica-parallel-type已弃用。从此版本开始，读取或设置此值会引发弃用警告；希望在未来的 MySQL 版本中将其删除。
- 服务器选项从--skip-host-cacheMySQL 8.0.30 开始被弃用；期望在未来的 MySQL 版本中将其删除。请改用 host_cache_size系统变量。
- 从 MySQL 8.0.30 开始，将 replica_parallel_workers 系统变量（或等效的服务器选项）设置为 0 已被弃用，并会引发警告。当您希望副本使用单线程时，请 replica_parallel_workers=1改用它，这会产生相同的结果，但没有警告。
- 该--old-style-user-limits 选项旨在与非常旧的（5.0.3 之前的）版本向后兼容，从 MySQL 8.0.30 开始已弃用；现在使用它会发出警告。您应该期望在未来的 MySQL 版本中删除此选项。
- 在 MySQL 8.0.30 之前，该 ST_TRANSFORM()函数不支持笛卡尔空间参考系统。在 MySQL 8.0.30 及更高版本中，此函数提供了对 Popular Visualization Pseudo Mercator (EPSG 1024) 投影方法的支持，用于 WGS 84 Pseudo-Mercator (SRID 3857)。其他笛卡尔 SRS 仍然不受支持。
- MySQL 8.0.31增加Linux系统只读 系统变量 ，编译时生成build_id160位签名；SHA1的值 build_id是将生成的值转换为十六进制字符串，为构建提供唯一标识符。 build_id每次 MySQL 启动时都会写入服务器日志。 如果您从源代码构建 MySQL，您可以观察到每次重新编译服务器时该值都会发生变化。有关详细信息，请参阅 第 2.9 节，“从源代码安装 MySQL”。 此变量在 Linux 以外的平台上不受支持。
- 从 MySQL 8.0.30 开始不推荐使用innodb_log_files_in_group 和innodb_log_file_size 变量。这些变量被变量取代 innodb_redo_log_capacity 。有关详细信息，请参阅 第 15.6.5 节，“重做日志”。
- 从 MySQL 8.0.31 开始，不推荐使用“ FULL ”作为不带引号的标识符，因为它是 SQL 标准中的保留关键字。这意味着诸如CREATE TABLE full (c1 INT, c2 INT)now 之类的语句会引发警告 ( ER_WARN_DEPRECATED_TO_BE_REMOVED_IDENT_FULL)。为防止这种情况发生，请更改名称，或者如此处所示，将其括在反引号 ( `) 中： ```sql CREATE TABLE `full` (c1 INT, c2 INT); ``` 有关详细信息，请参阅第 9.3 节，“关键字和保留字”。

### MySQL 8.0 中删除的功能

        以下项目已过时，已在 MySQL 8.0 中删除。在显示备选方案的地方，应更新应用程序以使用它们。

        对于使用 MySQL 8.0 中删除的功能的 MySQL 5.7 应用程序，从 MySQL 5.7 源复制到 MySQL 8.0 副本时，语句可能会失败，或者可能对源和副本产生不同的影响。为避免此类问题，应修改使用 MySQL 8.0 中删除的功能的应用程序以避免它们并尽可能使用替代方案。

- 系统innodb_locks_unsafe_for_binlog变量已删除。READ COMMITTED隔离级别提供类似 的功能。
- 该变量在 MySQL 8.0.0 中引入， 在 MySQL 8.0.3 中 information_schema_stats被删除并替换为 。information_schema_stats_expiry information_schema_stats_expiryINFORMATION_SCHEMA定义缓存表统计信息的过期设置 。有关详细信息，请参阅 第 8.2.3 节，“优化 INFORMATION_SCHEMA 查询”。
- InnoDBMySQL 8.0.3 中删除了 与过时系统表相关的代码。INFORMATION_SCHEMA基于InnoDB系统表的视图被数据字典表的内部系统视图所取代。受影响 InnoDB INFORMATION_SCHEMA的视图已重命名： 表 1.1 重命名的 InnoDB 信息模式视图 旧名称 新名字 INNODB_SYS_COLUMNS INNODB_COLUMNS INNODB_SYS_DATAFILES INNODB_DATAFILES INNODB_SYS_FIELDS INNODB_FIELDS INNODB_SYS_FOREIGN INNODB_FOREIGN INNODB_SYS_FOREIGN_COLS INNODB_FOREIGN_COLS INNODB_SYS_INDEXES INNODB_INDEXES INNODB_SYS_TABLES INNODB_TABLES INNODB_SYS_TABLESPACES INNODB_TABLESPACES INNODB_SYS_TABLESTATS INNODB_TABLESTATS INNODB_SYS_VIRTUAL INNODB_VIRTUAL 升级到 MySQL 8.0.3 或更高版本后，更新任何引用以前InnoDB INFORMATION_SCHEMA视图名称的脚本。
- 删除了以下与帐户管理相关的功能： 用于GRANT创建用户。相反，使用CREATE USER. Following this practice makes the NO_AUTO_CREATE_USERSQL mode immaterial for GRANT statements, so it too is removed, and an error now is written to the server log when the presence of this value for the sql_modeoption in the options file prevents mysqld from starting.
- 用于GRANT修改权限分配以外的帐户属性。这包括身份验证、SSL 和资源限制属性。相反，在创建帐户时使用 建立此类属性CREATE USER或之后使用 修改它们 ALTER USER。
- IDENTIFIED BY PASSWORD 'auth_string'CREATE USER 和GRANT的 语法 相反，使用 for 和 ，其中 值的格式与命名插件兼容。 IDENTIFIED WITH auth_plugin AS 'auth_string'CREATE USERALTER USER'auth_string' 此外，由于IDENTIFIED BY PASSWORD删除了语法，因此 log_builtin_as_identified_by_password 系统变量是多余的并已删除。
- PASSWORD()功能 。此外，PASSWORD()删除意味着 语法不再可用。 SET PASSWORD ... = PASSWORD('auth_string')
- 系统old_passwords变量。

- 查询缓存已删除。移除包括以下项目： 和FLUSH QUERY CACHE语句 RESET QUERY CACHE。
- 这些系统变量： query_cache_limit, query_cache_min_res_unit, query_cache_size, query_cache_type, query_cache_wlock_invalidate。
- 这些状态变量： Qcache_free_blocks, Qcache_free_memory, Qcache_hits, Qcache_inserts, Qcache_lowmem_prunes, Qcache_not_cached, Qcache_queries_in_cache, Qcache_total_blocks。
- 这些线程状态：checking privileges on cached query, checking query cache for query, invalidating query cache entries, sending cached result to client, storing result in query cache, Waiting for query cache lock。
- SQL_CACHE SELECT修饰符 。

            这些已弃用的查询缓存项仍然被弃用，但没有任何效果；希望它们在未来的 MySQL 版本中被删除：

- SQL_NO_CACHE SELECT修饰符 。
- 系统ndb_cache_check_time变量。

            系统`have_query_cache`变量仍然被弃用，并且始终具有值
            `NO`；希望在未来的 MySQL 版本中将其删除。

- 数据字典提供有关数据库对象的信息，因此服务器不再检查数据目录中的目录名称来查找数据库。因此， --ignore-db-dir选项和 ignore_db_dirs系统变量是无关的并被删除。
- DDL 日志，也称为元数据日志，已被删除。从 MySQL 8.0.3 开始，此功能由数据字典 innodb_ddl_log表处理。请参阅 查看 DDL 日志。
- 和系统变量已被删除tx_isolation。 tx_read_only使用transaction_isolationand transaction_read_only代替。
- 系统sync_frm变量已被删除，因为.frm文件已过时。
- 系统secure_auth变量和 --secure-auth客户端选项已被删除。删除了 C API 函数 的MYSQL_SECURE_AUTH选项。mysql_options()
- 系统multi_range_count变量被删除。
- 系统log_warnings变量和 --log-warnings服务器选项已被删除。请改用 log_error_verbosity系统变量。
- sql_log_bin删除 了系统变量的全局范围 。sql_log_bin只有会话范围，依赖访问的应用程序 @@GLOBAL.sql_log_bin应该调整。
- 和系统变量被删除 metadata_locks_cache_size。 metadata_locks_hash_instances
- 未使用date_format的 、 datetime_format、 time_format和 max_tmp_tables系统变量将被删除。
- 这些已弃用 的 兼容性 SQL 模式已 被删除 ： DB2、、、、、、、、、、、、。它们不能再分配给系统变量或用作 mysqldump选项的允许值。 MAXDBMSSQLMYSQL323MYSQL40ORACLEPOSTGRESQLNO_FIELD_OPTIONSNO_KEY_OPTIONSNO_TABLE_OPTIONSsql_mode --compatible 删除MAXDB意味着 or 的TIMESTAMP数据类型 被视为 ，并且不再被视为。 CREATE TABLEALTER TABLETIMESTAMPDATETIME
- 删除了不推荐使用的子句ASC或 DESC限定符。GROUP BY以前依赖于GROUP BY排序的查询可能会产生与以前的 MySQL 版本不同的结果。要生成给定的排序顺序，请提供一个ORDER BY 子句。
- 该语句的EXTENDED和 PARTITIONS关键字 已被删除。EXPLAIN这些关键字是不必要的，因为它们的效果始终处于启用状态。
- 这些与加密相关的项目已被删除： 和ENCODE()功能 DECODE()。
- ENCRYPT()功能 。
- 和函数、 DES_ENCRYPT()选项 、 系统变量、 语句选项和 CMake 选项 。 DES_DECRYPT()--des-key-filehave_cryptDES_KEY_FILEFLUSHHAVE_CRYPT

            代替删除的加密函数：对于
            `ENCRYPT()`，考虑使用
            `SHA2()`instead for one-way hashing。对于其他人，请考虑使用
            `AES_ENCRYPT()`and
            `AES_DECRYPT()`代替。

- 在 MySQL 5.7 中，多个名称下可用的几个空间函数已被弃用，以朝着使空间函数命名空间更加一致的方向移动，目标是每个空间函数名称ST_如果执行精确操作则以开头，或者MBR如果它执行一个基于最小边界矩形的操作。在 MySQL 8.0 中，已弃用的函数被移除，只留下对应的ST_和 MBR函数： 这些功能已被删除，取而代之的是 MBR名称： Contains(), Disjoint(), Equals(), Intersects(), Overlaps(), Within()。
- 删除了这些函数，取而代之的是 名称 ST_：Area(), AsBinary(), AsText(), AsWKB(), AsWKT(), Buffer(), Centroid(), ConvexHull(), Crosses(), Dimension(), Distance(), EndPoint(), Envelope(), ExteriorRing(), GeomCollFromText(), GeomCollFromWKB(), GeomFromText(), GeomFromWKB(), GeometryCollectionFromText(), GeometryCollectionFromWKB(), GeometryFromText(), GeometryFromWKB(), GeometryN(), GeometryType(), InteriorRingN()IsClosed(),,,,,,,,,,,,,,,,,,,,,,,,,,,,,, IsEmpty()_ IsSimple()_ LineFromText()_ LineFromWKB()_ LineStringFromText()_ LineStringFromWKB()_ MLineFromText()_ MLineFromWKB()_ MPointFromText()_ MPointFromWKB()_ MPolyFromText()_ MPolyFromWKB()_ MultiLineStringFromText()_ MultiLineStringFromWKB()_ MultiPointFromText()_ MultiPointFromWKB()_ MultiPolygonFromText()_ MultiPolygonFromWKB()_ NumGeometries()_ NumInteriorRings()_ NumPoints()_ PointFromText()_ PointFromWKB()_ PointN()_ PolyFromText()_ PolyFromWKB()_ PolygonFromText(),,,,,, . PolygonFromWKB()_ SRID()_ StartPoint()_ Touches()_ X()_ Y()
- GLength()被删除以支持 ST_Length().

- 第 12.17.4 节“从 WKB 值创建几何值 的函数”中描述的 函数以前接受 WKB 字符串或几何参数。不再允许几何参数并产生错误。有关将查询从使用几何参数迁移出去的指南，请参阅该部分。
- 解析器不再将SQL 语句\N视为同义词NULL。改用 NULL。 此更改不会影响使用 或 执行的文本文件导入或导出操作LOAD DATA， SELECT ... INTO OUTFILE因为它们NULL 继续由 表示\N。请参阅 第 13.2.7 节，“加载数据语句”。
- PROCEDURE ANALYSE()语法被删除。
- 客户端--ssl和 --ssl-verify-server-cert选项已被删除。使用 --ssl-mode=REQUIRED代替--ssl=1或 --enable-ssl。使用 --ssl-mode=DISABLED代替--ssl=0, --skip-ssl, 或 --disable-ssl。使用 --ssl-mode=VERIFY_IDENTITY 而不是--ssl-verify-server-cert 选项。（服务器端 --ssl选项仍然可用，但从 MySQL 8.0.26 开始已弃用，并可能在未来的 MySQL 版本中删除。） 对于 C API，MYSQL_OPT_SSL_ENFORCE和 MYSQL_OPT_SSL_VERIFY_SERVER_CERT选项mysql_options() 对应于客户端--ssl和 --ssl-verify-server-cert选项并被删除。MYSQL_OPT_SSL_MODE与选项值SSL_MODE_REQUIREDor 一起使用SSL_MODE_VERIFY_IDENTITY。
- 服务器选项已--temp-pool删除。
- 系统ignore_builtin_innodb变量被删除。
- 服务器不再将包含特殊字符的 MySQL 5.1 之前的数据库名称转换为带有#mysql50#前缀的 5.1 格式。因为不再执行这些转换，所以 删除了mysqlcheck--fix-db-names的和 --fix-table-names选项、 语句的子句 和状态变量。 UPGRADE DATA DIRECTORY NAMEALTER DATABASECom_alter_db_upgrade 仅支持从一个主要版本升级到另一个主要版本（例如，5.0 到 5.1，或 5.1 到 5.5），因此几乎不需要将旧的 5.0 数据库名称转换为当前版本的 MySQL。解决方法是先将 MySQL 5.0 安装升级到 MySQL 5.1，然后再升级到更新的版本。
- mysql_install_db程序已从 MySQL 发行版中删除 。应该通过 使用 或 选项调用mysqld来执行数据目录初始化。此外，删除了mysql_install_db使用的 mysqld 选项，并删除 了控制mysql_install_db 安装位置的 选项。 --initialize--initialize-insecure--bootstrapINSTALL_SCRIPTDIR CMake
- 通用分区处理程序已从 MySQL 服务器中删除。为了支持给定表的分区，用于表的存储引擎现在必须提供自己的（“本机”）分区处理程序。和 选项已从 MySQL 服务器中删除--partition， --skip-partition与分区相关的条目不再显示在输出SHOW PLUGINS或 INFORMATION_SCHEMA.PLUGINS 表中。 目前有两个 MySQL 存储引擎提供本机分区支持：InnoDB 和NDB. 其中，只有 InnoDBMySQL 8.0 支持。任何使用任何其他存储引擎在 MySQL 8.0 中创建分区表的尝试都会失败。 升级的后果。 不支持使用非InnoDB（如 MyISAM）存储引擎的分区表从MySQL 5.7（或更早版本）直接升级到MySQL 8.0。处理这样的表有两种选择： 删除表的分区，使用 ALTER TABLE ... REMOVE PARTITIONING.
- 将用于表的存储引擎更改为 InnoDB, with ALTER TABLE ... ENGINE=INNODB。

`InnoDB`
            在将服务器升级到 MySQL 8.0 之前，
            必须对每个分区的非表执行刚刚列出的两个操作中的至少一个。否则，升级后无法使用此类表。

            由于使用不支持分区的存储引擎导致分区表的表创建语句现在失败并出现错误 ( ER_CHECK_NOT_IMPLEMENTED )，因此您必须确保转储文件中的任何语句（例如**mysqldump**编写的语句）从您希望导入创建分区表的 MySQL 8.0 服务器的旧版本 MySQL 也不要指定存储引擎，例如
            `MyISAM`没有本机分区处理程序的存储引擎。您可以通过执行以下任一操作来执行此操作：

- 从使用除 以外CREATE TABLE的选项值的语句中 删除对分区的任何引用 。 STORAGE ENGINEInnoDB
- 指定存储引擎为 InnoDB，或者 InnoDB默认允许作为表的存储引擎。

            有关详细信息，请参阅
            第 24.6.2 节，“与存储引擎相关的分区限制”。

- 系统和状态变量信息不再在INFORMATION_SCHEMA. 这些表已删除： GLOBAL_VARIABLES, SESSION_VARIABLES, GLOBAL_STATUS, SESSION_STATUS。请改用相应的性能模式表。请参阅 第 27.12.14 节，“性能模式系统变量表”和 第 27.12.15 节，“性能模式状态变量表”。此外，show_compatibility_56 删除了系统变量。它被用在过渡时期，在此期间，系统和状态变量信息在INFORMATION_SCHEMA表已移至性能模式表，不再需要。这些状态变量被删除： Slave_heartbeat_period, Slave_last_heartbeat, Slave_received_heartbeats, Slave_retried_transactions, Slave_running。他们提供的信息在 Performance Schema 表中可用；请参阅 迁移到性能模式系统和状态变量表。
- Performance Schemasetup_timers表已删除，表中的TICK行 也已删除performance_timers。
- 嵌入式服务器库libmysqld被删除，连同： 、 、 和 选项 _mysql_options() MYSQL_OPT_GUESS_CONNECTIONMYSQL_OPT_USE_EMBEDDED_CONNECTIONMYSQL_OPT_USE_REMOTE_CONNECTIONMYSQL_SET_CLIENT_IP
- mysql_config --libmysqld-libs、 --embedded-libs和 --embedded选项 _
- CMake WITH_EMBEDDED_SERVER、 WITH_EMBEDDED_SHARED_LIBRARY和 INSTALL_SECURE_FILE_PRIV_EMBEDDEDDIR 选项 _
- （未记录的）mysql --server-arg选项
- mysqltest --embedded-server、 --server-arg和 --server-file选项 _
- mysqltest_embedded和mysql_client_test_embedded 测试程序

- 删除了mysql_plugin实用程序。备选方案包括在服务器启动时使用--plugin-loador --plugin-load-add选项加载插件，或在运行时使用INSTALL PLUGIN语句加载插件。
- resolveip实用程序已删除。 可以改用 nslookup、host或 dig 。
- resolve_stack_dump实用程序 已删除。来自官方 MySQL 构建的堆栈跟踪始终是符号化的，因此无需使用 resolve_stack_dump。
- 以下服务器错误代码未使用并已被删除。应更新专门针对这些错误中的任何一个进行测试的应用程序。 ```text ER_BINLOG_READ_EVENT_CHECKSUM_FAILURE ER_BINLOG_ROW_RBR_TO_SBR ER_BINLOG_ROW_WRONG_TABLE_DEF ER_CANT_ACTIVATE_LOG ER_CANT_CHANGE_GTID_NEXT_IN_TRANSACTION ER_CANT_CREATE_FEDERATED_TABLE ER_CANT_CREATE_SROUTINE ER_CANT_DELETE_FILE ER_CANT_GET_WD ER_CANT_SET_GTID_PURGED_WHEN_GTID_MODE_IS_OFF ER_CANT_SET_WD ER_CANT_WRITE_LOCK_LOG_TABLE ER_CREATE_DB_WITH_READ_LOCK ER_CYCLIC_REFERENCE ER_DB_DROP_DELETE ER_DELAYED_NOT_SUPPORTED ER_DIFF_GROUPS_PROC ER_DISK_FULL ER_DROP_DB_WITH_READ_LOCK ER_DROP_USER ER_DUMP_NOT_IMPLEMENTED ER_ERROR_DURING_CHECKPOINT ER_ERROR_ON_CLOSE ER_EVENTS_DB_ERROR ER_EVENT_CANNOT_DELETE ER_EVENT_CANT_ALTER ER_EVENT_COMPILE_ERROR ER_EVENT_DATA_TOO_LONG ER_EVENT_DROP_FAILED ER_EVENT_MODIFY_QUEUE_ERROR ER_EVENT_NEITHER_M_EXPR_NOR_M_AT ER_EVENT_OPEN_TABLE_FAILED ER_EVENT_STORE_FAILED ER_EXEC_STMT_WITH_OPEN_CURSOR ER_FAILED_ROUTINE_BREAK_BINLOG ER_FLUSH_MASTER_BINLOG_CLOSED ER_FORM_NOT_FOUND ER_FOUND_GTID_EVENT_WHEN_GTID_MODE_IS_OFF__UNUSED ER_FRM_UNKNOWN_TYPE ER_GOT_SIGNAL ER_GRANT_PLUGIN_USER_EXISTS ER_GTID_MODE_REQUIRES_BINLOG ER_GTID_NEXT_IS_NOT_IN_GTID_NEXT_LIST ER_HASHCHK ER_INDEX_REBUILD ER_INNODB_NO_FT_USES_PARSER ER_LIST_OF_FIELDS_ONLY_IN_HASH_ERROR ER_LOAD_DATA_INVALID_COLUMN_UNUSED ER_LOGGING_PROHIBIT_CHANGING_OF ER_MALFORMED_DEFINER ER_MASTER_KEY_ROTATION_ERROR_BY_SE ER_NDB_CANT_SWITCH_BINLOG_FORMAT ER_NEVER_USED ER_NISAMCHK ER_NO_CONST_EXPR_IN_RANGE_OR_LIST_ERROR ER_NO_FILE_MAPPING ER_NO_GROUP_FOR_PROC ER_NO_RAID_COMPILED ER_NO_SUCH_KEY_VALUE ER_NO_SUCH_PARTITION__UNUSED ER_OBSOLETE_CANNOT_LOAD_FROM_TABLE ER_OBSOLETE_COL_COUNT_DOESNT_MATCH_CORRUPTED ER_ORDER_WITH_PROC ER_PARTITION_SUBPARTITION_ERROR ER_PARTITION_SUBPART_MIX_ERROR ER_PART_STATE_ERROR ER_PASSWD_LENGTH ER_QUERY_ON_MASTER ER_RBR_NOT_AVAILABLE ER_SKIPPING_LOGGED_TRANSACTION ER_SLAVE_CHANNEL_DELETE ER_SLAVE_MULTIPLE_CHANNELS_HOST_PORT ER_SLAVE_MUST_STOP ER_SLAVE_WAS_NOT_RUNNING ER_SLAVE_WAS_RUNNING ER_SP_GOTO_IN_HNDLR ER_SP_PROC_TABLE_CORRUPT ER_SQL_MODE_NO_EFFECT ER_SR_INVALID_CREATION_CTX ER_TABLE_NEEDS_UPG_PART ER_TOO_MUCH_AUTO_TIMESTAMP_COLS ER_UNEXPECTED_EOF ER_UNION_TABLES_IN_DIFFERENT_DIR ER_UNSUPPORTED_BY_REPLICATION_THREAD ER_UNUSED1 ER_UNUSED2 ER_UNUSED3 ER_UNUSED4 ER_UNUSED5 ER_UNUSED6 ER_VIEW_SELECT_DERIVED_UNUSED ER_WRONG_MAGIC ER_WSAS_FAILED ```
- 已弃用的INFORMATION_SCHEMA INNODB_LOCKS和 INNODB_LOCK_WAITS表已删除。请改用性能模式 data_locks和 data_lock_waits表。 笔记 在 MySQL 5.7 中，LOCK_TABLE表INNODB_LOCKS中的 locked_table列以及 sys模式 innodb_lock_waits和 x$innodb_lock_waits视图中的列包含组合的模式/表名称值。在 MySQL 8.0 中，data_locks表和 sys模式视图包含单独的模式名称和表名称列。请参阅 第 28.4.3.9 节，“innodb_lock_waits 和 x$innodb_lock_waits 视图”。
- InnoDB不再支持压缩的临时表。启用时 innodb_strict_mode（默认值）， 如果指定或 则CREATE TEMPORARY TABLE返回错误 。如果 禁用，则会发出警告并使用非压缩行格式创建临时表。 ROW_FORMAT=COMPRESSEDKEY_BLOCK_SIZEinnodb_strict_mode
- InnoDB在 MySQL 数据目录之外创建表空间数据文件时不再创建 .isl文件（InnoDB 符号链接文件）。该 innodb_directories选项现在支持定位在数据目录之外创建的表空间文件。 .isl通过此更改，不再支持 在服务器离线时通过手动修改文件来移动远程表空间 。innodb_directories该选项现在支持移动远程表空间文件 。请参阅第 15.6.3.6 节，“在服务器离线时移动表空间文件”。
- 删除了以下InnoDB文件格式变量： innodb_file_format
- innodb_file_format_check
- innodb_file_format_max
- innodb_large_prefix

            文件格式变量对于创建与
            `InnoDB`MySQL 5.1 早期版本兼容的表是必需的。现在 MySQL 5.1 已经到达其产品生命周期的末尾，不再需要这些选项。

            该`FILE_FORMAT`列已从`INNODB_TABLES`和
            `INNODB_TABLESPACES`信息架构表中删除。

- innodb_support_xa删除了支持 XA 事务中的两阶段提交 的系统变量。InnoDB始终启用 XA 事务中对两阶段提交的支持。
- 删除了对 DTrace 的支持。
- 该JSON_APPEND()功能已被删除。改用JSON_ARRAY_APPEND() 。
- InnoDB在 MySQL 8.0.13 中删除了 对将表分区放置在共享 表空间中的支持。共享表空间包括 InnoDB系统表空间和通用表空间。有关识别共享表空间中的分区并将它们移动到 file-per-table 表空间的信息，请参阅第 2.11.5 节，“准备安装以进行升级”。
- 支持 SET 在 MySQL 8.0.13 中弃用以外的语句中设置用户变量。此功能在 MySQL 9.0 中可能会被删除。
- 删除 了--ndb perror选项。请改用ndb_perror实用程序。
- 变量已innodb_undo_logs删除。这些 innodb_rollback_segments 变量执行相同的功能，应该改为使用。
- 状态变量已Innodb_available_undo_logs删除。每个表空间的可用回滚段数可以使用SHOW VARIABLES LIKE 'innodb_rollback_segments';
- 从 MySQL 8.0.14 开始，以前弃用的 innodb_undo_tablespaces 变量不再可配置。有关详细信息，请参阅第 15.6.3.4 节，“撤消表空间”。
- 对该ALTER TABLE ... UPGRADE PARTITIONING声明的支持已被删除。
- 从 MySQL 8.0.16 开始，对 internal_tmp_disk_storage_engine 系统变量的支持已被移除；磁盘上的内部临时表现在总是使用 InnoDB存储引擎。有关详细信息，请参阅 磁盘内部临时表的存储引擎。
- CMake选项未使用，已被删除 。DISABLE_SHARED
- MySQL 8.0.30的myisam_repair_threads 系统变量。

---

[← 返回 第 1 章 一般信息 索引](00-index.md) · [← 返回总索引](../00-index.md)
