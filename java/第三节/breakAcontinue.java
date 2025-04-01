public class breakAcontinue{
    public static void main(String[] args)
    {
        for(int i=1;i<=5;i++)
        {
            if(i==3)
            {
                //表示直接退出循环，也就是不再执行for/while循环里面的语句.
                break;
                //结束本次循环，也就是continue后面条件不执行直接进行下一次循环
                //continue;
            }
        }
    }
}