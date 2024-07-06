[TOC]
# Less
Less （Leaner Style Sheets 的缩写） 是一门向后兼容的 CSS 扩展语言。这里呈现的是 Less 的官方文档（中文版），包含了 Less 语言以及利用 JavaScript 开发的用于将 Less 样式转换成 CSS 样式的 Less.js 工具。
## 安装

在 Node.js 环境中使用 Less ：
```npm install -g less```
```> lessc styles.less styles.css 编译成css```
在浏览器环境中使用 Less :
```<link rel="stylesheet/less" type="text/css" href="styles.less" />```
```<script src="https://cdn.jsdelivr.net/npm/less@4" ></script>```


## 变量

在Less中通过@xxx表示变量
例如```@style="10px"```
那么之后的引用中就可以通过
@style来代替.

## 混合

混合（Mixin）是一种将一组属性从一个规则集包含（或混入）到另一个规则集的方法。
通俗的说:就类似于继承，直接将某个集合的属性取来用.
例如首先定义一个集合
```
.border{
    border-radius:50%;
}
```
然后某个样式也是采用这种方式
```
.borderChild{
    .border()
}
```
此时就完成了混合的使用.

## 嵌套
Less 提供了使用嵌套（nesting）代替层叠或与层叠结合使用的能力。
通过这种方法有效减少了代码书写量，对于一个具有父级元素的内容下，如果嵌套内容相当的多，可以用嵌套.
同时当使用伪元素的时候，以&表示父元素
例如
```
a{
    b{

    }
    &a:hover{

    }
}
```

## @规则
@ 规则（例如 @media 或 @supports）可以与选择器以相同的方式进行嵌套。@ 规则会被放在前面，同一规则集中的其它元素的相对顺序保持不变。这叫做冒泡（bubbling）。
该规则采用冒泡的时候表示的是并集关系，类似于
```
.a{
    @media(条件1)
    {
        @media(条件2)
        @media(条件3)
    }
}
编译成CSS为
.a @media(条件1) and @media(条件2){
    
}
.a @media(条件1) and @media(条件3)
{

}
```

## 运算

算术运算符 +、-、*、/ 可以对任何数字、颜色或变量进行运算。如果可能的话，算术运算符在加、减或比较之前会进行单位换算。计算的结果以最左侧操作数的单位类型为准。如果单位换算无效或失去意义，则忽略单位。无效的单位换算例如：px 到 cm 或 rad 到 % 的转换。
乘法和除法不作转换。因为这两种运算在大多数情况下都没有意义，一个长度乘以一个长度就得到一个区域，而 CSS 是不支持指定区域的。Less 将按数字的原样进行操作，并将为计算结果指定明确的单位类型。
```
// 所有操作数被转换成相同的单位
@conversion-1: 5cm + 10mm; // 结果是 6cm
@conversion-2: 2 - 3cm - 5mm; // 结果是 -1.5cm
@incompatible-units: 2 + 5px - 3cm; // 结果是 4px

//乘法与除法不转换单位
@base: 5%;
@filler: @base * 2; // 结果是 10%
@other: @base + @filler; // 结果是 15%
@base: 2cm * 3mm; // 结果是 6cm
@color: (#224488 / 2); // 结果是 #112244
background-color: #112244 + #111; // 结果是 #223355

//从4.0版本之后,直接进行除法不提供运算
@color: #222 / 2; // 结果是#222/2,不是#111
background-color: (#FFFFFF / 16); //结果是#101010
```

