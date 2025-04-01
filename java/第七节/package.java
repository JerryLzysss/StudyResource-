class packages{
    //通过设置private实现封装，只有通过内部接口才能访问.
    //好处:与外界隔离，保护属性防止不合理的应用导致属性被破坏.
    private int a;
    private int b;
    public int getA()
    {
        return a;
    }
    public int getB()
    {
        return b;
    }

    public void setA(int a)
    {
        this.a=a;
    }
    public void setB(int b)
    {
        //通过this区分形参与实参.
        this.b=b;
    }
    public static void main(String[]args)
    {

    }
}