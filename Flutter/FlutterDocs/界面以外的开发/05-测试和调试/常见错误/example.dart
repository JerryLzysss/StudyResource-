import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final errors = const {
    'A RenderFlex overflowed': 'Row/Column 子项过大 → 用 Expanded/Flexible/换行或约束宽度。',
    'setState() called after dispose()': '异步回调先检查 mounted，或取消订阅。',
    'Vertical viewport was given unbounded height': 'ListView 放在无界高度父级 → 给高度或用 shrinkWrap/Expanded。',
  };


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '常见的 Flutter 错误',
      summary: '认识常见断言：RenderFlex overflow、setState after dispose、无限宽高等。',
      children: [
        TopicSection(
          title: '点选查看原因与修法',
          child: Column(
            children: [
              for (final e in errors.entries)
                ExpansionTile(
                  title: Text(e.key, style: const TextStyle(fontSize: 14)),
                  children: [Padding(padding: const EdgeInsets.all(12), child: Text(e.value))],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
