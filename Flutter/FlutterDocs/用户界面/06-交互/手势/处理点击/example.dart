import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '处理点击',
      summary: 'InkWell / GestureDetector / IconButton 等处理点击；Material 子树才有水波纹。',
      children: [
        TopicSection(
          title: '多种点击控件',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ElevatedButton'))),
                child: const Text('Elevated'),
              ),
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('TextButton'))),
                child: const Text('Text'),
              ),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('IconButton'))),
                icon: const Icon(Icons.thumb_up),
              ),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('InkWell'))),
                child: const Padding(padding: EdgeInsets.all(12), child: Text('InkWell 区域')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
