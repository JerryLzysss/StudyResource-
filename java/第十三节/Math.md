# 常用工具类（Math / 大数 / 日期 / System / Arrays）

## Math

概述：数学工具类，构造方法私有，方法多为静态。

常用方法：

- `abs(a)`：绝对值
- `floor(a)`：向下取整
- `ceil(a)`：向上取整
- `round(a)`：四舍五入
- `max(a, b)` / `min(a, b)`：最大/最小值

## BigInteger（大整数）

当数值超过 `long` 范围时使用。

- 构造：`BigInteger(String val)`
- 方法：`add` / `subtract` / `multiply` / `divide`

## BigDecimal（大浮点数）

`float` / `double` 运算可能有精度问题；金额等场景常用 `BigDecimal`。

- 构造：建议用 `BigDecimal(String val)`
- 除法注意：除不尽时要指定小数位和舍入模式，否则可能抛异常
  - `divide(divisor, scale, roundingMode)`
  - 常见舍入：`UP`、`DOWN`、`HALF_UP`（四舍五入）

## Date（日期）

表示特定瞬间，精确到毫秒。

- `new Date()`：当前时间
- `setTime(time)` / `getTime()`：设置/获取毫秒值

## Calendar（日历）

抽象类，常用 `Calendar.getInstance()` 获取实例。

- `get(field)` / `set(field, value)` / `add(field, count)`
- `getTime()`：转为 `Date`
- `field` 表示年、月、日、星期等字段

### 日期格式化 SimpleDateFormat

构造：`SimpleDateFormat(String pattern)`

| 字母 | 说明 |
|------|------|
| y | 年 |
| M | 月 |
| d | 日 |
| H | 时（0-23） |
| m | 分 |
| s | 秒 |

## 本地日期时间（java.time）

- `LocalDate.now()` / `LocalDate.of(year, month, day)`
- `withYear` / `withMonth` / `withDayOfMonth` 等调整字段
- `Period`：日期间隔（年/月/日）
- `Duration`：时间间隔（天/小时/分钟/毫秒等）

## System

系统相关工具类，构造私有，方法静态调用。

- `currentTimeMillis()`：当前毫秒时间戳
- `exit(status)`：终止 JVM
- `arraycopy(src, srcPos, dest, destPos, length)`：数组复制

## Arrays

- `toString(a)`：数组转字符串
- `sort(a)`：排序
- `binarySearch(a, key)`：二分查找（需先排序）
- `copyOf(original, newLength)`：复制并指定新长度
