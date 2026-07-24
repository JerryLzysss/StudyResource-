# 第 5 章 MySQL 服务器管理 · 选项文件

> 对应 SQL：[`sql/refman/ch05-server-administration/03-option-files.sql`](../../../sql/refman/ch05-server-administration/03-option-files.sql)

---

4.2.2.2 使用选项文件_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 4 章 MySQL 程序 / 4.2 使用 MySQL 程序 / 4.2.2 指定程序选项 / 4.2.2.2 使用选项文件 大多数 MySQL 程序可以从选项文件（有时称为配置文件）中读取启动选项。选项文件提供了一种指定常用选项的便捷方式，这样就无需在每次运行程序时都在命令行中输入它们。 要确定程序是否读取选项文件，请使用--help选项调用它。（对于 mysqld，使用 --verbose和 --help。）如果程序读取选项文件，帮助消息会指示它查找哪些文件以及它识别哪些选项组。 笔记 --no-defaults以该选项 启动的 MySQL 程序 不读取除.mylogin.cnf. 以禁用系统变量启动的服务器 persisted_globals_load不会读取 mysqld-auto.cnf。 许多选项文件是纯文本文件，使用任何文本编辑器创建。例外情况是： .mylogin.cnf包含登录路径选项 的文件。这是一个由mysql_config_editor实用程序创建的加密文件 。请参阅 第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。“登录路径”是一个仅允许某些选项的选项组 ：host、user、 password和。客户端程序使用该选项 指定要读取的登录路径。portsocket.mylogin.cnf--login-path 要指定备用登录路径文件名，请设置 MYSQL_TEST_LOGIN_FILE环境变量。此变量由 mysql-test-run.pl测试实用程序使用，但也被mysql_config_editor 和 MySQL 客户端（如mysql、 mysqladmin等）识别。
- mysqld-auto.cnf数据目录中 的文件。此 JSON 格式文件包含持久的系统变量设置。它由服务器在执行 SET PERSISTor SET PERSIST_ONLY语句时创建。请参阅 第 5.1.9.3 节，“持久化系统变量”。的管理 mysqld-auto.cnf应该留给服务器而不是手动执行。

- 选项文件处理顺序
- 选项文件语法
- 选项文件包含

选项文件处理顺序

          MySQL 按照以下讨论中描述的顺序查找选项文件并读取任何存在的文件。如果您要使用的选项文件不存在，请使用刚才讨论的适当方法创建它。

笔记

            有关与 NDB Cluster 程序一起使用的选项文件的信息，请参阅第 23.4 节，“NDB Cluster 的配置”。

          在 Windows 上，MySQL 程序按照指定的顺序从下表所示的文件中读取启动选项（首先读取列出的文件，后读取的文件优先）。

**表 4.1 在 Windows 系统上读取的选项文件**

| 文件名 | 目的 |
| --- | --- |
| %WINDIR%\my.ini, %WINDIR%\my.cnf | 全局选项 |
| C:\my.ini,C:\my.cnf | 全局选项 |
| BASEDIR\my.ini, BASEDIR\my.cnf | 全局选项 |
| defaults-extra-file | 指定的文件 --defaults-extra-file，如果有的话 |
| %APPDATA%\MySQL\.mylogin.cnf | 登录路径选项（仅限客户端） |
| DATADIR\mysqld-auto.cnf | 系统变量与 SET PERSISTor 保持一致SET PERSIST_ONLY（仅限服务器） |

