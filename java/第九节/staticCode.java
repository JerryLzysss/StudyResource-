package 第九节;

public class staticCode {
    //静态代码的执行步骤为第一位,且只执行一次。相当于全局初始化
    static{
        System.out.println("静态代码");
    }
    public static void main(String[]args)
    {
        Test01 t=new Test01();
        Test02 t2=new Test02();
    }
}
class Test01{
    Test01(){
        System.out.println("代码1");
    }
}
class Test02{
    Test02(){
        System.out.println("代码2");
    }
}