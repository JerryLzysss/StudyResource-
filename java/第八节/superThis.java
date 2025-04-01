package 第八节;

public class superThis {
   
    //注意:new 子类对象时，默认会先走父类无参构造方法
    //也就是每个构造方法的第一行会默认先进行super()
    public static void main(String[]args)
    {
       //super：代表的是父类引用，作用:调用父类方法
       //super()=>调用无参构造，super(参数)=>有参构造，super().method()=>调用父类方法
       //this =>代表当前对象，作用:用来区分成员变量和局部变量/调用当前对象成员
        RewriteSon2 rs=new RewriteSon2();
        //继承只支持单个继承，不能多个继承
        // A extends B
        //继承支持多层继承,也就是允许隔层继承
        //A extends B,B extends C
        //一个父类可以有多个子类
        //b extends C,a extends C
        //静态，私有方法可以被继承但是不能被重写

        //设置父类私有方法
        //1.通过开放set和get方法调用
        //2.构造子类方法的有参构造通过super调用父类的有参构造.
    }
}
