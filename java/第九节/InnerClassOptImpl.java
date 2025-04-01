package 第九节;



public class InnerClassOptImpl {
    public static void main(String[]args)
    {
       InnerClassOpt inOpt=new InnerClassOpt();
        method(inOpt);
        InnerClassOptInterface inOpt2=method02();
        inOpt2.open();
    }
    // 接口作为方法参数，传递实参时，传递的是实现类对象
    // 接口作为返回值时，返回的是实现类对象
    
    //抽象类作为方法传递，传递的时应该是其子类对象
    //抽象类作为返回值传递，返回的时其子类对象

    //普通类作为参数传递，传递的是对象
    //普通类作为方法返回值返回时，返回的是对象
    public static void method(InnerClassOptInterface inf)
    {
        inf.open();
    }
  
    public static InnerClassOptInterface method02()
    {
        return new InnerClassOpt();
    }
}
