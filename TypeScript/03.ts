/* Object 表示一个js对象 */
let a:object;
a={};
a=function()
{

};

/* ｛｝用来指定定对象中可以包含哪些属性 */
/* 属性名后边加上?表示属性是可选的 */
let b:{name:string,age?:number};
b={name:'1',age:1};
b={name:'1'};
/* [propName:string]:any表示任意类型都可以 */
let c:{name:string,[propName:string]:any}
c={name:'1',age:1,gender:'male'};
let d:{name:string,[propName:string]:any}
d={name:'1',age:1}

let e:(a:number,b:number)=>number
/* e=function(a:number,b:number):number{
    return a+b;
} */

/* 声明数组类型 */
let f:number[];
f=[1,2,3];
let g:Array<number>;
g=[1,2,3];

/* 元组，固定长度的数组
语法:[类型，类型，类型] */
let h:[string,string];
h=['1','3'];

/* enum枚举 */
let i:{name:string,gender:0|1|2}
i={name:'1',gender:0}
enum Gender{
    Male=0,
    Female=1
}
i={name:'1',gender:Gender.Male};

/* 表示类型要同时满足几个条件 */
let j:{name:string} & {age:number};



/* 类型的别名 */
type myType=1|2|3|4;
let k:myType;