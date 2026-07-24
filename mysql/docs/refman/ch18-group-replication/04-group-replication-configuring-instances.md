# 第 18 章 组复制 · 配置实例

> 对应 SQL：[`sql/refman/ch18-group-replication/04-group-replication-configuring-instances.sql`](../../../sql/refman/ch18-group-replication/04-group-replication-configuring-instances.sql)

---

18.2.1.2 配置组复制实例_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第十八章 组复制 / 18.2 开始 / 18.2.1 在单主模式下部署组复制 / 18.2.1.2 配置组复制实例 本节介绍要用于组复制的 MySQL 服务器实例所需的配置设置。有关背景信息，请参阅 第 18.3 节“要求和限制”。 存储引擎
- 复制框架
- 组复制设置

存储引擎

          对于组复制，数据必须存储在 InnoDB 事务存储引擎中（有关原因的详细信息，请参阅
          第 18.3.1 节，“组复制要求”）。使用其他存储引擎，包括临时
          `MEMORY`存储引擎，可能会导致组复制错误。如下设置
          `disabled_storage_engines`
          系统变量以防止使用它们：

```text
disabled_storage_engines="MyISAM,BLACKHOLE,FEDERATED,ARCHIVE,MEMORY"
```

          请注意，在`MyISAM`禁用存储引擎的情况下，当您将 MySQL 实例升级到仍使用**mysql_upgrade**的版本（MySQL 8.0.16 之前）时，**mysql_upgrade**可能会失败并出现错误。要处理这个问题，您可以在运行**mysql_upgrade**时重新启用该存储引擎，然后在重新启动服务器时再次禁用它。有关详细信息，请参阅第 4.4.5 节，“mysql_upgrade — 检查和升级 MySQL 表”。

复制框架

          以下设置根据 MySQL 组复制要求配置复制。

```text
server_id=1
gtid_mode=ON
enforce_gtid_consistency=ON
```

          这些设置将服务器配置为使用唯一标识符号 1，以启用
          第 17.1.3 节，“使用全局事务标识符进行复制”，并只允许执行可以使用 GTID 安全记录的语句。

          直至并包括 MySQL 8.0.20，还需要以下设置：

```text
binlog_checksum=NONE
```

          此设置禁用写入二进制日志的事件的校验和，默认为启用。从 MySQL 8.0.21 开始，Group Replication 支持在二进制日志中存在校验和，并且可以使用它们来验证某些通道上事件的完整性，因此您可以使用默认设置。有关详细信息，请参阅第 18.3.2 节，“组复制限制”。

          如果您使用的 MySQL 版本早于 8.0.3，其中复制的默认设置得到了改进，您还需要将这些行添加到成员的选项文件中。如果您在更高版本的选项文件中有这些系统变量中的任何一个，请确保按所示设置它们。有关详细信息，请参阅第 18.3.1 节，“组复制要求”。

```text
log_bin=binlog
log_slave_updates=ON
binlog_format=ROW
master_info_repository=TABLE
relay_log_info_repository=TABLE
transaction_write_set_extraction=XXHASH64
```

组复制设置

          此时，选项文件确保服务器已配置并被指示在给定配置下实例化复制基础结构。以下部分配置服务器的组复制设置。

```text
plugin_load_add='group_replication.so'
group_replication_group_name="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
group_replication_start_on_boot=off
group_replication_local_address= "s1:33061"
group_replication_group_seeds= "s1:33061,s2:33061,s3:33061"
group_replication_bootstrap_group=off
```

