/* 描述一个对象的类型 */
type MyType={
    name:string,
    age:number
};
/* 接口用来定义一个类的结构
    抽象类可以有方法
    接口的所有属性都不能有实际值
    接口中所有的方法都是抽象方法

*/
interface myInteface{
    name:string;
    age:number;
    sayHello():void;
}
const obj:myInteface={
    name:'111',
    age:111,
    sayHello(){
        console.log('gg');
    }
};
const obj2:MyType={
    name:'111',
    age:222
}
class Myclass implements myInteface{
    name:string;
    age:number;
    sayHello()
    {
        console.log("gg");
    }
}