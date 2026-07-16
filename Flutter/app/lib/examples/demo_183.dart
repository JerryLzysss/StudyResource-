import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final stages = const ['checkout', 'flutter test', 'build', 'upload'];
  int step = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '持续部署',
      summary: 'CI/CD：提交 → 测试 → 构建 → 分发（内测/商店）。',
      children: [
        TopicSection(
          title: '流水线',
          child: Column(
            children: [
              for (var i = 0; i < stages.length; i++)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: i < step ? Colors.green : Colors.grey.shade300,
                    child: Text('${i + 1}'),
                  ),
                  title: Text(stages[i]),
                ),
              FilledButton(
                onPressed: () => setState(() => step = (step % (stages.length + 1)) + (step >= stages.length ? 0 : 1)),
                child: Text(step >= stages.length ? '重置' : '推进一步'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
