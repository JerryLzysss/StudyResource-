# Math
概述:数学工具类
作用:用于数学计算
特点:构造方法私有化，方法都是静态
# 常用
abs(a) 求绝对值
floor(a) 向下取整
ceil(a)向上取整
round(a)四舍五入
max(a,b)取最大值
min(a,b)取最小值
# 大整数
概述:当数值非常大，比long还要大的时候，这时候就涉及到BigInteger了，
构造:BigInteger(String val)
方法:BigInteger add(BigInteger val)加法
BigInteger subtract(BigInteger val)减法
BigInteger multiply(BigInteger val)乘法
BigInteger divid(BigInteger val)除法

# 大浮点数
描述:当float和double做运算的时候会导致精度损失.
作用:主要是用来解决float和double做运算导致的精度损失
构造:BigDecimal(String val)-->val必须是数字形式
方法:与BigInteger相似，但是需要注意的是除不尽则需要进行指定保留位数，否则会报错.
BigDecimal divide(val)
BigDecimal divide(divisior,scale,roundingMode)
divisior:除数
scale:指定保留几位小数
roundingMode:取舍方式
UP->增1
DOWN->保留整数
HALF_UP->四舍五入

# 日期
概述:表示特定的瞬间，精准到毫秒
概述:new Date()获取当前时间
setTime(time)设置时间
getTime()获取当前时间

# 日历
概述:日历类,抽象类
获取:getInstance()
方法:get(field)获取对应日期对应值
set(field,value)将给定的日历字段设置为指定值
add(field,count)根据日历时间添加或者减去值得顶的时间量
getTime()将calendar转成Date对象
field代表的是年月日星期等等
## 日历格式化
概述:日期格式化类
构造:SimpleDataFormat(String pattern)
例如y,M,d,H,m,S
字母|说明
---|---
y|年
M|月
d|日
H|时
m|分
s|秒

## 本地日期
LocalDate是一个不可变的日期对象，表示日期，通常被视为年月日
LocalDate now()创建LocalDate of(year,month,day)创建LocalDate对象，设置年月日
withYear/Month/Day 设置年月日
withDayOfMonth 设置月份中的天数

Period.getYears 获取相差年
Period.getMonths 获取相差月
Period.getDays 获取相差日
Duration.toDays 获取相差天数
Duration.toHours 获取相差小时
Duration.toMinutes 获取相差分钟
Duration.toMillis 获取相差毫秒

# 系统
概述:系统相关类，是一个工具类
特点:构造私有，不能利用new对象建立
方法都是静态的直接调用即可.
currentTimeMillis()返回以毫秒的当前时间
exit(status)终止当前运行的java虚拟机
arraycopy(src,srcPos,dest,destPos,length)数组复制
src:原数组
dest:目标数组
pos:从哪个索引开始
length:赋值多少个元素
# 数组
toString(a[]) 数组转为字符串
sort(a[]) 排序
binarySearch(a[],key) 二分
copyOf(original[],Length)
