import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 处理长列表 — builder 惰性构建
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '处理长列表',
      summary: '长列表务必用 ListView.builder，避免一次性创建上千子组件。下方共 1000 项，仅视口附近被构建。',
      children: [
        TopicSection(
          title: 'ListView.builder · itemCount: 1000',
          child: SizedBox(
            height: 320,
            child: ListView.builder(
              itemCount: 1000,
              itemBuilder: (_, i) => ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 14,
                  child: Text('${i + 1}', style: const TextStyle(fontSize: 10)),
                ),
                title: Text('超长列表项 #${i + 1}'),
                subtitle: const Text('滚动时按需创建，而不是一次生成全部'),
              ),
            ),
          ),
        ),
        const TopicSection(
          title: '要点',
          child: TopicBulletList([
            '使用 ListView.builder / GridView.builder',
            '避免 children: List.generate(很大) 一次性全部创建',
            '复杂 item 可再配合缓存与拆分',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
