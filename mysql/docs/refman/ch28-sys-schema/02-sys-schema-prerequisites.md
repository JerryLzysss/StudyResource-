# 第 28 章 MySQL 系统模式 · 先决条件

> 对应 SQL：[`sql/refman/ch28-sys-schema/02-sys-schema-prerequisites.sql`](../../../sql/refman/ch28-sys-schema/02-sys-schema-prerequisites.sql)

---

## 28.1 使用 sys 模式的先决条件

      在使用`sys`模式之前，必须满足本节中描述的先决条件。

      因为`sys`模式提供了访问性能模式的替代方法，所以必须启用性能模式才能使
      `sys`模式工作。请参阅
      第 27.3 节，“性能模式启动配置”。

      要完全访问`sys`架构，用户必须具有以下权限：

- SELECT在所有 sys表和视图 上
- EXECUTE在所有 sys存储过程和函数 上
- INSERTUPDATE对于 表格， sys_config如果要对其进行更改
- 某些模式存储过程和函数的附加权限 sys，如其描述中所述（例如， ps_setup_save()过程）

      还需要对`sys`模式对象下的对象具有特权：

- SELECT在模式对象访问的任何性能模式表上sys ，以及UPDATE使用 sys模式对象 更新的任何表
- PROCESS对于 INFORMATION_SCHEMA INNODB_BUFFER_PAGE表

      必须启用某些 Performance Schema 工具和消费者，并且（对于工具）定时以充分利用
      `sys`模式功能：

- 所有wait仪器
- 所有stage仪器
- 所有statement仪器
- xxx_current和 xxx_history_long 所有事件的消费者

      您可以使用`sys`架构本身来启用所有其他工具和消费者：

```sql
CALL sys.ps_setup_enable_instrument('wait');
CALL sys.ps_setup_enable_instrument('stage');
CALL sys.ps_setup_enable_instrument('statement');
CALL sys.ps_setup_enable_consumer('current');
CALL sys.ps_setup_enable_consumer('history_long');
```

笔记

        对于`sys`模式的许多用途，默认的性能模式足以用于数据收集。启用刚才提到的所有仪器和消费者都会影响性能，因此最好只启用您需要的额外配置。另外，请记住，如果启用其他配置，则可以像这样轻松恢复默认配置：

```sql
CALL sys.ps_setup_reset_to_default(TRUE);
```

---

[← 返回 第 28 章 MySQL 系统模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
