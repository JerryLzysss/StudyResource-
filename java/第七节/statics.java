public class statics {
    public static void main(String[]args)
    {
        // static是一个静态关键字
        // 允许直接调用
        //特点:不需要new对象，一般使用private修饰，不能用new方法创建对象
        int sum=0;
        sum(1,2,3,4,5);
    }
    //可变参数,本质是一个数组
    //如果需要分开其中的数可以将定值放置到前面.
    public static int sum(int divid,int ...arr)
    {
        int sum=0;
        for(int i=0;i<arr.length;i++)
        {
            sum+=arr[i];
        }
        return sum/divid;
    }
    
}
