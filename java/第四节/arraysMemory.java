public class arraysMemory{
    public static void main(String[]args)
    {
        int []arr1=new int[3];
    
        int []arr2=new int[3];
        arr1[0]=300;
        arr2[0]=200;
        System.out.println(arr1);
        System.out.println(arr2);
       
        //两者不在同一内存
        System.out.println(arr1[0]);
        System.out.println(arr2[0]);
      arr1=arr2;
        System.out.println(arr1[0]);
        System.out.println(arr2[0]);
    }
}