**在上表中，`%WINDIR%`表示 Windows 目录的位置。这很常见 `C:\WINDOWS`。`WINDIR`使用以下命令根据环境变量 的值确定其确切位置 ： ```text C:\> echo %WINDIR% ``` `%APPDATA%`表示 Windows 应用程序数据目录的值。`APPDATA`使用以下命令根据环境变量 的值确定其确切位置 ： ```text C:\> echo %APPDATA% ``` `BASEDIR`表示 MySQL 基本安装目录。当使用 MySQL Installer 安装 MySQL 8.0 时，这通常 是 代表程序目录（通常用于 Windows 的英文版本）。请参阅 第 2.3.3 节，“Windows 的 MySQL 安装程序”。 `C:\PROGRAMDIR`\MySQL\MySQL Server 8.0`PROGRAMDIR``Program Files` 重要的 虽然 MySQL Installer 将大部分文件放在 目录下 ，但它默认 `PROGRAMDIR`安装 `my.ini`在该 目录下。`C:\ProgramData\MySQL\MySQL Server 8.0\` `DATADIR`代表MySQL数据目录。与 find 一样 `mysqld-auto.cnf`，它的默认值是编译 MySQL 时内置的数据目录位置，但可以通过`--datadir` 指定为 option-file 或 command-line option processed before `mysqld-auto.cnf`processed 来更改。 在 Unix 和类 Unix 系统上，MySQL 程序按照指定的顺序从下表所示的文件中读取启动选项（首先读取列出的文件，后读取的文件优先）。 笔记 在 Unix 平台上，MySQL 忽略全局可写的配置文件。这是有意作为一种安全措施。 表 4.2 在 Unix 和类 Unix 系统上读取的选项文件**

| 文件名 | 目的 |
| --- | --- |
| /etc/my.cnf | 全局选项 |
| /etc/mysql/my.cnf | 全局选项 |
| SYSCONFDIR/my.cnf | 全局选项 |
| $MYSQL_HOME/my.cnf | 服务器特定选项（仅限服务器） |
| defaults-extra-file | 指定的文件 --defaults-extra-file，如果有的话 |
| ~/.my.cnf | 用户特定选项 |
| ~/.mylogin.cnf | 用户特定的登录路径选项（仅限客户端） |
| DATADIR/mysqld-auto.cnf | 系统变量与 SET PERSISTor 保持一致SET PERSIST_ONLY（仅限服务器） |

**在上表中，`~`表示当前用户的主目录（ 的值 `$HOME`）。 `SYSCONFDIR`表示在构建 MySQL 时使用CMake**`SYSCONFDIR`
          选项指定的目录。默认情况下，这是位于编译安装目录下的目录。
        ****`etc`

          `MYSQL_HOME`是一个环境变量，包含服务器特定`my.cnf`文件所在目录的路径。如果
          `MYSQL_HOME`未设置并且您使用**mysqld_safe**程序启动服务器，
          则**mysqld_safe**将其设置
          *`BASEDIR`*为 MySQL 基本安装目录。

          *`DATADIR`*代表MySQL数据目录。与 find 一样
          `mysqld-auto.cnf`，它的默认值是编译 MySQL 时内置的数据目录位置，但可以通过`--datadir`
          指定为 option-file 或 command-line option processed before `mysqld-auto.cnf`processed 来更改。

          如果找到给定选项的多个实例，则最后一个实例优先，但有一个例外：对于
          **mysqld**，该选项的*第一个*
          实例`--user`用作安全预防措施，以防止选项文件中指定的用户在命令行。

选项文件语法

          以下对选项文件语法的描述适用于您手动编辑的文件。这不包括
          `.mylogin.cnf`使用
          **mysql_config_editor**创建并加密的 ，以及
          `mysqld-auto.cnf`服务器以 JSON 格式创建的 。

          运行 MySQL 程序时在命令行上给出的任何长选项也可以在选项文件中给出。要获取程序的可用选项列表，请使用该`--help`选项运行它。（对于
          **mysqld**，使用
          `--verbose`和
          `--help`。）

          在选项文件中指定选项的语法类似于命令行语法（请参阅
          第 4.2.2.1 节，“在命令行上使用选项”）。但是，在选项文件中，您从选项名称中省略了前导的两个破折号，并且每行仅指定一个选项。例如，
          命令行上的`--quick`and应
          在选项文件中`--host=localhost`
          指定为
          `quick`单独的行。`host=localhost`要

          在选项文件中指定形式的选项，请将其写为
          .
        `--loose-opt_name``loose-opt_name`

          选项文件中的空行将被忽略。非空行可以采用以下任何形式：

- #comment, ;comment 注释行以#或 开头;。注释也可以从一行的#中间开始。
- [group] group是要为其设置选项的程序或组的名称。在组行之后，任何选项设置行都适用于命名组，直到选项文件结束或给出另一个组行。选项组名称不区分大小写。
- opt_name 这相当于 在命令行上。 --opt_name
- opt_name=value 这相当于 在命令行上。在选项文件中，字符周围可以有空格，这在命令行中是不正确的。该值可以选择性地括在单引号或双引号中，如果该值包含注释字符，这将很有用。 --opt_name=value=#

          选项名称和值中的前导和尾随空格会自动删除。

          您可以在选项值中使用转义序列`\b`,
           `\t`, `\n`,
           `\r`,`\\`和
          `\s`来表示退格符、制表符、换行符、回车符、反斜杠和空格字符。在选项文件中，这些转义规则适用：

- 后跟有效转义序列字符的反斜杠将转换为序列表示的字符。例如，\s转换为空格。
- 没有跟在有效转义序列字符后的反斜杠保持不变。例如， \S原样保留。

          前面的规则意味着文字反斜杠可以作为`\\`, 或者就`\`好像它后面没有跟一个有效的转义序列字符一样。

          选项文件中的转义序列规则与 SQL 语句中字符串文字中的转义序列规则略有不同。在后一种情况下，如果
          “ *`x`*”不是有效的转义序列字符，
          则变为
          “ ”而不是
          。请参阅
          第 9.1.1 节，“字符串文字”。
        `\x`*`x`*`\x`

          选项文件值的转义规则尤其适用于
          `\`用作路径名分隔符的 Windows 路径名。Windows 路径名中的分隔符必须像`\\`
          其后跟转义序列字符一样书写。它可以写成`\\`或`\`不是。或者，`/`可以在 Windows 路径名中使用并被视为`\`. 假设您要
          `C:\Program Files\MySQL\MySQL Server 8.0`在选项文件中指定一个基本目录。这可以通过多种方式完成。一些例子：

```text
basedir="C:\Program Files\MySQL\MySQL Server 8.0"
basedir="C:\\Program Files\\MySQL\\MySQL Server 8.0"
basedir="C:/Program Files/MySQL/MySQL Server 8.0"
basedir=C:\\Program\sFiles\\MySQL\\MySQL\sServer\s8.0
```

          如果选项组名称与程序名称相同，则组中的选项专门应用于该程序。例如，`[mysqld]`和`[mysql]`
          组分别适用于**mysqld**服务器和
          **mysql**客户端程序。

选项组由MySQL 发行版中提供
          的`[client]`所有客户端程序读取（但
          *不由***mysqld**读取）。要了解使用 C API 的第三方客户端程序如何使用选项文件，请参阅
          mysql_options()中的 C API 文档。

          该`[client]`组使您能够指定适用于所有客户端的选项。例如，
          `[client]`是用于指定连接到服务器的密码的适当组。（但要确保选项文件只能由您自己访问，这样其他人就无法发现您的密码。）确保不要将选项放在`[client]`组中，除非您使用的*所有*客户端程序都可以识别它。如果您尝试运行不理解该选项的程序，则会在显示错误消息后退出。

          先列出更通用的选项组，然后再列出更具体的选项组。例如，一个`[client]`组更通用，因为它被所有客户端程序读取，而一个`[mysqldump]`组只被
          **mysqldump**读取。后面指定的选项会覆盖前面指定的选项，因此将选项组按顺序排列`[client]`，
          `[mysqldump]`使
          **mysqldump**特定的选项能够覆盖
          `[client]`选项。

          这是一个典型的全局选项文件：

```text
[client]
port=3306
socket=/tmp/mysql.sock

