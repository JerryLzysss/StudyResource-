public class methods {
    public static void main(String[] args) {
        /*
         * 方法：把功能封装起来，通过方法名复用。
         * 若所有逻辑都写在 main 中，代码会难以维护。
         */
        add();
        open("hello");
        int num = cal();
        int num2 = calc(1, 2);
        System.out.println(num + " " + num2);
    }

    // 无参数无返回值：方法名();
    public static void add() {
        System.out.println("hello");
    }

    // 有参数无返回值：方法名(实参);
    public static void open(String str) {
        System.out.println(str);
    }

    // 无参数有返回值：变量 = 方法名();
    public static int cal() {
        return 3;
    }

    // 有参数有返回值：变量 = 方法名(实参1, 实参2);
    // a、b 是形参（定义时声明）；调用时传入的 1、2 是实参
    public static int calc(int a, int b) {
        return a + b;
    }

    // 方法重载：方法名相同，参数列表不同（个数、类型或顺序不同）
    // 注意：仅返回值不同不能构成重载
    public static int calc() {
        return 0;
    }
}
