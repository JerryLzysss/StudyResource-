import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/dart_demo_frame.dart';

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
