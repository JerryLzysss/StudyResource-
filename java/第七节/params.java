public class params {
    public static void main(String[]args)
    {
        int a=10;
        int b=20;
        method(a,b);
        //此处的a与b还是10和20，传值为基本值传参.不影响该区域数据.
        System.out.println(a+" "+b);
        int []arr=new int[20];
        arr[0]=10;
        arr[1]=20;
        //传递数组时由于数组为引用数据类型，传递的是地址，因此会受到影响.
        method(arr);
        
        System.out.println(arr[0]+" "+arr[1]);   
       
    }
    
    
    
    public static void method(int a,int b)
    {
        a+=10;
        b+=20;
        System.out.println("methods:"+ a+" "+b);    
    }
    public static void method(int []arr)
    {
        arr[0]+=10;
        arr[1]+=20;
        System.out.println("methods:"+arr[0]+" "+arr[1]);   
    }
   
}
