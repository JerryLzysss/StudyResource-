# 第 2 章 安装和升级 MySQL · Windows 安装

> 对应 SQL：[`sql/refman/ch02-installing/05-windows-installation.sql`](../../../sql/refman/ch02-installing/05-windows-installation.sql)

---

## 2.3 在 Microsoft Windows 上安装 MySQL

重要的

      MySQL 8.0 Server 需要 Microsoft Visual C++ 2019 Redistributable Package 才能在 Windows 平台上运行。用户在安装服务器前应确保该软件包已经安装在系统上。该包可从
      [Microsoft 下载中心](http://www.microsoft.com/en-us/download/default.aspx)获得。此外，MySQL 调试二进制文件需要安装 Visual Studio 2019。

    MySQL 仅适用于 Microsoft Windows 64 位操作系统。有关支持的 Windows 平台信息，请参阅
    [https://www.mysql.com/support/supportedplatforms/database.html](https://www.mysql.com/support/supportedplatforms/database.html)。

    在 Microsoft Windows 上安装 MySQL 有不同的方法。

### MySQL 安装程序方法

    最简单和推荐的方法是下载 MySQL Installer (for Windows) 并让它安装和配置特定版本的 MySQL Server，如下所示：

- 从 下载 MySQL Installer 并执行它。 笔记 与标准的 MySQL 安装程序不同，较小的 web-community版本不捆绑任何 MySQL 应用程序，而是只下载您选择安装的 MySQL 产品。
- 确定用于 MySQL 产品初始安装的安装类型。例如： Developer Default：提供一个设置类型，包括所选版本的 MySQL Server 和其他与 MySQL 开发相关的 MySQL 工具，例如 MySQL Workbench。
- 仅服务器：提供选定版本的 MySQL Server 的设置，不包含其他产品。
- 自定义：使您能够选择任何版本的 MySQL 服务器和其他 MySQL 产品。

- 安装服务器实例（和产品），然后按照屏幕上的说明开始服务器配置。有关每个单独步骤的更多信息，请参阅 第 2.3.3.3.1 节，“使用 MySQL 安装程序配置 MySQL 服务器”。

    MySQL 现已安装。如果您将 MySQL 配置为服务，则 Windows 会在您每次重新启动系统时自动启动 MySQL 服务器。此外，此过程会在本地主机上安装 MySQL Installer 应用程序，稍后您可以使用它来升级或重新配置 MySQL 服务器。

笔记

      如果您在系统上安装了 MySQL Workbench，请考虑使用它来检查新的 MySQL 服务器连接。默认情况下，该程序会在安装 MySQL 后自动启动。

### 附加安装信息

    可以将 MySQL 作为标准应用程序或作为 Windows 服务运行。通过使用服务，您可以通过标准的 Windows 服务管理工具监视和控制服务器的运行。有关详细信息，请参阅
    第 2.3.4.8 节，“将 MySQL 作为 Windows 服务启动”。

    为了适应该`RESTART`语句，MySQL 服务器在作为服务或独立运行时进行分叉，以启用监控进程来监督服务器进程。在本例中，有两个**mysqld**进程。如果
    `RESTART`不需要功能，可以使用该
    `--no-monitor`选项启动服务器。请参阅
    第 13.7.8.8 节，“RESTART 语句”。

    通常，您应该使用具有管理员权限的帐户在 Windows 上安装 MySQL。否则，您可能会遇到某些操作的问题，例如编辑`PATH`
    环境变量或访问**服务控制管理器**。安装时，MySQL 不需要使用具有管理员权限的用户来执行。

    有关在 Windows 平台上使用 MySQL 的限制列表，请参阅第 2.3.7 节，“Windows 平台限制”。

    除了 MySQL 服务器包之外，您可能需要或想要其他组件以在您的应用程序或开发环境中使用 MySQL。这些包括但不限于：

- 要使用 ODBC 连接到 MySQL 服务器，您必须具有连接器/ODBC 驱动程序。有关更多信息，包括安装和配置说明，请参阅 MySQL 连接器/ODBC 开发人员指南。 笔记 MySQL 安装程序为您安装和配置连接器/ODBC。
- 要将 MySQL 服务器与 .NET 应用程序一起使用，您必须具有连接器/NET 驱动程序。有关更多信息，包括安装和配置说明，请参阅MySQL Connector/NET 开发人员指南。 笔记 MySQL Installer 为您安装和配置 MySQL Connector/NET。

    可以从
     Windows 的 MySQL 发行版。请参阅
    第 2.1.3 节，“如何获取 MySQL”。

    用于 Windows 的 MySQL 有多种分发格式，详见此处。一般来说，你应该使用 MySQL Installer。它包含比旧版 MSI 更多的功能和 MySQL 产品，比压缩文件更易于使用，并且您不需要额外的工具来启动和运行 MySQL。MySQL 安装程序自动安装 MySQL 服务器和其他 MySQL 产品，创建一个选项文件，启动服务器，并使您能够创建默认用户帐户。有关选择安装包的更多信息，请参阅
    第 2.3.2 节 “选择安装包”。

- MySQL Installer 发行版包括 MySQL Server 和其他 MySQL 产品，包括 MySQL Workbench 和 MySQL for Visual Studio。MySQL Installer 也可用于将来升级这些产品（请参阅  有关使用 MySQL Installer 安装 MySQL 的说明，请参阅 第 2.3.3 节，“Windows 的 MySQL 安装程序”。
- 标准二进制分发版（打包为压缩文件）包含您解压到所选位置的所有必要文件。此软件包包含完整 Windows MSI 安装程序软件包中的所有文件，但不包括安装程序。 有关使用压缩文件安装 MySQL 的说明，请参阅第 2.3.4 节，“使用 noinstallZIP 存档在 Microsoft Windows 上安装 MySQL”。
- 源分发格式包含使用 Visual Studio 编译器系统构建可执行文件的所有代码和支持文件。 有关在 Windows 上从源代码构建 MySQL 的说明，请参阅 第 2.9 节，“从源代码安装 MySQL”。

### Windows 上的 MySQL 注意事项

- 大表支持 如果您需要大小大于 4GB 的表，请在 NTFS 或更新的文件系统上安装 MySQL。不要忘记 在创建表时使用MAX_ROWSand 。AVG_ROW_LENGTH请参阅 第 13.1.20 节，“CREATE TABLE 语句”。
- MySQL 和病毒检查软件 Norton/Symantec Anti-Virus 等病毒扫描软件在包含 MySQL 数据和临时表的目录上可能会导致问题，既会影响 MySQL 的性能，也会导致病毒扫描软件将文件内容误认为包含垃圾邮件。这是由于病毒扫描软件使用的指纹识别机制，以及 MySQL 快速更新不同文件的方式，这可能被识别为潜在的安全风险。 安装 MySQL Server 后，建议您在datadir用于存储 MySQL 表数据的主目录 ( ) 上禁用病毒扫描。病毒扫描软件通常内置了一个系统，可以忽略特定的目录。 此外，默认情况下，MySQL 在标准 Windows 临时目录中创建临时文件。为防止临时文件也被扫描，为MySQL临时文件配置一个单独的临时目录，并将该目录加入病毒扫描排除列表。为此，请将 tmpdir参数的配置选项添加到您的 my.ini配置文件中。有关详细信息，请参阅第 2.3.4.2 节 “创建选项文件”。

---

[← 返回 第 2 章 安装和升级 MySQL 索引](00-index.md) · [← 返回总索引](../00-index.md)
