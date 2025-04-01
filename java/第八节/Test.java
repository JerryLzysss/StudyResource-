package 第八节;
public class Test {
    public static void main(String[]args)
    {
        Teacher teacher =new Teacher();
        teacher.name="1";
        teacher.age=18;
        teacher.work();
        // 私有方法不能访问 teacher.pp();
        Employee e=new Employee();
        // e.teach(); 不能直接调用子类特有的成员
        Teacher t=new Teacher();
        t.teach();
        t.work();//子类可以调用父类非私有的方法与属性
        Employee m=new Teacher();
        m.work();
       //此时如果说父类也有同名方法
       //例如:Teacher t=new Teacher() t.work();
       //此时观察右边生成的实例对象为谁，此处是Teacher类，因此同名时也是调用子类方法.

    } 
}
