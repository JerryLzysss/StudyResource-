# Record
Record 是Dart 3.0引入的一种新的数据类型，它允许您创建包含多个命名或位置字段的不可变数据结构。Record类似于python中的元组(tuple).
## 基础定义
```dart
var record = ('first', a: 2, b: true, 'last');
---------------
(String, int) record;
record = ('A string', 123);
--------------
//指定函数值
({int a, bool b}) record;
record = (a: 123, b: true);
```
## 函数使用
```dart
(int, int) swap((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
```
## 取值
```dart
//可以通过$1,$2索引的形式获取值
(num, Object) pair = (42, 'a');

var first = pair.$1; // Static type `num`, runtime type `int`.
var second = pair.$2; // Static type `Object`, runtime type `String`.

```
## 相同判断
```dart
(int x, int y, int z) point = (1, 2, 3);
(int r, int g, int b) color = (1, 2, 3);
print(point == color);//值相等
-----------------------------------------------------------------
({int x, int y, int z}) point = (x: 1, y: 2, z: 3);
({int r, int g, int b}) color = (r: 1, g: 2, b: 3);
print(point == color); // 字段名不等
```

## 多值传递
```dart
// Returns multiple values in a record:
(String name, int age) userInfo(Map<String, dynamic> json) {
  return (json['name'] as String, json['age'] as int);
}

final json = <String, dynamic>{'name': 'Dash', 'age': 10, 'color': 'blue'};

// Destructures using a record pattern with positional fields:
var (name, age) = userInfo(json);

/* Equivalent to:
  var info = userInfo(json);
  var name = info.$1;
  var age  = info.$2;
*/
```