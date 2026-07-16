import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final checks = const [
    '用 Profile 而非 Debug 测帧时',
    '打开 Performance overlay',
    'Timeline 找长任务',
    '缩小 rebuild 范围',
  ];
  final done = <String>{};


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '性能分析',
      summary: 'Profile 模式 + DevTools Performance，找 build/layout/paint 耗时。',
      children: [
        TopicSection(
          title: '检查清单',
          child: Column(
            children: [
              for (final s in checks)
                CheckboxListTile(
                  dense: true,
                  title: Text(s),
                  value: done.contains(s),
                  onChanged: (v) => setState(() {
                    if (v == true) {
                      done.add(s);
                    } else {
                      done.remove(s);
                    }
                  }),
                ),
            ],
          ),
        ),
        const TopicSection(title: '命令', child: TopicCode('flutter run --profile\n# 打开 DevTools → Performance')),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
