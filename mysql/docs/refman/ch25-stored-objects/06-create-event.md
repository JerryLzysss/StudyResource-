# 第 25 章 存储对象 · CREATE EVENT

> 对应 SQL：[`sql/refman/ch25-stored-objects/06-create-event.sql`](../../../sql/refman/ch25-stored-objects/06-create-event.sql)

---

13.1.13 CREATE EVENT 语句_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 13 章 SQL 语句 / 13.1 数据定义语句 / 13.1.13 CREATE EVENT 语句 ```sql CREATE [DEFINER = user] EVENT [IF NOT EXISTS] event_name ON SCHEDULE schedule [ON COMPLETION [NOT] PRESERVE] [ENABLE | DISABLE | DISABLE ON SLAVE] [COMMENT 'string'] DO event_body; schedule: { AT timestamp [+ INTERVAL interval] ... | EVERY interval [STARTS timestamp [+ INTERVAL interval] ...] [ENDS timestamp [+ INTERVAL interval] ...] } interval: quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE | WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE | DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND} ``` 此语句创建并安排新事件。除非启用事件计划程序，否则事件不会运行。有关检查 Event Scheduler 状态并在必要时启用它的信息，请参阅第 25.4.2 节，“Event Scheduler 配置”。 CREATE EVENT需要 EVENT在其中创建事件的模式的特权。如果 DEFINER存在该子句，则所需的权限取决于user值，如第 25.6 节“存储对象访问控制”中所述。 有效声明的最低要求CREATE EVENT如下： 关键字CREATE EVENT加上事件名称，它在数据库模式中唯一标识事件。
- 一个ON SCHEDULE子句，它确定事件执行的时间和频率。
- DO子句，其中包含事件要执行的 SQL 语句 。

      这是一个最小`CREATE EVENT`语句的示例：

```sql
CREATE EVENT myevent
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
    DO
      UPDATE myschema.mytable SET mycol = mycol + 1;
```

      前面的语句创建了一个名为 的事件
      `myevent`。`myschema.mytable`
      此事件执行一次（在其创建后一小时），方法是运行一条将表列的值递增 1 的 SQL 语句`mycol`。

*`event_name`*必须是最大长度为 64 个字符的有效 MySQL 标识符
      。事件名称不区分大小写，因此您不能
      在同一架构中同时命名`myevent`和命名两个事件。`MyEvent`通常，管理事件名称的规则与存储例程名称的规则相同。请参阅
      第 9.2 节，“模式对象名称”。

      事件与架构相关联。如果没有模式被指示为 的一部分*`event_name`*，则假定默认（当前）模式。要在特定模式中创建事件，请使用

      语法使用模式限定事件名称。
    `schema_name`.*`event_name`*

      该`DEFINER`子句指定在事件执行时检查访问权限时要使用的 MySQL 帐户。如果`DEFINER`存在该子句，则该
      *`user`*值应该是指定为 、 或 的
      MySQL
      帐户
      。允许的
      值取决于您拥有的权限，如
      第 25.6 节“存储对象访问控制”中所述。另请参阅该部分以获取有关事件安全性的其他信息。
    `'user_name`'@'*`host_name`*'`CURRENT_USER``CURRENT_USER()`*`user`*

      如果`DEFINER`省略该子句，则默认定义者是执行该`CREATE EVENT`语句的用户。这与明确指定相同
      `DEFINER = CURRENT_USER`。

      在事件主体中，该
      `CURRENT_USER`函数返回用于在事件执行时检查权限的帐户，即`DEFINER`用户。有关事件中用户审计的信息，请参阅
      第 6.2.23 节，“基于 SQL 的帐户活动审计”。

      `IF NOT EXISTS``CREATE EVENT`for与 for
      具有相同的含义
      `CREATE TABLE`：如果名为的事件
      *`event_name`*已存在于同一架构中，则不采取任何操作，也不会产生错误结果。（但是，在这种情况下会生成警告。）

      该`ON SCHEDULE`子句确定*`event_body`*
      为事件重复定义的时间、频率和时长。该子句采用以下两种形式之一：

