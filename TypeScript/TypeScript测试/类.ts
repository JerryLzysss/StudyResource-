/* class关键字来定义一个类 */
class Person{

    /* 对象包含两个部分
    一部分为属性
    一部分为方法 */

    /* 定义实例属性 */
    name:string='1';
    readonly age:number=1;
    /* 在属性使用static关键字词可以定义静态属性 */
    /* 静态方法可以通过直接对类进行操作 */
    static s:number=55;
}
const Per =new Person();
console.log(Per.age);
console.log(Person.s);