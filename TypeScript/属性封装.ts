class person3{
    /* Ts可以添加属性修饰符
    public修饰的属性可以在任意位置修改和访问
    private私有属性只能在类内部修改
    protected 只能在类和当前子类内部访问 */
    public name:string;
    public age:number;
    private sex:string;
    constructor(name,age,sex)
    {
        this.name=name;
        this.age=age;
        this.sex=sex;
    }
    getSex()
    {
        return this.sex;
    }
    setSex(sex)
    {
        this.sex=sex;
    }
}
const p=new person3('1',1,'male');
p.setSex('female');