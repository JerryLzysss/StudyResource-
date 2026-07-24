# 第 10 章 字符集、排序规则、Unicode · 连接字符集和排序规则

> 对应 SQL：[`sql/refman/ch10-charset/04-charset-connection.sql`](../../../sql/refman/ch10-charset/04-charset-connection.sql)

---

## 10.4 连接字符集和排序规则

      “连接”是客户端程序在连接到服务器时所做的，以开始与服务器交互的会话。客户端通过会话连接发送 SQL 语句，例如查询。服务器通过连接将响应（例如结果集或错误消息）发送回客户端。

- 连接字符集和排序规则系统变量
- 不允许的客户端字符集
- 客户端程序连接字符集配置
- 连接字符集配置的 SQL 语句
- 连接字符集错误处理

### 连接字符集和排序规则系统变量

        几个字符集和排序规则系统变量与客户端与服务器的交互有关。其中一些已在前面的部分中提到：

- 和系统变量表示服务器字符集和排序规则character_set_server 。collation_server请参阅第 10.3.2 节，“服务器字符集和排序规则”。
- character_set_database 和系统变量表示默认数据库 的collation_database 字符集和排序规则。请参阅 第 10.3.3 节，“数据库字符集和排序规则”。

        其他字符集和排序规则系统变量涉及处理客户端和服务器之间连接的流量。每个客户端都有特定于会话的连接相关字符集和排序规则系统变量。这些会话系统变量值在连接时初始化，但可以在会话中更改。

        关于客户端连接的字符集和排序规则处理的几个问题可以根据系统变量来回答：

- 语句离开客户端时的字符集是什么？ 服务器将 character_set_client系统变量作为客户端发送语句的字符集。 笔记 某些字符集不能用作客户端字符集。请参阅 不允许的客户端字符集。
- 服务器在收到语句后应该将语句翻译成什么字符集？ 为确定这一点，服务器使用 character_set_connection 和collation_connection 系统变量： 服务器将客户端发送的语句从 转换 character_set_client为 character_set_connection。例外：对于具有介绍人（例如_utf8mb4or _latin2）的字符串文字，介绍人确定字符集。请参阅 第 10.3.8 节，“字符集介绍人”。
- collation_connection对于文字字符串的比较很重要。对于字符串与列值的比较， collation_connection 无关紧要，因为列有自己的排序规则，它具有更高的排序规则优先级（请参阅 第 10.8.4 节，“表达式中的排序规则强制性”）。

- 在将查询结果发送回客户端之前，服务器应该将查询结果翻译成什么字符集？ 系统变量表示服务器向客户端返回查询结果的character_set_results 字符集。这包括结果数据（例如列值）、结果元数据（例如列名）和错误消息。 要告诉服务器不执行结果集或错误消息的转换，请设置 character_set_results为 NULL或binary： ```sql SET character_set_results = NULL; SET character_set_results = binary; ``` 有关字符集和错误消息的更多信息，请参阅第 10.6 节，“错误消息字符集”。

        要查看适用于当前会话的字符集和排序规则系统变量的值，请使用以下语句：

```sql
SELECT * FROM performance_schema.session_variables
WHERE VARIABLE_NAME IN (
  'character_set_client', 'character_set_connection',
  'character_set_results', 'collation_connection'
) ORDER BY VARIABLE_NAME;
```

        以下更简单的语句也显示连接变量，但也包括其他相关变量。它们对于查看*所有*字符集和排序规则系统变量很有用：

```sql
SHOW SESSION VARIABLES LIKE 'character\_set\_%';
SHOW SESSION VARIABLES LIKE 'collation\_%';
```

        客户可以微调这些变量的设置，或依赖于默认值（在这种情况下，您可以跳过本节的其余部分）。如果不使用默认值，则必须更改*每个与服务器的连接*的字符设置。

### 不允许的客户端字符集

        系统`character_set_client`变量不能设置为某些字符集：

```text
ucs2
utf16
utf16le
utf32
```

        尝试使用任何这些字符集作为客户端字符集会产生错误：

