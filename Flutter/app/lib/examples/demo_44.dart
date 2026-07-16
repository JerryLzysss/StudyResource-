import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return TopicDemoScaffold(
      title: '字体 & 版式',
      summary: 'TextTheme 提供 display / headline / title / body / label 层级，保持版式一致。',
      children: [
        TopicSection(
          title: 'TextTheme 层级',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Display Small', style: tt.displaySmall),
              Text('Headline Medium', style: tt.headlineMedium),
              Text('Title Large', style: tt.titleLarge),
              Text('Body Large — 正文示例段落。', style: tt.bodyLarge),
              Text('Label Medium', style: tt.labelMedium),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
