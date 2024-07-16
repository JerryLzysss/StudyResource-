# TypeScript Number

## 使用
var num = new Number(value);
注意： 如果一个参数值不能转换为一个数字将返回 NaN (非数字值)。

## 对象属性
使用方法:a=Number.max_value
函数|作用
--|--
MAX_VALUE|最大值
MIN_VALUE|最小值
NaN|非数字
NEGATIVE_INFINITY|负无穷，溢出时返回该值，小于MIN_VALUE
POSITIVE_INFINITY|正无穷大，溢出时返回该值。该值大于 MAX_VALUE。
prototype|Number 对象的静态属性。使您有能力向对象添加属性和方法。
constructor|返回对创建此对象的 Number 函数的引用。

## 对象方法
使用方法:a=Number.toFixed()
函数|作用
--|--
toExponential()|把对象的值转换为指数计数法。
toFixed()|把数字转换为字符串，并对小数点指定位数
toLocaleString()|把数字转换为字符串，使用本地数字格式顺序。
toPrecision()|把数字格式化为指定的长度。
toString()|把数字转换为字符串，使用指定的基数。数字的基数是 2 ~ 36 之间的整数。若省略该参数，则使用基数 10。
valueOf()|返回一个 Number 对象的原始数字值。