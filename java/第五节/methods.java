public class methods{
    public static void main(String[]args)
    {
            /*方法描述:所有代码都在main方法，
            如果将所有功能都放到main难以维护.
            也就是说，通过调用方法名来实现功能的复用.
            */
            //方法调用
            add();
            open("hello");
            int num=cal();
            int num2=calc(1,2);
            System.out.println(num+" "+num2);
    }
    //无参数无返回值
    //调用:方法();
    //void表示无返回值
    public static void add()
    {
        System.out.println("hello");
    }
      //有参数无返回值
    //调用:方法(参数1);
    //void表示无返回值
    public static void open(String str)
    {
        System.out.println(str);
    }
      //无参数有返回值
    //调用:变量=方法();
    //int表示返回整数
    //最后return表示返回参数
    public static int cal()
    {
        return 3;
    }
       //有参数有返回值
    //调用:变量=方法(参数1，参数2);
    //int表示返回整数
    //最后return表示返回参数
    public static int calc(int a,int b)
    {
        return a+b;
    }
    public static int calc()
    {
        return 0;
    }
    //上述使用的方式是方法重载，在Java中允许对方法参数进行重新使用，以及返回值进行重新使用.
    //也就是同一个参数，传入值的方式不同传回值也可以不同.
}
    //形参与实参的区别
        /*形参:也就是调用的方法时定义的参数，不代表具体值
          实参:也就是实际调用上述方法后返回的值,通过调用方法后得到的值返回
          例如:c=int add(int a,int b)
          {
            return a+b;
          } 此处c为实参，a,b为形参*/
       
        
