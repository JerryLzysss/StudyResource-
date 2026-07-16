import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

/// Interaction — GestureDetector / InkWell / Dismissible 效果。
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String _log = '点击 / 长按 / 双击下方区域';
  final _items = List.generate(4, (i) => '可滑动删除项 ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Interaction',
      summary: '对应交互 widget：GestureDetector、InkWell、Dismissible 等。',
      children: [
        TopicSection(
          title: 'GestureDetector',
          child: GestureDetector(
            onTap: () => setState(() => _log = 'onTap'),
            onDoubleTap: () => setState(() => _log = 'onDoubleTap'),
            onLongPress: () => setState(() => _log = 'onLongPress'),
            child: Container(
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(_log, textAlign: TextAlign.center),
            ),
          ),
        ),
        TopicSection(
          title: 'InkWell（水波纹）',
          child: Material(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('InkWell 点击')),
                );
              },
              child: const SizedBox(
                height: 56,
                width: double.infinity,
                child: Center(child: Text('点我看水波纹')),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'Dismissible',
          child: Column(
            children: [
              for (final item in List.of(_items))
                Dismissible(
                  key: ValueKey(item),
                  background: Container(color: Colors.red.shade300, alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 16), child: const Icon(Icons.delete, color: Colors.white)),
                  onDismissed: (_) => setState(() => _items.remove(item)),
                  child: ListTile(title: Text(item), subtitle: const Text('向左或向右滑动')),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
