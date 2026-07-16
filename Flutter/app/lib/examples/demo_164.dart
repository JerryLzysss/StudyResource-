import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final on = <String>{'Inspector'};


  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '调试 — 调试工具',
      summary: 'DevTools、断点、logging、debugPrint；性能页看 Timeline。',
      children: [
        TopicSection(
          title: '工具箱',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final x in ['Inspector', 'Performance', 'Memory', 'Network', 'Logging'])
                FilterChip(
                  label: Text(x),
                  selected: on.contains(x),
                  onSelected: (v) => setState(() {
                    if (v) {
                      on.add(x);
                    } else {
                      on.remove(x);
                    }
                  }),
                ),
            ],
          ),
        ),
        TopicSection(
          title: '代码侧',
          child: FilledButton(
            onPressed: () {
              debugPrint('demo debugPrint at ${DateTime.now()}');
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已 debugPrint（见控制台）')));
            },
            child: const Text('触发 debugPrint'),
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
