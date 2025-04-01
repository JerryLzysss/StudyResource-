public class arraysException {
    public static void main(String[]args)
    {
        //数组索引越界:ArrayIndexOutOfBoundsException
        int []arr=new int[2];
        
        System.out.println(arr[2]);
        //空指针异常:NullPointerException
        arr=null;
        System.out.println(arr.length);

    }
}
