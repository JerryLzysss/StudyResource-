import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 网格视图
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '构建一个网格视图',
      summary: 'GridView 按行列排布；可用 count / extent / builder 等构造方式。',
      children: [
        TopicSection(
          title: 'GridView.count（2 列）',
          child: SizedBox(
            height: 280,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(12, (i) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo, size: 36, color: Colors.teal.shade700),
                      const SizedBox(height: 6),
                      Text('格子 ${i + 1}'),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        const TopicSection(
          title: '代码要点',
          child: TopicCode('GridView.count(\n  crossAxisCount: 2,\n  children: [...],\n)'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
