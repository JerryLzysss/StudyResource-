# 第 13 章 SQL 语句 · 事务语句

> 对应 SQL：[`sql/refman/ch13-sql-statements/04-commit.sql`](../../../sql/refman/ch13-sql-statements/04-commit.sql)

---

13.3.1 START TRANSACTION、COMMIT 和 ROLLBACK 语句_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 13 章 SQL 语句 / 13.3 事务和锁定语句 / 13.3.1 START TRANSACTION、COMMIT 和 ROLLBACK 语句 ```sql START TRANSACTION [transaction_characteristic [, transaction_characteristic] ...] transaction_characteristic: { WITH CONSISTENT SNAPSHOT | READ WRITE | READ ONLY } BEGIN [WORK] COMMIT [WORK] [AND [NO] CHAIN] [[NO] RELEASE] ROLLBACK [WORK] [AND [NO] CHAIN] [[NO] RELEASE] SET autocommit = {0 | 1} ``` 这些语句提供对 事务使用的控制： START TRANSACTION或 BEGIN开始新的交易。
- COMMIT提交当前事务，使其更改永久化。
- ROLLBACK回滚当前事务，取消其更改。
- SET autocommit禁用或启用当前会话的默认自动提交模式。

      默认情况下，MySQL 在
      启用自动提交模式的情况下运行。这意味着，当不在事务内时，每个语句都是原子的，就好像它被`START TRANSACTION`and包围一样`COMMIT`。您不能使用`ROLLBACK`来撤销效果；但是，如果在语句执行期间发生错误，则回滚该语句。

      要为单个语句系列隐式禁用自动提交模式，请使用以下`START TRANSACTION`
      语句：

```sql
START TRANSACTION;
SELECT @A:=SUM(salary) FROM table1 WHERE type=1;
UPDATE table2 SET summary=@A WHERE type=1;
COMMIT;
```

      使用，自动提交将保持禁用状态，直到您使用或`START TRANSACTION`结束事务
      。自动提交模式然后恢复到它以前的状态。
    `COMMIT``ROLLBACK`

      `START TRANSACTION`允许几个控制事务特性的修饰符。要指定多个修饰符，请用逗号分隔它们。

- 修饰符为支持它的存储引擎WITH CONSISTENT SNAPSHOT启动一致读取。这仅适用于InnoDB. 效果与从任何 表发出一个START TRANSACTION 后跟一个相同。请参阅 第 15.7.2.3 节，“一致的非锁定读取”。该修饰符不会更改当前的事务 隔离级别，因此仅当当前隔离级别是允许一致读取的隔离级别时，它才会提供一致的快照。唯一允许一致读取的隔离级别是 . 对于所有其他隔离级别，SELECTInnoDBWITH CONSISTENT SNAPSHOTREPEATABLE READWITH CONSISTENT SNAPSHOT子句被忽略。WITH CONSISTENT SNAPSHOT忽略该子句 时会生成警告。
- 和修饰符设置事务访问模式READ WRITE。READ ONLY它们允许或禁止更改事务中使用的表。该READ ONLY限制防止事务修改或锁定对其他事务可见的事务和非事务表；事务仍然可以修改或锁定临时表。 InnoDB当已知事务是只读的时， MySQL 可以对表的查询进行额外的优化 。指定READ ONLY 可确保在无法自动确定只读状态的情况下应用这些优化。有关更多信息，请参阅 第 8.5.3 节，“优化 InnoDB 只读事务”。 如果未指定访问模式，则应用默认模式。除非更改了默认值，否则它是可读/可写的。不允许在同一语句中同时 指定READ WRITE 和。READ ONLY 在只读模式下，仍然可以TEMPORARY使用 DML 语句更改使用关键字创建的表。不允许使用 DDL 语句进行更改，就像永久表一样。 有关事务访问模式的其他信息，包括更改默认模式的方法，请参阅 第 13.3.7 节，“SET TRANSACTION 语句”。 如果read_only启用了系统变量，则显式启动事务 START TRANSACTION READ WRITE需要 CONNECTION_ADMIN特权（或已弃用的SUPER 特权）。

重要的

        许多用于编写 MySQL 客户端应用程序的 API（例如 JDBC）提供了它们自己的启动事务的方法，可以（有时应该）使用这些方法来代替
        `START TRANSACTION`从客户端发送语句。有关详细信息，请参阅第 29 章*连接器和 API*或您的 API 的文档。

      要显式禁用自动提交模式，请使用以下语句：

