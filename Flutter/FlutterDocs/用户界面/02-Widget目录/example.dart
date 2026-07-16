import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Widget 目录入口 — 展示设计系统与基础分类预览。
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Widget 目录',
      summary: 'Flutter 提供视觉、结构、平台与交互类 widget。下方为两套设计系统与基础分类的效果预览。',
      children: [
        TopicSection(
          title: '设计系统预览',
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.apple),
                  title: const Text('Cupertino'),
                  subtitle: const Text('iOS / macOS 风格'),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  leading: Icon(Icons.android, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  title: const Text('Material 3'),
                  subtitle: const Text('视觉、行为与动效'),
                  trailing: FilledButton(onPressed: () {}, child: const Text('按钮')),
                ),
              ),
            ],
          ),
        ),
        TopicSection(
          title: '基础分类一瞥',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(avatar: Icon(Icons.text_fields, size: 16), label: Text('Text')),
              Chip(avatar: Icon(Icons.view_column, size: 16), label: Text('Layout')),
              Chip(avatar: Icon(Icons.animation, size: 16), label: Text('Animation')),
              Chip(avatar: Icon(Icons.touch_app, size: 16), label: Text('Interaction')),
              Chip(avatar: Icon(Icons.input, size: 16), label: Text('Input')),
              Chip(avatar: Icon(Icons.brush, size: 16), label: Text('Painting')),
            ],
          ),
        ),
        const TopicSection(
          title: '说明',
          child: Text('请进入各子主题（Basics、Layout、Material…）查看对应 widget 的可运行效果。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
