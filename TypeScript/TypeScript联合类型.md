[TOC]
# TypeScript联合类型
联合类型（Union Types）可以通过管道(|)将变量设置多种类型，赋值时可以根据设置的类型来赋值。
注意：只能赋值指定的类型，如果赋值其它类型就会报错。
创建联合类型的语法格式如下：
Type1|Type2|Type3 
# 创建
```
var val:string|number
val=12
console.log(val)
val='noob'
console.log(val)
val=true<!-- 报错 -->
```
# 函数传递
```
function disp(name:string|string[]) { 
        if(typeof name == "string") { 
                console.log(name) 
        } else { 
                var i; 
                for(i = 0;i<name.length;i++) { 
                console.log(name[i])
                } 
        } 
} 
```
# 数组创建
```
var arr:number[]|string[]; 
var i:number; 
arr = [1,2,4] 
console.log("**数字数组**")  
 
for(i = 0;i<arr.length;i++) { 
   console.log(arr[i]) 
}  
 
arr = ["Runoob","Google","Taobao"] 
console.log("**字符串数组**")  
 
for(i = 0;i<arr.length;i++) { 
   console.log(arr[i]) 
}
```