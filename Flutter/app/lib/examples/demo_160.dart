import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '模拟滚动',
      summary: 'tester.drag / fling 模拟滚动，再 expect 可见项。',
      children: [
        TopicSection(
          title: '可滚动列表（请手势滚动）',
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (_, i) => ListTile(title: Text('Item $i', key: ValueKey('item-$i'))),
            ),
          ),
        ),
        const TopicSection(
          title: '测试代码',
          child: TopicCode("await tester.drag(find.byType(ListView), Offset(0, -300));\nawait tester.pumpAndSettle();"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
