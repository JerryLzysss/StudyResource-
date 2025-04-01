# 反射与单元测试

## Junit
概述:Junit是一个单元测试框架，可以代替main方法，用来测试功能是否成功跑通.
使用:导入Junit的jar包->定义一个方法添加注解@Unit->通过run执行.
注意事项:
@Test不能修饰static方法，带参数的方法，带有返回值的方法.
相关注解:
@Before:在Test之前执行有多少个Test就执行多少次，用作初始化.
@After:在Test之后执行，有多少个Test就执行多少次，用作释放资源.
## 类的加载机制
1.new对象
2.new子类对象
3.执行main方法
4.调用静态成员
5.利用反射创建Class对象
在加载完后，通过将class加载到内存，然后运行堆栈.
其中:jvm将class文件加载到库存，利用IO流加载,其中的操作就是通过类加载器完成的
### 类加载器 ClassLoader
概述:在jvm中负责将本地class文件加载到内存的对象ClassLoader.
分类:BootStrapClassLoader:根类加载器，也称之为引导类加载器，负责java额核心类
ExtClassLoader:拓展类加载器，负责jre的拓展目录中的jar包加载
AppClassLoader:系统类加载器，负责在jvm启动的时候加载来自java命令的class文件.
三者关系:AppClassLoader的父类是ExtClassLoader.
ExtClassLoader的父类是BootStrapClassLoader.
共同父类是ClassLoader.
获取类加载器对象:getClassLoader()
获取父类:getParent()
双亲委派:如果同时需要处理，会向父类查询是否加载，如果加载那么就全盘由父类负责.
缓存:一个类加载到内存会保持有一定缓存里内，如果没有加载那么就会加载,下一次其他类使用的时候就不会重新加载了,与双亲委派一起确定了类在内存中的唯一性。
## 反射
概述:解剖class对象的一个技术
作用:成员变量赋值，成员方法调用，构造方法new对象
好处:代码更通用更灵活.
### 获取class对象
1.调用Object的getClass方法
Class\<?>getClass()
2.jvm提供了一个静态成员:class
3.Class类中的静态方法
Class\<?> forName(String)传递的是类的全限定名(包名,类名)
最方便的是类名.class
### 获取构造方法
Constructor\<?>[]getConstructors()获取所有public
Constructor\<T>getConstructor(Class\<?>...parameterTypes)获取指定的public构造
如果获取的是空参构造，可以不用写参数.
如果是有参构造:那么写参数的Class类型.
Constructor类中的方法
T newInstance(Object ...initargs)创建对象
initargs:传递的是构造方法的实参
如果根据有参构造new对象，那么用initargs传递实参.
Constructor\<?>[]getDeclaredConstructors()获取所有构造方法，包括private方法
Constructor\<T>getDeclaredConstructor(类\<?>...parameters)获取指定构造，包括private.
### 获取成员方法
Method[] getMethods()获取所有public方法,包括父类的public方法.
Method getMethod(String name,class\<?>...parameterTypes)获取指定的public方法
调用方法:Object invoke(Object obj,Object ...args)执行方法
Method []getDeclaredMethods()获取所有成员方法，包括私有方法.
Method getDeclaredMethods(String name,类\<?>parameterTypes)获取指定的方法包括私有方法.
### 反射成员方法
Field getFileds()获取所有public属性
Field getDeclaredField(String name)获取指定属性，包括private属性
set(object obj,object value)为属性赋值
get()获取属性值

## 注解
引用数据类型:类，数组，接口，枚举，注解.
作用:对代码进行说明生成doc文档(API)
检查:检查代码是否符合条件
分析:对代码进行分析，起到了代替配置文件的作用.
@Override检查是否重写
@Deprecated弃用方法不推荐使用
@SuppressWarning清除警告
注解方法:public @interface xxx{

}
注解格式:@注解名(xxx ={...})
注意点：1.空注解可以直接使用
2.不同的位置可以用一样的注解
3.注解有属性，属性一定要赋值
4.注解有默认值可以不写.
5.注解只有一个属性并且属性叫value,属性名不用写只写值.
## 注解解析
注解的解析:获取注解中的属性值.
接口是:AnnotatedElement接口，实现类
AccessibleObject,Class,Constructor,Executable,Field,Method,Package,Parameter
解析思路:先判断指定位置有没有使用指定注解，如果有获取指定的注解，获取注解中的属性值.
boolean isAnnotationPresent(Class\<? extends Annotation> annotationClass)判断指定位置有没有指定的注解
getAnnotation(Class\<T> annotationClass)获取指定注解
### 元注解
概述:元注解:就是管理注解的注解
作用：控制使用位置与生命周期
@Target:控制注解的使用位置
属性:ElementType[]value()
TYPE:控制注解能否用在类
FIELD:控制注解能否用在属性
METHOD:控制注解能否使用在方法
PARAMETER:控制注解能否使用在参数上
CONSTRUCTOR:控制注解能否使用在构造器上.
LOCAL_VARIABLE:控制注解能否使用在局部变量上
## 枚举
定义:public enum xxx{

}
所有枚举父类都是Enum
特点:都是static final.
使用:类名直接调用.
注意:每一个枚举值都是当前枚举类的对象
构造默认都是private的.
方法:toString()返回枚举值的名字
values()返回所有的枚举值
valueOf()将字符串转为枚举类型