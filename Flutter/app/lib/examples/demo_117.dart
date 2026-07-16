import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String disk = '';
  final ctrl = TextEditingController();

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '读写文件',
      summary: 'path_provider 取目录 + File 读写。下方模拟一个内存「文件」。',
      children: [
        TopicSection(
          title: '模拟文件内容',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ctrl,
                maxLines: 4,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'notes.txt'),
              ),
              const SizedBox(height: 8),
              Row(children: [
                FilledButton(onPressed: () => setState(() => disk = ctrl.text), child: const Text('写入')),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () { ctrl.text = disk; setState(() {}); }, child: const Text('读取')),
              ]),
              Text('磁盘快照长度: ${disk.length} 字符', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
