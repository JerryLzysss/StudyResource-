import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_docs_demo/generated/demo_registry.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = <String, String>{};
    for (final d in kAllDemos) {
      sections[d.sectionFolder] = d.section;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterDocs 示例合集'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '基于 Flutter 中文文档与 Dart 笔记整理的 ${kAllDemos.length} 个主题',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          ...sections.entries.map((e) {
            final count = kAllDemos.where((d) => d.sectionFolder == e.key).length;
            return Card(
              child: ListTile(
                title: Text(e.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('$count 个子模块'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/section/${Uri.encodeComponent(e.key)}'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
