import 'package:flutter/material.dart';

/// 注释 — //  /* */  ///

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '注释',
      subtitle: '单行、多行与文档注释（dartdoc）',
      children: const [
        DemoSection(
          title: '单行注释 //',
          child: CodeLine("// TODO: refactor greeting\nprint('Welcome!');"),
        ),
        DemoSection(
          title: '多行注释 /* */',
          child: CodeLine('/*\n * 暂时禁用的代码块\n * llama.feed();\n */'),
        ),
        DemoSection(
          title: '文档注释 ///',
          child: CodeLine(
            '/// A domesticated South American camelid.\n'
            '///\n'
            '/// Don\'t forget to [feed] them.\n'
            'class Llama {\n'
            '  /// Feeds your llama [food].\n'
            '  void feed(Food food) {}\n'
            '}',
          ),
        ),
        DemoSection(
          title: '提示',
          child: Text('/// 文档注释会被 IDE 与 dartdoc 识别；可用 [链接] 引用同库成员。'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();

// --- 本地预览用 UI 辅助（与 demo_app 中 dart_demo_frame 一致）---
/// Dart 示例如统一外框：标题区 + 可滚动内容块。
class DartDemoFrame extends StatelessWidget {
  const DartDemoFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class DemoSection extends StatelessWidget {
  const DemoSection({
    super.key,
    required this.title,
    required this.child,
  });

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

class CodeLine extends StatelessWidget {
  const CodeLine(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
    );
  }
}

