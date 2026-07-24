# 第 12 章 函数和运算符 · 日期时间函数

> 对应 SQL：[`sql/refman/ch12-functions/08-date-and-time-functions.sql`](../../../sql/refman/ch12-functions/08-date-and-time-functions.sql)

---

## 12.7 日期和时间函数

      本节介绍可用于操作时间值的函数。请参阅
      第 11.2 节，“日期和时间数据类型”，了解每个日期和时间类型的值范围以及可以指定值的有效格式的描述。

**表 12.11 日期和时间函数**

| 姓名 | 描述 |
| --- | --- |
| ADDDATE() | 将时间值（间隔）添加到日期值 |
| ADDTIME() | 添加时间 |
| CONVERT_TZ() | 从一个时区转换为另一个时区 |
| CURDATE() | 返回当前日期 |
| CURRENT_DATE(),CURRENT_DATE | CURDATE() 的同义词 |
| CURRENT_TIME(),CURRENT_TIME | CURTIME() 的同义词 |
| CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP | NOW() 的同义词 |
| CURTIME() | 返回当前时间 |
| DATE() | 提取日期或日期时间表达式的日期部分 |
| DATE_ADD() | 将时间值（间隔）添加到日期值 |
| DATE_FORMAT() | 按指定格式设置日期 |
| DATE_SUB() | 从日期中减去时间值（间隔） |
| DATEDIFF() | 减去两个日期 |
| DAY() | DAYOFMONTH() 的同义词 |
| DAYNAME() | 返回工作日的名称 |
| DAYOFMONTH() | 返回月份中的第几天 (0-31) |
| DAYOFWEEK() | 返回参数的工作日索引 |
| DAYOFYEAR() | 返回一年中的第几天 (1-366) |
| EXTRACT() | 提取日期的一部分 |
| FROM_DAYS() | 将天数转换为日期 |
| FROM_UNIXTIME() | 将 Unix 时间戳格式化为日期 |
| GET_FORMAT() | 返回日期格式字符串 |
| HOUR() | 提取小时 |
| LAST_DAY | 返回参数月份的最后一天 |
| LOCALTIME(),LOCALTIME | NOW() 的同义词 |
| LOCALTIMESTAMP,LOCALTIMESTAMP() | NOW() 的同义词 |
| MAKEDATE() | 从年份和年份创建日期 |
| MAKETIME() | 从小时、分钟、秒创建时间 |
| MICROSECOND() | 从参数返回微秒 |
| MINUTE() | 从参数中返回分钟 |
| MONTH() | 从传递的日期返回月份 |
| MONTHNAME() | 返回月份名称 |
| NOW() | 返回当前日期和时间 |
| PERIOD_ADD() | 在年月中添加句点 |
| PERIOD_DIFF() | 返回期间之间的月数 |
| QUARTER() | 从日期参数返回季度 |
| SEC_TO_TIME() | 将秒数转换为 'hh:mm:ss' 格式 |
| SECOND() | 返回第二个 (0-59) |
| STR_TO_DATE() | 将字符串转换为日期 |
| SUBDATE() | 使用三个参数调用时 DATE_SUB() 的同义词 |
| SUBTIME() | 减去次数 |
| SYSDATE() | 返回函数执行的时间 |
| TIME() | 提取传递的表达式的时间部分 |
| TIME_FORMAT() | 格式化为时间 |
| TIME_TO_SEC() | 返回转换为秒的参数 |
| TIMEDIFF() | 减去时间 |
| TIMESTAMP() | 使用单个参数，此函数返回日期或日期时间表达式；有两个参数，参数之和 |
| TIMESTAMPADD() | 向日期时间表达式添加间隔 |
| TIMESTAMPDIFF() | 从日期时间表达式中减去一个间隔 |
| TO_DAYS() | 返回转换为天数的日期参数 |
| TO_SECONDS() | 返回自第 0 年以来转换为秒数的日期或日期时间参数 |
| UNIX_TIMESTAMP() | 返回一个 Unix 时间戳 |
| UTC_DATE() | 返回当前 UTC 日期 |
| UTC_TIME() | 返回当前 UTC 时间 |
| UTC_TIMESTAMP() | 返回当前 UTC 日期和时间 |
| WEEK() | 返回周数 |
| WEEKDAY() | 返回工作日索引 |
| WEEKOFYEAR() | 返回日期的日历周 (1-53) |
| YEAR() | 返回年份 |
| YEARWEEK() | 返回年份和星期 |

      这是一个使用日期函数的示例。以下查询选择具有*`date_col`*最近 30 天内值的所有行：

```sql
mysql> SELECT something FROM tbl_name
    -> WHERE DATE_SUB(CURDATE(),INTERVAL 30 DAY) “零”日期或不完整日期一起使用，例如`'2001-11-00'`，而其他函数则不能。提取部分日期的函数通常处理不完整的日期，因此当您可能期望非零值时可以返回 0。例如：

```sql
mysql> SELECT DAYOFMONTH('2001-11-00'), MONTH('2005-00-00');
        -> 0, 0
```

      其他函数需要完整的日期并返回
      `NULL`不完整的日期。这些包括执行日期算术或将部分日期映射到名称的函数。例如：

```sql
mysql> SELECT DATE_ADD('2006-05-00',INTERVAL 1 DAY);
        -> NULL
mysql> SELECT DAYNAME('2006-05-00');
        -> NULL
```

      几个函数在传递函数值作为参数时是严格的，
      并
      拒绝
      日
      部分
      为零
      `DATE()`的
      不
      完整
    日期
      ：
       `CONVERT_TZ()`,,,,,,,,,,,,,,
       。
      `DATE_ADD()``DATE_SUB()``DAYOFYEAR()``TIMESTAMPDIFF()``TO_DAYS()``TO_SECONDS()``WEEK()``WEEKDAY()``WEEKOFYEAR()``YEARWEEK()`

支持、 和值的
      小数秒`TIME`，

      精度可达微秒。采用时间参数的函数接受带有小数秒的值。时间函数的返回值包括适当的小数秒。
`DATETIME``TIMESTAMP`

- ADDDATE(date,INTERVAL expr unit), ADDDATE(date,days) 当以INTERVAL第二个参数的形式调用时，ADDDATE()是 的同义词DATE_ADD()。相关函数SUBDATE()是 的同义词DATE_SUB()。有关INTERVAL unit参数的信息，请参阅 时间间隔。 ```sql mysql> SELECT DATE_ADD('2008-01-02', INTERVAL 31 DAY); -> '2008-02-02' mysql> SELECT ADDDATE('2008-01-02', INTERVAL 31 DAY); -> '2008-02-02' ``` 当以days第二个参数的形式调用时，MySQL 将其视为要添加到的整数天数expr。 ```sql mysql> SELECT ADDDATE('2008-01-02', 31); -> '2008-02-02' ``` 此函数返回NULLif date或 daysis NULL。
- ADDTIME(expr1,expr2) ADDTIME()添加 并expr2返回 expr1结果。 expr1是时间或日期时间表达式，并且expr2是时间表达式。返回NULLif expr1或 expr2is NULL。 从 MySQL 8.0.28 开始，这个函数的返回类型和函数的返回类型SUBTIME()确定如下： 如果第一个参数是动态参数（例如在准备好的语句中），则返回类型为 TIME.
- 否则，函数的解析类型派生自第一个参数的解析类型。

```sql
mysql> SELECT ADDTIME('2007-12-31 23:59:59.999999', '1 1:1:1.000002');
        -> '2008-01-02 01:01:01.000001'
