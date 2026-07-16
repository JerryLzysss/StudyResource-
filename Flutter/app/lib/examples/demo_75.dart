import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '从新页面返回数据',
      summary: 'Navigator.pop(context, result) 把结果带回上一页。',
      children: [
        TopicSection(
          title: '选择并返回',
          child: FilledButton(
            onPressed: () async {
              final result = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('选择')),
                    body: ListView(
                      children: [
                        for (final s in ['苹果', '香蕉', '橙子'])
                          ListTile(
                            title: Text(s),
                            onTap: () => Navigator.pop(context, s),
                          ),
                      ],
                    ),
                  ),
                ),
              );
              if (context.mounted && result != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('返回: $result')));
              }
            },
            child: Text('去选择'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
