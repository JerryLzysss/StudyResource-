# JDK 新特性

## Lambda 表达式

格式：`() -> {}`

- `()` 内是抽象方法的参数列表
- `->` 右侧是方法体

前提：函数式接口（有且仅有一个抽象方法，可用 `@FunctionalInterface` 标注）。

作用：简化匿名实现，提高可读性与开发效率。

## 函数式接口（java.util.function）

| 接口 | 作用 | 核心方法 |
|------|------|----------|
| `Supplier<T>` | 供给 | `get()` |
| `Consumer<T>` | 消费 | `accept(T)` |
| `Function<T,R>` | 转换 | `apply(T)` |
| `Predicate<T>` | 判断 | `test(T)` |

## Stream 流

这里的 Stream 是流式编程，与 IO 流不同。

获取：

- 集合：`collection.stream()`
- 数组：`Stream.of(...)`

常用中间/终端操作：

- `forEach(Consumer<? super T>)`：遍历（终端操作，用后流结束）
- `count()`：统计个数（终端）
- `filter(Predicate)`：过滤，返回新 Stream
- `limit(n)` / `skip(n)`：截取/跳过
- `concat(a, b)`：合并两个流
- `collect(Collector)`：收集为集合等结果（注意：返回的是收集结果，不是 Stream）
- `distinct()`：去重，依赖 `hashCode` 与 `equals`
- `map(Function)`：映射转换元素类型

## 方法引用

被引用方法的参数与返回值需与函数式接口抽象方法兼容。

| 类型 | 格式 |
|------|------|
| 对象方法 | `对象::成员方法` |
| 静态方法 | `类名::静态方法` |
| 构造方法 | `类名::new` |
| 数组 | `类型[]::new` |

## JDK 9–17 部分新特性

### JDK 9

- 接口私有方法
- 匿名实现类的泛型推断增强
- try-with-resources 可使用已初始化的有效 final 资源
- 局部变量类型推断：`var 变量 = 值`（实际在 JDK 10 正式落地，常一并记忆）

### JDK 12 / 13

- `switch` 支持多值 case
- `yield` 用于在 switch 表达式中返回结果

### JDK 16

- `instanceof` 模式匹配，可少写强制转换
- **Record**：一种特殊的 `final` 类，自动生成全参构造、`equals` / `hashCode` / `toString` 等（语言特性，与 Lombok 无关）
  - 默认父类为 `java.lang.Record`
  - 不可显式继承其他类，不可是 abstract

### JDK 17

- 密封类：`sealed` + `permits` 限制可继承/实现的类型
- 子类需是 `sealed`、`non-sealed` 或 `final`
