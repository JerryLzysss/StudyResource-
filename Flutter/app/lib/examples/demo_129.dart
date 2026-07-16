import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '测试各层级',
      summary: '按层测试：数据层单测、ViewModel 单测、UI Widget 测、少量集成测。',
      children: [
        TopicSection(
          title: '测试金字塔',
          child: Column(
            children: [
              _bar('UI / 集成', 0.25, Colors.orange),
              _bar('Widget', 0.45, Colors.teal),
              _bar('单元（多）', 0.85, Colors.indigo),
              const SizedBox(height: 8),
              const Text('底层多、快；顶层少、慢但覆盖真实路径。'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _bar(String label, double w, Color c) => Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Row(
    children: [
      SizedBox(width: 88, child: Text(label)),
      Expanded(
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: w,
          child: Container(height: 28, color: c.withValues(alpha: 0.7), alignment: Alignment.center, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))),
        ),
      ),
    ],
  ),
);

Widget buildDemo() => const DemoPage();
