import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '支持的平台',
      summary: 'Flutter 支持移动、桌面与 Web；各平台能力与发布流程略有差异。',
      children: [
        TopicSection(
          title: '平台矩阵',
          child: Column(
            children: [
              for (final p in [
                ('Android', true),
                ('iOS', true),
                ('Web', true),
                ('Windows', true),
                ('macOS', true),
                ('Linux', true),
              ])
                ListTile(
                  leading: Icon(p.$2 ? Icons.check_circle : Icons.cancel, color: p.$2 ? Colors.green : Colors.grey),
                  title: Text(p.$1),
                  subtitle: Text(p.$2 ? '官方支持' : '受限'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
