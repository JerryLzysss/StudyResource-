import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final rows = <String>['学习 Flutter', '写示例'];
  final ctrl = TextEditingController();

  void _add() {
    final t = ctrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      rows.add(t);
      ctrl.clear();
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '利用 SQLite 持久化数据',
      summary: 'sqflite 在设备上跑 SQLite。此处用 List 模拟表的增删查。',
      children: [
        TopicSection(
          title: 'todos 表（内存）',
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: const InputDecoration(hintText: '新任务', border: OutlineInputBorder()),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _add, child: const Text('INSERT')),
              ]),
              const SizedBox(height: 8),
              for (var i = 0; i < rows.length; i++)
                ListTile(
                  leading: Text('#${i + 1}'),
                  title: Text(rows[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => setState(() => rows.removeAt(i)),
                  ),
                ),
              if (rows.isEmpty) const Text('SELECT * → 空表'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
