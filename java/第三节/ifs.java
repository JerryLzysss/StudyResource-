import java.util.Scanner;

public class ifs {
    public static void main(String[]args)
    {
        //if 用法
        //满足条件执行
        //else if(跟在if后面)
        //表示如果不满足if而满足else if
        //else(表示上述两种都不满足)
        
        Scanner it=new Scanner(System.in);
        if(it.nextInt()>=10)
        System.out.println(">=10");
        else if(it.nextInt()>=1)
        System.out.println(">=1&&<=10");
        else{
            System.out.println("<1");
        }
        it.close();
    }
}
