import 'package:flutter/material.dart';
import 'package:flutter_docs_demo/widgets/topic_demo_kit.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopicDemoScaffold(
      title: '交错动画',
      summary: '用 Interval 把一条时间轴切成多段，实现交错出现。',
      children: [
        TopicSection(
          title: '交错列表',
          child: Column(
            children: [
              for (var i = 0; i < 4; i++)
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: c,
                    curve: Interval(i * 0.2, 0.2 + i * 0.2 + 0.4, curve: Curves.easeOut),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text('菜单项 ${i + 1}'),
                  ),
                ),
              Row(
                children: [
                  FilledButton(onPressed: () => c.forward(from: 0), child: const Text('播放')),
                  const SizedBox(width: 8),
                  OutlinedButton(onPressed: () => c.reverse(), child: const Text('反向')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildDemo() => const DemoPage();
