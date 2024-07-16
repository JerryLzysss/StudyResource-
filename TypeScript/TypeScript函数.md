[TOC]
# Typescript 函数

相比于JS的函数，相差比较明显。
## 返回值
返回值要与函数定义的返回类型一致
```
function greet():string
{
    return "hello world"
}
```
## 带参函数
```
function greet(name:string,age:number):string{
    return name;

}
```
## 可选参数
使用?来表示可选参数
```
function Name(firstname:string,lastname:string):string{
return firstname+lastname
}
function Name(firstname:string,lastname?:string):string{
return firstname+lastname
}
```
此时第一个函数必须有两个参数，而第二个参数可以有一个参数也可以有两个参数，其他情况均会报错。

## 默认参数
```
function Name(firstname:string,lastname:string='word'):string{
return firstname+lastname
}
```
## 剩余函数
当不知道要向函数传入多少个参数时可以使用arguments语法来实现传参。
```
function buildName(firstName: string, ...restOfName: string[]) {
    return firstName + " " + restOfName.join(" ");
}
  
let employeeName = buildName("Joseph", "Samuel", "Lucas", "MacKinzie");
```
此处firstname="joseph",其余函数则以数组的形式传入
## 匿名函数

匿名函数是一个没有函数名的函数。

匿名函数在程序运行时动态声明，除了没有函数名外，其他的与标准函数一样。

我们可以将匿名函数赋值给一个变量，这种表达式就成为函数表达式。

语法格式如下：
```
var s=function(){

}
```
### 匿名函数自调用
```
(function () { 
    var x = "Hello!!";   
    console.log(x)     
 })()
 ```

## 构造函数
TypeScript 也支持使用 JavaScript 内置的构造函数 Function() 来定义函数：

语法格式如下：
```
var myFunction = new Function("a", "b", "return a * b"); 
var x = myFunction(4, 3); 
```
## 箭头函数
```
var foo = (x:number)=>10 + x
```

## 函数重载
重载是方法名字相同，而参数不同，返回类型可以相同也可以不同。

每个重载的方法（或者构造函数）都必须有一个独一无二的参数类型列表。
```
参数类型不同：
function disp(string):void; 
function disp(number):void;

参数数量不同：
function disp(n1:number):void; 
function disp(x:number,y:number):void;

参数类型顺序不同：
function disp(n1:number,s1:string):void; 
function disp(s:string,n:number):void;
```