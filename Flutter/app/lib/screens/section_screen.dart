import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_docs_demo/generated/demo_registry.g.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key, required this.sectionFolder});

  final String sectionFolder;

  @override
  Widget build(BuildContext context) {
    final demos = kAllDemos.where((d) => d.sectionFolder == sectionFolder).toList();
    if (demos.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('空模块')),
        body: const Center(child: Text('暂无内容')),
      );
    }

    final sectionTitle = demos.first.section;
    final modules = <String, String>{};
    for (final d in demos) {
      modules[d.moduleFolder] = d.module;
    }

    return Scaffold(
      appBar: AppBar(title: Text(sectionTitle)),
      body: ListView.builder(
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final key = modules.keys.elementAt(index);
          final title = modules[key]!;
          final moduleDemos = demos.where((d) => d.moduleFolder == key).toList();
          final count = moduleDemos.length;
          return ListTile(
            title: Text(title),
            subtitle: Text(count == 1 ? '示例 / 官方文档' : '$count 个主题'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              if (count == 1) {
                context.push('/demo/${Uri.encodeComponent(moduleDemos.first.id)}');
              } else {
                context.push(
                  '/section/${Uri.encodeComponent(sectionFolder)}/module/${Uri.encodeComponent(key)}',
                );
              }
            },
          );
        },
      ),
    );
  }
}
