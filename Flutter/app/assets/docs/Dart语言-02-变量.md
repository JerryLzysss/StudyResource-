# 变量

## 基础定义
```dart
//变量 name 的类型被推断为 String
//如果一个对象不受限于单一类型，可以指定为 Object 类型（或在必要时使用 dynamic）。
var name='Bob';

```
## 空安全
空安全能够防止意外访问 null 的变量而导致的错误。这样的错误也被称为空解引用错误。访问一个求值为 null 的表达式的属性或调用方法时，会发生空解引用错误。但是对于 toString() 方法和 hashCode 属性，空安全会体现出例外情况。 Dart 编译器可以在空安全的基础上在编译期检测到这些潜在的错误。

例如，假设你想要查找 int 变量 i 的绝对值。如果 i 是 null ，调用 i.abs() 会导致空解引用错误。在其他语言中，尝试这样做可能会导致运行时错误，但是 Dart 的编译器禁止这些操作。所以 Dart 应用程序不会引发运行时错误。
### 三个关键更改
* 当你为变量、参数或另一个相关组件指定类型时，可以控制该类型是否允许 null
```dart
String? name  // Nullable type. Can be `null` or string.
String name   // Non-nullable type. Cannot be `null` but can be string.
```
* 必须在使用变量之前对其进行初始化
* 不能在可空类型的表达式上访问属性或调用方法

## 默认值
具有可空类型的未初始化变量的初始值为 null 。即使是具有数值类型的变量，初始值也为空，因为数字（就像 Dart 中的其他所有东西一样）都是对象。
```dart
int? lineCount;
assert(lineCount == null);
//当你在生产环境中运行代码时，assert() 调用会被忽略。
//另外在开发过程中，assert(condition) 如果其 条件 为 false，会抛出一个异常。
```
你不必在声明变量时初始化变量，但在使用之前需要为其赋值。
顶级变量和类变量是延迟初始化的，它们会在第一次被使用时再初始化。

## 延迟初始化变量
* 声明一个非空变量，但不在声明时初始化。
* 延迟初始化一个变量。
```dart
late String description;

void main() {
  description = 'Feijoada!';
  print(description);
}
```

## 终值 (final) 和常量 (const)

如果你不打算更改一个变量，可以使用 final 或 const 修饰它，而不是使用 var 或作为类型附加。一个 final 变量只能设置一次，const 变量是编译时常量。（const 常量隐式包含了 final。）
final只能设置一次值
const变量是编译时常量

虽然 final 对象不能被修改，但它的字段可能可以被更改。相比之下，const 对象及其字段不能被更改：它们是 不可变的。

## wildcard
注:需要在3.7版本下使用
该变量类似于匿名运算符?使用`_`来作为声明使用.这个值时无法获取的,可以在一个命名空间使用多个这种值.
* 变量
```
main() {
  var _ = 1;
  int _ = 2;
}
```
* 循环变量
```
for (var _ in list) {}
```
* 错误捕获
```
try {
  throw '!';
} catch (_) {
  print('oops');
}
```

* 泛型
```
class T<_> {}
void genericFunction<_>() {}

takeGenericCallback(<_>() => true);
```
* 函数参数
```
Foo(_, this._, super._, void _()) {}

list.where((_) => true);

void f(void g(int _, bool _)) {}

typedef T = void Function(String _, String _);
```