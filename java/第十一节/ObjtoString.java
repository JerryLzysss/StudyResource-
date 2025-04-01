import java.util.Comparator;

public class ObjtoString{
    public static void main(String[]args) throws CloneNotSupportedException
    {
        p1 p=new p1();
        p1 q =new p1();
        System.out.println(p.toString());
        System.out.println(p==q);//对于引用数据类型，比较的是地址值
        System.out.println(p.equals(q));
        String s1=new String("123");//对于基本数据类型，比较的是值
        String s2=new String("123");
        System.out.println(s1==s2);//比较的是地址值.
        System.out.println(s1.equals(s2));//重写完的equals,比较的是内容0而不是地址值
        p2 pp=new p2("1","4");
        p2 qq=new p2("1","4");
        System.out.println(pp.equals(qq));
        p2 clo=new p2("1","4");
        Object o=clo.clone();
        p2 p3=(p2)o;
        System.out.println(p3==clo);
        System.out.println(p3.equals(clo));
        p1 px=new p1(1);
        p1 py=new p1(2);

    }
}
class p1 implements Comparator{
    public int x;
    p1(){

    }
    p1(int x)
    {
        this.x=x;
    }
   public int getX()
   {
    return this.x;
   }
    @Override
    public String toString()
    {
        return "hello world";
    }
    

    //比较器排序，通过继承comparator来实现数组上数据排序.
    //使用到:没有实现comparable接口或者需要重写比较规则
    
    @Override
    public int compare(Object o1, Object o2) {
        p1 s1=(p1)o1;
        p1 s2=(p1)o2;
        //返回值大于0则表示o1对象更大，否则o1对象更小.
        return s1.getX()-s2.getX();
      
     
    }
   
}
class p2 implements Cloneable{
    public String x;
    public String y;
    p2(String x,String y){
        this.x=x;
        this.y=y;
    }
    @Override
    public boolean equals(Object obj){
        //问题2:如果传递的不是person类型，就会出现类型转换异常
        //先判断类型，如果为person则强转为person,如果为null则直接返回false
        if(this==obj)
        return true;
        if(obj==null)
        return false;
        if(obj instanceof p2)
        {
        //问题1:obj不能直接调用x和y，因为obj接收的为person类型属于多态，多态前提下不能直接调用
        //通过强制转换
        p2 p=(p2)obj;
        return this.x.equals(p.x)&&this.y.equals(p.y);
        }
        return false;
    }
    @Override
    protected Object clone()throws CloneNotSupportedException{
        return super.clone();
    }
}