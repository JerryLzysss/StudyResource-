[TOC]
# Flutter 异步操作

## 使用内容
Future：表示异步操作的结果
async/await：简化异步代码的语法糖

### 基本用法
```dart
// 创建Future
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return '数据获取成功';
}

// 使用Future
void main() async {
  print('开始获取数据...');
  String data = await fetchData();
  print('获取到的数据: $data');
}
```

### Future创建
```dart
// 1. 使用async函数
Future<String> method1() async {
  return 'Hello';
}

// 2. 使用Future.value
Future<String> method2() {
  return Future.value('Hello');
}

// 3. 使用Future.delayed
Future<String> method3() {
  return Future.delayed(Duration(seconds: 1), () => 'Hello');
}

// 4. 使用Completer
Future<String> method4() {
  final completer = Completer<String>();
  Timer(Duration(seconds: 1), () {
    completer.complete('Hello');
  });
  return completer.future;
}
```
### Future状态检查
```dart
Future<String> future = fetchData();

// 检查Future状态
print('Future是否完成: ${future.isCompleted}');

// 使用then处理结果
future.then((data) {
  print('数据: $data');
}).catchError((error) {
  print('错误: $error');
});
```
### async和await
```dart
// async函数总是返回Future
Future<int> addAsync(int a, int b) async {
  await Future.delayed(Duration(seconds: 1));
  return a + b;
}

// 等价于
Future<int> addAsyncEquivalent(int a, int b) {
  return Future.delayed(Duration(seconds: 1)).then((_) => a + b);
}
```

### 并发操作
```dart
void main() async {
  print('开始');
  
  // 串行执行 - 总时间 = 2 + 2 = 4秒
  String result1 = await fetchData1();
  String result2 = await fetchData2();
  
  // 并发执行 - 总时间 = max(2, 2) = 2秒
  Future<String> future1 = fetchData1();
  Future<String> future2 = fetchData2();
  String result3 = await future1;
  String result4 = await future2;
  
  // 使用Future.wait等待所有操作完成
  List<String> results = await Future.wait([
    fetchData1(),
    fetchData2(),
    fetchData3(),
  ]);
  
  print('所有结果: $results');
}
```

### try/catch
```dart
Future<String> fetchDataWithError() async {
  await Future.delayed(Duration(seconds: 1));
  throw Exception('网络错误');
}

void main() async {
  try {
    String data = await fetchDataWithError();
    print('数据: $data');
  } catch (e) {
    print('捕获到错误: $e');
  }
}

void main() {
  fetchDataWithError()
    .then((data) => print('数据: $data'))
    .catchError((error) => print('错误: $error'));
}
```
### 异常处理
```dart
Future<void> handleSpecificErrors() async {
  try {
    await fetchData();
  } on TimeoutException catch (e) {
    print('超时错误: $e');
  } on FormatException catch (e) {
    print('格式错误: $e');
  } catch (e) {
    print('其他错误: $e');
  } finally {
    print('清理资源');
  }
}
```

## stream数据流
```dart
// 创建Stream
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// 监听Stream
void main() {
  countStream().listen(
    (data) => print('接收到数据: $data'),
    onError: (error) => print('错误: $error'),
    onDone: () => print('Stream完成'),
  );
}
```
### 手动控制Stream
```dart
import 'dart:async';

class DataService {
  final StreamController<String> _controller = StreamController<String>();
  
  Stream<String> get dataStream => _controller.stream;
  
  void addData(String data) {
    _controller.sink.add(data);
  }
  
  void addError(String error) {
    _controller.sink.addError(error);
  }
  
  void dispose() {
    _controller.close();
  }
}

void main() {
  final dataService = DataService();
  
  dataService.dataStream.listen(
    (data) => print('数据: $data'),
    onError: (error) => print('错误: $error'),
    onDone: () => print('Stream关闭'),
  );
  
  dataService.addData('第一条数据');
  dataService.addData('第二条数据');
  dataService.addError('发生错误');
  dataService.dispose();
}
```
### 广播Stream
```dart
// 单订阅Stream（默认）
StreamController<String> singleController = StreamController<String>();

// 广播Stream（多订阅）
StreamController<String> broadcastController = StreamController<String>.broadcast();

void main() {
  // 可以添加多个监听器
  broadcastController.stream.listen((data) => print('监听器1: $data'));
  broadcastController.stream.listen((data) => print('监听器2: $data'));
  
  broadcastController.sink.add('广播数据');
  broadcastController.close();
}
```

### Future.wait - 等待所有Future
```dart
Future<void> fetchMultipleData() async {
  List<Future<String>> futures = [
    fetchData1(),
    fetchData2(),
    fetchData3(),
  ];
  
  // 等待所有Future完成
  List<String> results = await Future.wait(futures);
  print('所有结果: $results');
}
```
### Future.any - 等待第一个完成的Future
```dart
Future<void> fetchFirstAvailable() async {
  List<Future<String>> futures = [
    fetchFromServer1(),
    fetchFromServer2(),
    fetchFromServer3(),
  ];
  
  // 等待第一个完成的Future
  String result = await Future.any(futures);
  print('第一个结果: $result');
}
```