### calc特例
为了与 CSS 保持兼容，calc() 并不对数学表达式进行计算，但是在嵌套函数中会计算变量和数学公式的值。
```
@var: 50vh/2;
width: calc(50% + (@var - 20px));  // 结果是 calc(50% + (25vh - 20px))
```
## 继承
使用继承的好处：可以减少代码的重复性，如果只是像变量和函数来创建，则会把指定的代码对当前的元素进行重写一边。若是使用继承，则会使用css中的并集选择器，把具有相同样式的元素并集起来，实现了代码的优化。
```
// less 继承 使用关键字 extend
.box2:extend(.box){}
```
## 转义
转义（Escaping）允许你使用任意字符串作为属性或变量值。任何 ~"anything" 或 ~'anything' 形式的内容都将按原样输出，除非 interpolation。
```
@min768: ~"(min-width: 768px)";
.element {
  @media @min768 {
    font-size: 1.2rem;
  }
}
注意，从 Less 3.5 开始，可以简写为：
@min768: (min-width: 768px);
.element {
  @media @min768 {
    font-size: 1.2rem;
  }
}
```
## 函数
Less 内置了多种函数用于转换颜色、处理字符串、算术运算等。这些函数在Less 函数手册中有详细介绍。
函数的用法非常简单。下面这个例子将介绍如何利用 percentage 函数将 0.5 转换为 50%，将颜色饱和度增加 5%，以及颜色亮度降低 25% 并且色相值增加 8 等用法：
```
@base: #f04615;
@width: 0.5;

.class {
  width: percentage(@width); // 函数转换为50% 
  color: saturate(@base, 5%); //饱和度增加5%
  background-color: spin(lighten(@base, 25%), 8); //亮度降低25%,色相增加8%
}
```
### 函数种类
在上述所提到的函数为直接调用的，除此之外可以提供有参函数与无参函数
#### 1.直接调用
```
.box{
    style...
}
.box1{
    .box1;
}
```
这种方法就是一种直接调用
#### 2.无参函数
```
.box()
{style...}
.box1{
    .box()
}
```
这种方式就是以无参形式调用
#### 3.有参函数
```
.card(@color: yellow) {
 width: 100px;
 height: 100px;
 border-radius: 10px;
 background-color: @color;
}
.myCard{
    .card();//调用参数，不传入使用默认值
    .card(red);//调用参数，使用传入值
}
```
如果使用有参函数，但是既没有默认值也没有传入值是会报错的.
### 逻辑判断
包括有以下几类
#### 1.与运算
```
#div{
    .less(@width,@height) when (@width>50px) and(@height>50px)
    {
        style...
    }
}
```
#### 2.非运算
```
#div()
{
    .less(@width) when not(@width>24px)
    {
        style...
    }
}
```
#### 3.或运算
```
#div(){
    .less(@width) when (@width>1000px),(@width<100px){
        style...
    }
}
```
### 循环
```
#cycle-cols(@i,@n) when(@i<=@n){
    .cycle-cols-item-@{i}
    {
        style...
    }
    #cycle-cols(@i+1,@n);
}
#cycle-cols(1,4)
```
### 拼接
## 命名空间和访问符
出于组织结构或仅仅是为了提供一些封装的目的，对混合（mixins）进行分组。
说白了就是封装一部分属性进入一个函数中，然后引入的时候选择性引入相关属性。
```
// 函数的嵌套
.box() { // 定义了一个 .box() 函数
 color: orange;
 // 嵌套一个函数
 #w() {
   width: 100px;
   // 嵌套函数 
   .h(@height: 20px) {
     height: @height;
   }
 }
}
// 使用嵌套中的函数
.box-height {
 .box > #w > .h(80px);
}  
```
使用嵌套函数需要写出父级函数中间用 > 分隔。
注意：如果嵌套的父级元素有参数但没默认值，会报错。 并且调用的函数自会执行当前函数内的内容，不会执行父函数或子函数的内容。

## 映射
从 Less 3.5 版本开始，你还可以将混合（mixins）和规则集（rulesets）作为一组值的映射（map）使用。
也就是直接以对象形式调用相应属性.
## 作用域
Less 中的作用域与 CSS 中的作用域非常类似。首先在本地查找变量和混合（mixins），如果找不到，则从“父”级作用域继承。
与 CSS 自定义属性一样，混合（mixin）和变量的定义不必在引用之前事先定义。

## 注释

唯一需要注意的是块注释是会顺带编译的，而行注释则在编译为CSS时去掉
/*不会注释掉 */
//会被注释掉

## 导入
“导入”的工作方式和你预期的一样。你可以导入一个 .less 文件，此文件中的所有变量就可以全部使用了。如果导入的文件是 .less 扩展名，则可以将扩展名省略掉：
```
@import "library"; // library.less
@import "typo.css";
```