```sql
mysql> SET character_set_client = 'ucs2';
ERROR 1231 (42000): Variable 'character_set_client'
can't be set to the value of 'ucs2'
```

        如果在以下上下文中使用任何这些字符集，则会发生相同的错误，所有这些都会导致尝试设置
        `character_set_client`为命名字符集：

- mysql和mysqladmin 等 MySQL 客户端程序使用 的 命令选项。 --default-character-set=charset_name
- 声明 。SET NAMES 'charset_name'
- 声明 。SET CHARACTER SET 'charset_name'

### 客户端程序连接字符集配置

        当客户端连接到服务器时，它指示要使用哪个字符集与服务器通信。（实际上，客户端指示该字符集的默认排序规则，服务器可以从中确定字符集。）服务器使用此信息将
        `character_set_client`,
         `character_set_results`,
        `character_set_connection`系统变量设置为字符集，并设置
        `collation_connection`为字符集默认排序规则。实际上，服务器执行等同于操作的`SET NAMES`
        操作。

        如果服务器不支持请求的字符集或排序规则，它会回退到使用服务器字符集和排序规则来配置连接。有关此回退行为的更多详细信息，请参阅
        连接字符集错误处理。

**mysql**
        、**mysqladmin**、**mysqlcheck**、
         **mysqlimport**和**mysqlshow**客户端程序确定要使用的默认字符集，如下所示：

- 在没有其他信息的情况下，每个客户端使用编译的默认字符集，通常是 utf8mb4.
- 每个客户端都可以根据操作系统设置自动检测要使用的字符集，例如 Unix 系统上的 LANG或LC_ALLlocale 环境变量的值或 Windows 系统上的代码页设置。对于操作系统提供区域设置的系统，客户端使用它来设置默认字符集，而不是使用编译的默认值。例如，设置LANG为 ru_RU.KOI8-R会导致使用 koi8r字符集。因此，用户可以在他们的环境中配置区域设置以供 MySQL 客户端使用。 如果没有完全匹配，OS 字符集将映射到最接近的 MySQL 字符集。如果客户端不支持匹配的字符集，则使用编译的默认值。例如，utf8 andutf-8映射到 utf8mb4, anducs2不支持作为连接字符集，因此它映射到编译的默认值。 C 应用程序可以使用基于操作系统设置的字符集自动检测，方法是 mysql_options()在连接到服务器之前调用以下命令： ```text mysql_options(mysql, MYSQL_SET_CHARSET_NAME, MYSQL_AUTODETECT_CHARSET_NAME); ```
- 每个客户端都支持一个 --default-character-set 选项，该选项使用户能够明确指定字符集以覆盖客户端以其他方式确定的任何默认值。 笔记 某些字符集不能用作客户端字符集。尝试将它们与一起使用 --default-character-set 会产生错误。请参阅 不允许的客户端字符集。

        对于**mysql**客户端，要使用不同于默认的字符集，您可以在
        `SET NAMES`每次连接到服务器时显式执行一条语句（请参阅
        客户端程序连接字符集配置）。要更轻松地实现相同的结果，请在选项文件中指定字符集。例如，以下选项文件设置更改了三个与连接相关的字符集系统变量设置为`koi8r`每次调用**mysql**时：

```text
[mysql]
default-character-set=koi8r
```

        如果您使用启用了自动重新连接的**mysql**客户端（不推荐），最好使用`charset`命令而不是`SET NAMES`. 例如：

```sql
mysql> charset koi8r
Charset changed
```

        该`charset`命令发出一条
        `SET NAMES`语句，还更改了**mysql**
        在连接断开后重新连接时使用的默认字符集。

        配置客户端程序时，还必须考虑它们执行的环境。请参阅
        第 10.5 节，“配置应用程序字符集和排序规则”。

### 连接字符集配置的 SQL 语句

        建立连接后，客户端可以更改当前会话的字符集和排序规则系统变量。`SET`
        这些变量可以使用语句
单独更改
        ，但是两个更方便的语句将连接相关的字符集系统变量作为一个组来影响：

