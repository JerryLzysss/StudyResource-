package 第八节;

public class polyDadImp {
    public static void main(String[]args)
    {
        polyChild2 p2=new polyChild2();
        p2.eat();
        p2.lookDoor();
        polyChild p1=new polyChild();
        p1.eat();
        p1.catchs();
        polyDad pd=new polyChild();

        pd.eat();
        //此处不存在于父类方法，因此不能直接调用
        //pd.lookDoor();
        polyDad pd2=new polyChild2();
        pd2.eat();
        
        
    }
}
