# 第 2 章 安装和升级 MySQL · 通用二进制安装

> 对应 SQL：[`sql/refman/ch02-installing/04-binary-installation.sql`](../../../sql/refman/ch02-installing/04-binary-installation.sql)

---

## 2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL

    Oracle 提供了一组 MySQL 的二进制发行版。**这些包括用于许多平台的压缩tar**文件（具有
    扩展名的文件）形式的通用二进制分发
    `.tar.xz`，以及用于选定平台的特定于平台的包格式的二进制文件。

    本节介绍
    在 Unix/Linux 平台上从压缩的**tar文件二进制分发版安装 MySQL。**有关以 MySQL 安全功能为重点的 Linux 通用二进制分发版安装说明，请参阅
    安全部署指南。对于其他特定于平台的二进制包格式，请参阅本手册中其他特定于平台的部分。例如，对于 Windows 发行版，请参阅
    第 2.3 节，“在 Microsoft Windows 上安装 MySQL”。参见
    第 2.1.3 节，“如何获取 MySQL”了解如何获取不同分发格式的 MySQL。

    MySQL 压缩的**tar**文件二进制分发具有形式的名称
    ，其中是一个数字（例如，），并
    指示分发所针对的操作系统类型（例如，
    或）。
  `mysql-VERSION`-*`OS`*.tar.xz`VERSION``8.0.31`*`OS`*`pc-linux-i686``winx64`

    还有一个用于 Linux 通用二进制分发
    版的 MySQL 压缩**tar**文件的“最小安装”版本，其名称形式为. 最小安装分发版不包括调试二进制文件并去除了调试符号，使其比常规二进制分发版小得多。如果您选择安装最小安装发行版，请记住在随后的说明中针对文件名格式的差异进行调整。
****`mysql-VERSION`-*`OS`*-*`GLIBCVER`*-*`ARCH`*-minimal.tar.xz

警告

- 如果您之前使用操作系统本机包管理系统（例如 Yum 或 APT）安装了 MySQL，则使用本机二进制文件安装时可能会遇到问题。确保您之前安装的 MySQL 已完全删除（使用您的包管理系统），并且任何其他文件（例如数据文件的旧版本）也已删除。您还应该检查配置文件（例如/etc/my.cnf 或/etc/mysql目录）并删除它们。 有关将第三方包替换为官方 MySQL 包的信息，请参阅相关的 APT 指南或Yum 指南。
- MySQL 依赖于该libaio 库。如果未在本地安装此库，则数据目录初始化和后续服务器启动步骤将失败。如有必要，请使用适当的包管理器安装它。例如，在基于 Yum 的系统上： ```text $> yum search libaio # search for info $> yum install libaio # install library ``` 或者，在基于 APT 的系统上： ```text $> apt-cache search libaio # search for info $> apt-get install libaio1 # install library ```
- Oracle Linux 8 / Red Hat 8 (EL8)：这些平台默认不安装 /lib64/libtinfo.so.5MySQL 客户端bin/mysql包 mysql-VERSION-el7-x86_64.tar.gz和 mysql-VERSION-linux-glibc2.12-x86_64.tar.xz. 要解决此问题，请安装 ncurses-compat-libs软件包： ```text $> yum install ncurses-compat-libs ```

    要安装压缩的**tar**文件二进制分发版，请在您选择的安装位置（通常是`/usr/local/mysql`）将其解压缩。这将创建下表中显示的目录。

**表 2.3 通用 Unix/Linux 二进制包的 MySQL 安装布局**

| 目录 | 目录内容 |
| --- | --- |
| bin | mysqld服务器、客户端和实用程序 |
| docs | Info 格式的 MySQL 手册 |
| man | Unix 手册页 |
| include | 包含（头）文件 |
| lib | 图书馆 |
| share | 数据库安装的错误信息、字典和 SQL |
| support-files | 杂项支持文件 |

**mysqld**二进制文件的
    调试版本可作为**mysqld-debug**获得。要从源代码分发编译您自己的 MySQL 调试版本，请使用适当的配置选项来启用调试支持。参见
    第 2.9 节，“从源代码安装 MySQL”。

    要安装和使用 MySQL 二进制发行版，命令序列如下所示：

