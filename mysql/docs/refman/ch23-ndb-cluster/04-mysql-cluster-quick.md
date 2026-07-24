# 第 23 章 MySQL NDB Cluster 8.0 · 快速测试设置

> 对应 SQL：[`sql/refman/ch23-ndb-cluster/04-mysql-cluster-quick.sql`](../../../sql/refman/ch23-ndb-cluster/04-mysql-cluster-quick.sql)

---

23.4.1 NDB Cluster 的快速测试设置_MySQL 8.0 参考手册

**Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 23 章 MySQL NDB Cluster 8.0 / 23.4 NDB Cluster的配置 / 23.4.1 NDB Cluster 的快速测试设置 为了让您熟悉基础知识，我们描述了功能 NDB Cluster 的最简单的配置。在此之后，您应该能够根据本章其他相关部分提供的信息设计所需的设置。 首先，您需要创建一个配置目录，例如 `/var/lib/mysql-cluster`，以系统`root`用户执行以下命令： ```text $> mkdir /var/lib/mysql-cluster ``` 在此目录中，创建一个名为的文件 `config.ini`，其中包含以下信息。根据需要为您的系统 `HostName`替换适当的值 。`DataDir` ```text # file "config.ini" - showing minimal setup consisting of 1 data node, # 1 management server, and 3 MySQL servers. # The empty default sections are not required, and are shown only for # the sake of completeness. # Data nodes must provide a hostname but MySQL Servers are not required # to do so. # If you don't know the hostname for your machine, use localhost. # The DataDir parameter also has a default value, but it is recommended to # set it explicitly. # Note: [db], [api], and [mgm] are aliases for [ndbd], [mysqld], and [ndb_mgmd], # respectively. [db] is deprecated and should not be used in new installations. [ndbd default] NoOfReplicas= 1 [mysqld default] [ndb_mgmd default] [tcp default] [ndb_mgmd] HostName= myhost.example.com [ndbd] HostName= myhost.example.com DataDir= /var/lib/mysql-cluster [mysqld] [mysqld] [mysqld] ``` 您现在可以启动ndb_mgmd**管理服务器。默认情况下，它会尝试读取
      `config.ini`其当前工作目录中的文件，因此将位置更改为文件所在的目录，然后调用**ndb_mgmd**：

```text
$> cd /var/lib/mysql-cluster
$> ndb_mgmd
```

**然后通过运行ndbd**
      启动单个数据节点：

```text
$> ndbd
```

      默认情况下，**ndbd**`localhost`在端口 1186 上
查找管理服务器。

笔记

        如果您从二进制 tarball 安装 MySQL，则必须明确指定**ndb_mgmd**和
        **ndbd**服务器的路径。（通常，这些可以在 中找到`/usr/local/mysql/bin`。）

      最后，将位置更改为 MySQL 数据目录（通常是
      `/var/lib/mysql`或
      `/usr/local/mysql/data`），并确保该`my.cnf`文件包含启用 NDB 存储引擎所需的选项：

```text
[mysqld]
ndbcluster
```

      您现在可以像往常一样启动 MySQL 服务器：

```text
$> mysqld_safe --user=mysql &
```

      稍等片刻，确保 MySQL 服务器正常运行。如果您看到通知`mysql ended`，请检查服务器的`.err`文件以找出问题所在。

      如果到目前为止一切顺利，您现在可以开始使用集群了。连接到服务器并验证
      `NDBCLUSTER`存储引擎是否已启用：

```sql
$> mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1 to server version: 8.0.31

Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

mysql> SHOW ENGINES\G
...
*************************** 12. row ***************************
Engine: NDBCLUSTER
Support: YES
Comment: Clustered, fault-tolerant, memory-based tables
*************************** 13. row ***************************
Engine: NDB
Support: YES
Comment: Alias for NDBCLUSTER
...
```

      上述示例输出中显示的行号可能与系统上显示的行号不同，具体取决于服务器的配置方式。

      尝试创建一个`NDBCLUSTER`表：

```sql
$> mysql
mysql> USE test;
Database changed

mysql> CREATE TABLE ctest (i INT) ENGINE=NDBCLUSTER;
Query OK, 0 rows affected (0.09 sec)

mysql> SHOW CREATE TABLE ctest \G
*************************** 1. row ***************************
       Table: ctest
Create Table: CREATE TABLE `ctest` (
  `i` int(11) default NULL
) ENGINE=ndbcluster DEFAULT CHARSET=latin1
1 row in set (0.00 sec)
```

      要检查您的节点是否设置正确，请启动管理客户端：

```text
$> ndb_mgm
```

      从管理客户端中使用**SHOW**命令获取集群状态报告：

```text
ndb_mgm> SHOW
Cluster Configuration
---------------------
[ndbd(NDB)]     1 node(s)
id=2    @127.0.0.1  (Version: 8.0.32-ndb-8.0.32, Nodegroup: 0, *)

[ndb_mgmd(MGM)] 1 node(s)
id=1    @127.0.0.1  (Version: 8.0.32-ndb-8.0.32)

[mysqld(API)]   3 node(s)
id=3    @127.0.0.1  (Version: 8.0.32-ndb-8.0.32)
id=4 (not connected, accepting connect from any host)
id=5 (not connected, accepting connect from any host)
```

      此时，您已经成功设置了一个工作的 NDB Cluster 。您现在可以使用使用`ENGINE=NDBCLUSTER`或其别名
      创建的任何表将数据存储在集群中`ENGINE=NDB`。

---

[← 返回 第 23 章 MySQL NDB Cluster 8.0 索引](00-index.md) · [← 返回总索引](../00-index.md)
