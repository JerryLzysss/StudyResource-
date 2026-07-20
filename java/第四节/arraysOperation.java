public class arraysOperation {
    public static void main(String[] args) {
        int[] arr = new int[3];
        String[] str = new String[3];

        int[] arr2 = {1, 2, 3, 4, 5, 6};
        String[] str2 = {"123", "234"};

        // 长度获取：数组名.length
        // 注意：不带括号，length 是数组属性，不是方法
        System.out.println(arr.length);
        // index：元素在数组中存储的位置
        // 特点：索引从 0 开始，最后一个索引为 length - 1
        System.out.println(arr[0]);
        // 存储元素：数组名[索引] = 值
        arr[0] = 2;
        System.out.println(arr[0]);
        // 直接输出数组名，会输出类似类型@哈希 的信息
        System.out.println(arr);
        // 未赋值元素会有默认值（如 int 为 0）
        System.out.println(arr[1]);
        // 遍历数组
        for (int i = 0; i < arr.length; i++) {
            System.out.println(arr[i]);
        }
    }
}
