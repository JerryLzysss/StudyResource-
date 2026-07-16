import 'package:flutter/material.dart';

/// 类型修饰符 — abstract / base / interface / final / sealed 概念演示

abstract class Animal {
  String sound();
  String describe() => '叫声: ${sound()}';
}

class Dog extends Animal {
  @override
  String sound() => 'Woof!';
}

class Cat extends Animal {
  @override
  String sound() => 'Meow!';
}

sealed class Shape {
  const Shape();
  double area();
}

class Circle extends Shape {
  const Circle(this.r);
  final double r;
  @override
  double area() => 3.14159 * r * r;
}

class Square extends Shape {
  const Square(this.side);
  final double side;
  @override
  double area() => side * side;
}

String describeShape(Shape s) => switch (s) {
      Circle(:final r) => '圆 r=$r，面积 ${s.area().toStringAsFixed(2)}',
      Square(:final side) => '正方形 side=$side，面积 ${s.area().toStringAsFixed(2)}',
    };

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Animal _animal = Dog();
  Shape _shape = const Circle(2);

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '类型修饰符',
      subtitle: 'abstract / sealed 等：控制继承与实现方式',
      children: [
        DemoSection(
          title: 'abstract：${_animal.describe()}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('abstract class Animal { String sound(); }'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Dog'),
                    selected: _animal is Dog,
                    onSelected: (_) => setState(() => _animal = Dog()),
                  ),
                  ChoiceChip(
                    label: const Text('Cat'),
                    selected: _animal is Cat,
                    onSelected: (_) => setState(() => _animal = Cat()),
                  ),
                ],
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'sealed + switch 穷尽：${describeShape(_shape)}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('sealed class Shape {}\nclass Circle extends Shape {}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Circle(2)'),
                    selected: _shape is Circle,
                    onSelected: (_) => setState(() => _shape = const Circle(2)),
                  ),
                  ChoiceChip(
                    label: const Text('Square(3)'),
                    selected: _shape is Square,
                    onSelected: (_) => setState(() => _shape = const Square(3)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const DemoSection(
          title: '其他修饰符（库边界）',
          child: CodeLine(
            'base     → 只能继承，不能 implements\n'
            'interface → 只能实现，不能跨库 extends\n'
            'final     → 不可再被继承/实现',
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

