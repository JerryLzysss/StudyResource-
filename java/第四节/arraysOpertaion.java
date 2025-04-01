public class arraysOpertaion {
    public static void main(String[]args)
    {
        
        int []arr=new int[3];
        String[]str=new String[3];
        
        int []arr2={1,2,3,4,5,6};
        String[]str2={"123","234"}; 
        //长度获取，数组名.length
        //注意:不带括号，length是数组属性，不是方法
        System.out.println(arr.length);
        //index:元素在数据中存储的位置
        //特点:索引唯一，索引都是从0开始，索引最后的值为长度-1
        System.out.println(arr[0]);
        //存储元素:数组名[索引]=值
        arr[0]=2;
        System.out.println(arr[0]);
        //获取元素
        //直接输出数组名，会输出数组在内存中地址的位置.
        System.out.println(arr);
        //如果数组中没有数据，直接获取也能获取到元素的默认值.
        System.out.println(arr[1]);
        //遍历数组
        for(int i=0;i<arr.length;i++)
        System.out.println(arr[i]);
    }
}
