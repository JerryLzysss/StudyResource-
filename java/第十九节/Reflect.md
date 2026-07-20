# 反射、注解与单元测试

## JUnit

概述：单元测试框架，可替代频繁改写 `main` 来验证功能。

使用：引入 JUnit 依赖 → 编写测试方法并添加 `@Test` → 运行测试。

注意：`@Test` 一般不修饰 `static` 方法、带参方法、有返回值的方法（JUnit 4 常见约定）。

相关注解（JUnit 4）：

- `@Before`：每个 `@Test` 前执行，做初始化
- `@After`：每个 `@Test` 后执行，做资源释放

（JUnit 5 对应为 `@BeforeEach` / `@AfterEach` 等。）

## 类的加载机制

常见触发类加载的时机：

1. `new` 对象
2. `new` 子类对象（会先加载父类）
3. 执行 `main` 方法
4. 调用静态成员
5. 通过反射获取/创建 `Class` 对象

JVM 将 `.class` 文件加载到**内存**，由类加载器完成。

### ClassLoader

| 加载器 | 职责 |
|--------|------|
| Bootstrap ClassLoader | 引导类加载器，负责 Java 核心类 |
| Ext / Platform ClassLoader | 扩展/平台类加载器 |
| App ClassLoader | 应用类加载器，加载 classpath 上的类 |

双亲委派：优先交给父加载器尝试加载，避免核心类被替换，并保证类的唯一性。  
类加载后会缓存在内存中，一般不会重复加载。

## 反射

概述：在运行时解析 `Class` 对象，动态访问字段、方法、构造器。

### 获取 Class 对象

1. `对象.getClass()`
2. `类名.class`
3. `Class.forName("全限定类名")`

### 构造方法

- `getConstructors()` / `getConstructor(...)`：public 构造
- `getDeclaredConstructors()` / `getDeclaredConstructor(...)`：含私有
- `newInstance(...)`：创建实例

### 成员方法

- `getMethods()` / `getMethod(name, ...)`：public（含继承）
- `getDeclaredMethods()` / `getDeclaredMethod(name, ...)`：含私有（注意是单数 `getDeclaredMethod`）
- `invoke(obj, args...)`：调用方法

### 成员字段

- `getFields()`：所有 public 字段
- `getDeclaredField(name)`：指定字段（含私有）
- `set(obj, value)` / `get(obj)`：赋值与取值

## 注解

作用：说明代码、生成文档、做编译检查、替代部分配置。

常见内置注解：

- `@Override`：检查是否正确重写
- `@Deprecated`：标记已过时
- `@SuppressWarnings`：抑制警告

自定义注解：`public @interface Xxx { }`

注意：有属性通常需赋值；仅有一个名为 `value` 的属性时可省略属性名。

### 元注解

- `@Target`：限制注解可用位置（TYPE / FIELD / METHOD 等）
- `@Retention`：控制生命周期（SOURCE / CLASS / RUNTIME）

解析：通过 `isAnnotationPresent`、`getAnnotation` 等读取注解信息（需 RUNTIME 保留策略）。

## 枚举

```java
public enum Xxx {
    A, B, C
}
```

特点：

- 枚举值本质上是该枚举类型的实例，通常视为 `static final`
- 构造默认 private
- 常用方法：`toString()`、`values()`、`valueOf(String)`
