# 集合

概述：集合是长度可变的容器。

特点：

1. 只能存储引用类型数据（基本类型会自动装箱）
2. 长度可变
3. 提供了大量操作方法

## 常见实现类

| 实现类 | 特点 | 底层结构 |
|--------|------|----------|
| ArrayList | 有序、可重复、有索引、线程不安全 | 数组 |
| LinkedList | 有序、可重复、有索引、线程不安全 | 双向链表 |
| Vector | 有序、可重复、有索引、线程安全 | 数组 |
| HashSet | 无序、唯一、无索引、线程不安全 | 哈希表 |
| LinkedHashSet | **插入有序**、唯一、无索引、线程不安全 | 哈希表 + 双向链表 |
| TreeSet | 可排序、唯一、无索引、线程不安全 | 红黑树 |

## Collection 接口

单列集合的顶级接口。

```java
Collection<E> coll = new 实现类<>();
```

常用方法：`add` / `addAll` / `clear` / `contains` / `isEmpty` / `remove` / `size` / `toArray`

## 迭代器

概述：`Iterator` 接口，作用是**遍历**集合。

- `boolean hasNext()`：是否还有下一个元素
- `next()`：获取下一个元素

注意：迭代遍历过程中不要随意增删集合元素，否则可能触发并发修改异常。

## 数据结构对比

- 数组：查询快，增删慢
- 链表：查询慢，增删快（含单向/双向链表）

## 增强 for

```java
for (元素类型 name : 数组或集合) {
    // name 代表当前元素
}
```

遍历集合底层使用迭代器；遍历数组等价于普通 for。

## Collections 工具类

构造私有，方法静态。

- `addAll(collection, e1, e2, ...)`：批量添加
- `shuffle(list)`：打乱
- `sort(list)`：默认规则排序
- `sort(list, comparator)`：按指定比较器排序

比较器示例：`o1 - o2` 升序，`o2 - o1` 降序。  
也可让元素实现 `Comparable`，重写 `compareTo`。

`Arrays.asList(...)`：把元素包装成固定长度的 List。

## 泛型

作用：统一数据类型，减少强制转换与类型异常。  
要求：泛型参数必须是引用类型。

- 泛型类：`class Name<E> { }`，在 `new` 时确定类型
- 泛型方法：`修饰符 <E> 返回值 方法名(E e)`，调用时确定类型
- 泛型接口：实现类或创建对象时确定类型
- 通配符：`ArrayList<?>`
- 上限：`<? extends Type>`（本类及子类）
- 下限：`<? super Type>`（本类及父类）

## HashSet 去重与扩容要点

1. 先比 `hashCode`，再比 `equals`
2. 哈希值相同且内容相等才视为重复
3. 默认容量 16，加载因子 0.75；容量达到阈值时扩容为约 2 倍
4. 链表长度达到 8 且数组容量 ≥ 64 时转红黑树；元素数 ≤ 6 时可能退回链表

## Map 分支

| 实现类 | 要点 |
|--------|------|
| HashMap | key 唯一，value 可重复，无序，可存 null，线程不安全 |
| LinkedHashMap | 类似 HashMap，保留插入顺序 |
| Hashtable | 线程安全，不能存 null |
| Properties | key/value 多为 String，常作配置 |
| TreeMap | 按 key 排序，不能存 null key |

### Map 接口

双列集合（key & value）的**顶级**接口。

常用方法：

- `put(key, value)`：添加/覆盖
- `remove(key)`：根据 key 删除，返回被删 value
- `get(key)`：根据 key 获取 value
- `containsKey(key)`：是否包含 key
- `values()`：所有 value
- `keySet()`：所有 key 组成的 Set
- `entrySet()`：所有键值对 `Set<Map.Entry<K,V>>`

HashMap 无序；LinkedHashMap 在哈希表基础上增加双向链表以保持顺序。
