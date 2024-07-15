class person2{

    name:string;
    age:number;
    constructor(name:string,age:number)
    {
        /* 在实例方法中，this表示当前的实例 */
        /* 构造函数中当前对象是当前新建的那个对象 */
        /* 可以通过this向新建的对象中添加属性 */
        this.name=name;
        this.age=age;
    }
    bark()
    {
        alert('hello');
    }
    
}
const per1=new person2('1',1);
const per2=new person2('2',2);
console.log(per1);
per1.bark();