mysql> SELECT ADDTIME('01:00:00.999999', '02:00:00.999998');
        -> '03:00:01.999997'
```

- CONVERT_TZ(dt,from_tz,to_tz) CONVERT_TZ()将日期时间值dt从给定的时区转换为给定from_tz的时区to_tz并返回结果值。时区的指定如 第 5.1.15 节，“MySQL 服务器时区支持”中所述。NULL如果任何参数无效，或者其中任何一个是 ，则此函数返回 NULL。 在 32 位平台上，此函数支持的值范围与 TIMESTAMP类型相同（有关范围信息，请参阅 第 11.2.1 节“日期和时间数据类型语法”）。在 64 位平台上，从 MySQL 8.0.28 开始，支持的最大值为'3001-01-18 23:59:59.999999'UTC。 from_tz无论平台或 MySQL 版本如何，如果值在转换为 UTC 时超出支持的范围 ，则不会发生转换。 ```sql mysql> SELECT CONVERT_TZ('2004-01-01 12:00:00','GMT','MET'); -> '2004-01-01 13:00:00' mysql> SELECT CONVERT_TZ('2004-01-01 12:00:00','+00:00','+10:00'); -> '2004-01-01 22:00:00' ``` 笔记 要使用诸如'MET'或 'Europe/Amsterdam'之类的命名时区，必须正确设置时区表。有关说明，请参阅 第 5.1.15 节，“MySQL 服务器时区支持”。
- CURDATE() 将当前日期作为值 或 格式返回，具体取决于该函数是在字符串还是数字上下文中使用。 'YYYY-MM-DD'YYYYMMDD ```sql mysql> SELECT CURDATE(); -> '2008-06-13' mysql> SELECT CURDATE() + 0; -> 20080613 ```
- CURRENT_DATE, CURRENT_DATE() CURRENT_DATE并且 CURRENT_DATE()是 的同义词 CURDATE()。
- CURRENT_TIME, CURRENT_TIME([fsp]) CURRENT_TIME并且 CURRENT_TIME()是 的同义词 CURTIME()。
- CURRENT_TIMESTAMP, CURRENT_TIMESTAMP([fsp]) CURRENT_TIMESTAMP并且 CURRENT_TIMESTAMP()是 的同义词NOW()。
- CURTIME([fsp]) 将当前时间作为值 'hh:mm:ss'或 hhmmss格式返回，具体取决于该函数是在字符串还是数字上下文中使用。该值以会话时区表示。 如果fsp给出参数以指定从 0 到 6 的小数秒精度，则返回值包括那么多数字的小数秒部分。 ```sql mysql> SELECT CURTIME(); +-----------+ | CURTIME() | +-----------+ | 19:25:37 | +-----------+ mysql> SELECT CURTIME() + 0; +---------------+ | CURTIME() + 0 | +---------------+ | 192537 | +---------------+ mysql> SELECT CURTIME(3); +--------------+ | CURTIME(3) | +--------------+ | 19:25:37.840 | +--------------+ ```
- DATE(expr) 提取日期或日期时间表达式的日期部分 expr。返回 NULL如果expr是 NULL。 ```sql mysql> SELECT DATE('2003-12-31 01:02:03'); -> '2003-12-31' ```
- DATEDIFF(expr1,expr2) DATEDIFF()返回 expr1- expr2表示为从一个日期到另一个日期的天数。expr1 并且expr2是日期或日期和时间表达式。计算中仅使用值的日期部分。 ```sql mysql> SELECT DATEDIFF('2007-12-31 23:59:59','2007-12-30'); -> 1 mysql> SELECT DATEDIFF('2010-11-30 23:59:59','2010-12-31'); -> -31 ``` 此函数返回NULLif expr1或 expr2is NULL。
- DATE_ADD(date,INTERVAL expr unit), DATE_SUB(date,INTERVAL expr unit) 这些函数执行日期算术。该 date参数指定开始日期或日期时间值。 expr是一个表达式，指定要从开始日期添加或减去的间隔值。expr被评估为一个字符串；它可能-以负间隔开始。unit是一个关键字，指示应该解释表达式的单位。 有关时间间隔语法的更多信息，包括说明符的完整列表、每个值unit的参数的预期形式以及时间算术中操作数解释的规则，请参阅 时间间隔。 exprunit 返回值取决于参数： 如果date是 NULL，函数返回 NULL。
- DATE如果 date参数是一个 DATE值并且您的计算仅涉及YEAR、 MONTH和DAY部分（即，没有时间部分）。
- ( MySQL 8.0.28 及更高版本:) TIME如果 date参数是一个 TIME值并且计算只涉及HOURS, MINUTES, 和SECONDS部分（即没有日期部分）。
- DATETIME如果第一个参数是DATETIME（或 TIMESTAMP）值，或者如果第一个参数是 aDATE 并且unit值使用 HOURS、MINUTES或 SECONDS，或者如果第一个参数是类型TIME并且 unit值使用 YEAR、MONTH或 DAY。
- （MySQL 8.0.28 及更高版本:) 如果第一个参数是动态参数（例如，准备好的语句），则其解析类型是 DATE如果第二个参数是仅包含 、 或值的某种组合 YEAR的MONTH区间 DAY；否则，它的类型是 DATETIME.
- 否则为字符串（类型 VARCHAR）。

笔记

            在 MySQL 8.0.22 到 8.0.27 中，当在准备好的语句中使用时，这些函数返回
            `DATETIME`值而不考虑参数类型。（漏洞 #103781）

          为确保结果为
          `DATETIME`，您可以使用
          `CAST()`将第一个参数转换为`DATETIME`。

```sql
mysql> SELECT DATE_ADD('2018-05-01',INTERVAL 1 DAY);
        -> '2018-05-02'
mysql> SELECT DATE_SUB('2018-05-01',INTERVAL 1 YEAR);
        -> '2017-05-01'
mysql> SELECT DATE_ADD('2020-12-31 23:59:59',
    ->                 INTERVAL 1 SECOND);
        -> '2021-01-01 00:00:00'
mysql> SELECT DATE_ADD('2018-12-31 23:59:59',
    ->                 INTERVAL 1 DAY);
        -> '2019-01-01 23:59:59'
mysql> SELECT DATE_ADD('2100-12-31 23:59:59',
    ->                 INTERVAL '1:1' MINUTE_SECOND);
        -> '2101-01-01 00:01:00'
mysql> SELECT DATE_SUB('2025-01-01 00:00:00',
    ->                 INTERVAL '1 1:1:1' DAY_SECOND);
        -> '2024-12-30 22:58:59'
