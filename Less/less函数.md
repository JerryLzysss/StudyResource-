[TOC]
# less函数

### 注:此处是将官网的函数做出部分挑选

## 逻辑函数

### if
格式:if((条件),true执行,False执行)
```
div {
    margin: if((2 > 1), 0, 3px);
    color:  if((iscolor(@some)), @some, black);
}
```
### boolean
格式:boolean(条件)=>true/false
```
@bg: black;
@bg-light: boolean(luma(@bg) > 50%);
div {
  background: @bg; 
  color: if(@bg-light, black, white);
}
```

## 字符串函数

### escape
作用:将可转义字符进行转义
这些字符不能进行转义:
1.```,```
2.```/```
3.```?```
4.```@```
5.```&```
6.```+```
7.```'```
8.```~```
9.```!```
10.```$```
这些字符可以转义:
1.```空格```
2.```#```
3.```^```
4.```(```
5.```)```
6.```{```
7.```}```
8.```|```
9.```:```
10.```>```
11.```<```
12.```;```
13.```[```
14.```]```
15.```=```
例如:```escape('a=1')=>a%3D1```
注意的是:如果参数不是一个字符串，输出的结果将会是未定义

### e
这个函数的作用是去掉参数中的引号
例如:
```
Input:
@mscode: "ms:alwaysHasItsOwnSyntax.For.Stuff()" 
filter: e(@mscode);
Output:
filter: ms:alwaysHasItsOwnSyntax.For.Stuff();
```

### format
跳过，感觉用不到

### replace
函数:replace(原字符串,旧部分内容，新内容)
```
Example:
replace("Hello, Mars?", "Mars\?", "Earth!");
replace("One + one = 4", "one", "2", "gi");
replace('This is a string.', "(string)\.$", "new $1.");
replace(~"bar-1", '1', '2');

Result:
"Hello, Earth!";
"2 + 2 = 4";
'This is a new string.';
bar-2;
``` 

## 列表函数

### length
作用:返回元素的列表长度
```
example:length(1px solid #0080ff);
result:3
```

### extract
作用:返回对应元素索引的值
```
example:extract(8px dot red,2)
result:dot
```

### range
作用:相当于循环执行
```
example:range(4)
result:1 2 3 4
example:range(10px 30px 10)
result:10px 20px 30px
```

### each(3.7+版本的less)
作用:对列表的值映射绑定
注意:此处可选的一共有三个值
@value,@key,@index
默认情况下为{@value,@key,@index}
```
example:
@list:1,2,3
each(@list,{
    .list-item-{@value}
    {
        a:b
    }
})

result:
.list-item-1{
    a:b
}
.list-item-2{
    a:b
}
.list-item-3{
    a:b
}
```


### each+range(3.9+版本的less)
```
Example:
each(range(4), {
  .col-@{value} {
    height: (@value * 50px);
  }
});

Outputs:
.col-1 {
  height: 50px;
}
.col-2 {
  height: 100px;
}
.col-3 {
  height: 150px;
}
.col-4 {
  height: 200px;
}
```

## 数学函数
包括以下几种,用途和js的一致.
函数|结果|描述
---|---|---
ceil(2.4)| (输出 3)|向上舍入到下一个最大整数 
floor(2.6) |(输出 2)|向下舍入到下一个最小整数 
percentage(0.5)| (输出 50%)|将浮点数转换为百分比字符串 
round(1.67)| (输出 2)|应用舍入 
sqrt(25cm) |(输出 5cm)|计算数字的平方根。保持单位不变 
abs(25cm) |(输出 25cm)|计算数字的绝对值。 保持单位不变 
sin(1deg)| (输出 0.01745240643728351)|计算正弦函数| 
asin(-0.8414709848078965)| (输出 -1rad)|计算反正弦（正弦的倒数）函数 
cos(1deg)| (输出 0.9998476951563913)|计算余弦函数 
acos(0.5403023058681398)| (输出 1rad)|计算反余弦（余弦的倒数）函数 
tan(1deg) |(输出 0.017455064928217585)|计算正切函数 
atan(-1.5574077246549023)| (输出 -1rad)|计算反正切（正切的倒数）函数 
pi()| (输出 3.141592653589793)|π (pi) 
pow(0cm, 0px)| (输出 1cm)|返回第一个参数的第二个参数次幂的值 
mod(11cm, 6px) |(输出 5cm)|返回第一个参数模数第二个参数的值 
min(5, 10) |(输出 5)|返回一个或多个值中的最小值 
max(5, 10) |(输出 10)|返回一个或多个值中的最大值 
## 类型函数
包括以下几种,用途和js的一致.
部分有出入
函数|描述
---|---
isnumber|	值是否为数字 
isstring|	值是否为字符串 
iscolor|	值是否为颜色值 
iskeyword|	值是否为 keyword 
isurl|	值是否为 url 值 
ispixel|	值是否为像素值 
isem	|值是否为 em 值 
ispercentage|值是否为 百分百 值 
isunit|	值是是否为指定单位的数字 
isruleset|	值是否为规则集 
isdefined|	值是否为 defined 

## misc函数
作用：获得函数体内的参数
函数|结果
---|---
color("#aaa")|#aaa
image-size("pic")|10px 10px
image-width("pic")|10px
image-height("pic")|10px
convert(9s,"ms")|9000ms
convert(14cm,"mm")|140mm
convert(8,mm)|8
data-uri(image.jpg)|base64格式的img
unit(5,px)|5px
unit(5em)|5em
get-unit(5px)|px
get-unit(5)|null

## 颜色函数

这一部分就跳过了，大概就是rgb,rgba,argb这些基础的，然后一堆颜色渐变什么的..
