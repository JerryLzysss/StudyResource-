import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '展示 SnackBar',
      summary: 'ScaffoldMessenger.showSnackBar 展示轻量反馈；可带 action。',
      children: [
        TopicSection(
          title: '展示 SnackBar',
          child: Wrap(
            spacing: 8,
            children: [
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已保存'))),
                child: const Text('简单提示'),
              ),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('已删除'),
                      action: SnackBarAction(label: '撤销', onPressed: () {}),
                    ),
                  );
                },
                child: const Text('带 Action'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
