import 'package:flutter/material.dart';

/// 变量 — 空安全 / late / final·const / wildcard

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String? _nullableName;
  late String _lateDescription;
  bool _lateReady = false;
  final String _finalName = 'Bob';
  static const String _appId = 'com.example.dart';

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '变量',
      subtitle: '空安全、late、final / const 与通配符 _',
      children: [
        DemoSection(
          title: '空安全 String? vs String',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine('String? name;  // 可为 null\nString name;   // 不可为 null'),
              const SizedBox(height: 8),
              Row(
                children: [
                  FilledButton(
                    onPressed: () => setState(() => _nullableName = 'Alice'),
                    child: const Text('赋值为 Alice'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => setState(() => _nullableName = null),
                    child: const Text('设为 null'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _nullableName == null
                    ? '当前为 null，不能直接调用 .length'
                    : 'name = "$_nullableName"，长度 ${_nullableName!.length}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'late 延迟初始化',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("late String description;\ndescription = 'Feijoada!';"),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() {
                  _lateDescription = 'Feijoada!';
                  _lateReady = true;
                }),
                child: const Text('初始化 late 变量'),
              ),
              const SizedBox(height: 8),
              Text(_lateReady ? 'description = $_lateDescription' : '尚未初始化，读取会抛 LateInitializationError'),
            ],
          ),
        ),
        DemoSection(
          title: 'final 与 const',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CodeLine("final name = '$_finalName';  // 运行时只能赋一次\nconst appId = '$_appId'; // 编译时常量"),
              const SizedBox(height: 8),
              const Text('final 对象引用不可变，但其字段可能可变；const 深不可变。'),
            ],
          ),
        ),
        const DemoSection(
          title: '通配符 _（Dart 3.7+）',
          child: CodeLine('var _ = 1;\nfor (var _ in list) {}\ncatch (_) { ... }'),
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

