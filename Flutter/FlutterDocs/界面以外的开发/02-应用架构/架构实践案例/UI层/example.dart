import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int ticks = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'UI 层',
      summary: 'UI 层：展示状态、转发用户意图；不直接写 HTTP/SQL。',
      children: [
        TopicSection(
          title: '单向数据流',
          child: Column(
            children: [
              _box(context, 'View (Widgets)', Theme.of(context).colorScheme.primaryContainer),
              const Text('↓ 事件 / ↑ 状态'),
              _box(context, 'ViewModel / Controller', Theme.of(context).colorScheme.secondaryContainer),
              const Text('↓ 调用'),
              _box(context, '（到数据层）', Theme.of(context).colorScheme.surfaceContainerHighest),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => setState(() => ticks++),
                child: Text('用户点击 → VM 处理（次数 $ticks）'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _box(BuildContext context, String t, Color c) => Container(
  width: double.infinity,
  margin: const EdgeInsets.symmetric(vertical: 4),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)),
  child: Text(t, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
);

Widget buildDemo() => const DemoPage();
