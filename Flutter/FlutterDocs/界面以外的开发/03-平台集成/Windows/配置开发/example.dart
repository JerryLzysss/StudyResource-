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
      title: '配置 Windows 开发',
      summary: '桌面端关注窗口、菜单、文件选择与多窗口体验。',
      children: [
        TopicSection(
          title: '目标平台',
          child: Wrap(
            spacing: 8,
            children: [
              for (final p in ['Windows', 'macOS', 'Linux'])
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
          child: TopicCode('''flutter run -d windows\nflutter build windows'''),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
