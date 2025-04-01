package 第八节;

public class Test02 {
    public static void main(String[]args)
    {
    RewriteDad rd=new RewriteDad();
    rd.methodDad();
    rd.method();
    RewriteSon rs=new RewriteSon();
        rs.method();
        rs.methodDad();
        rs.methodSon();
        //1.重写的要求:权限必须保证大于等于父类权限
        //public > protected > 默认 > private
        //也就是说如果父类是protected,那么子类不能是默认和private
        //2.子类方法重写父类方法，方法名和参数列表要一致.
        //3.私有、构造、静态方法不能被重写，
    }

}
