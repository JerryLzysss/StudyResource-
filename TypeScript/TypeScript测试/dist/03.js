/* Object 表示一个js对象 */
let a;
a = {};
a = function () {
};
/* ｛｝用来指定定对象中可以包含哪些属性 */
/* 属性名后边加上?表示属性是可选的 */
let b;
b = { name: '1', age: 1 };
b = { name: '1' };
/* [propName:string]:any表示任意类型都可以 */
let c;
c = { name: '1', age: 1, gender: 'male' };
let d;
d = { name: '1', age: 1 };
let e;
/* e=function(a:number,b:number):number{
    return a+b;
} */
/* 声明数组类型 */
let f;
f = [1, 2, 3];
let g;
g = [1, 2, 3];
/* 元组，固定长度的数组
语法:[类型，类型，类型] */
let h;
h = ['1', '3'];
/* enum枚举 */
let i;
i = { name: '1', gender: 0 };
var Gender;
(function (Gender) {
    Gender[Gender["Male"] = 0] = "Male";
    Gender[Gender["Female"] = 1] = "Female";
})(Gender || (Gender = {}));
i = { name: '1', gender: Gender.Male };
/* 表示类型要同时满足几个条件 */
let j;
let k;