- SET NAMES 'charset_name' [COLLATE 'collation_name'] SET NAMES指示客户端使用什么字符集向服务器发送 SQL 语句。因此，SET NAMES 'cp1251'告诉服务器，“来自该客户端的未来传入消息采用字符集 cp1251。 ” ”它还指定了服务器将结果发送回客户端时应使用的字符集。SELECT（例如，如果您使用生成结果集 的语句，它指示用于列值的字符 集。） 一个 语句等价于这三个语句： SET NAMES 'charset_name' ```sql SET character_set_client = charset_name; SET character_set_results = charset_name; SET character_set_connection = charset_name; ``` 设置 character_set_connection为 charset_name还隐式设置 collation_connection为默认排序规则 charset_name。没有必要显式设置该排序规则。要指定用于 for 的特定排序规则 collation_connection，请添加一个 COLLATE子句： ```sql SET NAMES 'charset_name' COLLATE 'collation_name' ```
- SET CHARACTER SET 'charset_name' SET CHARACTER SET类似于SET NAMESbut sets character_set_connection and collation_connectionto character_set_databaseand collation_database（如前所述，表示默认数据库的字符集和排序规则）。 一个语句等价于这三个语句： SET CHARACTER SET charset_name ```sql SET character_set_client = charset_name; SET character_set_results = charset_name; SET collation_connection = @@collation_database; ``` 设置 collation_connection还隐式设置 character_set_connection为与排序规则关联的字符集（相当于执行SET character_set_connection = @@character_set_database）。无需 character_set_connection 明确设置。

笔记

          某些字符集不能用作客户端字符集。尝试将它们与`SET NAMES`or一起使用`SET CHARACTER SET`会产生错误。请参阅
          不允许的客户端字符集。

        示例：假设`column1`定义为
        `CHAR(5) CHARACTER SET latin2`。如果您不说`SET NAMES`or
         `SET CHARACTER SET`，那么对于
        ，服务器会发回使用客户端在连接时指定的字符集的`SELECT column1 FROM t`所有值。`column1`另一方面，如果您在发出语句之前说`SET NAMES 'latin1'`
        or ，服务器会将值转换为
        刚好在发送回结果之前。对于不在两个字符集中的字符，转换可能是有损的。
`SET CHARACTER SET 'latin1'``SELECT``latin2``latin1`

### 连接字符集错误处理

        尝试使用不适当的连接字符集或排序规则可能会产生错误，或导致服务器回退到给定连接的默认字符集和排序规则。本节描述配置连接字符集时可能出现的问题。建立连接或更改已建立连接中的字符集时，可能会出现这些问题。

- 连接时错误处理
- 运行时错误处理

#### 连接时错误处理

        有些字符集不能作为客户端字符集；请参阅
        不允许的客户端字符集。如果您指定一个有效但不允许作为客户端字符集的字符集，则服务器会返回错误：

```text
$> mysql --default-character-set=ucs2
ERROR 1231 (42000): Variable 'character_set_client' can't be set to
the value of 'ucs2'
```

        如果指定客户端无法识别的字符集，则会产生错误：

```text
$> mysql --default-character-set=bogus
mysql: Character set 'bogus' is not a compiled character set and is
not specified in the '/usr/local/mysql/share/charsets/Index.xml' file
ERROR 2019 (HY000): Can't initialize character set bogus
(path: /usr/local/mysql/share/charsets/)
```

        如果您指定了客户端可识别但服务器无法识别的字符集，则服务器会回退到其默认字符集和排序规则。假设服务器配置为使用`latin1`和
        `latin1_swedish_ci`作为其默认值，并且它不识别`gb18030`为有效字符集。指定的客户端
        `--default-character-set=gb18030`能够连接到服务器，但生成的字符集不是客户端想要的：

