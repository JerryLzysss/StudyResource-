import java.util.Scanner;
// 键盘录入，是java定义好的一个类.
//作用:将数据通过键盘录入的形式放到代码中运行
// 位置:java.util
//使用:通过导入包使用
class scanner{
    public static void main(String[] args) {
        //表示录入系统输入
        Scanner it =new Scanner(System.in);
        // next表示录入字符串,遇到空格或者回车结束录入
        //nextLine表示录入回车就结束
        //nextInt输入int
        String str=it.next();
        //遇到录入类型不一致会导致java.util.inputmismatchException
        System.out.println(str);
        it.close();
    }
}