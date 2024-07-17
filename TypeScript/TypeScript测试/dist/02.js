/* 允许直接使用字面量进行类型声明 */
let a;
/* 定义后不能再次使用，在使用后不能进行修改 */
/* a=11; */
/* 表示类型为其中的一个 */
let b;
/* any表示任意类型，一个变量设置类型为any相当于关闭类型检测 */
/* 使用TS不建议使用 */
let c;
c = 10;
c = "1";
/* 声明变量不赋值指定类型,自动判断变量类型为any */
let d;
/* unknown表示未知类型的值 */
let e;
let s;
/* unknown实际上就是一个类型安全的any
unknown类型变量不能直接赋值给其他变量 */
if (typeof e === "string") {
    s = e;
}
/* 类型断言,可以告诉解析器实际类型 */
s = e;
s = e;
function fn() {
}
/* 永远不会返回一般用于报错 */
function fn2() {
    throw new Error;
}
