public class arrays {
    public static void main(String[]args)
    {
        // 数组，用来存储多个数据，普通的变量只能代表一个数据，通过数组可以存储等多个数据.
        //数组，引用数据类型
        //特点1，定义长度(多长数组固定多长)
        //特点2:可以存储数组,也就是存储自身，也能存储变量与常量
       
        //左边规定数据类型，右边规定数组长度,此后只能存储与左类一直的
        //动态初始，没有给具体数据只给长度
        int []arr=new int[3];
        String[]str=new String[3];
        //静态初始化，直接把数据也给存入.
        int []arr2={1,2,3,4,5,6};
        String[]str2={"123","234"}; 
    }
}
