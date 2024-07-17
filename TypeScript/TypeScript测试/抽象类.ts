/* 抽象类和其他类区别不大，只是不能用来创建对象
用处在于为其他类提供继承
抽象类可以添加抽象方法
const animal=new Animal('1') x */
abstract class Animal{
    name:string;
    constructor(name:string)
    {
        this.name=name;
    }
    /* 抽象方法使用abstract没有方法体，子类必须对抽象方法进行重写 */
    abstract sayHello():void;
    
}
class Dog2 extends Animal{
    sayHello()
    {
        console.log('gg');
    }
}
