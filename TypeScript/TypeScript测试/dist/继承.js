class animal {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    bark() {
        console.log("w");
    }
}
/* 通过继承可以将多个类中共有的代码写在一个父类中，
只需要写一次即可以让所有的子类同时拥有父类的属性和方法 */
/* 如果子类添加了和父类相同的方法，则会触发方法重写 */
class dog extends animal {
    constructor(name, age) {
        super(name, age);
        /* 子类的构造函数需要有父类的构造函数 */
    }
    bark() {
        console.log(this.name + "bark");
        /* 子类使用父类的方法 */
        super.bark();
    }
}
class cat extends animal {
    run() {
        console.log(this.name + "run");
    }
}
const Dog = new dog('1', 1);
const Cat = new cat('2', 2);
console.log(Dog);
Dog.bark();
Cat.run();
