# 第 2 章 安装和升级 MySQL · 保护初始 MySQL 帐户

> 对应 SQL：[`sql/refman/ch02-installing/07-default-privileges.sql`](../../../sql/refman/ch02-installing/07-default-privileges.sql)

---

2.10.4 保护初始 MySQL 帐户_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 2 章安装和升级 MySQL / 2.3 在 Microsoft Windows 上安装 MySQL / 2.3.6 Windows 安装后程序 / 2.10.4 保护初始 MySQL 帐户 MySQL 安装过程涉及初始化数据目录，包括 mysql系统模式中定义 MySQL 帐户的授权表。有关详细信息，请参阅第 2.10.1 节，“初始化数据目录”。 本节介绍如何为 root在 MySQL 安装过程中创建的初始帐户分配密码（如果您尚未这样做）。 笔记 执行本节中描述的过程的替代方法： 在 Windows 上，您可以在使用 MySQL 安装程序安装期间执行该过程（请参阅第 2.3.3 节，“Windows 的 MySQL 安装程序”）。
- 在所有平台上，MySQL 发行版都包含 mysql_secure_installation，这是一个命令行实用程序，可自动执行大部分保护 MySQL 安装的过程。
- 在所有平台上，MySQL Workbench 都可用并提供管理用户帐户的能力（请参阅 第 31 章，MySQL Workbench）。

      在这些情况下，密码可能已经分配给初始帐户：

- 在 Windows 上，使用 MySQL Installer 执行的安装为您提供了分配密码的选项。
- 使用 macOS 安装程序进行安装会生成一个初始随机密码，安装程序会在对话框中向用户显示该密码。
- 使用 RPM 包安装会生成一个初始随机密码，该密码将写入服务器错误日志。
- 使用 Debian 软件包的安装为您提供了分配密码的选项。
- 对于使用mysqld --initialize 手动执行的数据目录初始化 ， mysqld生成一个初始随机密码，将其标记为过期，并将其写入服务器错误日志。请参阅第 2.10.1 节，“初始化数据目录”。

      授权表`mysql.user`定义了初始 MySQL 用户帐户及其访问权限。安装 MySQL 只会创建一个`'root'@'localhost'`
      超级用户帐户，该帐户具有所有权限并且可以执行任何操作。如果该`root`帐户的密码为空，则您的 MySQL 安装不受保护：任何人都可以在`root` *没有密码*的情况下连接到 MySQL 服务器并被授予所有权限。

      该帐户在表中`'root'@'localhost'`还有一行，可以为 授予权限
      ，即为所有用户和所有主机授予权限。这可以设置代理用户，以及将设置代理用户的权限委托给其他帐户。请参阅第 6.2.19 节，“代理用户”。
    `mysql.proxies_priv``PROXY``''@''``root`

      要为初始 MySQL`root`
      帐户分配密码，请使用以下过程。将
      *`root-password`*示例中的密码替换为您要使用的密码。

      如果服务器未运行，请启动它。有关说明，请参阅
      第 2.10.2 节 “启动服务器”。

      初始`root`帐户可能有也可能没有密码。选择以下任何一个适用的程序：

- 如果该root帐户的初始随机密码已过期，请root使用该密码连接到服务器，然后选择一个新密码。如果使用mysqld --initialize手动初始化数据目录，或者使用在安装操作期间不提供指定密码选项的安装程序，就会出现这种情况。因为密码存在，所以您必须使用它来连接到服务器。但是由于密码已过期，您不能将该帐户用于除选择新密码以外的任何目的，直到您选择一个新密码。 如果您不知道初始随机密码，请查看服务器错误日志。
- root使用密码 连接到服务器： ```text $> mysql -u root -p Enter password: (enter the random root password here) ```
- 选择一个新密码来替换随机密码： ```sql mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'root-password'; ```

- 如果该root帐户存在但没有密码，请root 使用无密码连接到服务器，然后分配密码。如果您使用mysqld --initialize-insecure初始化数据目录，就会出现这种情况。 root不使用密码 连接到服务器： ```text $> mysql -u root --skip-password ```
- 分配密码： ```sql mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'root-password'; ```

      为帐户分配`root`密码后，无论何时使用该帐户连接到服务器，都必须提供该密码。例如，要使用
      **mysql**客户端连接到服务器，请使用以下命令：

```text
$> mysql -u root -p
Enter password: (enter root password here)
```

**要使用mysqladmin**
      关闭服务器，请使用以下命令：

```text
$> mysqladmin -u root -p shutdown
Enter password: (enter root password here)
```

笔记

        有关设置密码的其他信息，请参阅
        第 6.2.14 节“分配帐户密码”。如果您
        `root`在设置密码后忘记了密码，请参阅
        第 B.3.3.2 节“如何重置 Root 密码”。

        要设置其他帐户，请参阅
        第 6.2.8 节“添加帐户、分配权限和删除帐户”。

---

[← 返回 第 2 章 安装和升级 MySQL 索引](00-index.md) · [← 返回总索引](../00-index.md)
