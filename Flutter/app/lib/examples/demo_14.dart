import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Scrolling — ListView / GridView / PageView / SingleChildScrollView 效果。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Scrolling',
      summary: '对应滚动类 widget：ListView、GridView、PageView、SingleChildScrollView 等。',
      children: [
        TopicSection(
          title: 'ListView（纵向）',
          child: SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                leading: CircleAvatar(radius: 14, child: Text('${i + 1}', style: const TextStyle(fontSize: 12))),
                title: Text('列表项 ${i + 1}'),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'ListView（横向）',
          child: SizedBox(
            height: 72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => Container(
                width: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.primaries[i % Colors.primaries.length].shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('#$i'),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'GridView',
          child: SizedBox(
            height: 160,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(
                9,
                (i) => Container(
                  color: Colors.blue.shade100,
                  alignment: Alignment.center,
                  child: Text('G$i'),
                ),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'PageView',
          child: SizedBox(
            height: 100,
            child: PageView(
              children: [
                for (final c in [Colors.teal, Colors.indigo, Colors.deepOrange])
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: c.shade200,
                    alignment: Alignment.center,
                    child: const Text('左右滑动翻页'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