```sql
SET autocommit=0;
```

      通过将
      `autocommit`变量设置为零来禁用自动提交模式后，对事务安全表的更改（例如
      `InnoDB`或
      的更改`NDB`）不会立即永久化。您必须使用`COMMIT`将更改存储到磁盘或`ROLLBACK`忽略更改。

      `autocommit`是一个会话变量，必须为每个会话设置。要为每个新连接禁用自动提交模式，请参阅
      第 5.1.8 节“服务器系统变量”`autocommit`中系统变量
      的说明。

      `BEGIN`并`BEGIN WORK`支持作为`START TRANSACTION`发起交易的别名。`START TRANSACTION`是标准的 SQL 语法，是启动临时事务的推荐方式，并且允许`BEGIN`
      不使用的修饰符。

      该`BEGIN`语句不同于
      开始
      复合语句的`BEGIN`关键字
      的使用。`BEGIN ... END`后者不开始交易。请参阅
      第 13.6.1 节，“BEGIN ... END 复合语句”。

笔记

        在所有存储程序（存储过程和函数、触发器和事件）中，解析器将`BEGIN [WORK]`其视为块的开头
        `BEGIN ... END`。`START TRANSACTION`在此上下文中以instead
开始事务
        。

and`WORK`支持

      可选关键字，and
      子句也是如此。并可
      用于对事务完成的额外控制。系统变量的值
      决定了默认的完成行为。请参阅
      第 5.1.8 节，“服务器系统变量”。
    `COMMIT``ROLLBACK``CHAIN``RELEASE``CHAIN``RELEASE``completion_type`

      该`AND CHAIN`子句导致新事务在当前事务结束后立即开始，并且新事务与刚刚终止的事务具有相同的隔离级别。新事务也使用与刚刚终止的事务相同的访问模式（`READ WRITE`或）。`READ ONLY`该`RELEASE`子句使服务器在终止当前事务后断开当前客户端会话。包括
      `NO`关键字 suppresses`CHAIN`
      或completion，如果系统变量设置为默认导致链接或释放完成
    `RELEASE`，这将很有用。`completion_type`

      开始一个事务会导致任何待处理的事务被提交。有关更多信息，请参阅第 13.3.3 节，“导致隐式提交的语句”。

      开始一个事务也会导致
      `LOCK TABLES`释放获得的表锁，就好像你已经执行了一样
      `UNLOCK TABLES`。开始事务不会释放使用 获取的全局读锁`FLUSH TABLES WITH READ LOCK`。

      为获得最佳结果，应仅使用由单个事务安全存储引擎管理的表来执行事务。否则，可能会出现以下问题：

- 如果您使用来自多个事务安全存储引擎（例如InnoDB）的表，并且事务隔离级别不是 SERIALIZABLE，则当一个事务提交时，另一个使用相同表的正在进行的事务可能只会看到所做的部分更改通过第一笔交易。也就是说，混合引擎无法保证事务的原子性，并且可能导致不一致。（如果混合引擎事务不频繁，您可以根据 SET TRANSACTION ISOLATION LEVEL需要将隔离级别设置为SERIALIZABLE基于每个事务。）
- 如果您在事务中使用非事务安全的表，则对这些表的更改将立即存储，而不管自动提交模式的状态如何。
- 如果 ROLLBACK 在事务中更新非事务表后发出语句， ER_WARNING_NOT_COMPLETE_ROLLBACK 则会出现警告。回滚对事务安全表的更改，但不回滚对非事务安全表的更改。

      每个事务都以一个块的形式存储在二进制日志中
      `COMMIT`。不记录回滚的事务。（**例外**：不能回滚对非事务性表的修改。如果回滚的事务包括对非事务性表的修改，则整个事务会
      `ROLLBACK`
      在末尾记录一条语句，以确保复制对非事务性表的修改。）参见
      第5.4.4，“二进制日志”。

`SET TRANSACTION`您可以使用语句
      更改事务的隔离级别或访问模式。请参阅第 13.3.7 节，“SET TRANSACTION 语句”。

      回滚可能是一个缓慢的操作，可能在用户没有明确要求的情况下隐式发生（例如，当发生错误时）。因此，在会话的列中`SHOW PROCESSLIST`显示，不仅针对使用

      语句执行的显式回滚，还针对隐式回滚。
`Rolling back``State``ROLLBACK`

笔记

        在 MySQL 8.0 中，`BEGIN`,
         `COMMIT`, 和`ROLLBACK`不受`--replicate-do-db`
        or`--replicate-ignore-db`规则的影响。

      当`InnoDB`执行一个事务的完整回滚时，该事务设置的所有锁都被释放。如果事务中的单个 SQL 语句由于错误（例如重复键错误）而回滚，则在事务保持活动状态时保留由该语句设置的锁。发生这种情况是因为`InnoDB`以一种格式存储行锁，这样它以后就不知道哪个锁是由哪个语句设置的。

      如果`SELECT`事务中的语句调用存储函数，而存储函数中的语句失败，则该语句回滚。如果
      `ROLLBACK`后续对该事务执行，则整个事务回滚。

---

[← 返回 第 13 章 SQL 语句 索引](00-index.md) · [← 返回总索引](../00-index.md)
