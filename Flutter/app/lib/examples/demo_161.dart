import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ctrl = TextEditingController();
  String msg = '';

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '模拟用户操作',
      summary: 'tap、enterText、longPress 等模拟用户；每次操作后 pump。',
      children: [
        TopicSection(
          title: '可操作控件',
          child: Column(
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: '输入', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => setState(() => msg = '提交: ${ctrl.text}'),
                child: const Text('提交'),
              ),
              Text(msg.isEmpty ? '等待操作' : msg),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  ctrl.text = 'from test';
                  setState(() => msg = '模拟 enterText + tap → 提交: from test');
                },
                child: const Text('一键模拟 tester 操作'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
