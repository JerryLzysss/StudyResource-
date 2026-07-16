import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 带间隔的列表 — ListView.separated
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '构建元素之间包含间隔的列表',
      summary: 'ListView.separated 用 separatorBuilder 在条目之间插入分隔线或间距。',
      children: [
        TopicSection(
          title: 'ListView.separated',
          child: SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: 12,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (_, i) => ListTile(
                leading: Icon(Icons.circle, size: 12, color: Colors.blue.shade400),
                title: Text('项目 ${i + 1}'),
                subtitle: const Text('条目之间有 Divider'),
              ),
            ),
          ),
        ),
        const TopicSection(
          title: '代码要点',
          child: TopicCode('ListView.separated(\n  itemCount: n,\n  itemBuilder: ...,\n  separatorBuilder: (_, __) => const Divider(),\n)'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
