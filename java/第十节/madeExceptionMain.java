import java.util.Scanner;

public class madeExceptionMain {
    public static void main(String[]args) throws madeException
    {
        String user="root";
        Scanner sc=new Scanner(System.in);
        String name=sc.next();
        if(name.equals(user))
        System.out.println("ok");
        else{
            try{
                throw new madeException("error");
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
           
        }
    }
}
