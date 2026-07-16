import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 横向列表
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colors.primaries;
    return TopicDemoScaffold(
      title: '构建一个横向列表',
      summary: '设置 scrollDirection: Axis.horizontal，即可得到横向滚动列表。',
      children: [
        TopicSection(
          title: '横向 ListView',
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: 15,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final c = colors[i % colors.length];
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: c.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text('卡片 ${i + 1}', style: TextStyle(color: c.shade900, fontWeight: FontWeight.bold)),
                );
              },
            ),
          ),
        ),
        const TopicSection(
          title: '代码要点',
          child: TopicCode("ListView(\n  scrollDirection: Axis.horizontal,\n  children: [...],\n)"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
