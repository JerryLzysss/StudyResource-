import java.util.Scanner;

public class switchs {
    public static void main(String[]args)
    {
        //switch 用法
        //条件0:输出;跳出判断（没有跳出那么会接着执行下一个）
        //default表示上述都不符合的情况下跳出循环.
        Scanner it=new Scanner(System.in);
        switch(it.nextInt())
        {
            case 0:System.out.println(0);break;
            case 1:System.out.println(1);break;
            case 2:System.out.println(2);break;
            default:;break;
        }
        it.close();
    }
}