mysql> SELECT DATE_ADD('1900-01-01 00:00:00',
    ->                 INTERVAL '-1 10' DAY_HOUR);
        -> '1899-12-30 14:00:00'
mysql> SELECT DATE_SUB('1998-01-02', INTERVAL 31 DAY);
        -> '1997-12-02'
mysql> SELECT DATE_ADD('1992-12-31 23:59:59.000002',
    ->            INTERVAL '1.999999' SECOND_MICROSECOND);
        -> '1993-01-01 00:00:01.000001'
```

- DATE_FORMAT(date,format) date根据format字符串 格式化值。如果任一参数是NULL，则函数返回 NULL。 下表中显示的说明符可以在 format字符串中使用。该 %字符在格式说明符字符之前是必需的。说明符也适用于其他函数：STR_TO_DATE(), TIME_FORMAT(), UNIX_TIMESTAMP()。 说明符 描述 %a 缩写的工作日名称 ( Sun.. Sat) %b 缩写月份名称 ( Jan.. Dec) %c 月份，数字 ( 0.. 12) %D 带有英文后缀 ( 0th, 1st, 2nd, 3rd, …) %d 一个月中的第几天，数字 ( 00.. 31) %e 一个月中的第几天，数字 ( 0.. 31) %f 微秒 ( 000000.. 999999) %H 小时 ( 00.. 23) %h 小时 ( 01.. 12) %I 小时 ( 01.. 12) %i 分钟，数字 ( 00.. 59) %j 一年中的第几天 ( 001.. 366) %k 小时 ( 0.. 23) %l 小时 ( 1.. 12) %M 月份名称 ( January.. December) %m 月份，数字 ( 00.. 12) %p AM或者PM %r 时间，12 小时（hh:mm:ss后跟 AM或PM） %S 秒 ( 00.. 59) %s 秒 ( 00.. 59) %T 时间，24 小时 ( hh:mm:ss) %U 周 ( 00.. 53)，其中星期日是一周的第一天； WEEK()模式 0 %u 周 ( 00.. 53)，其中星期一是一周的第一天； WEEK()方式一 %V 周 ( 01.. 53)，其中星期日是一周的第一天； WEEK()方式二；与 %X %v 周 ( 01.. 53)，其中星期一是一周的第一天； WEEK()模式 3；与 %x %W 工作日名称 ( Sunday.. Saturday) %w 星期几（0=Sunday.. 6=Saturday） %X Year for week where Sunday is the first day of the week, numeric, 四位数字；与%V %x Year for week，其中Monday为一周的第一天，numeric，四位；与%v %Y 年份，数字，四位数字 %y 年份，数字（两位数） %% 文字%字符 %x x, 对于上面未列出的任何 “ x” 由于 MySQL 允许存储不完整的日期，例如'2014-00-00'. 用于日期和月份名称和缩写的语言由 lc_time_names系统变量的值控制（第 10.16 节，“MySQL 服务器区域设置支持”）。 对于%U、%u、 %V和%v说明符，请参阅 WEEK()函数说明以获取有关模式值的信息。该模式会影响周编号的发生方式。 DATE_FORMAT()返回一个字符串，该字符串具有由 character_set_connectionand 给出的字符集和排序规则，collation_connection因此它可以返回包含非 ASCII 字符的月份和星期名称。 ```sql mysql> SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y'); -> 'Sunday October 2009' mysql> SELECT DATE_FORMAT('2007-10-04 22:23:00', '%H:%i:%s'); -> '22:23:00' mysql> SELECT DATE_FORMAT('1900-10-04 22:23:00', -> '%D %y %a %d %m %b %j'); -> '4th 00 Thu 04 10 Oct 277' mysql> SELECT DATE_FORMAT('1997-10-04 22:23:00', -> '%H %k %I %r %T %S %w'); -> '22 22 10 10:23:00 PM 22:23:00 00 6' mysql> SELECT DATE_FORMAT('1999-01-01', '%X %V'); -> '1998 52' mysql> SELECT DATE_FORMAT('2006-06-00', '%d'); -> '00' ```
- DATE_SUB(date,INTERVAL expr unit) 请参阅说明 DATE_ADD()。
- DAY(date) DAY()是的同义词 DAYOFMONTH()。
- DAYNAME(date) 返回 的工作日名称 date。用于名称的语言由 lc_time_names系统变量的值控制（请参阅第 10.16 节，“MySQL 服务器区域设置支持”）。返回 NULL如果date是 NULL。 ```sql mysql> SELECT DAYNAME('2007-02-03'); -> 'Saturday' ```
- DAYOFMONTH(date) date返回 到范围内 1的 月中的第几天 31，或者 返回具有零日部分的或 之0类的日期 。返回如果 是。 '0000-00-00''2008-00-00'NULLdateNULL ```sql mysql> SELECT DAYOFMONTH('2007-02-03'); -> 3 ```
- DAYOFWEEK(date) 返回date ( 1= Sunday, 2= Monday, …, 7= Saturday) 的工作日索引。这些索引值对应于 ODBC 标准。返回 NULL如果date是 NULL。 ```sql mysql> SELECT DAYOFWEEK('2007-02-03'); -> 7 ```
- DAYOFYEAR(date) date返回范围 1为 的一年中的第几天 366。返回 NULL如果date是 NULL。 ```sql mysql> SELECT DAYOFYEAR('2007-02-03'); -> 34 ```
- EXTRACT(unit FROM date) 该函数使用与or EXTRACT()相同种类的unit说明符 ，但从日期中提取部分而不是执行日期算术。有关参数的信息，请参阅时间间隔。返回 如果是 。 DATE_ADD()DATE_SUB()unitNULLdateNULL ```sql mysql> SELECT EXTRACT(YEAR FROM '2019-07-02'); -> 2019 mysql> SELECT EXTRACT(YEAR_MONTH FROM '2019-07-02 01:02:03'); -> 201907 mysql> SELECT EXTRACT(DAY_MINUTE FROM '2019-07-02 01:02:03'); -> 20102 mysql> SELECT EXTRACT(MICROSECOND -> FROM '2003-01-02 10:30:00.000123'); -> 123 ```
- FROM_DAYS(N) 给定一个天数N，返回一个 DATE值。返回 NULL如果N是 NULL。 ```sql mysql> SELECT FROM_DAYS(730669); -> '2000-07-03' ``` FROM_DAYS()谨慎使用旧日期 。它不适用于公历 (1582) 出现之前的值。请参阅 第 12.9 节，“MySQL 使用什么日历？” .
- FROM_UNIXTIME(unix_timestamp[,format]) 返回 unix_timestamp日期时间或字符串值的表示形式。返回的值使用会话时区表示。（客户端可以设置会话时区，如第 5.1.15 节“MySQL 服务器时区支持”中所述。） unix_timestamp是一个内部时间戳值，表示自 '1970-01-01 00:00:00'UTC 以来的秒数，例如由UNIX_TIMESTAMP() 函数生成的。 如果format省略，则此函数返回一个DATETIME值。 如果unix_timestamp或 format是NULL，则此函数返回NULL。 如果unix_timestamp是整数，则小数秒精度 DATETIME为零。当 unix_timestamp为小数 时，datetime的小数秒精度DATETIME与小数精度相同，最大为6。当 unix_timestamp为浮点数时，datetime的小数秒精度为6。 在 32 位平台上，最大有用值为 unix_timestamp2147483647.999999，它返回'2038-01-19 03:14:07.999999'UTC。在运行 MySQL 8.0.28 或更高版本的 64 位平台上，有效最大值为 32536771199.999999，它返回'3001-01-18 23:59:59.999999'UTC。无论平台还是版本， unix_timestamp都比有效的最大回报值更大0。 formatDATE_FORMAT()用于以与用于函数的格式字符串相同的方式格式化结果 。如果 format提供，则返回的值为 a VARCHAR。 ```sql mysql> SELECT FROM_UNIXTIME(1447430881); -> '2015-11-13 10:08:01' mysql> SELECT FROM_UNIXTIME(1447430881) + 0; -> 20151113100801 mysql> SELECT FROM_UNIXTIME(1447430881, -> '%Y %D %M %h:%i:%s %x'); -> '2015 13th November 10:08:01 2015' ``` 笔记 如果您使用UNIX_TIMESTAMP() andFROM_UNIXTIME()在非 UTC 时区的值和 Unix 时间戳值之间进行转换，则转换是有损的，因为映射在两个方向上都不是一对一的。详情请见 UNIX_TIMESTAMP()功能说明。
- GET_FORMAT({DATE|TIME|DATETIME}, {'EUR'|'USA'|'JIS'|'ISO'|'INTERNAL'}) 返回格式字符串。DATE_FORMAT()此函数与和 函数结合使用时很有用 STR_TO_DATE()。 如果format是 NULL，则此函数返回 NULL。 第一个和第二个参数的可能值导致几种可能的格式字符串（对于使用的说明符，请参阅 DATE_FORMAT()函数描述中的表格）。ISO 格式是指 ISO 9075，而不是 ISO 8601。 函数调用 结果 GET_FORMAT(DATE,'USA') '%m.%d.%Y' GET_FORMAT(DATE,'JIS') '%Y-%m-%d' GET_FORMAT(DATE,'ISO') '%Y-%m-%d' GET_FORMAT(DATE,'EUR') '%d.%m.%Y' GET_FORMAT(DATE,'INTERNAL') '%Y%m%d' GET_FORMAT(DATETIME,'USA') '%Y-%m-%d %H.%i.%s' GET_FORMAT(DATETIME,'JIS') '%Y-%m-%d %H:%i:%s' GET_FORMAT(DATETIME,'ISO') '%Y-%m-%d %H:%i:%s' GET_FORMAT(DATETIME,'EUR') '%Y-%m-%d %H.%i.%s' GET_FORMAT(DATETIME,'INTERNAL') '%Y%m%d%H%i%s' GET_FORMAT(TIME,'USA') '%h:%i:%s %p' GET_FORMAT(TIME,'JIS') '%H:%i:%s' GET_FORMAT(TIME,'ISO') '%H:%i:%s' GET_FORMAT(TIME,'EUR') '%H.%i.%s' GET_FORMAT(TIME,'INTERNAL') '%H%i%s' TIMESTAMP也可以用作 的第一个参数 GET_FORMAT()，在这种情况下函数返回与 for 相同的值 DATETIME。 ```sql mysql> SELECT DATE_FORMAT('2003-10-03',GET_FORMAT(DATE,'EUR')); -> '03.10.2003' mysql> SELECT STR_TO_DATE('10.31.2003',GET_FORMAT(DATE,'USA')); -> '2003-10-31' ```
- HOUR(time) 返回 的小时time。返回值的范围是0到 23时间值。但是，TIME值的范围实际上要大得多，因此HOUR可以返回大于 的值23。返回 NULL如果time是 NULL。 ```sql mysql> SELECT HOUR('10:05:03'); -> 10 mysql> SELECT HOUR('272:59:59'); -> 272 ```
- LAST_DAY(date) 获取日期或日期时间值并返回该月最后一天的相应值。NULL如果参数无效或 ，则 返回 NULL。 ```sql mysql> SELECT LAST_DAY('2003-02-05'); -> '2003-02-28' mysql> SELECT LAST_DAY('2004-02-05'); -> '2004-02-29' mysql> SELECT LAST_DAY('2004-01-01 01:01:01'); -> '2004-01-31' mysql> SELECT LAST_DAY('2003-03-32'); -> NULL ```
- LOCALTIME, LOCALTIME([fsp]) LOCALTIME并且 LOCALTIME()是 的同义词 NOW()。
- LOCALTIMESTAMP, LOCALTIMESTAMP([fsp]) LOCALTIMESTAMP并且 LOCALTIMESTAMP()是 的同义词NOW()。
- MAKEDATE(year,dayofyear) 返回日期，给定年份和日期值。 dayofyear必须大于 0 否则结果为NULL. NULL如果任一参数为 ，结果也 为NULL。 ```sql mysql> SELECT MAKEDATE(2011,31), MAKEDATE(2011,32); -> '2011-01-31', '2011-02-01' mysql> SELECT MAKEDATE(2011,365), MAKEDATE(2014,365); -> '2011-12-31', '2014-12-31' mysql> SELECT MAKEDATE(2011,0); -> NULL ```
- MAKETIME(hour,minute,second) hour返回根据、 minute和 second参数 计算的时间值 。NULL如果它的任何参数是 ，则 返回 NULL。 second参数可以有小数部分 。 ```sql mysql> SELECT MAKETIME(12,15,30); -> '12:15:30' ```
- MICROSECOND(expr) 将时间或日期时间表达式中的微秒 作为从到expr范围内的数字 返回。返回 如果是 。 0999999NULLexprNULL ```sql mysql> SELECT MICROSECOND('12:00:00.123456'); -> 123456 mysql> SELECT MICROSECOND('2019-12-31 23:59:59.000010'); -> 10 ```
- MINUTE(time) 返回 的分钟time，在 的范围内0，59或者 NULL如果time是 NULL。 ```sql mysql> SELECT MINUTE('2008-02-03 10:05:03'); -> 5 ```
- MONTH(date) 返回1 月至 12 月date范围内1的月份，或 具有零月份部分的或之类的日期 。返回如果 是。 120'0000-00-00''2008-00-00'NULLdateNULL ```sql mysql> SELECT MONTH('2008-02-03'); -> 2 ```
- MONTHNAME(date) 返回 的月份的全名 date。用于名称的语言由 lc_time_names系统变量的值控制（第 10.16 节，“MySQL 服务器区域设置支持”）。返回 NULL如果date是 NULL。 ```sql mysql> SELECT MONTHNAME('2008-02-03'); -> 'February' ```
- NOW([fsp]) 以或 格式 返回当前日期和时间作为值 ，具体取决于该函数是在字符串还是数字上下文中使用。该值以会话时区表示。 'YYYY-MM-DD hh:mm:ss'YYYYMMDDhhmmss 如果fsp给出参数以指定从 0 到 6 的小数秒精度，则返回值包括那么多数字的小数秒部分。 ```sql mysql> SELECT NOW(); -> '2007-12-15 23:50:26' mysql> SELECT NOW() + 0; -> 20071215235026.000000 ``` NOW()返回一个常量时间，表示语句开始执行的时间。（在存储的函数或触发器中， NOW()返回函数或触发语句开始执行的时间。）这与 的行为不同 SYSDATE()，它返回执行的确切时间。 ```sql mysql> SELECT NOW(), SLEEP(2), NOW(); +---------------------+----------+---------------------+ | NOW() | SLEEP(2) | NOW() | +---------------------+----------+---------------------+ | 2006-04-12 13:47:36 | 0 | 2006-04-12 13:47:36 | +---------------------+----------+---------------------+ mysql> SELECT SYSDATE(), SLEEP(2), SYSDATE(); +---------------------+----------+---------------------+ | SYSDATE() | SLEEP(2) | SYSDATE() | +---------------------+----------+---------------------+ | 2006-04-12 13:47:44 | 0 | 2006-04-12 13:47:46 | +---------------------+----------+---------------------+ ``` 此外，该SET TIMESTAMP语句影响返回值 by NOW()但不影响 by SYSDATE()。这意味着二进制日志中的时间戳设置对SYSDATE(). 将时间戳设置为非零值会导致每次后续调用都NOW() 返回该值。将时间戳设置为零会取消此效果，以便NOW()再次返回当前日期和时间。 SYSDATE()有关这两个函数之间差异的更多信息， 请参阅说明 。
- PERIOD_ADD(P,N) 向句点添加N月份 P（格式为 YYMMor YYYYMM）。返回格式中的值YYYYMM。 笔记 period 参数P不是 日期值。 此函数返回NULLif P或N is NULL。 ```sql mysql> SELECT PERIOD_ADD(200801,2); -> 200803 ```
- PERIOD_DIFF(P1,P2) 返回期间 P1和 之间的月数P2。P1 并且P2应该采用 YYMMor 格式YYYYMM。请注意，句点参数P1和 P2不是日期 值。 此函数返回NULLif P1或P2 is NULL。 ```sql mysql> SELECT PERIOD_DIFF(200802,200703); -> 11 ```
- QUARTER(date) 返回 的一年中的季度 date，在 的范围内 1，4或者 NULL如果date是 NULL。 ```sql mysql> SELECT QUARTER('2008-04-01'); -> 2 ```
- SECOND(time) 返回第二个 for time，在范围内0to 59，或者 NULL如果time是 NULL。 ```sql mysql> SELECT SECOND('10:05:03'); -> 3 ```
- SEC_TO_TIME(seconds) 返回seconds转换为小时、分钟和秒的参数作为 TIME值。结果的范围限于 TIME数据类型的范围。如果参数对应于该范围之外的值，则会出现警告。 NULL如果 seconds是 则 该函数返回NULL。 ```sql mysql> SELECT SEC_TO_TIME(2378); -> '00:39:38' mysql> SELECT SEC_TO_TIME(2378) + 0; -> 3938 ```
- STR_TO_DATE(str,format) 这是函数的反 DATE_FORMAT()函数。它需要一个字符串str和一个格式字符串format。 如果格式字符串同时包含日期和时间部分，则 STR_TO_DATE()返回一个 值；如果字符串仅包含日期或时间部分，则返回一个或 值。如果 或 是，函数返回。如果从中提取的日期、时间或日期时间值 非法，则 返回 并产生警告。 DATETIMEDATETIMEstrformatNULLNULLstrSTR_TO_DATE()NULL 服务器扫描str试图匹配format它。格式字符串可以包含以 开头的文字字符和格式说明符%。中的文字字符 format必须与 中的文字匹配 str。中的格式说明符 format必须匹配中的日期或时间部分str。中可以使用format的说明符见 DATE_FORMAT()函数说明。 ```sql mysql> SELECT STR_TO_DATE('01,5,2013','%d,%m,%Y'); -> '2013-05-01' mysql> SELECT STR_TO_DATE('May 1, 2013','%M %d,%Y'); -> '2013-05-01' ``` 扫描从开头开始， str如果 format发现不匹配则失败。末尾的额外字符将str被忽略。 ```sql mysql> SELECT STR_TO_DATE('a09:30:17','a%h:%i:%s'); -> '09:30:17' mysql> SELECT STR_TO_DATE('a09:30:17','%h:%i:%s'); -> NULL mysql> SELECT STR_TO_DATE('09:30:17a','%h:%i:%s'); -> '09:30:17' ``` 未指定的日期或时间部分的值为 0，因此未完全指定的值会 str产生部分或所有部分设置为 0 的结果： ```sql mysql> SELECT STR_TO_DATE('abc','abc'); -> '0000-00-00' mysql> SELECT STR_TO_DATE('9','%m'); -> '0000-09-00' mysql> SELECT STR_TO_DATE('9','%s'); -> '00:00:09' ``` 日期值部分的范围检查如 第 11.2.2 节“DATE、DATETIME 和 TIMESTAMP 类型”中所述。这意味着，例如， “零”日期或部分值为 0 的日期是允许的，除非 SQL 模式设置为不允许此类值。 ```sql mysql> SELECT STR_TO_DATE('00/00/0000', '%m/%d/%Y'); -> '0000-00-00' mysql> SELECT STR_TO_DATE('04/31/2004', '%m/%d/%Y'); -> '2004-04-31' ``` 如果NO_ZERO_DATE启用了 SQL 模式，则不允许使用零日期。在这种情况下， STR_TO_DATE()返回 NULL并生成警告： ```sql mysql> SET sql_mode = ''; mysql> SELECT STR_TO_DATE('00/00/0000', '%m/%d/%Y'); +---------------------------------------+ | STR_TO_DATE('00/00/0000', '%m/%d/%Y') | +---------------------------------------+ | 0000-00-00 | +---------------------------------------+ mysql> SET sql_mode = 'NO_ZERO_DATE'; mysql> SELECT STR_TO_DATE('00/00/0000', '%m/%d/%Y'); +---------------------------------------+ | STR_TO_DATE('00/00/0000', '%m/%d/%Y') | +---------------------------------------+ | NULL | +---------------------------------------+ mysql> SHOW WARNINGS\G *************************** 1. row *************************** Level: Warning Code: 1411 Message: Incorrect datetime value: '00/00/0000' for function str_to_date ``` 笔记 您不能使用格式"%X%V"将年-周字符串转换为日期，因为如果周跨越月边界，年和周的组合不能唯一标识年和月。要将年-周转换为日期，您还应该指定工作日： ```sql mysql> SELECT STR_TO_DATE('200442 Monday', '%X%V %W'); -> '2004-10-18' ```
- SUBDATE(date,INTERVAL expr unit), SUBDATE(expr,days) 当以INTERVAL第二个参数的形式调用时，SUBDATE()是 的同义词DATE_SUB()。有关INTERVAL unit参数的信息，请参阅对 的讨论DATE_ADD()。 ```sql mysql> SELECT DATE_SUB('2008-01-02', INTERVAL 31 DAY); -> '2007-12-02' mysql> SELECT SUBDATE('2008-01-02', INTERVAL 31 DAY); -> '2007-12-02' ``` 第二种形式允许使用整数值 days。在这种情况下，它被解释为要从日期或日期时间表达式中减去的天数expr。 ```sql mysql> SELECT SUBDATE('2008-01-02 12:00:00', 31); -> '2007-12-02 12:00:00' ``` NULL如果它的任何参数是 ，则 此函数返回NULL。
- SUBTIME(expr1,expr2) SUBTIME()返回 expr1- expr2表示为与相同格式的值expr1。 expr1是时间或日期时间表达式，并且expr2是时间表达式。 这个函数的返回类型的解析是按照函数的原样执行的ADDTIME() ；有关详细信息，请参阅该功能的说明。 ```sql mysql> SELECT SUBTIME('2007-12-31 23:59:59.999999','1 1:1:1.000002'); -> '2007-12-30 22:58:58.999997' mysql> SELECT SUBTIME('01:00:00.999999', '02:00:00.999998'); -> '-00:59:59.999999' ``` 此函数返回NULLif expr1或 expr2is NULL。
- SYSDATE([fsp]) 以或 格式 返回当前日期和时间作为值 ，具体取决于该函数是在字符串还是数字上下文中使用。 'YYYY-MM-DD hh:mm:ss'YYYYMMDDhhmmss 如果fsp给出参数以指定从 0 到 6 的小数秒精度，则返回值包括那么多数字的小数秒部分。 SYSDATE()返回它执行的时间。这与 for 的行为不同 NOW()，后者返回一个常量时间，指示语句开始执行的时间。（在存储函数或触发器中， NOW()返回函数或触发语句开始执行的时间。） ```sql mysql> SELECT NOW(), SLEEP(2), NOW(); +---------------------+----------+---------------------+ | NOW() | SLEEP(2) | NOW() | +---------------------+----------+---------------------+ | 2006-04-12 13:47:36 | 0 | 2006-04-12 13:47:36 | +---------------------+----------+---------------------+ mysql> SELECT SYSDATE(), SLEEP(2), SYSDATE(); +---------------------+----------+---------------------+ | SYSDATE() | SLEEP(2) | SYSDATE() | +---------------------+----------+---------------------+ | 2006-04-12 13:47:44 | 0 | 2006-04-12 13:47:46 | +---------------------+----------+---------------------+ ``` 此外，该SET TIMESTAMP语句影响返回值 by NOW()但不影响 by SYSDATE()。这意味着二进制日志中的时间戳设置对SYSDATE(). 因为SYSDATE()即使在同一条语句中也可以返回不同的值，并且不受 影响SET TIMESTAMP，所以如果使用基于语句的二进制日志记录，它是不确定的，因此对于复制是不安全的。如果这是一个问题，您可以使用基于行的日志记录。 或者，您可以使用该 --sysdate-is-now选项使其SYSDATE()成为NOW(). 如果在复制源服务器和副本服务器上都使用该选项，则此方法有效。 的不确定性 SYSDATE()也意味着索引不能用于评估引用它的表达式。
- TIME(expr) 提取时间或日期时间表达式的时间部分 expr并将其作为字符串返回。返回NULL如果 expr是NULL。 此函数对于基于语句的复制是不安全的。如果您在 binlog_format设置为 时使用此功能，则会记录一条警告STATEMENT。 ```sql mysql> SELECT TIME('2003-12-31 01:02:03'); -> '01:02:03' mysql> SELECT TIME('2003-12-31 01:02:03.000123'); -> '01:02:03.000123' ```
- TIMEDIFF(expr1,expr2) TIMEDIFF()返回 expr1- expr2表示为时间值。 expr1and expr2是时间或日期和时间表达式，但两者必须属于同一类型。返回 NULLifexpr1或 expr2is NULL。 返回的结果TIMEDIFF()被限制在值允许的范围内 TIME。或者，您可以使用函数 TIMESTAMPDIFF()和 中的任何一个UNIX_TIMESTAMP()，它们都返回整数。 ```sql mysql> SELECT TIMEDIFF('2000-01-01 00:00:00', -> '2000-01-01 00:00:00.000001'); -> '-00:00:00.000001' mysql> SELECT TIMEDIFF('2008-12-31 23:59:59.000001', -> '2008-12-30 01:01:01.000002'); -> '46:58:57.999999' ```
- TIMESTAMP(expr), TIMESTAMP(expr1,expr2) 使用单个参数，此函数将日期或日期时间表达式expr作为日期时间值返回。使用两个参数，它将时间表达式添加expr2到日期或日期时间表达式expr1，并将结果作为日期时间值返回。返回 NULL如果expr、 expr1或 expr2是NULL。 ```sql mysql> SELECT TIMESTAMP('2003-12-31'); -> '2003-12-31 00:00:00' mysql> SELECT TIMESTAMP('2003-12-31 12:00:00','12:00:00'); -> '2004-01-01 00:00:00' ```
- TIMESTAMPADD(unit,interval,datetime_expr) 将整数表达式添加 interval到日期或日期时间表达式datetime_expr。的单位interval由参数给出 ，它 unit应该是以下值之一：（ MICROSECOND 微秒） 、、、、、、、、、或 。 SECONDMINUTEHOURDAYWEEKMONTHQUARTERYEARunit可以使用所示的关键字之一或使用前缀 来指定 该值SQL_TSI_。例如， DAY两者SQL_TSI_DAY都是合法的。 此函数返回NULLif interval或 datetime_expris NULL。 ```sql mysql> SELECT TIMESTAMPADD(MINUTE,1,'2003-01-02'); -> '2003-01-02 00:01:00' mysql> SELECT TIMESTAMPADD(WEEK,1,'2003-01-02'); -> '2003-01-09' ```
- TIMESTAMPDIFF(unit,datetime_expr1,datetime_expr2) 返回datetime_expr2− datetime_expr1，其中 datetime_expr1和 datetime_expr2是日期或日期时间表达式。一个表达式可以是日期，另一个可以是日期时间；'00:00:00'日期值在必要时被视为具有时间部分的日期时间。结果的单位（整数）由 unit参数给出。的合法值 与函数unit说明中列出的值相同 TIMESTAMPADD()。 此函数返回NULLif datetime_expr1或 datetime_expr2is NULL。 ```sql mysql> SELECT TIMESTAMPDIFF(MONTH,'2003-02-01','2003-05-01'); -> 3 mysql> SELECT TIMESTAMPDIFF(YEAR,'2002-05-01','2001-01-01'); -> -1 mysql> SELECT TIMESTAMPDIFF(MINUTE,'2003-02-01','2003-05-01 12:05:55'); -> 128885 ``` 笔记 TIMESTAMP()此函数的日期或日期时间参数的顺序与使用 2 个参数调用时函数 使用的顺序相反 。
- TIME_FORMAT(time,format) 这与 DATE_FORMAT()函数一样使用，但 format字符串可能仅包含小时、分钟、秒和微秒的格式说明符。其他说明符产生NULLor 0。TIME_FORMAT()返回 NULL如果time或是 。 format_NULL 如果该time值包含大于 的小时部分，则23和 %H小时%k格式说明符生成的值大于 的通常范围 0..23。其他小时格式说明符产生以 12 为模的小时值。 ```sql mysql> SELECT TIME_FORMAT('100:00:00', '%H %k %h %I %l'); -> '100 100 04 04 4' ```
- TIME_TO_SEC(time) 返回time参数，转换为秒。返回NULL如果 time是NULL。 ```sql mysql> SELECT TIME_TO_SEC('22:23:00'); -> 80580 mysql> SELECT TIME_TO_SEC('00:39:38'); -> 2378 ```
- TO_DAYS(date) 给定一个日期date，返回一个天数（从 0 年开始的天数）。返回 NULL如果date是 NULL。 ```sql mysql> SELECT TO_DAYS(950501); -> 728779 mysql> SELECT TO_DAYS('2007-10-07'); -> 733321 ``` TO_DAYS()不适用于公历 (1582) 出现之前的值，因为它不考虑更改日历时丢失的天数。对于 1582 年之前的日期（在其他语言环境中可能是更晚的年份），此函数的结果不可靠。请参阅 第 12.9 节，“MySQL 使用什么日历？” , 了解详情。 请记住，MySQL 使用第 11.2 节“日期和时间数据类型” 中的规则将日期中的两位数年份值转换为四位数形式 。例如， '2008-10-07'和 '08-10-07'被视为相同的日期： ```sql mysql> SELECT TO_DAYS('2008-10-07'), TO_DAYS('08-10-07'); -> 733687, 733687 ``` 在 MySQL 中，零日期定义为 '0000-00-00'，即使这个日期本身被认为是无效的。这意味着对于 '0000-00-00'和 '0000-01-01'， TO_DAYS()返回此处显示的值： ```sql mysql> SELECT TO_DAYS('0000-00-00'); +-----------------------+ | to_days('0000-00-00') | +-----------------------+ | NULL | +-----------------------+ 1 row in set, 1 warning (0.00 sec) mysql> SHOW WARNINGS; +---------+------+----------------------------------------+ | Level | Code | Message | +---------+------+----------------------------------------+ | Warning | 1292 | Incorrect datetime value: '0000-00-00' | +---------+------+----------------------------------------+ 1 row in set (0.00 sec) mysql> SELECT TO_DAYS('0000-01-01'); +-----------------------+ | to_days('0000-01-01') | +-----------------------+ | 1 | +-----------------------+ 1 row in set (0.00 sec) ``` 无论是否 ALLOW_INVALID_DATES启用 SQL 服务器模式都是如此。
- TO_SECONDS(expr) 给定日期或日期时间expr，返回自 0 年以来的秒数。如果 expr不是有效的日期或日期时间值（包括NULL），则返回 NULL。 ```sql mysql> SELECT TO_SECONDS(950501); -> 62966505600 mysql> SELECT TO_SECONDS('2009-11-29'); -> 63426672000 mysql> SELECT TO_SECONDS('2009-11-29 13:43:32'); -> 63426721412 mysql> SELECT TO_SECONDS( NOW() ); -> 63426721458 ``` 像TO_DAYS(), TO_SECONDS()不适用于公历 (1582) 出现之前的值，因为它不考虑更改日历时丢失的天数。对于 1582 年之前的日期（在其他语言环境中可能是更晚的年份），此函数的结果不可靠。请参阅 第 12.9 节，“MySQL 使用什么日历？” , 了解详情。 与TO_DAYS(), 一样，使用第 11.2 节“日期和时间数据类型”TO_SECONDS()中的规则将日期中的两位数年份值转换为四位数形式 。 在 MySQL 中，零日期定义为 '0000-00-00'，即使这个日期本身被认为是无效的。这意味着对于 '0000-00-00'和 '0000-01-01'， TO_SECONDS()返回此处显示的值： ```sql mysql> SELECT TO_SECONDS('0000-00-00'); +--------------------------+ | TO_SECONDS('0000-00-00') | +--------------------------+ | NULL | +--------------------------+ 1 row in set, 1 warning (0.00 sec) mysql> SHOW WARNINGS; +---------+------+----------------------------------------+ | Level | Code | Message | +---------+------+----------------------------------------+ | Warning | 1292 | Incorrect datetime value: '0000-00-00' | +---------+------+----------------------------------------+ 1 row in set (0.00 sec) mysql> SELECT TO_SECONDS('0000-01-01'); +--------------------------+ | TO_SECONDS('0000-01-01') | +--------------------------+ | 86400 | +--------------------------+ 1 row in set (0.00 sec) ``` 无论是否 ALLOW_INVALID_DATES启用 SQL 服务器模式都是如此。
- UNIX_TIMESTAMP([date]) 如果UNIX_TIMESTAMP()不带date参数调用，它返回一个 Unix 时间戳，表示自'1970-01-01 00:00:00'UTC 以来的秒数。 如果UNIX_TIMESTAMP()使用date参数调用，它将参数值返回为自 '1970-01-01 00:00:00'UTC 以来的秒数。服务器将其解释date为会话时区中的值，并将其转换为 UTC 中的内部 Unix 时间戳值。（客户端可以设置会话时区，如第 5.1.15 节“MySQL 服务器时区支持”中所述。） date参数可以是 DATE、 DATETIME或 TIMESTAMP字符串，或者YYMMDD、 YYMMDDhhmmss、 YYYYMMDD或 中的数字YYYYMMDDhhmmss格式。如果参数包含时间部分，则它可以选择包含小数秒部分。 如果没有给出参数或参数不包含小数秒部分，或者 DECIMAL如果给出的参数包含小数秒部分，则返回值是一个整数。 当date参数是一 TIMESTAMP列时， UNIX_TIMESTAMP()直接返回内部时间戳值，没有隐式 的“字符串到 Unix 时间戳”转换。 在 MySQL 8.0.28 之前，参数值的有效范围与TIMESTAMP 数据类型相同：'1970-01-01 00:00:01.000000'UTC 到'2038-01-19 03:14:07.999999'UTC。对于 32 位平台，MySQL 8.0.28 及更高版本也是如此。对于在64位平台上运行的MySQL 8.0.28及以后版本，参数值的有效范围 UNIX_TIMESTAMP()是'1970-01-01 00:00:01.000000'UTC到'3001-01-19 03:14:07.999999'UTC（对应32536771199.999999秒）。 无论 MySQL 版本或平台架构如何，如果您将超出范围的日期传递给 UNIX_TIMESTAMP()，它都会返回 0。如果date是 NULL，则返回NULL。 ```sql mysql> SELECT UNIX_TIMESTAMP(); -> 1447431666 mysql> SELECT UNIX_TIMESTAMP('2015-11-13 10:20:19'); -> 1447431619 mysql> SELECT UNIX_TIMESTAMP('2015-11-13 10:20:19.012'); -> 1447431619.012 ``` 如果您使用UNIX_TIMESTAMP()and FROM_UNIXTIME()在非 UTC 时区的值和 Unix 时间戳值之间进行转换，则转换是有损的，因为映射在两个方向上都不是一对一的。例如，由于夏令时 (DST) 等本地时区更改的约定，可以 UNIX_TIMESTAMP()将非 UTC 时区中不同的两个值映射到相同的 Unix 时间戳值。 FROM_UNIXTIME()将该值映射回原始值之一。下面是一个示例，使用MET 时区中不同的值： ```sql mysql> SET time_zone = 'MET'; mysql> SELECT UNIX_TIMESTAMP('2005-03-27 03:00:00'); +---------------------------------------+ | UNIX_TIMESTAMP('2005-03-27 03:00:00') | +---------------------------------------+ | 1111885200 | +---------------------------------------+ mysql> SELECT UNIX_TIMESTAMP('2005-03-27 02:00:00'); +---------------------------------------+ | UNIX_TIMESTAMP('2005-03-27 02:00:00') | +---------------------------------------+ | 1111885200 | +---------------------------------------+ mysql> SELECT FROM_UNIXTIME(1111885200); +---------------------------+ | FROM_UNIXTIME(1111885200) | +---------------------------+ | 2005-03-27 03:00:00 | +---------------------------+ ``` 笔记 要使用诸如'MET'或 'Europe/Amsterdam'之类的命名时区，必须正确设置时区表。有关说明，请参阅 第 5.1.15 节，“MySQL 服务器时区支持”。 如果要减去 UNIX_TIMESTAMP()列，您可能希望将它们转换为带符号的整数。请参阅 第 12.11 节，“Cast 函数和运算符”。
- UTC_DATE, UTC_DATE() 将当前 UTC 日期作为值 或 格式返回，具体取决于该函数是在字符串还是数字上下文中使用。 'YYYY-MM-DD'YYYYMMDD ```sql mysql> SELECT UTC_DATE(), UTC_DATE() + 0; -> '2003-08-14', 20030814 ```
- UTC_TIME, UTC_TIME([fsp]) 将当前 UTC 时间作为值 'hh:mm:ss'或 hhmmss格式返回，具体取决于该函数是在字符串还是数字上下文中使用。 如果fsp给出参数以指定从 0 到 6 的小数秒精度，则返回值包括那么多数字的小数秒部分。 ```sql mysql> SELECT UTC_TIME(), UTC_TIME() + 0; -> '18:07:53', 180753.000000 ```
- UTC_TIMESTAMP, UTC_TIMESTAMP([fsp]) 以或 格式 返回当前 UTC 日期和时间 ，具体取决于该函数是在字符串还是数字上下文中使用。 'YYYY-MM-DD hh:mm:ss'YYYYMMDDhhmmss 如果fsp给出参数以指定从 0 到 6 的小数秒精度，则返回值包括那么多数字的小数秒部分。 ```sql mysql> SELECT UTC_TIMESTAMP(), UTC_TIMESTAMP() + 0; -> '2003-08-14 18:08:04', 20030814180804.000000 ```
- WEEK(date[,mode]) 此函数返回 的周数 date。的双参数形式 WEEK()使您能够指定一周是从星期日还是星期一开始，以及返回值应该在从0 到53还是从1到 的范围内53。如果mode 省略参数， default_week_format则使用系统变量的值。请参阅 第 5.1.8 节，“服务器系统变量”。对于 NULL日期值，函数返回 NULL。 下表描述了 mode参数的工作原理。 模式 一周的第一天 范围 第一周是第一周…… 0 星期日 0-53 今年有个星期天 1个 周一 0-53 今年有 4 天或更多天 2个 星期日 1-53 今年有个星期天 3个 周一 1-53 今年有 4 天或更多天 4个 星期日 0-53 今年有 4 天或更多天 5个 周一 0-53 今年有一个星期一 6个 星期日 1-53 今年有 4 天或更多天 7 周一 1-53 今年有一个星期一 对于mode含义为 “今年有 4 天或更多天”的值，周数根据 ISO 8601:1988 进行编号： 如果包含 1 月 1 日的一周在新年中有 4 天或更多天，则为第 1 周。
- 否则为上一年的最后一周，下周为第 1 周。

