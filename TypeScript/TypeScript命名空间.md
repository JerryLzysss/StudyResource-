# TypeScript命名空间

命名空间一个最明确的目的就是解决重名问题。
命名空间定义了标识符的可见范围，一个标识符可在多个命名空间中定义，它在不同命名空间中的含义是互不相干的。这样，在一个新的命名空间中可定义任何标识符，它们不会与任何已有的标识符发生冲突，因为已有的定义都处于其他命名空间中。
TypeScript 中命名空间使用 namespace 来定义.
# 创建
namespace xxx{
    export class yyy{}
    export interface zzz{}
}
```
namespace Drawing { 
    export interface IShape { 
        draw(); 
    }
}
namespace Drawing { 
    export class Circle implements IShape { 
        public draw() { 
            console.log("Circle is drawn"); 
        }  
    }
}
namespace Drawing { 
    export class Triangle implements IShape { 
        public draw() { 
            console.log("Triangle is drawn"); 
        } 
    } 
}
function drawAllShapes(shape:Drawing.IShape) { 
    shape.draw(); 
} 
drawAllShapes(new Drawing.Circle());
drawAllShapes(new Drawing.Triangle());
在上述例子中，虽然都是使用的Drawing的命名空间，但是之间互相独立。

```
# 嵌套
命名空间支持嵌套，即你可以将命名空间定义在另外一个命名空间里头。
成员的访问使用点号 . 来实现，如下实例：
```
namespace namespace_name1 { 
    export namespace namespace_name2 {
        export class class_name {    } 
    } 
}
namespace Runoob { 
   export namespace invoiceApp { 
      export class Invoice { 
         public calculateDiscount(price: number) { 
            return price * .40; 
         } 
      } 
   } 
}
```
