package 第九节;

public class InnerClass {
    String name="outer";
    class inner{
        String name="inner";
        public void display(String name)
        {
            System.out.println(name);//内部类局部变量
            System.out.println(this.name);//内部类成员变量
            System.out.println(InnerClass.this.name);//外部类
        }
        public void e()
        {
            System.out.println("eee");
        }
        public void f()
        {
            System.out.println("fff");
        }
    }
    

}