- AT timestamp用于一次性事件。它指定事件仅在 给定的日期和时间执行一次，该日期和时间 timestamp必须包括日期和时间，或者必须是解析为日期时间值的表达式。为此，您可以使用 DATETIME或 类型的值。TIMESTAMP如果日期是过去的日期，则会出现警告，如下所示： ```sql mysql> SELECT NOW(); +---------------------+ | NOW() | +---------------------+ | 2006-02-10 23:59:01 | +---------------------+ 1 row in set (0.04 sec) mysql> CREATE EVENT e_totals -> ON SCHEDULE AT '2006-02-10 23:59:00' -> DO INSERT INTO test.totals VALUES (NOW()); Query OK, 0 rows affected, 1 warning (0.00 sec) mysql> SHOW WARNINGS\G *************************** 1. row *************************** Level: Note Code: 1588 Message: Event execution time is in the past and ON COMPLETION NOT PRESERVE is set. The event was dropped immediately after creation. ``` CREATE EVENT本身无效的语句——无论出于何种原因——都会因错误而失败。 您可以使用CURRENT_TIMESTAMP 来指定当前日期和时间。在这种情况下，事件在创建后立即生效。 要创建发生在相对于当前日期和时间的未来某个时间点的事件（例如短语“三周后”所表达的事件），您可以使用可选子句。该 部分由两部分组成，一个数量和一个时间单位，并遵循时间间隔中描述的语法规则，除了在定义事件时不能使用任何涉及微秒的单位关键字。对于某些间隔类型，可以使用复杂的时间单位。例如，“二分十秒”可以表示为。 + INTERVAL intervalinterval+ INTERVAL '2:10' MINUTE_SECOND 您还可以组合间隔。例如，AT CURRENT_TIMESTAMP + INTERVAL 3 WEEK + INTERVAL 2 DAY 相当于“三周零两天后”。此类子句的每个部分都必须以 + INTERVAL.
- 要定期重复操作，请使用 EVERY子句。EVERY 关键字后跟一个interval ，如前面对关键字的讨论中 所述AT。（+ INTERVAL 不与一起使用 EVERY。）例如，EVERY 6 WEEK表示“每六周”。 尽管+ INTERVAL子句中不允许使用EVERY子句，但您可以使用+ INTERVAL. 一个EVERY子句可以包含一个可选 STARTS子句。STARTS后面跟着一个timestamp值，指示动作何时开始重复，也可以用来指定“从现在开始”的时间量。例如， 表示“每三个月，从现在开始一周”。同样，您可以将“每两周，从现在起六小时十五分钟开始”表示为。不指定 与使用相同+ INTERVAL intervalEVERY 3 MONTH STARTS CURRENT_TIMESTAMP + INTERVAL 1 WEEKEVERY 2 WEEK STARTS CURRENT_TIMESTAMP + INTERVAL '6:15' HOUR_MINUTESTARTSSTARTS CURRENT_TIMESTAMP——也就是说，为事件指定的动作在事件创建后立即开始重复。 一个EVERY子句可以包含一个可选 ENDS子句。ENDS 关键字后跟一个值，该timestamp 值告诉 MySQL 事件何时应该停止重复。你也可以使用with ; 例如，相当于 “每十二个小时，从现在开始三十分钟，从现在开始四个星期结束”。不使用 意味着事件将无限期地继续执行。 + INTERVAL intervalENDSEVERY 12 HOUR STARTS CURRENT_TIMESTAMP + INTERVAL 30 MINUTE ENDS CURRENT_TIMESTAMP + INTERVAL 4 WEEKENDS ENDS支持与复杂时间单位相同的语法STARTS。 您可以在子句 中使用STARTS, ENDS, both 或 neither 。EVERY 如果重复事件没有在其调度间隔内终止，则结果可能是该事件的多个实例同时执行。如果这是不可取的，您应该建立一种机制来防止同时发生实例。例如，您可以使用 GET_LOCK()函数、行或表锁定。

      该`ON SCHEDULE`子句可以使用涉及内置 MySQL 函数和用户变量的表达式来获取它包含的任何*`timestamp`*或
      值。*`interval`*您不得在此类表达式中使用存储函数或可加载函数，也不得使用任何表引用；但是，您可以使用`SELECT FROM DUAL`. 对于
      `CREATE EVENT`and
      `ALTER EVENT`语句都是如此。在这种情况下，对存储函数、可加载函数和表的引用是明确不允许的，并且会因错误而失败（参见错误 #22830）。

