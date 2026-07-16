import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// 布局概览 — 约束传递示意
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '概览',
      summary: '布局核心：父级下发约束 → 子级回报尺寸 → 父级决定位置。',
      children: [
        TopicSection(
          title: '约束示意 ConstrainedBox',
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 120, maxWidth: 240, minHeight: 48, maxHeight: 80),
              child: Container(
                color: Colors.indigo.shade100,
                alignment: Alignment.center,
                child: const Text('子组件在约束范围内布局'),
              ),
            ),
          ),
        ),
        TopicSection(
          title: '对齐 Align',
          child: Container(
            height: 80,
            color: Colors.grey.shade200,
            child: const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text('右下对齐'),
              ),
            ),
          ),
        ),
        TopicSection(
          title: '常见布局构件',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(label: Text('Row / Column')),
              Chip(label: Text('Stack')),
              Chip(label: Text('ListView')),
              Chip(label: Text('GridView')),
              Chip(label: Text('CustomScrollView')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
