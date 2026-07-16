import 'package:flutter/material.dart';

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

// --- 本地预览用 UI 辅助 ---
/// Dart 示例如统一外框：标题区 + 可滚动内容块。
class DartDemoFrame extends StatelessWidget {
  const DartDemoFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class DemoSection extends StatelessWidget {
  const DemoSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class CodeLine extends StatelessWidget {
  const CodeLine(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
    );
  }
}

