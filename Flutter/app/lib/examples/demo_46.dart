import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '将字体从 package 中对外暴露',
      summary: '通过 pubspec fonts 声明字体族；package 内字体需指定 package 名。本 App 本地字体族名为 AppNotoSansSC。',
      children: [
        TopicSection(
          title: '默认主题字体',
          child: Text('你好 Flutter — Theme 默认', style: Theme.of(context).textTheme.headlineSmall),
        ),
        const TopicSection(
          title: '显式指定 fontFamily',
          child: Text(
            '你好 Flutter — AppNotoSansSC',
            style: TextStyle(fontFamily: 'AppNotoSansSC', fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        const TopicSection(
          title: 'pubspec 示意',
          child: TopicCode("flutter:\n  fonts:\n    - family: AppNotoSansSC\n      fonts:\n        - asset: assets/fonts/NotoSansSC-Regular.ttf"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
