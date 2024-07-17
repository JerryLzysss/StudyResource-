/* 声明一个变量，同时制定他的类型为Number */
let a:number;
//a的类型设置为number以后的使用过程a值只能是数字
a=10;
a=30;

/* 01.ts:6:1 - error TS2322: Type 'string' is not assignable to type 'number'.
说明类型不能之后在编译 */
/* a="hello" */

/* 声明完变量直接进行赋值,TS可以直接自动进行变量类型检测 */
let b:boolean=false;

/* JS的函数是不考虑参数的类型和个数 */
function sum(a:number,b:number):number/* 表示返回类型 */
{
    return a+b;
}
sum(123,456);
/* sum(123,456)=>579
    sum(123,"456")=>579 */