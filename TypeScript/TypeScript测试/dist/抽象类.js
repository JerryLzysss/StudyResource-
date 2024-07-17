/* 抽象类和其他类区别不大，只是不能用来创建对象
用处在于为其他类提供继承
抽象类可以添加抽象方法
const animal=new Animal('1') x */
class Animal {
    constructor(name) {
        this.name = name;
    }
}
class Dog2 extends Animal {
    sayHello() {
        console.log('gg');
    }
}
