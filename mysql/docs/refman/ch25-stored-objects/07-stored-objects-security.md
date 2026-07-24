# 第 25 章 存储对象 · 安全

> 对应 SQL：[`sql/refman/ch25-stored-objects/07-stored-objects-security.sql`](../../../sql/refman/ch25-stored-objects/07-stored-objects-security.sql)

---

## 25.6 存储对象访问控制

      存储的程序（过程、函数、触发器和事件）和视图在使用前定义，并且在被引用时在确定其特权的安全上下文中执行。适用于执行存储对象的权限由其`DEFINER`属性和
      `SQL SECURITY`特性控制。

- 定义器属性
- SQL 安全特性
- 例子
- 孤儿存储对象
- 风险最小化指南

### 定义器属性

        存储对象定义可以包括
        `DEFINER`命名 MySQL 帐户的属性。如果定义省略该`DEFINER`属性，则默认对象定义者是创建它的用户。

        以下规则确定您可以将哪些帐户指定为`DEFINER`存储对象的属性：

- 如果您有SET_USER_ID 特权（或已弃用的 SUPER特权），则可以将任何帐户指定为DEFINER 属性。如果该帐户不存在，则会生成警告。此外，要将存储对象 DEFINER属性设置为具有权限的帐户SYSTEM_USER，您必须具有SYSTEM_USER 权限。
- 否则，唯一允许的帐户是您自己的帐户，按字面指定或指定为 CURRENT_USER或 CURRENT_USER()。您不能将定义者设置为任何其他帐户。

        使用不存在的
        `DEFINER`帐户创建存储对象会创建一个孤立对象，这可能会产生负面后果；请参阅
        孤立存储对象。

### SQL 安全特性

        对于存储例程（过程和函数）和视图，对象定义可以包括`SQL SECURITY`
        一个值为`DEFINER`or
        的特征，`INVOKER`以指定对象是在定义者上下文还是调用者上下文中执行。如果定义省略了`SQL SECURITY`特征，则默认为定义者上下文。

        触发器和事件没有`SQL SECURITY`
        特征并且总是在定义者上下文中执行。服务器根据需要自动调用这些对象，因此没有调用用户。

        定义者和调用者安全上下文的不同之处如下：

- 在定义者安全上下文中执行的存储对象以其 DEFINER属性命名的帐户的特权执行。这些权限可能与调用用户的权限完全不同。调用者必须具有适当的权限才能引用对象（例如，EXECUTE 调用存储过程或 SELECT从视图中进行选择），但在对象执行期间，调用者的权限将被忽略，只有DEFINER帐户权限才是重要的。如果该DEFINER帐户的权限很少，则该对象可以执行的操作会相应受到限制。如果 DEFINERaccount 是高特权的（例如管理账户），无论谁调用它，该对象都可以执行强大的操作。
- 在调用者安全上下文中执行的存储例程或视图只能执行调用者具有特权的操作。该DEFINER属性对对象执行没有影响。

### 例子

        考虑以下存储过程，它声明
        `SQL SECURITY DEFINER`为在定义者安全上下文中执行：

```sql
CREATE DEFINER = 'admin'@'localhost' PROCEDURE p1()
SQL SECURITY DEFINER
BEGIN
  UPDATE t1 SET counter = counter + 1;
END;
```

        任何拥有`EXECUTE`
        权限的用户都可以使用语句`p1`调用它
        。`CALL`但是，当
        `p1`执行时，它是在定义者安全上下文中执行的，因此
        `'admin'@'localhost'`以作为其
        `DEFINER`属性命名的帐户的特权执行。此帐户必须具有
        对象主体中引用的表
        的`EXECUTE`权限
        `p1`以及
        权限。否则，程序失败。
      `UPDATE``t1`

        现在考虑这个存储过程，
        `p1`除了它的`SQL SECURITY`特征是`INVOKER`：

```sql
CREATE DEFINER = 'admin'@'localhost' PROCEDURE p2()
SQL SECURITY INVOKER
BEGIN
  UPDATE t1 SET counter = counter + 1;
END;
```

        与 不同`p1`，`p2`在调用者安全上下文中执行，因此无论`DEFINER`
        属性值如何，都具有调用用户的特权。`p2`如果调用者缺少 table 的`EXECUTE`权限
        `p2`或
        `UPDATE`table 的权限，则
        失败`t1`。

