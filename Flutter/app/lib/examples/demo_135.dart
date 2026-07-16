import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ctrl = TextEditingController(text: 'demo');
  final log = <String>[];

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '撰写平台代码 (插件编写实现)',
      summary: 'MethodChannel / EventChannel / FFI 让 Dart 调用原生，或嵌入原生视图。',
      children: [
        TopicSection(
          title: 'MethodChannel 模拟',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: 'invokeMethod 参数', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() {
                  log.add('Dart → native: getBattery(${ctrl.text})');
                  log.add('native → Dart: 85%');
                }),
                child: const Text('channel.invokeMethod'),
              ),
              const SizedBox(height: 8),
              TopicCode(log.isEmpty ? '// 尚无调用' : log.join('\n')),
            ],
          ),
        ),
        const TopicSection(
          title: '文档对应',
          child: TopicCode("static const ch = MethodChannel('demo/battery');\nfinal level = await ch.invokeMethod('getBattery');"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
