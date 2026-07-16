import 'package:flutter/material.dart';

/// 注解 — @override / @Deprecated / 自定义注解

class Animal {
  String makeSound() => 'Some sound';
}

class Dog extends Animal {
  @override
  String makeSound() => 'Woof!';
}

class Api {
  @Deprecated('请改用 newMethod()')
  String oldMethod() => '旧 API';

  String newMethod() => '新 API';
}

class Todo {
  const Todo(this.message);
  final String message;
}

@Todo('补充单元测试')
void unfinished() {}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _api = Api();
  String _log = '';

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '注解',
      subtitle: '用 @ 为代码附加元数据：override、deprecated、自定义等',
      children: [
        DemoSection(
          title: '@override：${Dog().makeSound()}',
          child: const CodeLine(
            'class Dog extends Animal {\n'
            '  @override\n'
            '  String makeSound() => \'Woof!\';\n'
            '}',
          ),
        ),
        DemoSection(
          title: '@Deprecated',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CodeLine("@Deprecated('Use newMethod()')\nvoid oldMethod() {}"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // ignore: deprecated_member_use_from_same_package
                      setState(() => _log = '调用: ${_api.oldMethod()}（已废弃）');
                    },
                    child: const Text('oldMethod()'),
                  ),
                  FilledButton(
                    onPressed: () => setState(() => _log = '调用: ${_api.newMethod()}'),
                    child: const Text('newMethod()'),
                  ),
                ],
              ),
              if (_log.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(_log),
              ],
            ],
          ),
        ),
        const DemoSection(
          title: '自定义注解',
          child: CodeLine(
            'class Todo {\n'
            '  const Todo(this.message);\n'
            '  final String message;\n'
            '}\n\n'
            "@Todo('补充单元测试')\n"
            'void unfinished() {}',
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();

// --- 本地预览用 UI 辅助 ---
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

