[TOC]
# File
概述:文件和目录的抽象表示
创建:File file=new File();
静态方法:pathSeparator:系统有关的路径分隔符
separator:系统有关的默认名称分隔符
构造方法:File(String parent,String child)根据所写路径创建File对象
File(File parent,String child)根据所填写的路径创建File对象
File(String pathname)根据所写路径创建File对象
常用方法:getAbsolutePath()获取File的绝对路径
getPath()获取封装路径
getName()获取文件或者文件夹名字
length()获取文件长度

## 绝对路径和相对路径
绝对路径:从盘符开始写的路径
相对路径:相对于当前参照的路径
默认情况下写的都是相对路径，其参照为模块所在的地方.

# IO流
作用:将当前的数据存储到文件内。
输入流:将数据从硬盘读到内存
输出流:从内存出发将数据写到硬盘
## IO分类
字节流:一切都是字节使用
输出:outpuutStream
输入:inputStream
字符流:用来操作文本文档
输出:Writer
输入:Reader

## FileOutputStream
构造:FileOutputStream(File file)
FileOutputStream(String name,boolean append)
append:实现续写追加
方法:write(int)写一个字节
write(byte[],int off,int len)写一个字节数组的部分从off开始长度为len.
特点:指定的文件如果没有，输出流会自动创建.
每次执行都会覆盖之前的文件.
换行符:windows:\r\n,linux:\n,macos:\r.

## FileInputStream
构造:FileInputStream(File file)
FileInputStream(String name)
方法:read()一次读一个字节
read(byte[],int off,int len)读取从off开始长度为len.
close()关闭资源
特点:读完之后需要重新定义对象进行读取，关闭之后流对象不能继续使用.
每个文件末尾都有一个结束标记，其值返回为-1.
数组长度定位多少每次读取多少，如果剩下的不够那么会直到读取完.
##  FileReader
使用原因:字节流不利于边读边看,原因在于UTF-8和GBK格式中分别占用3个字节和2个字节，如果按照字节读取，每次读取的字节没有构成一个汉字的字节数，是无法正常显示汉字的
解决方法:将文档的内容按照字符去操作.
概述:字符输入流Reader,子类FileReader
作用:将文本文档的内容读取到内存中.
构造；FileReader(File file)
FileReader(String path)
read()一次读取一个字符
read(char[]cbuf,int off,int len)读取字符数组从off开始长度为len.
close()关闭字符流
## FileWriter
概述:字符输出流:FileWriter
作用:将数据写到文件
构造:FileWriter(File file)
FileWriter(String fileName)
FileWriter(String fileName,boolean append)
方法:write(int)写一个字符
write(char[],int off,int len)写一个字符数组从off开始长度为Len
write(string)写一个字符串
flush()将缓冲区的数据刷到文件，后续流对象还能使用
close()关闭输出流，后续不能使用
注意点:FileWriter写的数据会先保存到缓冲区，因此
## IO异常
try(IO){

}catch(exception name){

}
## 字节缓冲流
作用:之前的读写方法都是本地方法，作用是和系统以及硬盘进行读写，效率低，而通过缓冲区来完成可以提高效率.
构造:通过将基本流包装成缓冲流
BufferedOutputStream:字节缓冲输出流
构造:BufferedOutputStream(OutputStream out)
BufferedInputStream:字节缓冲输入流
构造:BufferedInputStream(InputStream input)
细节:关闭缓冲流的时候不需要关闭基本流其原因在于缓冲流的close方法底层会自动关闭基本流.
缓冲流读写的过程:线通过基本流将数据读出，然后由于缓冲流缓冲区是8192，每次读取8192字节放到缓冲区，然后再将输入流的数据交给输出流，再写到硬盘，总的来说就是两个缓冲流都是在内存中进行数据交换的.
## 字符缓冲流
BufferedWriter:字符缓冲输出流
构造:BufferedWriter(writer w)
方法:效果和FileWriter一样
特有方法:newLine()换行
BufferedReader:字符缓冲输入流
构造:BufferedReader(reader r)
方法:和FileReader一样
特有方法:readLine()
## 字符编码
数字，英文，标点等到都是二进制数根据某种规则存储到计算机称为编码，反之按照某种规则解析称之为解码.
字符编码就是一套字符与二进制数之间的对应规则
常见的字符集有ASCII,ISO-8859-1,GBxxx,Unicode.

## 转换流
InputStreamReader
概述:字节流通向字符流
构造:InputStreamReader(InputStream in,String charsetName)
charsetName:指定编码格式
作用:可以直接指定编码，按照编码去读内容.
用法:和FileReader一样
OutputStreamWriter
概述:字符流通向字节流
构造:OutputStreamWriter(OutputStream out,String charsetName)
作用:可以直接指定编码，按照编码去写内容.
用法:和FileWriter一样

## 序列化流
作用:读写对象
ObjectOutputStream写对象
构造:ObjectOutputStream(OutputStream out)
方法:writeObject(Object obj)
ObjectInputStream读对象
构造:ObjectInputStream(InputStream in)
方法:ReadObject(Object obj)
### 反序列化的问题
序列化之后，修改源码没有重新序列化直接进行反序列化，就会出现序列号冲突的问题.
解决方式:直接确定序列号,在被序列化对的中定义一个static final long.
循环读取的次数和存储对象个数不对应会导致EOFexception,解决方式:通过将循环也反序列化.
## 打印流
构造:PrintStream(String fileName)
方法:println()换行输出
print()原样输出
用途:将控制台输出改为指定文件输出.
方法:setOut(printStream out)
## Properties结合
使用场景:作为配置文件
创建方式:1.创建xxx.properties
2.key和value都是key=value的形式
3.key和value都是String不加双引号
4.键值对最好不要有空格
例如:
```
xxx.username=123
xxx.password=1234
```
## IO流工具包
commonsIO引入jar包
1.当前模块创建文件夹lib
2.将jar包放到文件夹
3.将jar 包右键-> add as library
4.level 可以选择module
### utils
方法:IOutils.copy(InputStream in,OutputStream out) 传递字节流实现文件赋值
IOutils.closeQuietly(Stream)自动处理close()
Fileutils.copyDirectoryToDirectory(File src,File dest)目录及其内容进行复制
writeStringToFile(File file,String str)将字符串写进文本
readFileToString(File file)读取文本内容，返回字符串
## 设计模式
创建型:工厂方法，抽象工厂，单例，建造者，原型
结构性:适配器，装饰器，代理，外观，桥接，组合，享元.
行为型:策略，模板方法，观察者，迭代子模式，责任链，命令，备忘录，状态，访问者，中介者，解释器
## Lombok
作用:简化javabean开发
安装:从idea的plugins搜索,2022版本之后自带.
使用:settings->annotation Processors->Enable annotation processing (允许注解使用)
compiler->Build project automatically (自动编译)
优点:通过增加一些处理方式，能够以注解形式来简化java代码，简化javabean生成.
常用注解:
@Getter和@Setter
生成get和set方法
成员变量有效，类上对全体成员有效,静态变量无效
@ToString
生成toString方法
只能写在类上
@NoArgsConstructor和@AllArgsConstructor
无参数构造方法和满参数构造方法
只能写在类上.
@EqualsAndHashCode
生成hashCode和equals方法
只能写在类上.
@Data
生成get/set,toString,hashCode,equals和无参构造
只能写在类上.


