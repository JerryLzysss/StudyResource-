import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final name = TextEditingController();
  final deps = <String>['go_router'];

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Package 和插件',
      summary: '在 pubspec.yaml 声明依赖，flutter pub get 拉取；插件含原生代码。',
      children: [
        TopicSection(
          title: '添加依赖',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'package 名', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() {
                  if (name.text.trim().isEmpty) return;
                  deps.add(name.text.trim());
                  name.clear();
                }),
                child: const Text('flutter pub add（模拟）'),
              ),
              const SizedBox(height: 8),
              TopicCode(deps.isEmpty ? 'dependencies:' : 'dependencies:\n${deps.map((d) => '  $d: any').join('\n')}'),
            ],
          ),
        ),
        TopicSection(
          title: '本 App 已用',
          child: Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text('go_router')),
              Chip(label: Text('flutter_markdown')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
