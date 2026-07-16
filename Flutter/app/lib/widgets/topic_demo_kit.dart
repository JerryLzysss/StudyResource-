import 'package:flutter/material.dart';

/// 用户界面 / 界面以外开发示例的统一外框与说明组件。
class TopicDemoScaffold extends StatelessWidget {
  const TopicDemoScaffold({
    super.key,
    required this.title,
    required this.summary,
    required this.children,
    this.floatingActionButton,
  });

  final String title;
  final String summary;
  final List<Widget> children;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: floatingActionButton,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            summary,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class TopicSection extends StatelessWidget {
  const TopicSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class TopicBulletList extends StatelessWidget {
  const TopicBulletList(this.items, {super.key});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• '),
                Expanded(child: Text(item, style: const TextStyle(height: 1.45))),
              ],
            ),
          ),
      ],
    );
  }
}

class TopicCode extends StatelessWidget {
  const TopicCode(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'AppRoboto',
          fontFamilyFallback: const ['AppNotoSansSC', 'Consolas'],
          fontSize: 12.5,
          height: 1.45,
          color: scheme.onSurface,
        ),
      ),
    );
  }
}

/// 工程/配置类主题：示例区展示文档要点，引导查看官方文档 Tab。
class DocAlignedPanel extends StatelessWidget {
  const DocAlignedPanel({
    super.key,
    required this.title,
    required this.summary,
    required this.points,
    this.codeHint,
  });

  final String title;
  final String summary;
  final List<String> points;
  final String? codeHint;

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: title,
      summary: summary,
      children: [
        TopicSection(
          title: '与官方文档对应的要点',
          child: TopicBulletList(points),
        ),
        if (codeHint != null)
          TopicSection(title: '关键概念 / 命令', child: TopicCode(codeHint!)),
        const TopicSection(
          title: '说明',
          child: Text('完整步骤、配置与代码摘录请切换到「官方文档」Tab 阅读。'),
        ),
      ],
    );
  }
}
