[TOC]
# Dart类型

* Numbers(int,double)
* Strings(String)
* Booleans(bool)
* Records((value1,value2))
* Functions(Fuction)
* Lists(List,arrays)
* Sets(Set)
* Maps(Map)
* Runes(Runes)
* Symbols(symbl)
* null(Null)
* Object
* Enum
* Future and Stream
* Iterable
* Never
* dynamic
* void

## 类型转换
```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```
## 布尔值方法
```dart
// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);

// Check for zero.
var hitPoints = 0;
assert(hitPoints == 0);

// Check for null.
var unicorn = null;
assert(unicorn == null);

// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```
## Runes说明
Runes 是Dart中用于表示Unicode码点的类型，它代表字符串中的Unicode字符。在Dart中，每个字符串实际上都是由一系列Unicode码点组成的。
### 基本定义
```dart
Runes runes = 'Hello World'.runes;
Runes emojiRunes = '🚀��💻'.runes;
Runes chineseRunes = '你好世界'.runes;
Runes runes1 = Runes([72, 101, 108, 108, 111]); // "Hello"
Runes runes2 = Runes([0x1F680, 0x1F389, 0x1F4BB]); // "🚀🎉💻"
Runes runes3 = Runes([0x4F60, 0x597D, 0x4E16, 0x754C]); // "你好世界"
```
### 属性方法以及遍历

```dart
void main() {
  String text = '🚀🎉💻你好';
  Runes runes = text.runes;
  
  print('字符串: $text');
  print('Runes长度: ${runes.length}');
  print('字符串长度: ${text.length}');
  print('字符串代码单元长度: ${text.codeUnits.length}');
  
  // 输出:
  // 字符串: ������你好
  // Runes长度: 5
  // 字符串长度: 5
  // 字符串代码单元长度: 10
}
------------------
void main() {
  String text = '🚀🎉💻你好';
  Runes runes = text.runes;
  
  print('遍历Runes:');
  for (int rune in runes) {
    print('码点: $rune, 字符: ${String.fromCharCode(rune)}');
  }
  
  // 输出:
  // 码点: 128640, 字符: 🚀
  // 码点: 127881, 字符: 🎉
  // 码点: 128187, 字符: ��
  // 码点: 20320, 字符: 你
  // 码点: 22909, 字符: 好
}
```
### 转换
```dart
void main() {
  // Runes转字符串
  Runes runes = Runes([72, 101, 108, 108, 111]);
  String text = String.fromCharCodes(runes);
  print('转换结果: $text'); // 输出: 转换结果: Hello
  
  // 处理emoji
  Runes emojiRunes = Runes([0x1F680, 0x1F389]);
  String emojiText = String.fromCharCodes(emojiRunes);
  print('Emoji文本: $emojiText'); // 输出: Emoji文本: ��🎉
}
```

## Symbol说明
Symbol 是Dart中的一种特殊类型，用于表示标识符（如变量名、方法名、类名等）。Symbol主要用于反射、元编程和动态调用等场景。
### 基本定义
```dart
// Symbol是标识符的表示
Symbol symbol1 = #hello;
Symbol symbol2 = #world;
Symbol symbol3 = #myMethod;
Symbol symbol4 = #MyClass;
```
### 创建方式
```dart
void main() {
  // 基本Symbol创建
  Symbol methodName = #calculate;
  Symbol variableName = #userCount;
  Symbol className = #User;
  
  print('方法名Symbol: $methodName');
  print('变量名Symbol: $variableName');
  print('类名Symbol: $className');
  
  // 输出:
  // 方法名Symbol: Symbol("calculate")
  // 变量名Symbol: Symbol("userCount")
  // 类名Symbol: Symbol("User")
}
```
### 字符串创建Symbol
```dart
void main() {
  // 从字符串创建Symbol
  Symbol symbol1 = Symbol('calculate');
  Symbol symbol2 = Symbol('userCount');
  Symbol symbol3 = Symbol('User');
  
  print('从字符串创建: $symbol1');
  print('从字符串创建: $symbol2');
  print('从字符串创建: $symbol3');
  
  // 注意：字符串创建的Symbol和#创建的Symbol是相同的
  print('是否相等: ${#calculate == Symbol('calculate')}'); // true
}
```
### 基本用法
```dart
void main() {
  Symbol symbol = #hello;
  
  // 获取Symbol的名称
  print('Symbol名称: ${symbol.toString()}');
  
  // 比较Symbol
  Symbol symbol1 = #hello;
  Symbol symbol2 = #hello;
  Symbol symbol3 = #world;
  
  print('symbol1 == symbol2: ${symbol1 == symbol2}'); // true
  print('symbol1 == symbol3: ${symbol1 == symbol2}'); // false
  
  // Symbol的hashCode
  print('symbol1 hashCode: ${symbol1.hashCode}');
  print('symbol2 hashCode: ${symbol2.hashCode}');
}
```