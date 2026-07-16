import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/dart_demo_frame.dart';

/// Record — 元组、解构、相等性

(int, int) swap((int, int) record) {
  final (a, b) = record;
  return (b, a);
}

(String name, int age) userInfo(Map<String, dynamic> json) {
  return (json['name'] as String, json['age'] as int);
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  var _pair = (1, 2);
  late final (String, int) _user;

  @override
  void initState() {
    super.initState();
    _user = userInfo({'name': 'Dash', 'age': 10, 'color': 'blue'});
  }

  @override
  Widget build(BuildContext context) {
    final (name, age) = _user;
    final point = (1, 2, 3);
    final color = (1, 2, 3);
    final namedPoint = (x: 1, y: 2, z: 3);
    final namedColor = (r: 1, g: 2, b: 3);

    return DartDemoFrame(
      title: 'Record',
      subtitle: '不可变聚合类型：位置字段、命名字段与解构',
      children: [
        DemoSection(
          title: '当前位置 Record: $_pair',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('var record = (1, 2);\nvar (a, b) = record;'),
              const SizedBox(height: 8),
              Text('\$1 = ${_pair.$1}, \$2 = ${_pair.$2}'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() => _pair = swap(_pair)),
                child: const Text('swap((a, b))'),
              ),
            ],
          ),
        ),
        DemoSection(
          title: '函数多值返回',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("(String, int) userInfo(...) => (name, age);"),
              const SizedBox(height: 8),
              Text('解构后: name=$name, age=$age'),
            ],
          ),
        ),
        DemoSection(
          title: '相等性',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('位置 Record (1,2,3)==(1,2,3) → ${point == color}'),
              // 不同类型的命名 Record 无法用 == 比较（字段名不同即不同类型）
              Text('命名点 $namedPoint · 命名色 $namedColor（字段名不同，类型不同）'),
              const SizedBox(height: 8),
              const CodeLine('({int x,y,z}) 与 ({int r,g,b}) 即使值相同也不是同一类型'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
