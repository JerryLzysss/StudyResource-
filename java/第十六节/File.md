# File 与 IO

## File

概述：文件和目录路径名的抽象表示。

静态字段：

- `pathSeparator`：路径列表分隔符
- `separator`：文件名分隔符

构造：

- `File(String pathname)`
- `File(String parent, String child)`
- `File(File parent, String child)`

常用方法：`getAbsolutePath()` / `getPath()` / `getName()` / `length()`

### 绝对路径和相对路径

- 绝对路径：从盘符（或根）开始的完整路径
- 相对路径：相对于当前工作目录/模块的路径

## IO 流

- 输入流：从硬盘读到内存
- 输出流：从内存写到硬盘

分类：

| 类型 | 输出 | 输入 |
|------|------|------|
| 字节流 | `OutputStream` | `InputStream` |
| 字符流 | `Writer` | `Reader` |

### FileOutputStream

- 构造：`FileOutputStream(File)` / `FileOutputStream(String, boolean append)`
- `append=true` 表示追加写入
- 方法：`write(int)`、`write(byte[], int off, int len)`
- 换行：Windows `\r\n`，Linux `\n`，旧 macOS `\r`

### FileInputStream

- `read()`：读一个字节，读到末尾返回 `-1`
- `read(byte[], int off, int len)`：读入数组
- 使用完毕应 `close()`

### FileReader / FileWriter

字节流按字节读取，遇到多字节汉字可能截断；文本内容更适合用字符流。

`FileWriter` 写入内容会先进入缓冲区，因此需要 `flush()` 或 `close()` 才会真正写到文件。

### 缓冲流

把基本流包装成缓冲流可提高效率。

- `BufferedInputStream` / `BufferedOutputStream`
- `BufferedReader` / `BufferedWriter`（`readLine()` / `newLine()`）
- 关闭缓冲流时，底层通常会一并关闭被包装的基本流

缓冲读写过程：先通过基本流读数据，再经缓冲区（常见默认约 8192）在内存中交换，最后写出。

### 转换流

- `InputStreamReader`：字节流 → 字符流，可指定字符集
- `OutputStreamWriter`：字符流 → 字节流，可指定字符集

### 序列化流

- `ObjectOutputStream.writeObject(obj)`：写对象
- `ObjectInputStream.readObject()`：读对象

注意：

- 类建议声明固定 `serialVersionUID`，避免修改源码后反序列化版本冲突
- 循环读取次数与对象个数不匹配可能导致 `EOFException`

### 打印流

`PrintStream`：`print` / `println`；可用 `System.setOut` 重定向控制台输出。

### Properties

常用作配置文件：`key=value`，类型多为 String。

- `setProperty` / `getProperty` / `stringPropertyNames` / `load`

### Commons IO（第三方）

引入 jar 后可用 `IOUtils`、`FileUtils` 简化复制与读写。

## 设计模式（简记）

- 创建型：工厂方法、抽象工厂、单例、建造者、原型
- **结构型**：适配器、装饰器、代理、外观、桥接、组合、享元
- 行为型：策略、模板方法、观察者、迭代器、责任链、命令、备忘录、状态、访问者、中介者、解释器

## Lombok

作用：用注解简化 JavaBean 样板代码（需开启注解处理）。

常用：`@Getter` / `@Setter` / `@ToString` / `@NoArgsConstructor` / `@AllArgsConstructor` / `@EqualsAndHashCode` / `@Data`
