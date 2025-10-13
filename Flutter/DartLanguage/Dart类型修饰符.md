
# Dart 类修饰符详解

## 1. `abstract` - 抽象类

### 1.1 基本概念
```dart
<code_block_to_apply_changes_from>
```

### 1.2 特点
- **不能实例化**：`abstract` 类不能直接创建实例
- **可以有抽象方法**：没有实现的方法
- **可以有具体方法**：有实现的方法
- **可以被继承和实现**

## 2. `base` - 基础类

### 2.1 基本概念
```dart
// 在库 a.dart 中
base class Vehicle {
  void moveForward(int meters) {
    print('Moving forward $meters meters');
  }
}

// 在库 b.dart 中
import 'a.dart';

// ✅ 可以构造
Vehicle myVehicle = Vehicle();

// ✅ 可以继承
base class Car extends Vehicle {
  int passengers = 4;
}

// ❌ 不能实现（在其他库中）
class MockVehicle implements Vehicle {  // 编译错误
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

### 2.2 特点
- **强制继承**：只能通过继承使用，不能实现
- **保证实现完整性**：所有子类都继承完整的实现
- **防止外部破坏**：外部库不能通过实现来破坏类的保证

## 3. `interface` - 接口类

### 3.1 基本概念
```dart
// 在库 a.dart 中
interface class Vehicle {
  void moveForward(int meters) {
    print('Moving forward $meters meters');
  }
}

// 在库 b.dart 中
import 'a.dart';

// ✅ 可以构造
Vehicle myVehicle = Vehicle();

// ❌ 不能继承（在其他库中）
class Car extends Vehicle {  // 编译错误
  int passengers = 4;
}

// ✅ 可以实现
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    print('Mock moving forward $meters meters');
  }
}
```

### 3.2 特点
- **只能实现，不能继承**：外部库只能实现接口，不能继承
- **保证方法调用**：类内部方法调用总是使用已知的实现
- **减少脆弱基类问题**

## 4. `final` - 最终类

### 4.1 基本概念
```dart
// 在库 a.dart 中
final class Vehicle {
  void moveForward(int meters) {
    print('Moving forward $meters meters');
  }
}

// 在库 b.dart 中
import 'a.dart';

// ✅ 可以构造
Vehicle myVehicle = Vehicle();

// ❌ 不能继承（在其他库中）
class Car extends Vehicle {  // 编译错误
  int passengers = 4;
}

// ❌ 不能实现（在其他库中）
class MockVehicle implements Vehicle {  // 编译错误
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

### 4.2 特点
- **完全封闭**：外部库既不能继承也不能实现
- **API 稳定性**：可以安全地添加增量更改
- **方法调用保证**：知道方法没有被第三方子类重写

## 5. `sealed` - 密封类

### 5.1 基本概念
```dart
sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

class Error<T> extends Result<T> {
  final String message;
  Error(this.message);
}

// 使用模式匹配
String handleResult(Result<String> result) {
  return switch (result) {
    Success<String>(data: final data) => 'Success: $data',
    Error<String>(message: final message) => 'Error: $message',
  };
}
```

### 5.2 特点
- **隐式抽象**：不能直接实例化
- **有限子类型**：所有子类型必须在同一库中定义
- **穷尽性检查**：编译器知道所有可能的子类型
- **模式匹配友好**：支持穷尽的 switch 表达式

## 6. 修饰符组合

### 6.1 有效组合
```dart
// 抽象基础类
abstract base class AbstractBase {
  void abstractMethod();
  void concreteMethod() {
    print('Concrete implementation');
  }
}

// 抽象接口类
abstract interface class AbstractInterface {
  void interfaceMethod();
}

// 抽象最终类
abstract final class AbstractFinal {
  void finalMethod();
}
```

### 6.2 无效组合
```dart
// ❌ 不能组合 base, interface, final
base interface final class Invalid {}  // 编译错误

// ❌ sealed 和 abstract 不能组合
abstract sealed class Invalid {}  // 编译错误

// ❌ sealed 不能与其他修饰符组合
sealed base class Invalid {}  // 编译错误
```



## 8. 使用建议

1. **`abstract`**：定义接口或基类，需要子类实现特定方法
2. **`base`**：需要强制继承，保证实现完整性
3. **`interface`**：定义契约，只允许实现不允许继承
4. **`final`**：完全封闭的类，不允许任何形式的子类型化
5. **`sealed`**：有限的状态集合，支持模式匹配

## 9. 版本要求

- **Dart 3.0+**：除了 `abstract` 外，其他修饰符都需要 Dart 3.0 或更高版本
- **向后兼容**：`abstract` 修饰符在 Dart 2.x 中就已存在

这些修饰符为 Dart 提供了更精细的类设计控制，让开发者能够更好地控制类的使用方式和继承关系，提高代码的安全性和可维护性。