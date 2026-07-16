import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final ctrl = TextEditingController();
  String live = '';

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() => live = ctrl.text));
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '读取输入框的内容',
      summary: 'TextField / TextEditingController 读取与监听输入；InputDecoration 调整样式。',
      children: [
        TopicSection(
          title: '输入与实时读取',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(
                  labelText: '昵称',
                  hintText: '输入点什么',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Text('实时: $live'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('读取: ${ctrl.text}'))),
                child: const Text('读取 controller.text'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
