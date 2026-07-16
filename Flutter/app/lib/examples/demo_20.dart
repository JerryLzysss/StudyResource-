import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 构建与使用列表 — ListView / ListView.builder
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '构建与使用列表',
      summary: 'ListView 适合纵向滚动列表；item 多时用 builder 惰性创建子项。',
      children: [
        TopicSection(
          title: 'ListView.builder（惰性）',
          child: SizedBox(
            height: 280,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('条目 ${index + 1}'),
                    subtitle: const Text('仅可见项才会被构建'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          ),
        ),
        const TopicSection(
          title: '要点',
          child: TopicCode('ListView(\n  children: [...],  // 适合少量固定子项\n)\nListView.builder(  // 适合长列表\n  itemCount: n,\n  itemBuilder: ...\n)'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
