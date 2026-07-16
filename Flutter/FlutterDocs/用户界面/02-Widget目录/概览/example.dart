import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Widget 目录概览 — 与目录首页类似的分类效果导览。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(IconData, String, String)>[
      (Icons.widgets, 'Basics', 'AppBar / Row / Column / Text…'),
      (Icons.grid_view, 'Layout', 'Align / Expanded / Stack…'),
      (Icons.animation, 'Animation', 'AnimatedContainer…'),
      (Icons.touch_app, 'Interaction', 'GestureDetector / InkWell…'),
      (Icons.text_fields, 'Text', 'Text / RichText…'),
    ];

    return TopicDemoScaffold(
      title: '概览',
      summary: '核心 Widget 目录概览：可按设计系统或基础分类浏览，并在本 App 中查看效果。',
      children: [
        TopicSection(
          title: '分类入口（效果示意）',
          child: Column(
            children: [
              for (final (icon, name, desc) in items)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(icon, size: 20)),
                    title: Text(name),
                    subtitle: Text(desc),
                  ),
                ),
            ],
          ),
        ),
        TopicSection(
          title: '最小 Hello',
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.blue.shade50,
            child: const Center(
              child: Text('Hello, Flutter Widgets!', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
