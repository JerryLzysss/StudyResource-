# TypeScript声明文件
TypeScript 作为 JavaScript 的超集，在开发过程中不可避免要引用其他第三方的 JavaScript 的库。虽然通过直接引用可以调用库的类和方法，但是却无法使用TypeScript 诸如类型检查等特性功能。为了解决这个问题，需要将这些库里的函数和方法体去掉后只保留导出类型声明，而产生了一个描述 JavaScript 库和模块信息的声明文件。通过引用这个声明文件，就可以借用 TypeScript 的各种特性来使用库文件了。
# 例子
我们需要使用 declare 关键字来定义它的类型，帮助 TypeScript 判断我们传入的参数类型对不对：
declare var jQuery: (selector: string) => any;

jQuery('#foo');
declare 定义的类型只会用于编译时的检查，编译结果中会被删除。

上例的编译结果是：
jQuery('#foo');

声明文件以 .d.ts 为后缀，例如：
runoob.d.ts
声明文件或模块的语法格式如下：
declare module Module_Name {
}
TypeScript 引入声明文件语法格式：
/// <reference path = " runoob.d.ts" />

如果我们想在 TypeScript 中引用上面的代码，则需要设置声明文件 Calc.d.ts，代码如下：

Calc.d.ts 文件代码：
declare module Runoob { 
   export class Calc { 
      doSum(limit:number) : number; 
   }
}
声明文件不包含实现，它只是类型声明，把声明文件加入到 TypeScript 中：

CalcTest.ts 文件代码：
/// <reference path = "Calc.d.ts" /> 
var obj = new Runoob.Calc(); 
// obj.doSum("Hello"); // 编译错误
console.log(obj.doSum(10));