```sql
mysql> SHOW SESSION VARIABLES LIKE 'character\_set\_%';
+--------------------------+--------+
| Variable_name            | Value  |
+--------------------------+--------+
| character_set_client     | latin1 |
| character_set_connection | latin1 |
...
| character_set_results    | latin1 |
...
+--------------------------+--------+
mysql> SHOW SESSION VARIABLES LIKE 'collation_connection';
+----------------------+-------------------+
| Variable_name        | Value             |
+----------------------+-------------------+
| collation_connection | latin1_swedish_ci |
+----------------------+-------------------+
```

        您可以看到已设置连接系统变量以反映 和 的字符集和排序
        `latin1`规则
        `latin1_swedish_ci`。发生这种情况是因为服务器无法满足客户端字符集请求并回退到其默认值。

        在这种情况下，客户端无法使用它想要的字符集，因为服务器不支持它。客户端必须要么愿意使用不同的字符集，要么连接到支持所需字符集的不同服务器。

        同样的问题出现在更微妙的上下文中：当客户端告诉服务器使用服务器识别的字符集时，但客户端不知道该字符集在服务器端的默认排序规则。例如，当 MySQL 8.0 客户端想要使用`utf8mb4`客户端字符集连接到 MySQL 5.7 服务器时，就会发生这种情况。指定的客户端
        `--default-character-set=utf8mb4`能够连接到服务器。但是，与前面的示例一样，服务器回退到其默认字符集和排序规则，而不是客户端请求的内容：

```sql
mysql> SHOW SESSION VARIABLES LIKE 'character\_set\_%';
+--------------------------+--------+
| Variable_name            | Value  |
+--------------------------+--------+
| character_set_client     | latin1 |
| character_set_connection | latin1 |
...
| character_set_results    | latin1 |
...
+--------------------------+--------+
mysql> SHOW SESSION VARIABLES LIKE 'collation_connection';
+----------------------+-------------------+
| Variable_name        | Value             |
+----------------------+-------------------+
| collation_connection | latin1_swedish_ci |
+----------------------+-------------------+
```

        为什么会发生这种情况？毕竟`utf8mb4`8.0的客户端和5.7的服务器都知道，所以他们都认了。要理解此行为，有必要了解当客户端告诉服务器它要使用哪个字符集时，它实际上是在告诉服务器该字符集的默认排序规则。因此，上述行为是多种因素共同作用的结果：

- MySQL 5.7 和 8.0 之间的默认排序规则utf8mb4不同（utf8mb4_general_ci对于 5.7， utf8mb4_0900_ai_ci对于 8.0）。
- 8.0客户端请求字符集时 utf8mb4，发送给服务器的是默认的8.0utf8mb4排序规则；也就是说，utf8mb4_0900_ai_ci.
- utf8mb4_0900_ai_ci仅从 MySQL 8.0 开始实现，因此 5.7 服务器无法识别它。
- 由于5.7服务器不识别 utf8mb4_0900_ai_ci，无法满足客户端字符集请求，退回到其默认字符集和排序规则（latin1和 latin1_swedish_ci）。

        在这种情况下，客户端连接后仍然可以
        `utf8mb4`通过发出`SET NAMES 'utf8mb4'`语句来使用。生成的排序规则是 5.7 默认`utf8mb4`
        排序规则；也就是说，`utf8mb4_general_ci`。如果客户端还需要 的排序规则
        `utf8mb4_0900_ai_ci`，则无法实现，因为服务器无法识别该排序规则。客户端必须愿意使用不同的
        `utf8mb4`排序规则，或者从 MySQL 8.0 或更高版本连接到服务器。

#### 运行时错误处理

        在已建立的连接中，客户端可以使用
        `SET NAMES`或
        请求更改连接字符集和排序规则`SET CHARACTER SET`。

        有些字符集不能作为客户端字符集；请参阅
        不允许的客户端字符集。如果您指定一个有效但不允许作为客户端字符集的字符集，则服务器会返回错误：

```sql
mysql> SET NAMES 'ucs2';
ERROR 1231 (42000): Variable 'character_set_client' can't be set to
the value of 'ucs2'
```

        如果服务器无法识别字符集（或排序规则），则会产生错误：

```sql
mysql> SET NAMES 'bogus';
ERROR 1115 (42000): Unknown character set: 'bogus'

mysql> SET NAMES 'utf8mb4' COLLATE 'bogus';
ERROR 1273 (HY000): Unknown collation: 'bogus'
```

小费

          想要验证其请求的字符集是否被服务器接受的客户端可以在连接并检查结果是否为预期的字符集后执行以下语句：

```sql
SELECT @@character_set_client;
```

---

[← 返回 第 10 章 字符集、排序规则、Unicode 索引](00-index.md) · [← 返回总索引](../00-index.md)
