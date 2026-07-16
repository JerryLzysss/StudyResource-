import 'package:flutter/material.dart';

/// 类型 — 转换、集合、布尔判断

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _input = TextEditingController(text: '3.14159');
  String _parseResult = '';
  final List<String> _list = ['Voyager', 'Pioneer'];
  final Set<String> _set = {'a', 'b'};
  final Map<String, int> _map = {'Dash': 10, 'Flutter': 3};

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _parse() {
    final raw = _input.text.trim();
    setState(() {
      try {
        final asInt = int.tryParse(raw);
        final asDouble = double.parse(raw);
        _parseResult =
            'int.tryParse → $asInt\ndouble.parse → $asDouble\ntoStringAsFixed(2) → ${asDouble.toStringAsFixed(2)}';
      } catch (e) {
        _parseResult = '解析失败: $e';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DartDemoFrame(
      title: '类型',
      subtitle: 'Numbers / String / bool / List / Set / Map 与类型转换',
      children: [
        DemoSection(
          title: '类型转换',
          child: Column(
            children: [
              TextField(
                controller: _input,
                decoration: const InputDecoration(
                  labelText: '输入数字字符串',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _parse(),
              ),
              const SizedBox(height: 8),
              FilledButton(onPressed: _parse, child: const Text('parse')),
              if (_parseResult.isNotEmpty) ...[
                const SizedBox(height: 8),
                CodeLine(_parseResult),
              ],
            ],
          ),
        ),
        DemoSection(
          title: '布尔判断',
          child: CodeLine(
            "''.isEmpty → ${''.isEmpty}\n"
            '0 == 0 → ${0 == 0}\n'
            '(0/0).isNaN → ${(0 / 0).isNaN}',
          ),
        ),
        DemoSection(
          title: 'List / Set / Map',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('List: $_list'),
              Text('Set（去重）: $_set'),
              Text('Map: $_map'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () => setState(() => _list.add('Cassini')),
                    child: const Text('List.add'),
                  ),
                  OutlinedButton(
                    onPressed: () => setState(() => _set.add('c')),
                    child: const Text('Set.add'),
                  ),
                  OutlinedButton(
                    onPressed: () => setState(() => _map['Dart'] = 1),
                    child: const Text('Map[...]='),
                  ),
                ],
              ),
            ],
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