```sql
mysql> SELECT WEEK('2008-02-20');
        -> 7
mysql> SELECT WEEK('2008-02-20',0);
        -> 7
mysql> SELECT WEEK('2008-02-20',1);
        -> 8
mysql> SELECT WEEK('2008-12-31',1);
        -> 53
```

          如果日期落在前一年的最后一周，`0`如果您不使用
          `2`, `3`,
           `6`, 或`7`作为可选
          *`mode`*参数，MySQL 将返回：

```sql
mysql> SELECT YEAR('2000-01-01'), WEEK('2000-01-01',0);
        -> 2000, 0
```

          有人可能会争辩说`WEEK()`
          应该返回`52`，因为给定的日期实际上是在 1999 年的第 52 周。
          `WEEK()`返回
          `0`而不是返回值是
          “给定年份的周数。”`WEEK()`当与从日期中提取日期部分的其他函数结合
        使用时，这使得该函数的使用更加可靠。

          如果您希望根据包含给定日期的一周的第一天的年份评估结果，请使用
          `0`、`2`、
          `5`或`7`作为可选
          *`mode`*参数。

```sql
mysql> SELECT WEEK('2000-01-01',2);
        -> 52
```

          或者，使用
          `YEARWEEK()`函数：

```sql
mysql> SELECT YEARWEEK('2000-01-01');
        -> 199952
mysql> SELECT MID(YEARWEEK('2000-01-01'),5,2);
        -> '52'
```

