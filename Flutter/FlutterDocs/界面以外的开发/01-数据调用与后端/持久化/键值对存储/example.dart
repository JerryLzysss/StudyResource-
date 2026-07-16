import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final store = <String, String>{};
  final k = TextEditingController(text: 'theme');
  final v = TextEditingController(text: 'dark');

  @override
  void dispose() {
    k.dispose();
    v.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '将键值对数据存储在硬盘上',
      summary: 'shared_preferences 等把简单键值写入本地。此处用内存 Map 模拟读写。',
      children: [
        TopicSection(
          title: 'KV 读写',
          child: Column(
            children: [
              TextField(controller: k, decoration: const InputDecoration(labelText: 'key', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: v, decoration: const InputDecoration(labelText: 'value', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              Row(children: [
                FilledButton(onPressed: () => setState(() => store[k.text] = v.text), child: const Text('set')),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () { v.text = store[k.text] ?? ''; setState(() {}); }, child: const Text('get')),
                const SizedBox(width: 8),
                TextButton(onPressed: () => setState(() => store.remove(k.text)), child: const Text('remove')),
              ]),
              const SizedBox(height: 8),
              TopicCode(store.isEmpty ? '(empty)' : store.entries.map((e) => '${e.key}=${e.value}').join('\n')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
