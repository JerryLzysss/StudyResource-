public class beans{
    public String name;
    private int age;
    public beans()
    {

    }
    public beans(String name, int age) {
        this.name = name;
        this.age = age;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
    public static void main(String[] args) {
        //javaBean 是java语言编写的一种规范
        /*
         * 1.类必须是具体的(非抽象)和公共public class
         * 2.必须具有无参数构造和有参数构造
         * 3.成员变量私有化，并提供用来操作的GET和SET
         */

    }
 
}