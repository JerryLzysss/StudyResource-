import 'package:flutter/material.dart';

/// 模式匹配 — Record / List / Map / switch

sealed class Shape {
  const Shape();
}

class Circle extends Shape {
  const Circle(this.radius);
  final double radius;
}

class Rectangle extends Shape {
  const Rectangle(this.width, this.height);
  final double width;
  final double height;
}

String describe(Shape shape) => switch (shape) {
      Circle(radius: final r) when r > 0 => '圆，半径 $r',
      Circle(radius: final r) => '无效圆 (r=$r)',
      Rectangle(:final width, :final height) => '矩形 ${width}x$height',
    };

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Shape _shape = const Circle(3);
  final _numbers = [1, 2, 3, 4, 5];
  final _user = {'name': '李四', 'age': 30, 'city': '上海'};

  @override
  Widget build(BuildContext context) {
    final [first, second, ...rest] = _numbers;
    final {'name': name, 'city': city} = _user;

    return DartDemoFrame(
      title: '模式匹配',
      subtitle: '解构赋值与 switch 表达式（Dart 3）',
      children: [
        DemoSection(
          title: 'List 解构：首=$first, 次=$second, 其余=$rest',
          child: const CodeLine('var [first, second, ...rest] = [1,2,3,4,5];'),
        ),
        DemoSection(
          title: 'Map 解构：$name @ $city',
          child: const CodeLine("var {'name': name, 'city': city} = user;"),
        ),
        DemoSection(
          title: 'switch(Shape)：${describe(_shape)}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine(
                'switch (shape) {\n'
                '  Circle(radius: final r) when r > 0 => ...\n'
                '  Rectangle(:final width, :final height) => ...\n'
                '}',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Circle(3)'),
                    selected: _shape is Circle && (_shape as Circle).radius == 3,
                    onSelected: (_) => setState(() => _shape = const Circle(3)),
                  ),
                  ChoiceChip(
                    label: const Text('Circle(0)'),
                    selected: _shape is Circle && (_shape as Circle).radius == 0,
                    onSelected: (_) => setState(() => _shape = const Circle(0)),
                  ),
                  ChoiceChip(
                    label: const Text('Rectangle'),
                    selected: _shape is Rectangle,
                    onSelected: (_) => setState(() => _shape = const Rectangle(4, 2)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();

// --- 本地预览用 UI 辅助（与 demo_app 中 dart_demo_frame 一致）---
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

