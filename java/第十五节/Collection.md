[TOC]
# 集合
概述:集合是一个长度可变的容器
特点:1.只能存储引用数据类型的数据
2.长度可变
3.集合中有大量方法可以提供给我们使用.
## 种类
* ArrayList:元素有序，可重复，有索引，线程不安全,底层结构:数组
* LinkedList:元素有序，可重复，有索引，线程不安全,底层结构:双向链表
* Vector:元素有序，可重复，有索引，线程安全,底层结构:数组
* HashSet:元素无序，唯一，无索引，线程不安全，底层结构:哈希表
* LinkedHashSet:元素无序，唯一，无索引，线程不安全，底层结构:哈希表双向链表
* TreeSet:元素有序，元素唯一，无索引，线程不安全，底层结构:红黑树
## 接口
概述:单列集合的总接口
使用:Collection\<E>对象名 = new 实现类对象\<E>()
泛型特点:后面的泛型可以根据前面进行推断.
常用方法:add(E)添加
addAll(Collection\<? extends E>)将另一个集合添加到当前集合
clear()清除集合的所有元素
contains(E)判断当前集合是否包含指定元素
isEmpty()判断当前集合是否为空
remove(e)删除指定元素
size()获取当前集合中元素的个数
toArray()：集合的元素存储到数组中

## 迭代器
概述:Iterator接口
作用:便利集合
Iterator<E>iterator();
方法:Boolean hasNext() 判断是否有下一个元素
next() 获取下一个元素
原理:获取iterator其有一个对应的实现类对象，那么其实现类对象是在arraylist的内部类Itr，而其他的原理相似只不过不是内部类Itr,可以通过源码看.

## 数据结构
数组,链表,包括单项链表双向链表
数组:查询快增删慢
链表:查询慢增删快

## 增强for
作用:遍历集合或者数组
格式:for(element name:array/collection)
element:元素类型
name:变量名
array,collection表示集合或者数组
此时name代表每一个元素
或者
array/collection.for()
原理:遍历集合用的是迭代器，数组用的是for
## 注意
迭代器和增强for都不要随意修改集合长度，会造成并发问题

## 集合工具类
概述:集合工具类
特点:构造私有，方法静态
addAll(collection\<T>,"T1,T2,T3")批量添加元素
shuffle(list)打乱顺序
sort(list)按照默认规则排序
sort(list，comparator\<T>)将集合元素按照指定规则排序
```
comparator(T o1,To2)
{
    o1-o2 ->升序
    o2-o1 ->降序
}
```
可以通过重写CompareTo方法来实现比较
static asList(...element)直接将元素以当前集合形式存储.

## 泛型
描述:<>
作用:统一数据类型，防止数据转换异常.
要求:泛型必须是引用类型，默认为Object
### 泛型类
描述:class name<E>
{

}
确定类型:在new对象的时候确定类型
### 泛型方法
描述: 修饰符<E> type name(E e){

}
确定类型:调用的时候确定类型
### 泛型接口
描述:interface name<E>{

}
确定类型:在实现类的时候还没有确定类，那么在new实现时就会确定类型.

### 泛型通配符
ArrayList<?>

### 泛型的上下限
作用:可以确定泛型的范围
上限:格式:<? extends type>
含义:?只能接受extends后面的本类与子类
下限:格式<? super type>
含义:?只能接受super后面的本类类型和父类

## 哈希值
概述:是由计算机算出的一个十进制数.
获取对象的哈希值使用的是object中的方法hashCode()
如果重写了hashCode方法，那计算的就是对象内容的哈希值
String哈希值计算:用0xff对任何数据做&运算
## set集合
Set和Map密切相关
Map的遍历需要转为set集合
## HashSet
概述:HashSet是set接口的实现类
特点:元素唯一，元素无序，无索引，线程不安全.
结构:哈希表
方法:与collection一样
遍历:增强for/迭代器
## LinkedHashSet
使用与HashSet一致，只是相比于HashSet有序
## HashSet哈希去重
1.先计算哈希的哈希值(hashCode)，在比较内容(equal)
2.哈希值一样且内容一样才去重复
注意点:1.哈希表的数组默认长度为16，初次put的时候才会被初始化为长度16.
2.哈希表的加载因子为0.75F，当数组存储打到百分之75的时候，扩容达到2倍.
3.链表达到8的时候且数组容量大于等于64会转为红黑树，元素个数小于等于6的时候回变回链表
default_initial_capacity:默认容量16
default_load_factor:默认加载因子 0.75f
threshold:扩容的临界值 capacity* factor
treeify_threshold:链表长度默认值转为红黑树:8
min_treeify_capacity:最小转化为红黑树的数组容量:64
# Map分支
HashMap:key唯一,value可重复，无序，无索引，线程不安全，可以存null
LinkedHashMap:与HashMap相似，结构为双向链表
HashTable:key唯一，value可重复，无序无索引，线程安全，不能存null
Properties:与HashTable相似，key和value都是String
TreeMap:key唯一，value可以重复，可以对key排序，无索引线程不安全，不能存null,结构:红黑树.
## Map接口
概述:双列集合(key & value)的定级接口
特点:都是由key和value组成
## hashMap
概述:Map的实现类
特点:key唯一，value可以重复,key重复会进行覆盖.
put(key,value)添加元素
remove(key)感觉key删除键值对，返回的是被删除的value
get(key)根据key获取value
containKeys(key)查看是否存在指定的key
Collection.values()获取集合的所有value转存到collection
Set.KeySet()将Map的Key趣出来，转存到set
Set<\Map.Entry\<k,v>>.entrySet()将键值对转存到set
问题:哈希表中有数组但是没有索引.
原因:哈希表中虽然有数组，单set和map没有索引，索引上存在链表的时候就不确定获取到的值了.
问题:hashMap无序，但是linkedHashMap是有序的
原因:LinkedHashMap在哈希表的基础上增加了双向链表.

## TreeSet
概述:TreeSet是Set的实现类
特点:对元素进行排序，无索引，不能存null,线程不安全，元素唯一
结构:红黑树
TreeSet()构造新的set,按照自然顺序排序
TreeSet(Comparator<?>comparator)根据比较器进行排序
## TreeMap
概述:TreeMap是Map的实现类
特点:对key进行排序，无索引,key唯一，线程不安全，不能存null
结构:红黑树
构造:与treeset相似,只是将实现类改成了map的形式
## HashTable
概述:Hashtable是Map的实现类
特点:key唯一，value可以重复，无序，无索引，线程安全，不能存储null
结构:哈希表
与hashMap差别:线程安全，不能存储null
## Vector
概述:Vector是List的实现类
特点:有序，有索引，可重复，线程安全
结构:数组
构造:Vector()空向量，内部数据数组的大小为10，增量为0
Vector(initialCapacity,capacityIncrement)指定初始值和增量
## Properties属性集
概述:Properties 继承 Hashtable
特点:key唯一,value可重复，无序无索引，线程安全，不能存null
,key和value类型默认都是string
结构:哈希表
特有方法:setProperty(key,value)设置键值对
getProperty(key)根据键获取值
Set.stringPropertyNames()获取所有的key保存到set
load(inputstream)加载流的数据到集合