[mysqld]
port=3306
socket=/tmp/mysql.sock
key_buffer_size=16M
max_allowed_packet=128M

[mysqldump]
quick
```

          这是一个典型的用户选项文件：

```text
[client]
# The following password is sent to all standard MySQL clients
password="my password"

[mysql]
no-auto-rehash
connect_timeout=2
```

          要创建仅供来自特定 MySQL 版本系列的
          **mysqld**服务器读取的选项组，请使用名称为
          `[mysqld-5.7]`、
          `[mysqld-8.0]`等的组。以下组表示该
          `sql_mode`设置只能由版本号为 8.0.x 的 MySQL 服务器使用：

```text
[mysqld-8.0]
sql_mode=TRADITIONAL
```

选项文件包含

          可以`!include`在选项文件中使用指令来包含其他选项文件并
          `!includedir`在特定目录中搜​​索选项文件。例如，要包含
          `/home/mydir/myopt.cnf`文件，请使用以下指令：

```text
!include /home/mydir/myopt.cnf
```

          要搜索`/home/mydir`目录并读取在那里找到的选项文件，请使用此指令：

```text
!includedir /home/mydir
```

          MySQL 不保证目录中选项文件的读取顺序。

笔记

`!includedir`在 Unix 操作系统上
            使用指令查找和包含的任何文件
            *必须*具有以
            `.cnf`. 在 Windows 上，此指令检查扩展名为
`.ini`or
            的文件。`.cnf`

          像任何其他选项文件一样写入包含的选项文件的内容。也就是说，它应该包含选项组，每个选项前面都有
          一行指示选项适用的程序。
        `[group`]

          在处理包含的文件时，仅使用当前程序正在查找的组中的那些选项。其他组被忽略。假设一个
          `my.cnf`文件包含这一行：

```text
!include /home/mydir/myopt.cnf
```

          假设它`/home/mydir/myopt.cnf`
          看起来像这样：

```text
[mysqladmin]
force

[mysqld]
key_buffer_size=16M
```

          如果`my.cnf`由
          **mysqld**处理，则仅使用
          `[mysqld]`组 in
           `/home/mydir/myopt.cnf`。如果文件由**mysqladmin**处理，则仅使用
          `[mysqladmin]`组。如果文件由任何其他程序处理，则不
          `/home/mydir/myopt.cnf`使用任何选项。

          除了读取指定目录中的所有选项文件外，该`!includedir`指令的处理方式类似。

          如果选项文件包含`!include`或
          `!includedir`指令，则只要处理选项文件，就会处理由这些指令命名的文件，无论它们出现在文件中的什么位置。

          为了使包含指令起作用，文件路径不应在引号内指定，并且不应包含转义序列。例如，
          `my.ini`读取选项文件
          中提供的以下语句`myopts.ini`：

```text
!include C:/ProgramData/MySQL/MySQL Server/myopts.ini
!include C:\ProgramData\MySQL\MySQL Server\myopts.ini
!include C:\\ProgramData\\MySQL\\MySQL Server\\myopts.ini
```

          在 Windows 上，如果是文件中的最后一行，请确保在末尾附加一个换行符；否则，该行将被忽略。
`!include /path/to/extra.ini`

---

[← 返回 第 5 章 MySQL 服务器管理 索引](00-index.md) · [← 返回总索引](../00-index.md)
