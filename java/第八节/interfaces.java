package 第八节;
// 接口是一个引用数据类型，是一种标准.
//implements 实现，实现类implements 接口名()
//接口中可以定义抽象类
//jdk7 默认public abstract
//jdk8 public default 默认方法
//jdk9 私有方法private
//使用:实现类实现接口，重写接口的抽象方法，创建实现类对象，调用重写的方法.
interface interfaces {
    public abstract void open();
    //默认方法可重写可不重写
    public default void see(){
        System.out.println("see");
    }
    //静态方法可以直接调用
    public static void ok(){
        System.out.println("ok");
    }
    String close();
    //final表示不允许重写，也就是可以视为常量.
    public static final int num=3;
    //默认也有final，因此需要手动赋值
    int num2=4;
    //接口特点
    //1.一个接口可以继承多个接口
    //public interface InterfaceA extends interfaceB,Interfacec
    //2.接口可以多实现，一个实现类可以实现多个接口
    //public class interfaceImpl implements interfaceA,interfaceB
    //3. 一个子类可以继承一个父类实现一个或者多个接口
    //public class interfaceImpl extends interfaceDad implements interfaceA,InterfaceB
    //接口和抽象类的区别
    //a.都可以用于继承体系，被其他实现或者继承
    //b.都不能new
    //c.都包含抽象方法，都必须重写抽象方法.
}