### 孤儿存储对象

        孤立存储对象是其
        `DEFINER`属性命名为不存在的帐户的对象：

- 可以通过DEFINER在对象创建时指定一个不存在的帐户来创建一个孤立的存储对象。
- 现有的存储对象可以通过执行DROP USER 删除对象DEFINER 帐户的语句或RENAME USER 重命名对象DEFINER 帐户的语句而变得孤立。

        孤立的存储对象可能在这些方面有问题：

- 由于该DEFINER帐户不存在，如果对象在定义者安全上下文中执行，则该对象可能无法按预期工作： SQL SECURITY 对于存储例程，如果值为DEFINER但定义者帐户不存在， 则在例程执行时会发生错误。
- 对于触发器，在帐户实际存在之前激活触发器不是一个好主意。否则，关于特权检查的行为是未定义的。
- 对于事件，如果帐户不存在，则在事件执行时会发生错误。
- 对于视图，如果SQL SECURITY值为是 DEFINER但定义者帐户不存在，则在引用视图时会出错。

- DEFINER如果随后出于与对象无关的目的重新创建 不存在的帐户，则对象可能存在安全风险 。在这种情况下，该帐户“采用”了该对象，并且具有适当的权限，即使这不是有意的，也能够执行它。

        从 MySQL 8.0.22 开始，服务器实施了额外的帐户管理安全检查，旨在防止（可能无意中）导致存储对象成为孤立对象或导致采用当前孤立的存储对象的操作：

- DROP USER如果要删除的任何帐户被命名 DEFINER为任何存储对象的属性，则会失败并出现错误。（也就是说，如果删除帐户会导致存储的对象成为孤立对象，则该语句将失败。）
- RENAME USER如果要重命名的任何帐户被命名 DEFINER为任何存储对象的属性，则失败并出现错误。（也就是说，如果重命名帐户会导致存储的对象成为孤立对象，则该语句将失败。）
- CREATE USERDEFINER如果要创建的任何帐户被命名为任何存储对象的属性，则失败并出现错误 。（也就是说，如果创建一个帐户会导致该帐户采用当前孤立的存储对象，则该语句失败。）

        在某些情况下，可能有必要故意执行这些账户管理报表，即使它们可能会失败。为了使这成为可能，如果用户拥有
        `SET_USER_ID`特权，该特权将覆盖孤立对象安全检查，并且语句成功并发出警告而不是失败并出现错误。

        要获取有关在 MySQL 安装中用作存储对象定义者的帐户的信息，请查询
        `INFORMATION_SCHEMA`.

        此查询确定哪些
        `INFORMATION_SCHEMA`表描述了具有`DEFINER`属性的对象：

```sql
mysql> SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS
       WHERE COLUMN_NAME = 'DEFINER';
+--------------------+------------+
| TABLE_SCHEMA       | TABLE_NAME |
+--------------------+------------+
| information_schema | EVENTS     |
| information_schema | ROUTINES   |
| information_schema | TRIGGERS   |
| information_schema | VIEWS      |
+--------------------+------------+
```

        结果告诉您要查询哪些表以发现`DEFINER`存在哪些存储的对象值以及哪些对象具有特定`DEFINER`值：

- 要确定DEFINER每个表中存在哪些值，请使用以下查询： ```sql SELECT DISTINCT DEFINER FROM INFORMATION_SCHEMA.EVENTS; SELECT DISTINCT DEFINER FROM INFORMATION_SCHEMA.ROUTINES; SELECT DISTINCT DEFINER FROM INFORMATION_SCHEMA.TRIGGERS; SELECT DISTINCT DEFINER FROM INFORMATION_SCHEMA.VIEWS; ``` 查询结果对任何账户都有意义，显示如下： 如果该帐户存在，则删除或重命名它会导致存储的对象成为孤立对象。如果您打算删除或重命名帐户，请考虑首先删除其关联的存储对象或重新定义它们以具有不同的定义器。
- 如果该帐户不存在，则创建它会导致它采用当前孤立的存储对象。如果您计划创建帐户，请考虑是否应将孤立对象与其相关联。如果不是，请重新定义它们以具有不同的定义器。

            要使用不同的定义器重新定义对象，您可以使用
            `ALTER EVENT`或
            `ALTER VIEW`直接修改`DEFINER`事件和视图的帐户。对于存储过程和函数以及触发器，您必须删除对象并重新创建它以分配不同的
            `DEFINER`帐户

