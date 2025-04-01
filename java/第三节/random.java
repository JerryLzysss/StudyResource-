import java.util.Random;
// 随机数，是java定义好的一个类.
//作用:在指定范围内随机一个整数.
// 位置:java.util
//使用:通过导入包使用
public class random {
    public static void main(String[]args)
    {
        Random p=new Random();
        //表示在0-9之间随机一个数
        int data=p.nextInt(10);
        //表示在1-100之间随机一个数
        int data2=p.nextInt(100)+1;
        //也就是说:p.nextInt(x)+y;
        //表示为在(y)-(x+y-1)之间随机一个数
        System.out.println(data);
    }
}
