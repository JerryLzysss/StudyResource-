import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final steps = const ['版本号 / 签名就绪', 'flutter build', '产物自检', '上传商店或 CDN'];
  int done = 0;


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '构建和发布为 iOS 应用',
      summary: '使用 flutter build 产出发布产物，再提交商店或托管静态资源。',
      children: [
        TopicSection(
          title: '构建步骤',
          child: Column(
            children: [
              for (var i = 0; i < steps.length; i++)
                CheckboxListTile(
                  title: Text(steps[i]),
                  value: i < done,
                  onChanged: (_) => setState(() => done = (i + 1).clamp(0, steps.length)),
                ),
              TopicCode('flutter build ipa --release'),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
