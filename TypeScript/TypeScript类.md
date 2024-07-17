[TOC]
# TypeScript类
TypeScript 是面向对象的 JavaScript。
类描述了所创建的对象共同的属性和方法。
TypeScript 支持面向对象的所有特性，比如 类、接口等。
# 创建
```
class x{
    name:string;
    constructor(name:string){
        this.name=name
    }
    con():void{
        console.log(this.name)
    }
}
```
# 实例化
```
var obj=new x("123")
obj.con()
```
# 继承
TypeScript 支持继承类，即我们可以在创建类的时候继承一个已存在的类，这个已存在的类称为父类，继承它的类称为子类。
类继承使用关键字 extends，子类除了不能继承父类的私有成员(方法和属性)和构造函数，其他的都可以继承。
TypeScript 一次只能继承一个类，不支持继承多个类，但 TypeScript 支持多重继承（A 继承 B，B 继承 C）。
```
class Shape { 
   Area:number 
   constructor(a:number) { 
      this.Area = a 
   } 
} 
class Circle extends Shape { 
   disp():void { 
      console.log("圆的面积:  "+this.Area) 
   } 
}
var obj = new Circle(223); 
obj.disp()
```
# 重写
类继承后，子类可以对父类的方法重新定义，这个过程称之为方法的重写。
其中 super 关键字是对父类的直接引用，该关键字可以引用父类的属性和方法。
```
class PrinterClass { 
   doPrint():void {
      console.log("父类的 doPrint() 方法。") 
   } 
} 
 
class StringPrinter extends PrinterClass { 
   doPrint():void { 
      super.doPrint() // 调用父类的函数
      console.log("子类的 doPrint()方法。")
   } 
}
```
# 静态
static 关键字
static 关键字用于定义类的数据成员（属性和方法）为静态的，静态成员可以直接通过类名调用。
```
class StaticMem {  
   static num:number; 
   
   static disp():void { 
      console.log("num 值为 "+ StaticMem.num) 
   } 
} 
staticMem.num=12
staticMem.disp()
```
# instanceof运算符
instanceof 运算符用于判断对象是否是指定的类型，如果是返回 true，否则返回 false。
```
class Person{ } 
var obj = new Person() 
var isPerson = obj instanceof Person; 
console.log("obj 对象是 Person 类实例化来的吗？ " + isPerson);
```

# 控制修饰符
TypeScript 中，可以使用访问控制符来保护对类、变量、方法和构造方法的访问。TypeScript 支持 3 种不同的访问权限。
public（默认） : 公有，可以在任何地方被访问。
protected : 受保护，可以被其自身以及其子类访问。
private : 私有，只能被其定义所在的类访问。

# 类和接口
类可以实现接口，使用关键implements，并将 interest 字段作为类的属性使用。
```
interface ILoan { 
   interest:number 
} 
 
class AgriLoan implements ILoan { 
   interest:number 
   rebate:number 
   
   constructor(interest:number,rebate:number) { 
      this.interest = interest 
      this.rebate = rebate 
   } 
} 
 
var obj = new AgriLoan(10,1) 
console.log("利润为 : "+obj.interest+"，抽成为 : "+obj.rebate )
```