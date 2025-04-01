package 第九节;

public class InnerClassImp {
  public static void main(String[]args)
  {
     InnerClass.inner inn=new InnerClass().new inner();
     inn.e();
     inn.f();
     inn.display("hello");
  }
}
