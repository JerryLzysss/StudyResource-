[TOC]
# TypeScript指令与参数
## 组成
TypeScript 程序由以下几个部分组成：
* 模块
* 函数
* 变量
* 语句和表达式
* 注释
## 指令
* tsc xxx.ts 编译TS
* tsc xxx.ts yyy.ts zzz.ts 编译多个TS
* tsc xxx.ts --w 实时监测
除此之外还有以下参数

指令|参数
---|---
--help|显示帮助信息
--module|载入拓展
--target|设置版本
--declaration|额外生成一个.d.ts拓展名的文件
--removeComments|删除文件的注释
--out|编译多个文件合并到一个输出文件
--sourcemap|生成一个.map文件(存储与编译代码对应的信息)
--module noimplicitAny|在表达式和声明中具有隐含的any类型报错
--watch|监视模式下运行

## 关键字
1|2|3|4
---|---|---|---
break|as|catch|switch|
case|if|throw|else|
var|number|string|get|
module|type|instanceof|typeof
public|private|enum|export|
finally|for|while|void|
null|super|this|new|
in|return|true|false
any|extends|static|let
package|implements|interface|function
do|try|	yield|const
continue	 	 	 

## 空白和换行
TypeScript 会忽略程序中出现的空格、制表符和换行符。
空格、制表符通常用来缩进代码，使代码易于阅读和理解。

## 区分大小写
TypeScript 区分大写和小写字符。

## 分号是可选的
每行指令都是一段语句，你可以使用分号或不使用， 分号在 TypeScript 中是可选的，建议使用。
以下代码都是合法的：
```
console.log("Runoob")
console.log("Google");
```
如果语句写在同一行则一定需要使用分号来分隔，否则会报错，如：
```
console.log("Runoob");console.log("Google");
```
## TypeScript 注释
注释可以提高程序的可读性。
注释可以包含有关程序一些信息，如代码的作者，有关函数的说明等。
编译器会忽略注释。
## 两种类型的注释
单行注释 ( // ) − 在 // 后面的文字都是注释内容。
多行注释 (/* */) − 这种注释可以跨越多行。
注释实例：
```
// 这是一个单行注释
/* 
 这是一个多行注释 
 这是一个多行注释 
 这是一个多行注释 
*/
```