- WEEKDAY(date) 返回date ( 0= Monday, 1= Tuesday, … 6= Sunday) 的工作日索引。返回 NULL如果date是 NULL。 ```sql mysql> SELECT WEEKDAY('2008-02-03 22:23:00'); -> 6 mysql> SELECT WEEKDAY('2007-11-06'); -> 1 ```
- WEEKOFYEAR(date) 1以从到 范围内的数字形式返回日期的日历周53。返回 NULL如果date是 NULL。 WEEKOFYEAR()是一个兼容函数，等价于 . WEEK(date,3) ```sql mysql> SELECT WEEKOFYEAR('2008-02-20'); -> 8 ```
- YEAR(date) 返回 到date范围内1000或9999“ 零”日期的0年份。返回 如果是 。 NULLdateNULL ```sql mysql> SELECT YEAR('1987-01-01'); -> 1987 ```
- YEARWEEK(date), YEARWEEK(date,mode) 返回日期的年和周。对于一年的第一周和最后一周，结果中的年份可能与日期参数中的年份不同。返回NULL 如果date是NULL。 该参数与 的参数 mode完全一样。对于单参数语法，使用值 0。不同的是，值 不影响。 modeWEEK()modeWEEK()default_week_formatYEARWEEK() ```sql mysql> SELECT YEARWEEK('1987-01-01'); -> 198652 ``` 周数不同于 函数为可选参数 WEEK()返回的 ( )或，因为 然后返回给定年份上下文中的周数。 001WEEK()

---

[← 返回 第 12 章 函数和运算符 索引](00-index.md) · [← 返回总索引](../00-index.md)
