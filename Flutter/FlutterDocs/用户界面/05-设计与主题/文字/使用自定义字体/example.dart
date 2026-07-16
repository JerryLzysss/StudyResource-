import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '使用自定义字体',
      summary: '通过 pubspec fonts 声明字体族；package 内字体需指定 package 名。本 App 已嵌入 Noto Sans SC。',
      children: [
        TopicSection(
          title: '默认主题字体',
          child: Text('你好 Flutter — Theme 默认', style: Theme.of(context).textTheme.headlineSmall),
        ),
        const TopicSection(
          title: '显式指定 fontFamily',
          child: Text(
            '你好 Flutter — Noto Sans SC',
            style: TextStyle(fontFamily: 'Noto Sans SC', fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        const TopicSection(
          title: 'pubspec 示意',
          child: TopicCode("flutter:\n  fonts:\n    - family: Noto Sans SC\n      fonts:\n        - asset: assets/fonts/NotoSansSC-Regular.otf"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
