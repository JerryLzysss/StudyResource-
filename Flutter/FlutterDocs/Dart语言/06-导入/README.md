# Dart导入

### 1. 基本语法
Dart使用`import`关键字来导入库，语法如下：
```dart
import '库的路径';
```

### 2. 导入类型

#### 2.1 核心库导入
```dart
<code_block_to_apply_changes_from>
```

#### 2.2 包导入
```dart
// 导入外部包
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:test/test.dart';
```

#### 2.3 相对路径导入
```dart
// 导入项目内的文件
import 'path/to/my_other_file.dart';
import './widgets/custom_widget.dart';
import '../utils/helper.dart';
```

### 3. 导入修饰符

#### 3.1 别名导入（as）
```dart
import 'dart:math' as math;
import 'dart:ui' as ui;
```

#### 3.2 选择性导入（show）
```dart
// 只导入特定的类或函数
import 'dart:ui' show Color, Paint;
import 'package:flutter/material.dart' show MaterialApp, Scaffold;
```

#### 3.3 隐藏导入（hide）
```dart
// 导入库但隐藏特定的类或函数
import 'dart:io' hide File;
```

### 4. 导入顺序规范

根据Flutter官方规范，导入应该按以下顺序排列：

1. **Dart核心库**（dart:xxx）
2. **Flutter库**（package:flutter/xxx）
3. **第三方包**（package:xxx）
4. **项目内部文件**（相对路径）

```dart
// 示例：正确的导入顺序
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:english_words/english_words.dart';

import 'widgets/custom_widget.dart';
import 'utils/helper.dart';
```

### 5. 实际项目中的导入示例

从您的项目代码中可以看到：

**firstapp/lib/main.dart:**
```dart
import 'package:flutter/material.dart';        // Flutter核心UI库
import 'package:english_words/english_words.dart';  // 第三方包
```

**WidgetContents/lib/main.dart:**
```dart
import 'package:flutter/material.dart';        // Flutter核心UI库
```

### 6. 导入的最佳实践

1. **按顺序排列**：遵循官方推荐的导入顺序
2. **使用别名**：当库名冲突时使用`as`关键字
3. **选择性导入**：使用`show`只导入需要的部分，减少命名冲突
4. **避免循环导入**：确保不会出现A导入B，B又导入A的情况
5. **相对路径vs绝对路径**：
   - 项目内部文件：优先使用相对路径
   - 跨包导入：使用绝对路径

### 7. 特殊导入

#### 7.1 延迟导入（deferred）
```dart
import 'package:greetings/hello.dart' deferred as hello;

// 使用时需要先加载
Future<void> greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

#### 7.2 条件导入
```dart
import 'package:myapp/io.dart' if (dart.library.html) 'package:myapp/web.dart';
```

这就是Dart导入机制的完整介绍。导入是Dart中组织代码和复用功能的重要方式，正确使用导入可以让代码更加清晰和模块化。
