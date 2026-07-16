import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '针对插件作者',
      summary: '开发 package/plugin：确定支持平台、实现通道、写好示例与文档。',
      children: [
        TopicSection(
          title: '插件结构',
          child: const TopicCode('mypackage/\n  lib/\n  android/\n  ios/\n  pubspec.yaml'),
        ),
        const TopicSection(
          title: '要点',
          child: TopicBulletList([
            '明确支持的平台与最低系统版本',
            'MethodChannel / FFI 实现原生能力',
            '提供 example/ 与完善 README',
          ]),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
