import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String out = '';


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'JSON 序列化',
      summary: 'jsonEncode / jsonDecode（或 json_serializable）在 Dart 对象与 JSON 间转换。',
      children: [
        TopicSection(
          title: '编解码演示',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () {
                  final map = {'id': 1, 'name': 'Flutter'};
                  final s = jsonEncode(map);
                  final back = jsonDecode(s) as Map<String, dynamic>;
                  setState(() => out = 'encode → $s\ndecode name=${back['name']}');
                },
                child: const Text('jsonEncode / jsonDecode'),
              ),
              const SizedBox(height: 8),
              if (out.isNotEmpty) TopicCode(out),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