`ON SCHEDULE`使用当前会话
      `time_zone`值解释子句中的
      时间。这成为事件时区；即，用于事件调度并在事件执行时在事件中生效的时区。这些时间将转换为 UTC 并在内部与事件时区一起存储。这使事件执行能够按照定义继续进行，而不管服务器时区或夏令时的任何后续更改。有关事件时间表示的其他信息，请参阅
      第 25.4.4 节，“事件元数据”。另见
      第 13.7.7.18 节，“SHOW EVENTS 语句”和
      第 26.3.14 节，“INFORMATION_SCHEMA EVENTS 表”。

      通常，一旦事件过期，它就会立即被删除。您可以通过指定覆盖此行为`ON COMPLETION PRESERVE`。使用`ON COMPLETION NOT PRESERVE`仅使默认的非持久行为显式化。

`DISABLE`您可以创建一个事件，但使用关键字
      阻止它处于活动状态
      。或者，您可以使用
      `ENABLE`来明确默认状态，即活动状态。`ALTER EVENT`这与（请参阅
      第 13.1.3 节，“ALTER EVENT 语句”）
    结合使用时最有用
      。

      第三个值也可能出现在
      `ENABLE`or的位置`DISABLE`；
      `DISABLE ON SLAVE`为副本上的事件状态设置，以指示事件在复制源服务器上创建并复制到副本，但不在副本上执行。请参阅
      第 17.5.1.16 节，“调用功能的复制”。

      您可以使用
      `COMMENT`子句为事件提供评论。
      *`comment`*可以是您希望用于描述事件的最多 64 个字符的任何字符串。注释文本是字符串文字，必须用引号括起来。

      子句指定事件携带的`DO`动作，由SQL语句组成。几乎任何可以在存储例程中使用的有效 MySQL 语句也可以用作计划事件的操作语句。（请参阅
      第 25.8 节，“存储程序的限制”。）例如，以下事件每小时`e_hourly`从表中删除一次所有行，其中此表是模式的一部分：
    `sessions``site_activity`

```sql
CREATE EVENT e_hourly
    ON SCHEDULE
      EVERY 1 HOUR
    COMMENT 'Clears out sessions table each hour.'
    DO
      DELETE FROM site_activity.sessions;
```

      MySQL`sql_mode`在创建或更改事件时存储有效的系统变量设置，并且始终使用此设置执行事件，
      *而不管事件开始执行时当前服务器 SQL 模式如何*。

在其子句`CREATE EVENT`中包含语句
      的语句似乎成功；但是，当服务器尝试执行生成的计划事件时，执行失败并出现错误。
`ALTER EVENT``DO`

笔记

`SELECT`仅返回结果集的或

        之类的语句`SHOW`在事件中使用时无效；这些的输出不会发送到 MySQL Monitor，也不会存储在任何地方。但是，您可以使用诸如
        `SELECT ... INTO`和
        之类的语句`INSERT INTO ... SELECT`来存储结果。（有关后者的实例，请参阅本节中的下一个示例。）

      事件所属的模式是`DO`子句中表引用的默认模式。对其他模式中表的任何引用都必须使用正确的模式名称进行限定。

      与存储例程一样，您可以通过使用and关键字在`DO`子句
      中使用复合语句语法，如下所示：
    `BEGIN``END`

```sql
delimiter |

CREATE EVENT e_daily
    ON SCHEDULE
      EVERY 1 DAY
    COMMENT 'Saves total number of sessions then clears the table each day'
    DO
      BEGIN
        INSERT INTO site_activity.totals (time, total)
          SELECT CURRENT_TIMESTAMP, COUNT(*)
            FROM site_activity.sessions;
        DELETE FROM site_activity.sessions;
      END |

delimiter ;
```

      此示例使用`delimiter`命令更改语句分隔符。请参阅
      第 25.1 节，“定义存储程序”。

      更复杂的复合语句，例如存储例程中使用的语句，在事件中是可能的。此示例使用局部变量、错误处理程序和流程控制结构：

```sql
delimiter |

CREATE EVENT e
    ON SCHEDULE
      EVERY 5 SECOND
    DO
      BEGIN
        DECLARE v INTEGER;
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

        SET v = 0;

        WHILE v

---

[← 返回 第 25 章 存储对象 索引](00-index.md) · [← 返回总索引](../00-index.md)
