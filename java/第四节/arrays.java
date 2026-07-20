public class arrays {
    public static void main(String[]args)
    {
        // 数组：用来存储多个同类型数据；普通变量只能存一个值
        // 数组属于引用数据类型
        // 特点1：长度在创建时确定，之后固定
        // 特点2：可以存储基本类型或引用类型的元素

        // 左边规定元素类型，右边规定数组长度，之后只能存与左边类型一致的数据
        // 动态初始化：只给长度，不给具体元素
        int []arr=new int[3];
        String[]str=new String[3];
        //静态初始化，直接把数据也给存入.
        int []arr2={1,2,3,4,5,6};
        String[]str2={"123","234"}; 
    }
}
