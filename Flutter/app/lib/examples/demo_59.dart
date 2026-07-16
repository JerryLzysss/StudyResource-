import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final a = FocusNode();
  final b = FocusNode();

  @override
  void dispose() {
    a.dispose();
    b.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '管理输入框之间的焦点',
      summary: 'FocusNode / FocusScope 在输入框间移动焦点；键盘「下一步」可 requestFocus。',
      children: [
        TopicSection(
          title: '焦点切换',
          child: Column(
            children: [
              TextField(
                focusNode: a,
                decoration: const InputDecoration(labelText: '字段 A', border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).requestFocus(b),
              ),
              const SizedBox(height: 12),
              TextField(
                focusNode: b,
                decoration: const InputDecoration(labelText: '字段 B', border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  OutlinedButton(onPressed: () => a.requestFocus(), child: const Text('聚焦 A')),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () => b.requestFocus(), child: const Text('聚焦 B')),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () => FocusScope.of(context).unfocus(), child: const Text('收起')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
