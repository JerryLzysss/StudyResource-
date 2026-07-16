import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '测试 — 概览',
      summary: '测试金字塔 + 调试工具，保证重构与发布信心。',
      children: [
        TopicSection(
          title: '三层测试',
          child: Column(
            children: [
              for (final x in [
                ('单元测试', '纯逻辑', Icons.science),
                ('Widget 测试', 'UI 组件', Icons.widgets),
                ('集成测试', '端到端', Icons.devices),
              ])
                ListTile(
                  leading: Icon(x.$3),
                  title: Text(x.$1),
                  subtitle: Text(x.$2),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
