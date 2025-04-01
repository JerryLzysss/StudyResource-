[TOC]
# String
# 概述
String 类代表字符串
# 特点
* 凡是带双引号""的都表示string的对象
* 字符串是常量，创建之后不能更改
# 实现原理
jdk8之前是final修饰的char数组
jdk9之后是final修饰的byte数组
作用:节省空间
# 方法
通过使用String的方法API可以快速完成对字符串的增删改查
## 创建
* String():利用无参构造
* String(String original)：根据字符串构建String
* String(char []value)根据char数组构建
* String(byte []value)根据byte数组构建
* String(char[]value,int offset,int count)将char数组的一部分转为string
* String(char[]bytes int offset,int length)
    * offset:开始的索引
    * length/count:长度
## 拼接
字符串拼接，如果等号右边是字符串字面值拼接不会产生新对象。
例如:s1="abc",s1=="abc",比较值
字符串拼接，如果等号右边带有字符串变量，那么会产生新对象。
例如:s1="abcdef",s2="abc",s3=s2+"def",s1!=s3,比较地址

## 比较
String== 比较字符串地址
String.equals() 比较字符串内容
String.equalsIgnoreCase() 比较字符串内容无视大小写

## 获取
length() 获取字符串长度
concat(String) 字符串拼接
charAt(int) 获取索引对应对的卫子夫
indexOf(string )获取第一次出现的位置
substring(int,int?)只有一个参数表示到末尾，两个参数则是从前面到尾部

## 转换
toCharArray()转为char数组
getBytes()转为byte数组
replace(c1,c2)替换字符
getBytes("utf-8")将字符串改为对应的编码形式

## 分割
split(regex) 根据规则分割字符串
contains() 判断是否包含指定字符串
endsWith() 判断是否以指定字符串结尾
toLowerCase() 将字母转换为小写
toUpperCase() 将字母转为大写
trim() 去掉两边空格

# StringBuilder
概述:一个可变的字符序列，提供一个与StringBuffer兼容的API,不保证同步，线程不安全，效率高
## 作用
主要是字符串拼接,在String拼接的时候就会产生新的字符串对象.而使用StringBuilder每次拼接后都会在缓冲区中保存，不会随意产生对象
## 特点
* 底层自带缓冲区，没有被final修饰的byte,默认长度为16.
* 如果超出了数组长度，数组会扩容，创建了一个新长度的新数组，将老数组的元素赋值到新数组中
* 默认每次扩容老数组的2倍+2
## 方法
StringBuilder()
StringBuilder(str)
StringBuilder append(str) 字符串最后拼接str
StringBuilder reverse() 字符串翻转
StringBuilder toString() 将stringbuilder转为string
## StringBuffer
StringBuffer与StringBuilder在用法和作用一致
效率:Builder比Buffer高
但是Buffer比Builder线程更安全