- plugin-load-add将 Group Replication 插件添加到服务器在启动时加载的插件列表中。这在生产部署中比手动安装插件更可取。
- 配置 group_replication_group_name 告诉插件它正在加入或创建的组名为“aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa”。 的值 group_replication_group_name 必须是有效的 UUID。你可以SELECT UUID()用来生成一个。此 UUID 构成 GTID 的一部分，当组成员从客户端接收到的事务以及组成员内部生成的视图更改事件被写入二进制日志时使用。
- 配置 group_replication_start_on_boot 变量以off指示插件在服务器启动时不自动启动操作。这在设置组复制时很重要，因为它确保您可以在手动启动插件之前配置服务器。配置成员后，您可以设置 group_replication_start_on_boot 为on在服务器启动时自动启动组复制。
- 配置 group_replication_local_address 设置成员用于与组中其他成员进行内部通信的网络地址和端口。Group Replication 使用此地址进行涉及组通信引擎远程实例（XCom，一种 Paxos 变体）的内部成员到成员连接。 重要的 组复制本地地址必须不同于用于 SQL 客户端连接的主机名和端口，它们由 MySQL 服务器 hostname和 port系统变量定义。它不得用于客户端应用程序。在运行组复制时，它必须仅用于组成员之间的内部通信。 配置的网络地址 group_replication_local_address 必须可由所有组成员解析。例如，如果每个服务器实例位于具有固定网络地址的不同机器上，您可以使用机器的 IP 地址，例如 10.0.0.1。如果使用主机名，则必须使用完全限定名称，并确保它可通过 DNS 解析，并正确配置 /etc/hosts文件或其他名称解析过程。从 MySQL 8.0.14 开始，可以使用 IPv6 地址（或解析到它们的主机名）以及 IPv4 地址。一个组可以同时包含使用 IPv6 的成员和使用 IPv4 的成员。有关 IPv6 网络和混合 IPv4 和 IPv6 组的组复制支持的更多信息，请参阅 第 18.5.5 节，“支持 IPv6 以及混合 IPv6 和 IPv4 组”。 推荐的端口 group_replication_local_address 是 33061。 group_replication_local_address 它被组复制用作复制组内组成员的唯一标识符。只要主机名或 IP 地址都不同，您就可以对复制组的所有成员使用相同的端口，如本教程中所示。或者，您可以对所有成员使用相同的主机名或 IP 地址，只要端口全部不同即可，例如第 18.2.2 节“在本地部署组复制”中所示。 现有成员为组复制的分布式恢复过程提供给加入成员的连接不是由配置的网络地址 group_replication_local_address。直到 MySQL 8.0.20，组成员提供他们的标准 SQL 客户端连接到加入成员以进行分布式恢复，如 MySQL 服务器 hostname和 port系统变量所指定。从 MySQL 8.0.21 开始，组成员可以将分布式恢复端点的替代列表作为加入成员的专用客户端连接。有关更多详细信息，请参阅 第 18.5.4.1 节，“分布式恢复的连接”。 重要的 如果加入成员无法使用 MySQL 服务器 hostname系统变量定义的主机名正确识别其他成员，则分布式恢复可能会失败。建议运行 MySQL 的操作系统使用 DNS 或本地设置正确配置唯一的主机名。Member_host可以在 Performance Schema 表的列中 验证服务器用于 SQL 客户端连接的主机名replication_group_members. 如果多个组成员将操作系统设置的默认主机名外部化，则加入成员有可能无法将其解析为正确的成员地址，并且无法连接以进行分布式恢复。在这种情况下，您可以使用 MySQL 服务器的 report_host系统变量来配置一个唯一的主机名，以供每个服务器外部化。
- 配置 group_replication_group_seeds 设置新成员用来建立与组的连接的组成员的主机名和端口。这些成员称为种子成员。建立连接后，组成员信息将列在 Performance Schema 表中 replication_group_members。通常该 group_replication_group_seeds 列表包含hostname:port每个组成员的 group_replication_local_address，但这不是强制性的，并且可以选择组成员的子集作为种子。 重要的 中hostname:port列出的 group_replication_group_seeds 是种子成员的内部网络地址，由 SQL 客户端连接配置， group_replication_local_address 而不是hostname:port用于 SQL 客户端连接，例如在 Performance Schema 表中显示 replication_group_members。 启动组的服务器不使用此选项，因为它是初始服务器，因此负责引导组。换句话说，引导组的服务器上的任何现有数据都将用作下一个加入成员的数据。第二个服务器加入要求组中唯一的成员加入，第二个服务器上的任何丢失数据都从引导成员上的捐赠者数据中复制，然后组扩展。第三个服务器加入可以要求这两个中的任意一个加入，数据同步到新成员，然后再次扩群。 警告 同时加入多个服务器时，请确保它们指向已在组中的种子成员。不要使用也加入该组的成员作为种子，因为他们在联系时可能还不在组中。 最好先启动 bootstrap 成员，然后让它创建组。然后使其成为其他加入成员的种子成员。这确保在加入其余成员时形成一个组。 不支持创建群组并同时加入多个成员。它可能会起作用，但很可能是操作竞争，然后加入组的行为以错误或超时告终。 加入成员必须使用种子成员在 group_replication_group_seeds 选项中公布的相同协议（IPv4 或 IPv6）与种子成员通信。出于组复制的 IP 地址权限的目的，种子成员的白名单必须包括种子成员提供的协议的加入成员的 IP 地址，或解析为该协议地址的主机名。除了加入成员的地址或主机名之外，还必须设置并允许此地址或主机名 group_replication_local_address 如果该地址的协议与种子成员的广告协议不匹配。如果加入成员没有适当协议的允许地址，则拒绝其连接尝试。有关详细信息，请参阅 第 18.6.4 节，“组复制 IP 地址权限”。
- 配置 group_replication_bootstrap_group 指示插件是否引导组。在这种情况下，即使 s1 是组中的第一个成员，我们也会在选项文件中将此变量设置为 off。相反，我们 group_replication_bootstrap_group 在实例运行时进行配置，以确保只有一个成员实际引导该组。 重要的 该 group_replication_bootstrap_group 变量在任何时候都只能在属于一个组的一个服务器实例上启用，通常是在您第一次引导该组时（或者在整个组关闭并再次备份的情况下）。如果您多次引导该组，例如当多个服务器实例设置了此选项时，那么它们可能会创建一个人为的裂脑场景，其中存在两个具有相同名称的不同组。始终 group_replication_bootstrap_group=off 在第一个服务器实例联机后设置。

          本教程中描述的系统变量是启动新成员所需的配置设置，但其他系统变量也可用于配置组成员。这些列在
          第 18.9 节，“组复制系统变量”中。

重要的

            许多系统变量，一些特定于组复制，另一些则不是，是组范围的配置设置，必须对所有组成员具有相同的值。如果组成员为这些系统变量之一设置了值，并且加入成员为其设置了不同的值，则加入成员无法加入组并返回错误消息。如果群成员对该系统变量设置了值，而加入的成员不支持该系统变量，则无法加入该群。这些系统变量都在
            第 18.9 节，“组复制系统变量”中标识。

---

[← 返回 第 18 章 组复制 索引](00-index.md) · [← 返回总索引](../00-index.md)
