# 第 3 章 教程 · 连接与断开

> 对应 SQL：[`sql/refman/ch03-tutorial/02-connecting-disconnecting.sql`](../../../sql/refman/ch03-tutorial/02-connecting-disconnecting.sql)

---

## 3.1 连接和断开服务器

      要连接到服务器，您通常需要在调用**mysql**时提供 MySQL 用户名，并且很可能需要提供密码。如果服务器在您登录的机器以外的机器上运行，您还必须指定一个主机名。请与您的管理员联系以了解应该使用哪些连接参数进行连接（即要使用的主机、用户名和密码）。知道正确的参数后，您应该能够像这样连接：

```text
$> mysql -h host -u user -p
Enter password: ********
```

      *`host`*并
      *`user`*代表运行 MySQL 服务器的主机名和 MySQL 帐户的用户名。为您的设置替换适当的值。代表您的
      `********`密码；**在mysql**显示`Enter password:`提示
    时输入。

      如果可行，您应该会看到一些介绍性信息，然后是`mysql>`提示：

```sql
$> mysql -h host -u user -p
Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25338 to server version: 8.0.31-standard

Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

mysql>
```

`mysql>`提示符告诉你
      **mysql**已经准备好让你输入sql语句了

      。

      如果你在运行 MySQL 的同一台机器上登录，你可以省略主机，只需使用以下内容：

```text
$> mysql -u user -p
```

      如果在尝试登录时收到错误消息，例如
      ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)，这意味着 MySQL 服务器守护进程 (Unix) 或服务 (Windows) 未运行。请咨询管理员或参阅
      第 2 章*安装和升级 MySQL*中适合您的操作系统的部分。

      有关尝试登录时经常遇到的其他问题的帮助，请参阅第 B.3.2 节，“使用 MySQL 程序时的常见错误”。

      一些 MySQL 安装允许用户以匿名（未命名）用户的身份连接到在本地主机上运行的服务器。如果你的机器是这种情况，你应该能够通过不带任何选项
    调用**mysql来连接到该服务器：**

```text
$> mysql
```

      成功连接后，您可以随时通过在提示符
    下键入`QUIT`（或`\q`）断开连接：`mysql>`

```sql
mysql> QUIT
Bye
```

      在 Unix 上，您也可以通过按 Control+D 来断开连接。

      以下部分中的大多数示例都假定您已连接到服务器。他们通过
      `mysql>`提示表明这一点。

---

[← 返回 第 3 章 教程 索引](00-index.md) · [← 返回总索引](../00-index.md)
