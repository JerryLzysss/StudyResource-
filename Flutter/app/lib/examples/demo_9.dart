import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Basics — AppBar/Row/Column/Container/Text/Icon/Placeholder 等入门 widget 效果。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Basics',
      summary: '对应入门必知 widget：Text、Icon、Row、Column、Container、Placeholder、FlutterLogo 等。',
      children: [
        TopicSection(
          title: 'Text / Icon / FlutterLogo',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Icon(Icons.star, color: Colors.amber, size: 32),
              FlutterLogo(size: 40),
            ],
          ),
        ),
        TopicSection(
          title: 'Row / Column',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _box('A', Colors.orange.shade200)),
                  Expanded(child: _box('B', Colors.blue.shade200)),
                  Expanded(child: _box('C', Colors.green.shade200)),
                ],
              ),
              const SizedBox(height: 8),
              _box('Column 子项 1', Colors.purple.shade100),
              const SizedBox(height: 4),
              _box('Column 子项 2', Colors.purple.shade200),
            ],
          ),
        ),
        TopicSection(
          title: 'Container',
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal),
            ),
            child: const Text('Container：padding + decoration + 子组件'),
          ),
        ),
        TopicSection(
          title: 'Placeholder / ElevatedButton',
          child: Column(
            children: [
              const SizedBox(height: 60, child: Placeholder()),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _box(String label, Color color) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      color: color,
      child: Text(label),
    );
  }
}

Widget buildDemo() => const DemoPage();
