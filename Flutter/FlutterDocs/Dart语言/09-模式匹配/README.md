[TOC]
# Dart 模式匹配
模式匹配 是Dart 3.0引入的一种强大语法，允许您使用模式来解构和匹配数据结构，使代码更加简洁和易读。

## 基本形式
```dart
// 模式匹配的基本形式
var pattern = value;

// 解构赋值
var (a, b) = (1, 2);
var [first, second] = [10, 20];
var {'name': name, 'age': age} = {'name': 'John', 'age': 25};
```
## 内容解构
```dart
void main() {
  // 基本Record解构
  (int, String) record = (42, 'hello');
  var (number, text) = record;
  
  print('数字: $number'); // 数字: 42
  print('文本: $text');   // 文本: hello
  
  // 部分解构
  var (first, _) = record; // 忽略第二个值
  print('第一个值: $first'); // 第一个值: 42
  
  // 嵌套Record解构
  (int, (String, bool)) nested = (1, ('test', true));
  var (num, (str, flag)) = nested;
  
  print('数字: $num, 字符串: $str, 布尔值: $flag');
  // 输出: 数字: 1, 字符串: test, 布尔值: true
}
```

### Record解构
```dart
void main() {
  // 命名Record解构
  ({String name, int age, String city}) person = (
    name: '张三',
    age: 25,
    city: '北京'
  );
  
  var (name: personName, age: personAge, city: personCity) = person;
  print('$personName 住在 $personCity，年龄 $personAge');
  
  // 部分解构
  var (name: _, age: personAge2) = person; // 只解构age
  print('年龄: $personAge2');
  
  // 重命名解构
  var (name: fullName, age: userAge) = person;
  print('$fullName 的年龄是 $userAge');
}
```
### List解构
```dart
void main() {
  // 基本List解构
  List<int> numbers = [1, 2, 3, 4, 5];
  var [first, second, third] = numbers;
  
  print('前三个数: $first, $second, $third');
  
  // 部分解构
  var [head, ...tail] = numbers;
  print('头部: $head, 尾部: $tail');
  
  // 忽略某些元素
  var [_, second2, _, fourth] = numbers;
  print('第二个和第四个: $second2, $fourth');
  
  // 嵌套List解构
  List<List<int>> matrix = [[1, 2], [3, 4], [5, 6]];
  var [[a, b], [c, d], [e, f]] = matrix;
  print('矩阵: $a, $b, $c, $d, $e, $f');
}
```
### Map解构
```dart
void main() {
  // 基本Map解构
  Map<String, dynamic> user = {
    'name': '李四',
    'age': 30,
    'city': '上海',
    'email': 'lisi@example.com'
  };
  
  var {'name': userName, 'age': userAge} = user;
  print('$userName 的年龄是 $userAge');
  
  // 部分解构
  var {'name': _, 'city': userCity} = user;
  print('城市: $userCity');
  
  // 重命名解构
  var {'name': fullName, 'age': userAge2} = user;
  print('$fullName 的年龄是 $userAge2');
  
  // 嵌套Map解构
  Map<String, Map<String, dynamic>> nested = {
    'user': {'name': '王五', 'age': 28},
    'settings': {'theme': 'dark', 'language': 'zh'}
  };
  
  var {'user': {'name': nestedName, 'age': nestedAge}} = nested;
  print('嵌套用户: $nestedName, 年龄: $nestedAge');
}
```

### Switch内容解构
```dart
void main() {
  var value = (1, 'hello');
  
  var result = switch (value) {
    (int a, String b) => '整数: $a, 字符串: $b',
    (int a, int b) => '两个整数: $a, $b',
    _ => '其他类型'
  };
  
  print(result); // 输出: 整数: 1, 字符串: hello
  
  // 更复杂的模式
  var list = [1, 2, 3];
  var listResult = switch (list) {
    [] => '空列表',
    [var first] => '只有一个元素: $first',
    [var first, var second] => '两个元素: $first, $second',
    [var first, var second, ...var rest] => '多个元素: $first, $second, 其余: $rest',
  };
  
  print(listResult); // 输出: 多个元素: 1, 2, 其余: [3]
}
```
### 类实例解构
```dart
class Point {
  final int x;
  final int y;
  
  const Point(this.x, this.y);
  
  // 定义解构方法
  void deconstruct(void Function(int x, int y) callback) {
    callback(x, y);
  }
}

void main() {
  var point = Point(10, 20);
  
  // 使用解构方法
  point.deconstruct((x, y) {
    print('坐标: ($x, $y)');
  });
  
  // 如果类支持解构操作符
  // var Point(x: x, y: y) = point; // 需要类实现解构操作符
}
```
### 枚举模式解构
```dart
enum Status { active, inactive, pending }

void main() {
  var status = Status.active;
  
  var message = switch (status) {
    Status.active => '用户活跃',
    Status.inactive => '用户非活跃',
    Status.pending => '用户待验证'
  };
  
  print(message); // 输出: 用户活跃
}
```

# Dart 匹配类型
* 或 ||
* 与 &&
* 关系 >= / <= 
* 类型转换 as
* 空值检查 ?
* 空值断言 assert
* 常量 const
* 变量 variable
* 标识符 Indentifier
* 括号 ()
* 列表 list
* 剩余元素 argument ...
* 映射 map
* 记录 record
* 对象 object
* 通配符 wildcard

## 类型转换
```dart
(num, Object) record = (1, 's');
var (i as int, s as String) = record;
```
## 空值检查
```dart
String? maybeString = 'nullable with base type String';
switch (maybeString) {
  case var s?:
  // 's' has type non-nullable String here.
}
```
## 空值断言
```dart
List<String?> row = ['user', null];
switch (row) {
  case ['user', var name!]: // ...
  // 'name' is a non-nullable string here.
}
```
## 剩余元素
```dart
var [a, b, ..., c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 6 7".
print('$a $b $c $d');
--------------
var [a, b, ...rest, c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 [3, 4, 5] 6 7".
print('$a $b $rest $c $d');
```
## 对象
```dart
switch (shape) {
  // Matches if shape is of type Rect, and then against the properties of Rect.
  case Rect(width: var w, height: var h): // ...
}
```
## 通配符
```dart
var list = [1, 2, 3];
var [_, two, _] = list;
switch (record) {
  case (int _, String _):
    print('First field is int and second is String.');
}
```