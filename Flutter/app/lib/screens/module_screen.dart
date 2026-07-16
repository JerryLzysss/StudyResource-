import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_docs_demo/generated/demo_registry.g.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({
    super.key,
    required this.sectionFolder,
    required this.moduleFolder,
  });

  final String sectionFolder;
  final String moduleFolder;

  @override
  Widget build(BuildContext context) {
    final demos = kAllDemos
        .where((d) => d.sectionFolder == sectionFolder && d.moduleFolder == moduleFolder)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(demos.isNotEmpty ? demos.first.module : moduleFolder)),
      body: ListView.builder(
        itemCount: demos.length,
        itemBuilder: (context, index) {
          final d = demos[index];
          return ListTile(
            title: Text(d.title),
            trailing: const Icon(Icons.play_circle_outline),
            onTap: () => context.push('/demo/${Uri.encodeComponent(d.id)}'),
          );
        },
      ),
    );
  }
}
