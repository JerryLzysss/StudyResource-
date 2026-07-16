import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final selected = <String>{};


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: 'Google APIs',
      summary: '通过 googleapis / 官方插件调用 Maps、Sign-In 等，需 OAuth 与平台密钥。',
      children: [
        TopicSection(
          title: '常见 Google 能力',
          child: Column(
            children: [
              for (final p in ['Google Sign-In', 'Maps', 'Drive API', 'Calendar API'])
                CheckboxListTile(
                  dense: true,
                  title: Text(p),
                  value: selected.contains(p),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      selected.add(p);
                    } else {
                      selected.remove(p);
                    }
                  }),
                ),
              Text('已选 ${selected.length} 项（示意接入清单）'),
            ],
          ),
        ),
        TopicSection(
          title: '配置命令',
          child: TopicCode("在 Google Cloud 创建凭据\\n按插件 README 配置 Android/iOS"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
