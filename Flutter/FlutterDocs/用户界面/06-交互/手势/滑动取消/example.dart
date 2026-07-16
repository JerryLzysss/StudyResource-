import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final items = List.generate(6, (i) => '条目 ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '实现滑动取消',
      summary: 'Dismissible 实现滑动删除；需配合唯一 Key 与确认回调。',
      children: [
        TopicSection(
          title: '左滑删除',
          child: Column(
            children: [
              for (final item in List.of(items))
                Dismissible(
                  key: ValueKey(item),
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 16), child: const Icon(Icons.delete, color: Colors.white)),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => setState(() => items.remove(item)),
                  child: ListTile(title: Text(item), subtitle: const Text('← 左滑')),
                ),
              if (items.isEmpty)
                TextButton(onPressed: () => setState(() => items.addAll(List.generate(6, (i) => '条目 ${i + 1}'))), child: const Text('重置列表')),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
