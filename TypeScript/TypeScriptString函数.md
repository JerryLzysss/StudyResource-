# TypeScript String

## 使用
var txt = new String("string");
或者更简单方式：
var txt = "string";

## 对象属性
使用方法:a=Number.max_value
函数|作用
--|--
length|返回字符串的长度。
prototype|String 对象的静态属性。使您有能力向对象添加属性和方法。
constructor|返回对创建此对象的 String 函数的引用。

## 对象方法
使用方法:a=String.charAt(1);
函数|作用
--|--
charAt()|返回在指定位置的字符。
charCodeAt()|返回在指定的位置的字符的 Unicode 编码。
concat()|连接两个或更多字符串，并返回新的字符串。
indexOf()|返回某个指定的字符串值在字符串中首次出现的位置。
lastIndexOf()|从后向前搜索字符串，并从起始位置（0）开始计算返回字符串最后出现的位置。
localeCompare()|用本地特定的顺序来比较两个字符串。
match()|查找找到一个或多个正则表达式的匹配。
replace()|替换与正则表达式匹配的子串
search()|检索与正则表达式相匹配的值
slice()|提取字符串的片断，并在新的字符串中返回被提取的部分。
split()|把字符串分割为子字符串数组。
substr()|从起始索引号提取字符串中指定数目的字符。
substring()|提取字符串中两个指定的索引号之间的字符。
toLocaleLowerCase()|根据主机的语言环境把字符串转换为小写，只有几种语言（如土耳其语）具有地方特有的大小写映射。
toLocaleUpperCase()|根据主机的语言环境把字符串转换为大写，只有几种语言（如土耳其语）具有地方特有的大小写映射。
toLowerCase()|把字符串转换为小写。
toString()|返回字符串。
toUpperCase()|把字符串转换为大写。
valueOf()|返回指定字符串对象的原始值。