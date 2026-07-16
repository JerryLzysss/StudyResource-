import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isCupertino = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    return TopicDemoScaffold(
      title: '不同平台的自动适配',
      summary: '同一套代码可按平台切换控件风格（Material / Cupertino）与交互习惯。',
      children: [
        TopicSection(
          title: '当前平台',
          child: TopicCode('defaultTargetPlatform = $defaultTargetPlatform\nisCupertino-ish = $isCupertino'),
        ),
        TopicSection(
          title: '自适应按钮示意',
          child: isCupertino
              ? TextButton(onPressed: () {}, child: const Text('Cupertino 风格 TextButton'))
              : FilledButton(onPressed: () {}, child: const Text('Material FilledButton')),
        ),
        TopicSection(
          title: 'Theme 平台密度',
          child: Text('VisualDensity: ${Theme.of(context).visualDensity}'),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
