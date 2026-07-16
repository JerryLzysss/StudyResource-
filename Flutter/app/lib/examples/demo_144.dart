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
      title: '配置 Web 开发',
      summary: 'Web 编译为 HTML/Canvas/WASM；注意 URL 策略、SEO 与插件兼容。',
      children: [
        TopicSection(
          title: '目标平台',
          child: Wrap(
            spacing: 8,
            children: [
              for (final p in ['Chrome', 'Edge', 'Safari', 'Firefox'])
                FilterChip(
                  label: Text(p),
                  selected: selected.contains(p),
                  onSelected: (v) => setState(() {
                    if (v) {
                      selected.add(p);
                    } else {
                      selected.remove(p);
                    }
                  }),
                ),
            ],
          ),
        ),
        TopicSection(
          title: '常用命令',
          child: TopicCode('''flutter run -d chrome\nflutter build web'''),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
