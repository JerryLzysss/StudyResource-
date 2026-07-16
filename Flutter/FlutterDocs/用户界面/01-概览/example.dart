import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TopicDemoScaffold(
      title: '用户界面 · 概览',
      summary: 'Flutter UI 由 Widget 树构成：布局、主题、交互、导航与动画都在同一套声明式模型里组合。',
      children: [
        TopicSection(
          title: '声明式 UI 一瞥',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('一切皆 Widget', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(avatar: Icon(Icons.widgets, size: 16, color: scheme.primary), label: const Text('Widget')),
                  Chip(avatar: Icon(Icons.view_quilt, size: 16, color: scheme.primary), label: const Text('布局')),
                  Chip(avatar: Icon(Icons.palette, size: 16, color: scheme.primary), label: const Text('主题')),
                  Chip(avatar: Icon(Icons.touch_app, size: 16, color: scheme.primary), label: const Text('交互')),
                  Chip(avatar: Icon(Icons.route, size: 16, color: scheme.primary), label: const Text('导航')),
                  Chip(avatar: Icon(Icons.animation, size: 16, color: scheme.primary), label: const Text('动画')),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('从左侧模块进入各主题查看可运行效果')),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('从下一模块开始探索'),
              ),
            ],
          ),
        ),
        const TopicSection(
          title: '学习路径',
          child: TopicBulletList([
            'Widget 目录 → 认识常用组件',
            '布局 → 约束与滚动',
            '自适应 → MediaQuery / 断点',
            '主题 / 交互 / 导航 / 动画 → 打磨体验',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