- 要确定哪些对象具有给定 DEFINER帐户，请使用这些查询，将感兴趣的帐户替换为 ： user_name@host_name ```sql SELECT EVENT_SCHEMA, EVENT_NAME FROM INFORMATION_SCHEMA.EVENTS WHERE DEFINER = 'user_name@host_name'; SELECT ROUTINE_SCHEMA, ROUTINE_NAME, ROUTINE_TYPE FROM INFORMATION_SCHEMA.ROUTINES WHERE DEFINER = 'user_name@host_name'; SELECT TRIGGER_SCHEMA, TRIGGER_NAME FROM INFORMATION_SCHEMA.TRIGGERS WHERE DEFINER = 'user_name@host_name'; SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE DEFINER = 'user_name@host_name'; ``` 对于ROUTINES表，查询包括ROUTINE_TYPE列，以便输出行区分 DEFINER是针对存储过程还是存储函数。 如果您要搜索的帐户不存在，则这些查询显示的任何对象都是孤立对象。

### 风险最小化指南

        为了最大限度地降低创建和使用存储对象的潜在风险，请遵循以下准则：

- 不要创建孤立的存储对象；也就是说，DEFINER属性为其命名不存在帐户的对象。不要通过删除或重命名由 DEFINER任何现有对象的属性命名的帐户来使存储的对象成为孤立对象。
- 对于存储的例程或视图，SQL SECURITY INVOKER尽可能在对象定义中使用，以便它只能由具有适合对象执行的操作权限的用户使用。
- SET_USER_ID如果您在使用具有权限（或已弃用权限） 的帐户时创建定义器上下文存储对象 SUPER，请指定一个显式DEFINER属性，该属性命名一个帐户，该帐户仅拥有对象执行的操作所需的权限。DEFINER仅在绝对必要时才 指定高特权帐户。
- 管理员可以通过不授予用户特权（或弃用的特权） 来阻止用户创建指定高特权 DEFINER帐户的 存储对象。SET_USER_IDSUPER
- 编写定义上下文对象时应牢记，它们可能能够访问调用用户没有权限的数据。在某些情况下，您可以通过不授予未经授权的用户特定权限来防止对这些对象的引用： 没有权限的用户不能引用存储的例程EXECUTE 。
- SELECT没有相应权限（从中选择、INSERT插入等） 的用户不能引用视图。

            但是，触发器和事件不存在这样的控制，因为它们总是在定义者上下文中执行。服务器根据需要自动调用这些对象，用户不会直接引用它们：

- 触发器通过访问与其关联的表来激活，即使是没有特殊权限的用户的普通表访问。
- 服务器按计划执行事件。

            在这两种情况下，如果`DEFINER`帐户具有高特权，则对象可能能够执行敏感或危险的操作。如果创建该对象所需的权限已从创建该对象的用户的帐户中撤消，则情况仍然如此。管理员在授予用户对象创建权限时应特别小心。

- 默认情况下，当SQL SECURITY DEFINER执行具有该特征的例程时，MySQL Server 不会为该DEFINER子句中指定的 MySQL 帐户设置任何活动角色，只会设置默认角色。例外情况 activate_all_roles_on_login 是启用了系统变量，在这种情况下，MySQL 服务器设置授予DEFINER用户的所有角色，包括强制角色。CREATE PROCEDURE因此，在发出or CREATE FUNCTION语句时，默认情况下不会检查通过角色授予的任何特权 。对于存储的程序，如果以不同于默认的角色执行，则程序主体可以执行 SET ROLE激活所需的角色。必须谨慎执行此操作，因为分配给角色的权限可以更改。

---

[← 返回 第 25 章 存储对象 索引](00-index.md) · [← 返回总索引](../00-index.md)
