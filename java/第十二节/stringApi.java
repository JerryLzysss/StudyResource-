package 第十二节;

public class stringApi {
    public static void main(String[]args)
    {
        String s1="bc";
        String s2="a";
        char []p={'a','b','c'};
        String s3=new String(p);
        String s4="a"+"bc";
        String s5=s2+s1;
        String s6="abc";
        System.out.println(s3+" "+s4+" "+s5);
        System.out.println(s3==s4);
        System.out.println(s4==s5);
        System.out.println(s6=="abc");
    
    }
}
