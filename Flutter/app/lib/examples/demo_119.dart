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
      title: 'Firebase 概览',
      summary: 'FlutterFire 接入 Analytics、Auth、Firestore、Crashlytics 等；需控制台配置。',
      children: [
        TopicSection(
          title: '常见 Firebase 产品',
          child: Column(
            children: [
              for (final p in ['Authentication', 'Cloud Firestore', 'Cloud Messaging', 'Crashlytics', 'Remote Config'])
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
          child: TopicCode("dart pub global activate flutterfire_cli\\nflutterfire configure"),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
