# 第 2 章 安装和升级 MySQL · 章首

> 对应 SQL：[`sql/refman/ch02-installing/01-installing.sql`](../../../sql/refman/ch02-installing/01-installing.sql)

---

# 第 2 章安装和升级 MySQL

    本章介绍如何获取和安装 MySQL。该过程的摘要如下，后面的部分提供了详细信息。如果您计划将现有版本的 MySQL 升级到更新版本而不是第一次安装 MySQL，请参阅
    第 2.11 节，“升级 MySQL”，了解有关升级过程和升级前应考虑的问题的信息。

    如果您有兴趣从另一个数据库系统迁移到 MySQL，请参阅第 A.8 节，“MySQL 8.0 常见问题解答：迁移”，其中包含有关迁移问题的一些常见问题的答案。

    MySQL 的安装通常遵循此处概述的步骤：

- 确定 MySQL 是否在您的平台上运行和受支持。 请注意，并非所有平台都同样适合运行 MySQL，而且并非所有已知运行 MySQL 的平台都得到 Oracle Corporation 的正式支持。有关官方支持的平台的信息，请参阅MySQL 网站上的 https://www.mysql.com/support/supportedplatforms/database.html 。
- 选择要安装的发行版。 有多个版本的 MySQL 可用，并且大多数都以多种分发格式提供。您可以从包含二进制（预编译）程序或源代码的预打包发行版中进行选择。如有疑问，请使用二进制分发。Oracle 还为那些想要查看最新开发和测试新代码的人提供了对 MySQL 源代码的访问。要确定您应该使用哪个版本和类型的发行版，请参阅第 2.1.2 节，“安装哪个 MySQL 版本和发行版”。
- 下载您要安装的发行版。 有关说明，请参阅第 2.1.3 节，“如何获取 MySQL”。要验证分发的完整性，请使用 第 2.1.4 节“使用 MD5 校验和或 GnuPG 验证包完整性”中的说明。
- 安装发行版。 要从二进制分发版安装 MySQL，请使用第 2.2 节“使用通用二进制文件在 Unix/Linux 上安装 MySQL”中的说明。或者，使用 Secure Deployment Guide，它提供了部署 MySQL Enterprise Edition Server 的通用二进制分发的过程，具有管理 MySQL 安装安全性的功能。 要从源代码分发或当前开发源代码树安装 MySQL，请使用 第 2.9 节“从源代码安装 MySQL”中的说明。
- 执行任何必要的安装后设置。 安装 MySQL 后，请参阅第 2.10 节“安装后设置和测试” 以获取有关确保 MySQL 服务器正常工作的信息。另请参阅 第 2.10.4 节“保护初始 MySQL 帐户”中提供的信息。本节介绍如何保护初始 MySQLroot用户帐户，在您分配一个密码之前，该帐户没有密码。无论您是使用二进制还是源代码分发安装 MySQL，本节都适用。
- 如果您想运行 MySQL 基准测试脚本，则必须提供对 MySQL 的 Perl 支持。请参见第 2.13 节 “Perl 安装说明”。

    在不同平台和环境中安装 MySQL 的说明可在不同平台的基础上获得：

- Unix、Linux、FreeBSD 有关使用通用二进制文件（例如， .tar.gz软件包）在大多数 Linux 和 Unix 平台上安装 MySQL 的说明，请参阅 第 2.2 节，“使用通用二进制文件在 Unix/Linux 上安装 MySQL”。 有关完全从源代码分发或源代码存储库构建 MySQL 的信息，请参阅 第 2.9 节，“从源代码安装 MySQL” 有关从源代码安装、配置和构建的特定平台帮助，请参阅相应的平台部分： Linux，包括关于分发特定方法的注释，请参阅 第 2.5 节，“在 Linux 上安装 MySQL”。
- IBM AIX，请参阅第 2.7 节，“在 Solaris 上安装 MySQL”。
- FreeBSD，请参阅第 2.8 节，“在 FreeBSD 上安装 MySQL”。

- 微软Windows 有关使用 MySQL 安装程序或压缩二进制文件在 Microsoft Windows 上安装 MySQL 的说明，请参阅 第 2.3 节，“在 Microsoft Windows 上安装 MySQL”。 有关使用 Microsoft Visual Studio 从源代码构建 MySQL 的详细信息和说明，请参阅 第 2.9 节，“从源代码安装 MySQL”。
- 苹果系统 对于 macOS 上的安装，包括使用二进制包和本机 PKG 格式，请参阅 第 2.4 节，“在 macOS 上安装 MySQL”。 有关使用 macOS 启动守护程序自动启动和停止 MySQL 的信息，请参阅 第 2.4.3 节，“安装和使用 MySQL 启动守护程序”。 有关 MySQL 首选项面板的信息，请参阅 第 2.4.4 节，“安装和使用 MySQL 首选项面板”。

---

[← 返回 第 2 章 安装和升级 MySQL 索引](00-index.md) · [← 返回总索引](../00-index.md)
