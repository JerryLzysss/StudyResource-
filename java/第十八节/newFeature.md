# jdk新特性
## lambda表达式
定义格式:()->{}
解释:()重写方法的参数
->参数传递到方法体
适用前提:必须是函数式接口做方法参数传递，有且只有一个抽象方法的接口(可以使用FunctionalInterface)
作用:简化方法提高开发效率
## 函数式接口
描述:有且只有一个抽象方法接口
检测:@FunctionalInterface
Supplier:供给接口
java.util.function.Supplier\<T>
方法:get()表示获取
Consumer:消费接口
java.util.function.Consumer\<T>
方法:accept(T)表示操作
Function:方法接口
java.util.function.Function\<T,R>接口表示根据一个类型的数据得到另一个类型的数据
方法:apply(T t)根据类型T参数获取类型R的结果.
Predicate:判断性接口
java.util.function.Predicate\<T>
方法:test(T t)返回判断的方法.
## Stream流
其不同于IO流，指的是流式编程.
获取:针对集合:Stream\<E>stream()
针对数组：static\<T>Stream\<T>of(...values)
方法:
* forEach:遍历
forEach(cosumer\<? super T>).
注意:在使用完后将会关闭不能再使用.
* count:统计元素个数
count()
注意:在使用完后将会关闭不能再使用.
* filter:根据某个条件过滤数组,并返回一个新的Stream对象
Stream\<T>filter(Predicate\<? super T> predicate)

* limit:获取stream对象中的前n个元素，并返回一个新的Stream对象
Stream\<T>limit(long maxsize)
* skip:跳过Stream对象中的前n个元素,并返回一个新的Stream对象
Stream\<T>skip(long n)
* concat:合并两个Stream流 
Stream\<T>concat(Stream\<? extends T> a,Stream\<? extends T> b)
* collect():将流转为集合.
Stream\<T>collect()
* distinct():元素去重复依旧依赖于hashCode和equal方法
* map(Function\<T,R>mapper) 转换流中的数据类型
## 方法引用
概述:引用方法.
使用:被引用的方法必须在重写方法里面
被引用的方法从参数上，返回值要和重写方法一致
对象名-引用方法
格式:对象::成员方法
需求如下:
函数式接口:Supplier
抽象方法:get()
类名-引用静态方法
格式:类名::静态方法
类-构造方法
格式:构造方法名称::new
需求:函数式接口:Function
抽象方法:apply(T t)
数组-数组引用
格式:数组的数据类型[]::new
## jdk9-jdk17的新特性
jdk9:
* 私有的方法
* 匿名实现类也支持通过泛型进行推断.
* try-catch语法升级,必须实现closeable接口,必须初始化资源对象，且该对象必须是final的
try(IO流对象1,IO流对象2){
    
}catch(){

}
* 局部变量类型自动推断.
var 变量 = 值
java 12:case支持多个值
java 13:引入yield 值表示switch结果

jdk16:instanceof 不需要强转自带强行转换.
Record类是一种全新类型，本质是一个final类,自动实现lombok提供的方法.
注意:Record只有一个全参构造,
重写的equal方法比较所有属性值
可以在Record定义静态字段，静态方法或者实例方法.
类不能是抽象abstract类
不能显式声明父类，默认是java.lang.Record.
Record类是一个final类不含有子类.
java17:密封类,其效果为用sealed修饰符描述，使用permits关键字来指定可以继承或者实现的类.
该继承类必须是sealed,non-sealed,final修饰的.
sealed修饰的类或者接口必须有子类或者实现类.