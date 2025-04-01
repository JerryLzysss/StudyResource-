public class finallys {
    public static void main(String[]args)
    {
      System.out.println(method());
    }
    public static int method()
    {
    try{
        String s=null;
        System.out.println(s.length());
        return 2;
    }
    catch(Exception e)
    {
        return 1;
    }
    finally{
        System.out.println("ok");
        return 3;
    }
    }
}
