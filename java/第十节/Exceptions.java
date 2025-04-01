import java.io.IOException;

public class Exceptions{
    public static void main(String[]args)throws IOException
    {
        String s="123s.txts";
        method(s);
    }
    public static void method(String s) throws IOException
    {
        if(s.endsWith(".txt"))
        {
            throw new NullPointerException();
        }
        else{
            System.out.println("ok");
        }
    }
}