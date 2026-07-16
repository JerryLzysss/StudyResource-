import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '添加 Material 风格的水波纹',
      summary: 'InkWell / InkResponse 在 Material 祖先下绘制水波纹反馈。',
      children: [
        TopicSection(
          title: 'InkWell',
          child: Material(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: const SizedBox(
                height: 80,
                width: double.infinity,
                child: Center(child: Text('点击查看水波纹')),
              ),
            ),
          ),
        ),
        TopicSection(
          title: 'ListTile（自带 ink）',
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.waves),
              title: const Text('带水波纹的列表项'),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