```text
$> groupadd mysql
$> useradd -r -g mysql -s /bin/false mysql
$> cd /usr/local
$> tar xvf /path/to/mysql-VERSION-OS.tar.xz
$> ln -s full-path-to-mysql-VERSION-OS mysql
$> cd mysql
$> mkdir mysql-files
$> chown mysql:mysql mysql-files
$> chmod 750 mysql-files
$> bin/mysqld --initialize --user=mysql
$> bin/mysql_ssl_rsa_setup
$> bin/mysqld_safe --user=mysql &
# Next command is optional
$> cp support-files/mysql.server /etc/init.d/mysql.server
```

笔记

      此过程假定您对`root`
      系统具有（管理员）访问权限。**或者，您可以使用sudo** (Linux) 或
      **pfexec** (Solaris) 命令
为每个命令添加前缀。

    该`mysql-files`目录提供了一个方便的位置来用作
    `secure_file_priv`系统变量的值，这将导入和导出操作限制在特定目录中。请参阅
    第 5.1.8 节，“服务器系统变量”。

    前面关于安装二进制分发版的描述的更详细版本如下。

### 创建 mysql 用户和组

    如果您的系统还没有用于运行**mysqld**的用户和组，您可能需要创建它们。以下命令添加`mysql`组和
    `mysql`用户。您可能想要调用用户并分组其他内容而不是`mysql`. 如果是这样，请在以下说明中替换为适当的名称。**useradd**和
    **groupadd**的语法在不同版本的 Unix/Linux 上可能略有不同，或者它们可能具有不同的名称，例如
    **adduser**和**addgroup**。

```text
$> groupadd mysql
$> useradd -r -g mysql -s /bin/false mysql
```

笔记

      因为用户仅出于所有权目的而不是登录目的需要，所以**useradd**命令使用
      `-r`和`-s /bin/false`选项来创建一个用户，该用户对您的服务器主机没有登录权限。**如果您的useradd**不支持
这些选项，请忽略它们。

### 获取并解压分发

    选择要将分发包解压到的目录，并将位置更改为该目录。此处的示例将分发包解压到`/usr/local`. 因此，这些说明假定您有权在`/usr/local`. 如果该目录受保护，则必须以
    `root`.

```text
$> cd /usr/local
```

使用第 2.1.3 节“如何获取 MySQL”
    中的说明获取分发文件
    。对于给定的版本，所有平台的二进制发行版都是从相同的 MySQL 源发行版构建的。

    解压分发，创建安装目录。
    如果有选项支持
  ， **tar可以解压和解压发行版：**`z`

```text
$> tar xvf /path/to/mysql-VERSION-OS.tar.xz
```

**tar**命令创建
    一个名为
    .
  `mysql-VERSION`-*`OS`*

    要从压缩的**tar**文件二进制发行版安装 MySQL，您的系统必须有 GNU`XZ Utils`来解压发行版和合理的
    **tar**来解压它。

笔记

      MySQL Server 8.0.12压缩算法由Gzip改为XZ；并且通用二进制文件的文件扩展名从 .tar.gz 更改为 .tar.xz。

    GNU **tar**是众所周知的工作。一些操作系统提供的标准
    **tar**无法解压 MySQL 发行版中的长文件名。您应该下载并安装 GNU **tar**，或者如果可用，使用 GNU tar 的预安装版本。通常这在 GNU 或自由软件目录中以**gnutar**、**gtar**或**tar**的形式提供，例如`/usr/sfw/bin`或
    `/usr/local/bin`。GNU **tar**可从[http://www.gnu.org/software/tar/](http://www.gnu.org/software/tar/)获得。

    如果您的**tar**不支持该
    `xz`格式，则使用**xz**
    命令解压发行版并使用**tar**解压它。将前面的**tar**命令替换为以下替代命令以解压缩和提取分发：

```text
$> xz -dc /path/to/mysql-VERSION-OS.tar.xz | tar x
```

    接下来，创建指向由**tar**创建的安装目录的符号链接：

```text
$> ln -s full-path-to-mysql-VERSION-OS mysql
```

    该`ln`命令创建一个指向安装目录的符号链接。这使您可以更轻松地将其称为`/usr/local/mysql`. 为了避免在使用 MySQL 时总是必须键入客户端程序的路径名，可以将`/usr/local/mysql/bin`
    目录添加到`PATH`变量中：

```text
$> export PATH=$PATH:/usr/local/mysql/bin
```

### 执行安装后设置

    安装过程的其余部分包括设置分发所有权和访问权限、初始化数据目录、启动 MySQL 服务器以及设置配置文件。有关说明，请参阅
    第 2.10 节 “安装后设置和测试”。

---

[← 返回 第 2 章 安装和升级 MySQL 索引](00-index.md) · [← 返回总索引](../00-index.md)
