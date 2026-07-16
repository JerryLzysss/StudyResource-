import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '资源 & 媒体',
      summary: '在 pubspec.yaml 声明 assets，用 Image.asset / rootBundle 加载。',
      children: [
        TopicSection(
          title: 'Icon 作为内置资源示意',
          child: Row(
            children: [
              Icon(Icons.flutter_dash, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              const Expanded(child: Text('本地图片请放 assets/ 并在 pubspec 声明后使用 Image.asset。')),
            ],
          ),
        ),
        const TopicSection(
          title: 'pubspec',
          child: TopicCode("flutter:\n  assets:\n    - assets/images/logo.png"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
