[TOC]
# Dart注解

Dart注解（Annotations）是一种元数据，用于为代码元素提供额外的信息。注解以`@`符号开头，可以应用于类、方法、字段、参数等代码元素。

## 内置注解（Built-in Annotations）

### 1. @override
用于标记重写父类方法的方法，提供编译时检查。

```dart
class Animal {
  void makeSound() {
    print('Some sound');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof!');
  }
}
```

### 2. @deprecated
标记已废弃的API，编译器会给出警告。

```dart
@Deprecated(
  'Use newMethod() instead. '
  'This feature was deprecated after v2.0.0.'
)
void oldMethod() {
  // 旧实现
}

void newMethod() {
  // 新实现
}
```

### 3. @pragma
向Dart编译器提供特定的指令，用于优化和特殊处理。

```dart
// 告诉编译器这个函数永远不会被内联
@pragma('vm:never-inline')
void complexFunction() {
  // 复杂的计算逻辑
}

// 告诉编译器这个函数应该被内联
@pragma('vm:prefer-inline')
int simpleCalculation(int a, int b) {
  return a + b;
}

// 告诉编译器这个函数可能抛出异常
@pragma('vm:prefer-const')
Widget buildWidget() {
  return const Text('Hello');
}

// 禁用特定警告
@pragma('vm:prefer-const-elements')
List<Widget> buildChildren() {
  return [
    const Text('Child 1'),
    const Text('Child 2'),
  ];
}
```

### 4. @visibleForTesting
标记仅用于测试的API，在生产代码中应该避免使用。

```dart
class MyService {
  // 私有方法，但在测试中需要访问
  @visibleForTesting
  void resetState() {
    // 仅用于测试的方法
  }
  
  // 私有字段，测试中需要验证
  @visibleForTesting
  int get internalCounter => _counter;
  
  int _counter = 0;
  
  void increment() {
    _counter++;
  }
}

// 在测试文件中可以访问这些标记的方法
void main() {
  test('should reset counter', () {
    final service = MyService();
    service.increment();
    service.resetState(); // 可以访问测试方法
    expect(service.internalCounter, 0); // 可以访问测试字段
  });
}
```

### 5. @awaitNotRequired
标记不需要await的函数，即使它们返回Future。

```dart
class DataService {
  // 这个函数返回Future但不需要await
  @awaitNotRequired
  Future<void> logEvent(String event) async {
    // 异步记录事件，但不关心结果
    await _writeToLog(event);
  }
  
  // 这个函数需要await
  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    return response.body;
  }
}

void main() async {
  final service = DataService();
  
  // 不需要await，因为标记了@awaitNotRequired
  service.logEvent('User login');
  
  // 需要await，因为要获取结果
  final data = await service.fetchData();
  print(data);
}
```


## 自定义注解

您也可以创建自己的注解类：

```dart
class MyAnnotation {
  final String description;
  const MyAnnotation(this.description);
}

@MyAnnotation('这是一个自定义注解')
class MyClass {
  // 类实现
}
```

